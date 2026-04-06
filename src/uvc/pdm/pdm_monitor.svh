`ifndef PDM_MONITOR_SVH
`define PDM_MONITOR_SVH

class pdm_monitor extends uvm_monitor;

    `uvm_component_utils(pdm_monitor)

    typedef virtual interface pdm_if vif_t;
    typedef pdm_seq_item item_t;

    protected vif_t vif;
    protected pdm_configuration configuration;

    uvm_analysis_port #(item_t) output_ap;

    function new(string name = "pdm_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is monitor's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(pdm_configuration)::read_by_type(
            get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive PDM configuration from uvm_resource_db")
        end

        output_ap = new("output_ap", this);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        // your code here
    endtask : run_phase

endclass : pdm_monitor

`endif