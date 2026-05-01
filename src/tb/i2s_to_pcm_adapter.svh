class i2s_to_pcm_adapter extends uvm_component;

    `uvm_component_utils(i2s_to_pcm_adapter)

    uvm_analysis_imp #(i2s_seq_item, i2s_to_pcm_adapter) i2s_imp;
    uvm_analysis_port #(pcm_seq_item) pcm_left_port;
    uvm_analysis_port #(pcm_seq_item) pcm_right_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        i2s_imp = new("i2s_imp", this);
        pcm_left_port = new("pcm_left_port", this);
        pcm_right_port = new("pcm_right_port", this);
    endfunction : new

    virtual function void write(i2s_seq_item item);
        i2s_seq_item i2s_item;
        pcm_seq_item pcm_left_item;
        pcm_seq_item pcm_right_item;

        if (!$cast(i2s_item, item.clone())) begin
            `uvm_error(get_type_name(), "Failed to cast i2s_seq_item")
        end

        pcm_left_item = pcm_seq_item::type_id::create("pcm_left_item");
        pcm_left_item.data = i2s_item.data_left;
        pcm_left_port.write(pcm_left_item);

        pcm_right_item = pcm_seq_item::type_id::create("pcm_right_item");
        pcm_right_item.data = i2s_item.data_right;
        pcm_right_port.write(pcm_right_item);
    endfunction : write

endclass : i2s_to_pcm_adapter