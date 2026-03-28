`ifndef SPI_MONITOR_SVH
`define SPI_MONITOR_SVH

class spi_monitor extends uvm_monitor;

    `uvm_component_utils(spi_monitor )

    typedef virtual interface spi_if vif_t;

    protected vif_t vif;
    protected spi_configuration configuration;

    uvm_analysis_port #(spi_seq_item ) output_ap;

    function new(string name = "spi_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is monitor's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(spi_configuration)::read_by_type(
            get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive SPI configuration from uvm_resource_db")
        end

        output_ap = new("output_ap", this);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        // your code here
    endtask : run_phase

endclass : spi_monitor

`endif