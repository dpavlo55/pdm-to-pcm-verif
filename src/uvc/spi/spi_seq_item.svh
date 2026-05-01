`ifndef SPI_SEQ_ITEM_SVH
`define SPI_SEQ_ITEM_SVH

class spi_seq_item extends uvm_sequence_item;

    `uvm_object_utils(spi_seq_item)

    typedef spi_seq_item this_t;

    // types
    typedef enum logic [2:0] {
        SPI_READ = 3'b000,
        SPI_WRITE = 3'b001
    } cmd_t;

    // sequence items
    rand cmd_t cmd;
    rand logic [4:0] addr;
    rand logic [7:0] data;

    // metadata
    string reg_name;

    function new(string name = "spi_seq_item");
        super.new(name);
    endfunction : new

    virtual function string convert2string();
        string s = super.convert2string();
        s = {s, $sformatf("\nSPI transaction:\n")};
        s = {s, $sformatf("  cmd  : %s\n", cmd.name())};
        s = {s, $sformatf("  addr : 0x%2h (%s)\n", addr, reg_name)};
        if (cmd == SPI_WRITE)
            s = {s, $sformatf("  data : 0x%2h\n", data)};
        else begin
            s = {s, $sformatf("  data : --\n")};
        end
        return s;
    endfunction : convert2string

    virtual function void do_copy(uvm_object rhs);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_copy method")
        super.do_copy(rhs);
        this.cmd = item.cmd;
        this.addr = item.addr;
        this.data = item.data;
        this.reg_name = item.reg_name;
    endfunction : do_copy

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t item;
        if (!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument of do_compare method")
        return
            (this.cmd == item.cmd) &&
            (this.addr == item.addr) &&
            (this.data == item.data) &&
            (this.reg_name == item.reg_name);
    endfunction : do_compare

    virtual function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction : do_print

    virtual function void do_pack(uvm_packer packer);
        packer.pack_field_int(cmd, $bits(cmd));
        packer.pack_field_int(addr, $bits(addr));
        packer.pack_field_int(data, $bits(data));
    endfunction : do_pack

    virtual function void do_unpack(uvm_packer packer);
        cmd = cmd_t'(packer.unpack_field_int($bits(cmd)));
        addr = packer.unpack_field_int($bits(addr));
        data = packer.unpack_field_int($bits(data));
    endfunction : do_unpack

    virtual function void do_record(uvm_recorder recorder);
        recorder.record_string("cmd", cmd.name());
        recorder.record_string("reg", reg_name);
        recorder.record_field("addr", addr, $bits(addr), UVM_HEX);
        recorder.record_field("data", data, $bits(data), UVM_HEX);
    endfunction : do_record

endclass : spi_seq_item

`endif