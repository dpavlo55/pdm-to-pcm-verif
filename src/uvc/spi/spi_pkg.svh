`ifndef SPI_PKG_SV
`define SPI_PKG_SV

package spi_pkg;

    timeunit 1ns / 1ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "spi_seq_item.svh"
    `include "spi_reg_adapter.svh"
    `include "spi_reg_predictor.svh"
    `include "spi_sequencer.svh"
    `include "spi_configuration.svh"
    `include "spi_driver.svh"
    `include "spi_monitor.svh"
    `include "spi_seqs_lib.svh"
    `include "spi_agent.svh"

endpackage : spi_pkg

`endif