class pcm_seq_item extends uvm_sequence_item;

    `uvm_object_utils(pcm_seq_item)

    typedef pcm_seq_item this_t;

    int signed data;

    function new(string name = "pcm_seq_item");
        super.new(name);
    endfunction : new

    virtual function string convert2string();
        string s = super.convert2string();
        s = {s, $sformatf("\nPCM sequence item:\n")};
        s = {s, $sformatf("  data : 0x%4h\n", data)};
        return s;
    endfunction : convert2string

    virtual function void do_copy(uvm_object rhs);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_copy method")
        super.do_copy(rhs);
        this.data = item.data;
    endfunction : do_copy

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_compare method")
        return
            (this.data == item.data);
    endfunction : do_compare

    virtual function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction : do_print

    virtual function void do_pack(uvm_packer packer);
        packer.pack_field_int(data, $bits(data));
    endfunction : do_pack

    virtual function void do_unpack(uvm_packer packer);
        data = packer.unpack_field_int($bits(data));
    endfunction : do_unpack

    virtual function void do_record(uvm_recorder recorder);
        recorder.record_field("data", data, $bits(data), UVM_HEX);
    endfunction : do_record


endclass : pcm_seq_item