class pcm_comparator extends uvm_component;

    `uvm_component_utils(pcm_comparator)

    uvm_analysis_export #(pcm_seq_item) pcm_expected_export;
    uvm_analysis_export #(pcm_seq_item) pcm_received_export;

    uvm_tlm_analysis_fifo #(pcm_seq_item) expected_fifo;
    uvm_tlm_analysis_fifo #(pcm_seq_item) received_fifo;

    protected int signed expected_pcm;
    protected int signed received_pcm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        pcm_expected_export = new("pcm_expected_export", this);
        pcm_received_export = new("pcm_received_export", this);

        expected_fifo = new("expected_fifo", this);
        received_fifo = new("received_fifo", this);
    endfunction : new

    virtual function void connect_phase(uvm_phase phase);
        pcm_expected_export.connect(expected_fifo.analysis_export);
        pcm_received_export.connect(received_fifo.analysis_export);
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        forever begin
            pcm_seq_item expected_item;
            pcm_seq_item received_item;

            expected_fifo.get(expected_item);
            received_fifo.get(received_item);


            expected_pcm = int'(signed'(expected_item.data));
            received_pcm = int'(signed'(received_item.data));

            if (expected_pcm !== received_pcm) begin
                `uvm_error(get_type_name(),
                    $sformatf("PCM mismatch: \n  expected %h \n  received %h",
                        expected_pcm, received_pcm))
            end else begin
                `uvm_info(get_type_name(),
                    $sformatf("PCM match: \n  expected %h \n  received %h",
                        expected_pcm, received_pcm), UVM_HIGH)
            end
        end
    endtask : run_phase

endclass : pcm_comparator