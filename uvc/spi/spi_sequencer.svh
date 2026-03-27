`ifndef SPI_SEQUENCER_SVH
`define SPI_SEQUENCER_SVH

class spi_sequencer #(int WIDTH = 8) extends uvm_sequencer #(spi_seq_item#(WIDTH));

    `uvm_component_param_utils(spi_sequencer#(WIDTH))

    function new(string name = "spi_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

endclass : spi_sequencer

`endif