`ifndef SPI_SEQ_ITEM_SVH
`define SPI_SEQ_ITEM_SVH

class spi_seq_item #(int WIDTH = 8) extends uvm_sequence_item;

    `uvm_object_param_utils(spi_seq_item#(WIDTH))

    typedef spi_seq_item#(WIDTH) this_t;

    // types

    // parameters

    // sequence items

    function new(string name = "spi_seq_item");
        super.new(name);
    endfunction : new

    virtual function string convert2string();
        string s = super.convert2string();
        // your code here
        return s;
    endfunction : convert2string

    virtual function void do_copy(uvm_object rhs);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_copy method")
        super.do_copy(rhs);
        // your code here
    endfunction : do_copy

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_compare method")
        // your code here
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

endclass : spi_seq_item

`endif