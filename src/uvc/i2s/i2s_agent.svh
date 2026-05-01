`ifndef I2S_AGENT_SVH
`define I2S_AGENT_SVH

class i2s_agent extends uvm_agent;

    `uvm_component_utils(i2s_agent)

    protected i2s_driver driver;
    protected i2s_monitor monitor;
    protected i2s_sequencer sequencer;
    protected i2s_configuration configuration;

    uvm_analysis_port #(i2s_seq_item) analysis_port;

    function new(string name = "i2s_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function i2s_sequencer get_sequencer();
        return this.sequencer;
    endfunction : get_sequencer

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is agent's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(i2s_configuration)::
            read_by_type(get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive I2S configuration from uvm_resource_db")
        end

        monitor = i2s_monitor::type_id::create("monitor", this);

        if (configuration.get_is_active() == UVM_ACTIVE) begin
            driver = i2s_driver::type_id::create("driver", this);
            sequencer = i2s_sequencer::type_id::create("sequencer", this);
        end

        uvm_resource_db#(i2s_configuration)::set(
            {get_full_name(), ".*"}, "configuration", configuration, this);

        analysis_port = new("analysis_port", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (configuration.get_is_active() == UVM_ACTIVE)
            driver.seq_item_port.connect(sequencer.seq_item_export);
        monitor.output_ap.connect(analysis_port);
    endfunction : connect_phase

endclass : i2s_agent

`endif