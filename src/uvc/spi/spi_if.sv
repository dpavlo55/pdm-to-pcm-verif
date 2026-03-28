interface spi_if;
    logic clk;
    logic mosi;
    wire miso;
    logic cs_n;

    modport master (
        output clk,
        output cs_n,
        output mosi,
        input miso
    );

    modport slave (
        input clk,
        input cs_n,
        input mosi,
        output miso
    );

    modport monitor (
        input clk,
        input cs_n,
        input mosi,
        input miso
    );

endinterface