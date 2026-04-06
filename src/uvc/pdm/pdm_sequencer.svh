`ifndef PDM_SEQUENCER_SVH
`define PDM_SEQUENCER_SVH

class pdm_sequencer extends uvm_sequencer #(pdm_seq_item);

    `uvm_component_utils(pdm_sequencer)

    uvm_analysis_export #(pdm_seq_item) request_ep;
    uvm_tlm_analysis_fifo #(pdm_seq_item) request_fifo;

    function new(string name = "pdm_sequencer", uvm_component parent = null);
        super.new(name, parent);
        request_ep = new("request_ep", this);
        request_fifo = new("request_fifo", this);
    endfunction : new

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        request_ep.connect(request_fifo.analysis_export);
    endfunction : connect_phase

endclass : pdm_sequencer

`endif