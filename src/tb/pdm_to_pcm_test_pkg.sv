package pdm_to_pcm_test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // UVC packages
    import spi_pkg::*;   // needed if tests reference spi_agent, spi_configuration, etc.

    // RAL package
    import pdm_to_pcm_reg_pkg::*;

    // testbench classes
    `include "../tb/pdm_to_pcm_test_lib.svh"

endpackage : pdm_to_pcm_test_pkg