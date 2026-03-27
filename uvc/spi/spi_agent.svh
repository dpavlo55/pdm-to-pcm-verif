`ifndef SPI_AGENT_SVH
`define SPI_AGENT_SVH

class spi_agent #(int WIDTH = 8) extends uvm_agent;

    `uvm_component_param_utils(spi_agent#(WIDTH))

    protected spi_driver#(WIDTH) driver;
    protected spi_monitor#(WIDTH) monitor;
    protected spi_sequencer#(WIDTH) sequencer;
    protected spi_configuration configuration;

    function new(string name = "spi_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function spi_sequencer#(WIDTH) get_sequencer();
        return this.sequencer;
    endfunction : get_sequencer

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is agent's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(spi_configuration)::
            read_by_type(get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive SPI configuration from uvm_resource_db")
        end

        monitor = spi_monitor#(WIDTH)::type_id::create("monitor", this);

        if (configuration.get_is_active() == UVM_ACTIVE) begin
            driver = spi_driver#(WIDTH)::type_id::create("driver", this);
            sequencer = spi_sequencer#(WIDTH)::type_id::create("sequencer", this);
        end

        uvm_resource_db#(spi_configuration)::set(
            {get_full_name(), ".*"}, "configuration", configuration, this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (configuration.get_is_active() == UVM_ACTIVE)
            driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

endclass : spi_agent

`endif