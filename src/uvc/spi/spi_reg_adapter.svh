`ifndef SPI_REG_ADAPTER_SVH
`define SPI_REG_ADAPTER_SVH

class spi_reg_adapter extends uvm_reg_adapter;

    `uvm_object_utils(spi_reg_adapter)

    typedef spi_seq_item item_t;

    function new(string name = "spi_reg_adapter");
        super.new(name);
        supports_byte_enable = 1'b0;
        provides_responses = 1'b1;
    endfunction : new

    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        item_t item;
        uvm_reg_item reg_item;
        uvm_reg register;

        item = item_t::type_id::create("item");

        item.cmd = (rw.kind == UVM_READ) ? item_t::SPI_READ : item_t::SPI_WRITE;
        item.addr = rw.addr;

        if (item.cmd == item_t::SPI_WRITE) begin
            item.data = rw.data;
        end else begin
            item.data = 'h00;
        end

        reg_item = this.get_item();

        if (reg_item != null) begin
            if ($cast(register, reg_item.element)) begin
                item.reg_name = register.get_name().toupper();
            end else begin
                item.reg_name = "UNKNOWN";
            end
        end

        return item;
    endfunction : reg2bus

    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        item_t item;
        if (!$cast(item, bus_item)) begin
            `uvm_fatal(get_type_name(), "Type mismatch in bus2reg")
        end

        rw.kind = (item.cmd == item_t::SPI_READ) ? UVM_READ : UVM_WRITE;
        rw.addr = item.addr;
        rw.data = item.data;

    endfunction : bus2reg

endclass : spi_reg_adapter

`endif
