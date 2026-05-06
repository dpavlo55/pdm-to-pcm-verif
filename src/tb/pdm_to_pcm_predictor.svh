class pdm_to_pcm_predictor extends uvm_component;

    `uvm_component_utils(pdm_to_pcm_predictor)

    uvm_analysis_imp #(pdm_seq_item, pdm_to_pcm_predictor) pdm_imp;
    uvm_analysis_port #(pcm_seq_item) pcm_port;

    int channel = 0;  // 0 = left, 1 = right — set before start_of_simulation

    protected cic_model cic_ref_model;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        pdm_imp = new("pdm_imp", this);
        pcm_port = new("pcm_port", this);
        cic_ref_model = new();
    endfunction : new

    virtual function void start_of_simulation_phase(uvm_phase phase);
        cic_ref_model.reset();
    endfunction : start_of_simulation_phase

    function void write(pdm_seq_item item);
        pdm_seq_item pdm_item;
        pcm_seq_item pcm_item;
        bit pcm_valid;

        if (!$cast(pdm_item, item.clone())) begin
            `uvm_error(get_type_name(), "Failed to cast pdm_seq_item")
        end

        pcm_item = pcm_seq_item::type_id::create("pcm_item");

        pcm_valid = cic_ref_model.step(pdm_item.data, pcm_item.data);

        if (pcm_valid) begin
            //pcm_item.data = int'({24'b0, pcm_item.data[7:0]});
            pcm_port.write(pcm_item);
            `uvm_info(get_type_name(), $sformatf("Predicted PCM sample: %s",
                pcm_item.convert2string()), UVM_DEBUG)
        end
    endfunction : write

endclass : pdm_to_pcm_predictor