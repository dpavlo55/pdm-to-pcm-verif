`ifndef PDM_SEQS_LIB_SVH
`define PDM_SEQS_LIB_SVH

class pdm_base_seq extends uvm_sequence #(pdm_seq_item);

    `uvm_object_utils(pdm_base_seq)
    `uvm_declare_p_sequencer(pdm_sequencer)

    function new(string name = "pdm_base_seq");
        super.new(name);
    endfunction

    virtual task pre_body();
        uvm_phase phase;
        phase = starting_phase;
        if (phase != null) begin
            phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "Raising objection", UVM_LOW)
        end
    endtask : pre_body

    virtual task post_body();
        uvm_phase phase;
        phase = starting_phase;
        if (phase != null) begin
            phase.drop_objection(this, get_type_name());
            `uvm_info(get_type_name(), "Dropping objection", UVM_LOW)
        end
    endtask : post_body

endclass : pdm_base_seq

`endif