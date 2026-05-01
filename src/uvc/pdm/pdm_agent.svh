`ifndef PDM_AGENT_SVH
`define PDM_AGENT_SVH

class pdm_agent extends uvm_agent;

    `uvm_component_utils(pdm_agent)

    protected pdm_driver driver;
    protected pdm_monitor monitor;
    protected pdm_sequencer sequencer;
    protected pdm_configuration configuration;

    uvm_analysis_port #(pdm_seq_item) analysis_port;

    function new(string name = "pdm_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function pdm_sequencer get_sequencer();
        return this.sequencer;
    endfunction : get_sequencer

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is agent's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(pdm_configuration)::
            read_by_type(get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive PDM configuration from uvm_resource_db")
        end

        monitor = pdm_monitor::type_id::create("monitor", this);

        if (configuration.get_is_active() == UVM_ACTIVE) begin
            driver = pdm_driver::type_id::create("driver", this);
            sequencer = pdm_sequencer::type_id::create("sequencer", this);
        end

        uvm_resource_db#(pdm_configuration)::set(
            {get_full_name(), ".*"}, "configuration", configuration, this);

        analysis_port = new("analysis_port", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (configuration.get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
            monitor.request_ap.connect(sequencer.request_ep);
        end
        monitor.output_ap.connect(analysis_port);
    endfunction : connect_phase

endclass : pdm_agent

`endif