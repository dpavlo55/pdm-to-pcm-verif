interface spi_if;
    logic clk;
    logic mosi;
    wire miso;
    logic cs_n;

    modport master (
        output mosi,
        output cs_n,
        inout  miso,
        input  clk
    );

    modport slave (
        input  mosi,
        input  cs_n,
        inout  miso,
        input  clk
    );

endinterface