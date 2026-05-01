#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "svdpi.h"

static PyObject *s_model = NULL;

/* Call once before simulation starts */
__declspec(dllexport) void cic_model_init(const char *rtl_src_dir) {
    Py_Initialize();
    PyRun_SimpleString("import sys");
    /* Build the sys.path.insert call dynamically from the passed path */
    char buf[512];
    snprintf(buf, sizeof(buf), "sys.path.insert(0, '%s')", rtl_src_dir);
    PyRun_SimpleString(buf);
    PyObject *mod = PyImport_ImportModule("cic_model");
    if (!mod) { PyErr_Print(); return; }
    PyObject *cls = PyObject_GetAttrString(mod, "CicModel");
    s_model = PyObject_CallNoArgs(cls);
    Py_DECREF(cls);
    Py_DECREF(mod);
}

__declspec(dllexport) void cic_model_reset() {
    PyObject_CallMethod(s_model, "reset", NULL);
}

/* Returns 1 if valid output, 0 otherwise. Sets *pcm_out when valid. */
__declspec(dllexport) int cic_model_step(int pdm_in, int *pcm_out) {
    if (!s_model) {
        fprintf(stderr, "[cic_model_dpi] ERROR: s_model is NULL — cic_model_init() was not called or failed\n");
        fflush(stderr);
        return 0;
    }
    PyObject *ret = PyObject_CallMethod(s_model, "step", "i", pdm_in);
    PyObject *val = PyTuple_GetItem(ret, 0);  /* borrowed ref */
    PyObject *vld = PyTuple_GetItem(ret, 1);
    int valid = PyObject_IsTrue(vld);
    if (valid) *pcm_out = (int)PyLong_AsLong(val);
    Py_DECREF(ret);
    return valid;
}