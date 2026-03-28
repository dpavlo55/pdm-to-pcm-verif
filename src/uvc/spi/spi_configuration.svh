`ifndef SPI_CONFIGURATION_SVH
`define SPI_CONFIGURATION_SVH

class spi_configuration extends uvm_object;

    `uvm_object_utils(spi_configuration)

    typedef virtual interface spi_if vif_t;

    protected vif_t vif;
    protected uvm_active_passive_enum is_active = UVM_ACTIVE;

    protected bit cpol = 1'b0;
    protected bit cpha = 1'b0;
    protected bit lsb_first = 1'b1;
    protected real frequency = 1.0e6;
    protected real delay_lead = 1.0e-6;
    protected real delay_trail = 1.0e-6;
    protected real delay_inter = 1.0e-6;

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

    function void set_vif(input vif_t vif);
        this.vif = vif;
    endfunction : set_vif

    function vif_t get_vif();
        return this.vif;
    endfunction : get_vif

endclass : spi_configuration

`endif