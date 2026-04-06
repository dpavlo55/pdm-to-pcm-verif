`ifndef PDM_SEQ_ITEM_SVH
`define PDM_SEQ_ITEM_SVH

class pdm_seq_item extends uvm_sequence_item;

    `uvm_object_utils(pdm_seq_item)

    typedef pdm_seq_item this_t;

    // types

    // parameters

    // sequence items
    logic [0:0] pdm_data;

    function new(string name = "pdm_seq_item");
        super.new(name);
    endfunction : new

    virtual function string convert2string();
        string s = super.convert2string();
        s = $sformatf("%s, pdm_data=%0b", s, pdm_data);
        return s;
    endfunction : convert2string

    virtual function void do_copy(uvm_object rhs);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_copy method")
        super.do_copy(rhs);
        this.pdm_data = item.pdm_data;
    endfunction : do_copy

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_compare method")
        if (this.pdm_data != item.pdm_data)
            return 0;
        return 1'b1;
    endfunction : do_compare

    virtual function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction : do_print

    virtual function void do_pack(uvm_packer packer);
        return;
    endfunction : do_pack

    virtual function void do_unpack(uvm_packer packer);
        return;
    endfunction : do_unpack

    virtual function void do_record(uvm_recorder recorder);
        return;
    endfunction : do_record

endclass : pdm_seq_item

`endif