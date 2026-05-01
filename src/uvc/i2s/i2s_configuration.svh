`ifndef I2S_CONFIGURATION_SVH
`define I2S_CONFIGURATION_SVH

class i2s_configuration extends uvm_object;

    `uvm_object_utils(i2s_configuration)

    typedef virtual interface i2s_if vif_t;

    protected vif_t vif;

    protected uvm_active_passive_enum is_active = UVM_ACTIVE;

    // class constructor
    function new(string name = "i2s_configuration");
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

endclass : i2s_configuration

`endif