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
    protected real period = 1.0 / frequency;
    protected real delay_lead = 1.0e-6;
    protected real delay_inter = 1.0e-6;
    protected real delay_trail = 1.0e-6;

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

    function void set_cpol(input bit cpol);
        this.cpol = cpol;
    endfunction : set_cpol

    function bit get_cpol();
        return this.cpol;
    endfunction : get_cpol

    function void set_cpha(input bit cpha);
        this.cpha = cpha;
    endfunction : set_cpha

    function bit get_cpha();
        return this.cpha;
    endfunction : get_cpha

    function void set_lsb_first(input bit lsb_first);
        this.lsb_first = lsb_first;
    endfunction : set_lsb_first

    function bit get_lsb_first();
        return this.lsb_first;
    endfunction : get_lsb_first

    function void set_frequency(input real frequency);
        this.frequency = frequency;
        this.period = 1.0 / frequency;
    endfunction : set_frequency

    function real get_frequency();
        return this.frequency;
    endfunction : get_frequency

    function void set_period(input real period);
        this.period = period;
        this.frequency = 1.0 / period;
    endfunction : set_period

    function real get_period();
        return this.period;
    endfunction : get_period

    function void set_delay_lead(input real delay_lead);
        this.delay_lead = delay_lead;
    endfunction : set_delay_lead

    function real get_delay_lead();
        return this.delay_lead;
    endfunction : get_delay_lead

    function void set_delay_inter(input real delay_inter);
        this.delay_inter = delay_inter;
    endfunction : set_delay_inter

    function real get_delay_inter();
        return this.delay_inter;
    endfunction : get_delay_inter

    function void set_delay_trail(input real delay_trail);
        this.delay_trail = delay_trail;
    endfunction : set_delay_trail

    function real get_delay_trail();
        return this.delay_trail;
    endfunction : get_delay_trail

endclass : spi_configuration

`endif