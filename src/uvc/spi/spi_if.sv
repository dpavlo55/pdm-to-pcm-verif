interface spi_if;
    logic sck;
    logic mosi;
    wire miso;
    logic cs_n;

    modport master (
        output sck,
        output cs_n,
        output mosi,
        input miso
    );

    modport slave (
        input sck,
        input cs_n,
        input mosi,
        output miso
    );

    modport monitor (
        input sck,
        input cs_n,
        input mosi,
        input miso
    );

endinterface