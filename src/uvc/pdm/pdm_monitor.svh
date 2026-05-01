`ifndef PDM_MONITOR_SVH
`define PDM_MONITOR_SVH

class pdm_monitor extends uvm_monitor;

    `uvm_component_utils(pdm_monitor)

    typedef virtual interface pdm_if vif_t;
    typedef pdm_seq_item item_t;

    protected vif_t vif;
    protected pdm_configuration configuration;

    uvm_analysis_port #(item_t) output_ap;
    uvm_analysis_port #(item_t) request_ap;

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

        vif = configuration.get_vif();

        output_ap = new("output_ap", this);
        request_ap = new("request_ap", this);
    endfunction : build_phase

    virtual task wait_active_edge();
        if (configuration.get_side() == pdm_configuration::MIC_RIGHT)
            @(posedge vif.clk);
        else
            @(negedge vif.clk);
    endtask : wait_active_edge

    virtual task wait_release_edge();
        if (configuration.get_side() == pdm_configuration::MIC_RIGHT)
            @(negedge vif.clk);
        else
            @(posedge vif.clk);
    endtask : wait_release_edge

    virtual task run_phase(uvm_phase phase);
        item_t item;

        forever begin
            item = item_t::type_id::create("item");
            wait_active_edge();
            request_ap.write(item);
            wait_release_edge();
            item.data = vif.data;
            output_ap.write(item);
        end
    endtask : run_phase

endclass : pdm_monitor

`endif
