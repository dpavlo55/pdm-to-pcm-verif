package pdm_to_pcm_test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // UVC packages
    import spi_pkg::*;
    import pdm_pkg::*;
    import i2s_pkg::*;

    // RAL package
    import pdm_to_pcm_reg_pkg::*;

    // Reference model package
    import cic_model_dpi_pkg::*;

    // testbench classes
    `include "../tb/pcm_seq_item.svh"
    `include "../tb/i2s_to_pcm_adapter.svh"
    `include "../tb/pdm_to_pcm_predictor.svh"
    `include "../tb/pcm_comparator.svh"
    `include "../tb/pdm_to_pcm_scoreboard.svh"
    `include "../tb/pdm_to_pcm_test_lib.svh"

endpackage : pdm_to_pcm_test_pkg