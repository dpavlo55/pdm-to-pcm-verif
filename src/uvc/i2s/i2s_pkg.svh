`ifndef I2S_PKG_SV
`define I2S_PKG_SV

package i2s_pkg;

    timeunit 1ns / 1ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "i2s_seq_item.svh"

    `include "i2s_sequencer.svh"
    `include "i2s_configuration.svh"
    `include "i2s_driver.svh"
    `include "i2s_monitor.svh"
    `include "i2s_seqs_lib.svh"
    `include "i2s_agent.svh"

endpackage : i2s_pkg

`endif