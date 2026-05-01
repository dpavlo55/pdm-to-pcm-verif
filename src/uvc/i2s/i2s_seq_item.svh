`ifndef I2S_SEQ_ITEM_SVH
`define I2S_SEQ_ITEM_SVH

class i2s_seq_item extends uvm_sequence_item;

    `uvm_object_utils(i2s_seq_item)

    typedef i2s_seq_item this_t;

    // types

    // parameters

    // sequence items
    logic [15:0] data_left;
    logic [15:0] data_right;

    function new(string name = "i2s_seq_item");
        super.new(name);
    endfunction : new

    virtual function string convert2string();
        string s = super.convert2string();
        s = {s, $sformatf("\nI2S transaction:\n")};
        s = {s, $sformatf("  data_left  : 0x%4h\n", data_left)};
        s = {s, $sformatf("  data_right : 0x%4h\n", data_right)};
        return s;
    endfunction : convert2string

    virtual function void do_copy(uvm_object rhs);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_copy method")
        super.do_copy(rhs);
        this.data_left = item.data_left;
        this.data_right = item.data_right;
    endfunction : do_copy

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_compare method")
        return
            (this.data_left == item.data_left) &&
            (this.data_right == item.data_right);
    endfunction : do_compare

    virtual function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction : do_print

    virtual function void do_pack(uvm_packer packer);
        packer.pack_field_int(data_left, $bits(data_left));
        packer.pack_field_int(data_right, $bits(data_right));
    endfunction : do_pack

    virtual function void do_unpack(uvm_packer packer);
        data_left = packer.unpack_field_int($bits(data_left));
        data_right = packer.unpack_field_int($bits(data_right));
    endfunction : do_unpack

    virtual function void do_record(uvm_recorder recorder);
        recorder.record_field("data_left", data_left, $bits(data_left), UVM_HEX);
        recorder.record_field("data_right", data_right, $bits(data_right), UVM_HEX);
    endfunction : do_record

endclass : i2s_seq_item

`endif