`ifndef SPI_REG_ADAPTER_SVH
`define SPI_REG_ADAPTER_SVH

class spi_reg_adapter extends uvm_reg_adapter;

    `uvm_object_utils(spi_reg_adapter)

    typedef spi_seq_item item_t;

    function new(string name = "spi_reg_adapter");
        super.new(name);
        supports_byte_enable = 1'b0;
        provides_responses = 1'b0;
    endfunction : new

    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        item_t item;
        item = item_t::type_id::create("item");
        // your code here
        return item;
    endfunction : reg2bus

    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        item_t item;
        if (!$cast(item, bus_item)) begin
            `uvm_fatal(get_type_name(), "Type mismatch in bus2reg")
        end
        // your code here
    endfunction : bus2reg

endclass : spi_reg_adapter

`endif
