`ifndef I2S_SEQUENCER_SVH
`define I2S_SEQUENCER_SVH

class i2s_sequencer extends uvm_sequencer #(i2s_seq_item);

    `uvm_component_utils(i2s_sequencer)

    function new(string name = "i2s_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

endclass : i2s_sequencer

`endif