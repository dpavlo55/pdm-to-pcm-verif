class pdm_to_pcm_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(pdm_to_pcm_scoreboard)

    uvm_analysis_export #(pdm_seq_item) pdm_left_export;
    uvm_analysis_export #(pdm_seq_item) pdm_right_export;
    uvm_analysis_export #(i2s_seq_item) i2s_export;

    protected pdm_to_pcm_predictor predictor_left;
    protected pdm_to_pcm_predictor predictor_right;
    protected i2s_to_pcm_adapter i2s_adapter;

    protected pcm_comparator comparator_left;
    protected pcm_comparator comparator_right;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        pdm_left_export = new("pdm_left_export", this);
        pdm_right_export = new("pdm_right_export", this);
        i2s_export = new("i2s_export", this);

        predictor_left  = pdm_to_pcm_predictor::type_id::create("predictor_left",  this);
        predictor_right = pdm_to_pcm_predictor::type_id::create("predictor_right", this);
        predictor_left.channel = 0;
        predictor_right.channel = 1;
        i2s_adapter = i2s_to_pcm_adapter::type_id::create("i2s_adapter", this);

        comparator_left = pcm_comparator::type_id::create("comparator_left", this);
        comparator_right = pcm_comparator::type_id::create("comparator_right", this);
    endfunction : new

    virtual function void connect_phase(uvm_phase phase);
        pdm_left_export.connect(predictor_left.pdm_imp);
        pdm_right_export.connect(predictor_right.pdm_imp);
        i2s_export.connect(i2s_adapter.i2s_imp);

        predictor_left.pcm_port.connect(comparator_left.pcm_expected_export);
        i2s_adapter.pcm_left_port.connect(comparator_left.pcm_received_export);

        predictor_right.pcm_port.connect(comparator_right.pcm_expected_export);
        i2s_adapter.pcm_right_port.connect(comparator_right.pcm_received_export);
    endfunction : connect_phase

endclass : pdm_to_pcm_scoreboard