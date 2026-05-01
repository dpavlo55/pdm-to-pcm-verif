interface pdm_if;

    logic clk;
    wire data;

    logic pdm_data;
    logic pdm_en = 1'b0;

    assign data = pdm_en ? pdm_data : 1'bZ;

    modport master (
        output clk,
        inout data
    );

    modport slave (
        input clk,
        inout data
    );

endinterface