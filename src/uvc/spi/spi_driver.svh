`ifndef SPI_DRIVER_SVH
`define SPI_DRIVER_SVH

class spi_driver extends uvm_driver #(spi_seq_item);

    // factory registration
    `uvm_component_utils(spi_driver )

    typedef virtual interface spi_if vif_t;
    typedef spi_seq_item item_t;

    protected vif_t vif;
    protected spi_configuration configuration;
    uvm_tlm_analysis_fifo #(spi_seq_item) rsp_fifo;

    // class constructor
    function new(string name = "spi_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // driver's build phase
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is driver's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(spi_configuration)::read_by_type(
            get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive SPI configuration from uvm_resource_db")
        end

        vif = configuration.get_vif();
        this.rsp_fifo = new("rsp_fifo", this);
    endfunction : build_phase

    task reset();
        vif.cs_n <= 1'b1;
        vif.sck <= 1'b0;
        vif.mosi <= 1'b0;
    endtask : reset

    task transaction(item_t item);
        bit bit_stream[];

        item.pack(bit_stream);

        vif.cs_n <= 1'b0;

        foreach (bit_stream[i]) begin
            vif.mosi <= bit_stream[i];
            #(configuration.get_period() / 2.0 * 1s);
            vif.sck <= 1'b1;
            #(configuration.get_period() / 2.0 * 1s);
            vif.sck <= 1'b0;
        end

        #(configuration.get_period() / 2.0 * 1s);
        vif.cs_n <= 1'b1;
        #(configuration.get_period() / 2.0 * 1s);

    endtask : transaction

    virtual task run_phase(uvm_phase phase);
        item_t req;
        item_t rsp;

        reset();

        #(configuration.get_delay_lead() * 1s);

        forever begin
            // get the next item from the sequencer
            seq_item_port.get_next_item(req);

            `uvm_info(get_type_name(), $sformatf("%s", req.convert2string()), UVM_HIGH)

            transaction(req);

            // wait for monitor to capture the completed transaction (with real MISO data)
            this.rsp_fifo.get(rsp);
            rsp.set_id_info(req);

            // return monitor's response item to the RAL sequence
            seq_item_port.item_done(rsp);
        end
    endtask : run_phase

endclass : spi_driver

`endif