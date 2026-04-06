`ifndef PDM_SEQUENCER_SVH
`define PDM_SEQUENCER_SVH

class pdm_sequencer extends uvm_sequencer #(pdm_seq_item);

    `uvm_component_utils(pdm_sequencer)

    function new(string name = "pdm_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

endclass : pdm_sequencer

`endif