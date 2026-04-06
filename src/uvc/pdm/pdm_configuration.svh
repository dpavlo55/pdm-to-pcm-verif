`ifndef PDM_CONFIGURATION_SVH
`define PDM_CONFIGURATION_SVH

class pdm_configuration extends uvm_object;

    `uvm_object_utils(pdm_configuration)

    typedef virtual interface pdm_if vif_t;

    typedef enum {
        MIC_LEFT,
        MIC_RIGHT
    } side_t;

    protected vif_t vif;

    protected uvm_active_passive_enum is_active = UVM_ACTIVE;
    protected side_t side = MIC_LEFT;
    protected real output_enable_delay = 30.0e-9;
    protected real output_disable_delay = 10.0e-9;

    // class constructor
    function new(string name = "pdm_configuration");
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

    function void set_side(input side_t side);
        this.side = side;
    endfunction : set_side

    function side_t get_side();
        return this.side;
    endfunction : get_side

    function void set_output_delays(input real enable_delay, input real disable_delay);
        this.output_enable_delay = enable_delay;
        this.output_disable_delay = disable_delay;
    endfunction : set_output_delays

    function real get_output_enable_delay();
        return this.output_enable_delay;
    endfunction : get_output_enable_delay

    function real get_output_disable_delay();
        return this.output_disable_delay;
    endfunction : get_output_disable_delay

endclass : pdm_configuration

`endif