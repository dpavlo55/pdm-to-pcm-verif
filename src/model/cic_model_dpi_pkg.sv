package cic_model_dpi_pkg;
    import "DPI-C" function void cic_model_init(string rtl_src_dir);
    import "DPI-C" function void cic_model_reset(int channel);
    import "DPI-C" function int  cic_model_step(int channel, int pdm_in, output int pcm_out);
endpackage