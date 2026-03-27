`ifndef SPI_CONFIGURATION_SVH
`define SPI_CONFIGURATION_SVH

class spi_configuration extends uvm_object;

    `uvm_object_utils(spi_configuration)

    virtual interface spi_if vif;

    protected uvm_active_passive_enum is_active = UVM_ACTIVE;

    // class constructor
    function new(string name = "spi_configuration");
        super.new(name);
    endfunction : new

    function void set_is_active(input uvm_active_passive_enum is_active);
        this.is_active = is_active;
    endfunction : set_is_active

    function uvm_active_passive_enum get_is_active();
        return this.is_active;
    endfunction : get_is_active

endclass : spi_configuration

`endif