`ifndef SPI_MONITOR_SVH
`define SPI_MONITOR_SVH

class spi_monitor extends uvm_monitor;

    `uvm_component_utils(spi_monitor)

    typedef virtual interface spi_if vif_t;

    protected vif_t vif;
    protected spi_configuration configuration;

    uvm_analysis_port #(spi_seq_item) output_ap;

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

        vif = configuration.get_vif();

        output_ap = new("output_ap", this);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        spi_seq_item item;

        forever begin
            logic mosi[$];
            logic miso[$];
            item = spi_seq_item::type_id::create("item");

            // Wait for CS to go low, then sample MOSI and MISO on each clock edge
            @(negedge vif.cs_n);
            repeat (16) begin
                @(posedge vif.sck);
                mosi.push_back(vif.mosi);
                miso.push_back(vif.miso);
            end

            item.cmd = (mosi[2] == 1'b0) ?
                spi_seq_item::SPI_READ : spi_seq_item::SPI_WRITE;
            item.addr = {>>{mosi[3:7]}};
            if (item.cmd == spi_seq_item::SPI_WRITE)
                item.data = {>>{mosi[8:15]}};
            else begin
                item.data = {>>{miso[8:15]}};
            end
            item.reg_name = "UNKNOWN";

            output_ap.write(item);
        end
    endtask : run_phase

endclass : spi_monitor

`endif