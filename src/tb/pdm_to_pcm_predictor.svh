`uvm_analysis_imp_decl(_pdm_left)
`uvm_analysis_imp_decl(_pdm_right)

class pdm_to_pcm_predictor extends uvm_component;

    `uvm_component_utils(pdm_to_pcm_predictor)

    uvm_analysis_imp_pdm_left #(pdm_seq_item, pdm_to_pcm_predictor) pdm_left_imp;
    uvm_analysis_imp_pdm_right #(pdm_seq_item, pdm_to_pcm_predictor) pdm_right_imp;
    uvm_analysis_port #(pcm_seq_item) pcm_left_port;
    uvm_analysis_port #(pcm_seq_item) pcm_right_port;

    protected cic_dual_folded_model cic_ref_model;
    protected bit pending_left;
    protected bit pdm_left;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        pdm_left_imp = new("pdm_left_imp", this);
        pdm_right_imp = new("pdm_right_imp", this);
        pcm_left_port = new("pcm_left_port", this);
        pcm_right_port = new("pcm_right_port", this);
        cic_ref_model = new();
    endfunction : new

    function void reset();
        cic_ref_model.reset();
        pending_left = 0;
        pdm_left = 0;
    endfunction : reset

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        reset();
    endfunction : start_of_simulation_phase

    virtual task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        reset();
    endtask : reset_phase

    function void write_pdm_left(pdm_seq_item item);
        if ($isunknown(item.data)) begin
            `uvm_fatal(get_type_name(), "Unknown left PDM sample")
        end
        if (pending_left) begin
            `uvm_fatal(get_type_name(), "Left PDM sample arrived before the previous pair completed")
        end
        pdm_left = item.data;
        pending_left = 1;
    endfunction : write_pdm_left

    function void write_pdm_right(pdm_seq_item item);
        pcm_seq_item pcm_left_item;
        pcm_seq_item pcm_right_item;
        int pcm_left;
        int pcm_right;

        if ($isunknown(item.data)) begin
            `uvm_fatal(get_type_name(), "Unknown right PDM sample")
        end
        if (!pending_left) begin
            `uvm_fatal(get_type_name(), "Right PDM sample arrived without a matching left sample")
        end
        pending_left = 0;

        if (cic_ref_model.step(pdm_left, item.data, pcm_left, pcm_right)) begin
            pcm_left_item = pcm_seq_item::type_id::create("pcm_left_item");
            pcm_right_item = pcm_seq_item::type_id::create("pcm_right_item");
            pcm_left_item.data = pcm_left;
            pcm_right_item.data = pcm_right;
            pcm_left_port.write(pcm_left_item);
            pcm_right_port.write(pcm_right_item);
            `uvm_info(get_type_name(), $sformatf("Predicted PCM pair: left=%0d right=%0d",
                pcm_left, pcm_right), UVM_DEBUG)
        end
    endfunction : write_pdm_right

endclass : pdm_to_pcm_predictor