// Post P&R adapter: wraps the tt_um_top gate-level netlist and presents the
// pdm_to_pcm_top interface so the existing testbench can be reused without
// modification.  Signal mapping mirrors rtl/src/tt_um_top.sv exactly.
//
// This file is compiled instead of the RTL sources when SIM_MODE=post.
// It is included by post.f and must NOT be added to rtl.f or tb.f.

module pdm_to_pcm_top (
    input  logic clk,
    input  logic rst_n,

    output logic pdm_clk,
    input  logic pdm_data,

    // SPI interface
    input  logic spi_sck,
    input  logic spi_mosi,
    output logic spi_miso,
    input  logic spi_cs_n
);

    logic [7:0] ui_in;
    logic [7:0] uo_out;
    logic [7:0] uio_in;
    logic [7:0] uio_out;
    logic [7:0] uio_oe;

    // Map DUT signals to TT I/O bus — must stay in sync with rtl/src/tt_um_top.sv
    assign ui_in  = {4'b0, pdm_data, spi_cs_n, spi_mosi, spi_sck};
    assign uio_in = 8'b0;

    assign spi_miso = uio_out[0];
    assign pdm_clk  = uo_out[0];

    tt_um_top tt_um_top_inst (
        .clk    (clk),
        .rst_n  (rst_n),
        .ena    (1'b1),
        .ui_in  (ui_in),
        .uo_out (uo_out),
        .uio_in (uio_in),
        .uio_out(uio_out),
        .uio_oe (uio_oe)
    );

endmodule : pdm_to_pcm_top
