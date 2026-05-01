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

        vif = configuration.get_vif();
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
        forever begin
            wait_active_edge();
            seq_item_port.get_next_item(req);
            #(configuration.get_output_enable_delay() * 1s);
            vif.pdm_data <= req.data;
            vif.pdm_en <= 1'b1;
            wait_release_edge();
            #(configuration.get_output_disable_delay() * 1s);
            vif.pdm_en <= 1'b0;
            seq_item_port.item_done();
        end
    endtask : run_phase

endclass : pdm_driver

`endif