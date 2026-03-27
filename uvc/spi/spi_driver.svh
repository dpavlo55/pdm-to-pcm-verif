`ifndef SPI_DRIVER_SVH
`define SPI_DRIVER_SVH

class spi_driver #(int WIDTH = 8) extends uvm_driver #(spi_seq_item#(WIDTH));

    // factory registration
    `uvm_component_param_utils(spi_driver#(WIDTH))

    typedef virtual interface spi_if vif_t;
    typedef spi_seq_item#(WIDTH) item_t;

    protected vif_t vif;
    protected spi_configuration configuration;

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
    endfunction : build_phase

    virtual task automatic delay(input int NUMBER_OF_DELAY_CYCLES = 1);
        @(posedge vif.aclk);
        if (NUMBER_OF_DELAY_CYCLES != 0) begin
            repeat (NUMBER_OF_DELAY_CYCLES) @(posedge vif.aclk);
        end
    endtask : delay

    virtual task run_phase(uvm_phase phase);
        // your code here
    endtask : run_phase

endclass : spi_driver

`endif