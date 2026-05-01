// DPI-C wrapper for CicModel.
// Two independent instances — channel 0 = left, channel 1 = right.
//
// Build (from sim/ directory):
//   cl.exe /LD /MD /nologo /I <questa_include> /I ../rtl/tb \
//          ../src/model/cic_model_dpi.cpp /link /OUT:cic_model_dpi.dll

#include "../../rtl/tb/cic_model.hpp"
#include "svdpi.h"
#include <cstdio>

static CicModel s_model[2];

extern "C" {

// Called once before simulation. Resets both channels.
DPI_DLLESPEC void cic_model_init(const char * /* rtl_src_dir */) {
    s_model[0].reset();
    s_model[1].reset();
}

// Reset one channel (0=left, 1=right).
DPI_DLLESPEC void cic_model_reset(int channel) {
    if (channel < 0 || channel > 1) {
        fprintf(stderr, "[cic_model_dpi] ERROR: invalid channel %d\n", channel);
        return;
    }
    s_model[channel].reset();
}

// Returns 1 when a new PCM sample is ready (sets *pcm_out), 0 otherwise.
DPI_DLLESPEC int cic_model_step(int channel, int pdm_in, int *pcm_out) {
    if (channel < 0 || channel > 1) {
        fprintf(stderr, "[cic_model_dpi] ERROR: invalid channel %d\n", channel);
        return 0;
    }
    return s_model[channel].step(pdm_in, pcm_out);
}

}  // extern "C"
