`ifndef I2S_DRIVER_SVH
`define I2S_DRIVER_SVH

class i2s_driver extends uvm_driver #(i2s_seq_item);

    // factory registration
    `uvm_component_utils(i2s_driver)

    typedef virtual interface i2s_if vif_t;
    typedef i2s_seq_item item_t;

    protected vif_t vif;
    protected i2s_configuration configuration;

    // class constructor
    function new(string name = "i2s_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // driver's build phase
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is driver's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(i2s_configuration)::read_by_type(
            get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive I2S configuration from uvm_resource_db")
        end
    endfunction : build_phase

    virtual task automatic delay(input int NUMBER_OF_DELAY_CYCLES = 1);
        // your code here
    endtask : delay

    virtual task run_phase(uvm_phase phase);
        // your code here
    endtask : run_phase

endclass : i2s_driver

`endif