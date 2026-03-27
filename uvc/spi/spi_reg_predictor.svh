`ifndef SPI_REG_PREDICTOR_SVH
`define SPI_REG_PREDICTOR_SVH

class spi_reg_predictor extends uvm_reg_predictor #(spi_seq_item);

    `uvm_component_utils(spi_reg_predictor)

    function new(string name = "spi_reg_predictor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

endclass : spi_reg_predictor

`endif
