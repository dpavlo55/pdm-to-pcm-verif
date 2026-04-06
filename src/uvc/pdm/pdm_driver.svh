`ifndef PDM_DRIVER_SVH
`define PDM_DRIVER_SVH

class pdm_driver extends uvm_driver #(pdm_seq_item);

    // factory registration
    `uvm_component_utils(pdm_driver)

    typedef virtual interface pdm_if vif_t;
    typedef pdm_seq_item item_t;

    protected vif_t vif;
    protected pdm_configuration configuration;

    // class constructor
    function new(string name = "pdm_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // driver's build phase
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is driver's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(pdm_configuration)::read_by_type(
            get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive PDM configuration from uvm_resource_db")
        end
    endfunction : build_phase

    virtual task automatic delay(input int NUMBER_OF_DELAY_CYCLES = 1);
        // your code here
    endtask : delay

    virtual task run_phase(uvm_phase phase);
        // your code here
    endtask : run_phase

endclass : pdm_driver

`endif