import uvm_pkg::*;
`include "uvm_macros.svh"

import pdm_to_pcm_test_pkg::*;

module pdm_to_pcm_top_tb;

    timeunit 1ns/1ps;

    localparam real CLOCK_FREQUENCY  = 50.0e6;
    localparam real CLOCK_PERIOD      = 1.0 / CLOCK_FREQUENCY;
    localparam real PDM_SAMPLE_RATE   = 2.0e6;
    localparam int  CLKS_PER_SAMPLE   = int'(CLOCK_FREQUENCY / PDM_SAMPLE_RATE); // 25
    //localparam string PDM_FILE        = "pdm_10kHz_2MHz.txt";
    localparam string PDM_FILE        = "pdm_2kHz_2MHz.txt";
    //localparam string PDM_FILE        = "pdm_2kHz_4MHz.txt";
    //localparam string PDM_FILE        = "pdm_10kHz_4MHz.txt";
    //localparam string PDM_FILE        = "pdm_2kHz_2MHz_10ms.txt";

    // Clock and reset
    logic clk;
    logic rst_n;
    logic pdm_in;
    logic pdm_in_valid;

    // interfaces
    spi_if spi_if_inst();

    pdm_to_pcm_top dut (
        .clk (clk),
        .rst_n (rst_n),
        .pdm_in (pdm_in),
        .pdm_in_valid (pdm_in_valid),
        .spi_sck (spi_if_inst.sck),
        .spi_mosi (spi_if_inst.mosi),
        .spi_miso (spi_if_inst.miso),
        .spi_cs_n (spi_if_inst.cs_n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLOCK_PERIOD / 2.0 * 1s) clk = ~clk;
    end

    task automatic wait_clk(input int delay);
        repeat (delay) @(posedge clk);
    endtask

    // Reset generation
    initial begin
        rst_n = 1'b1;
        #20ns rst_n = 1'b0;
        wait_clk(5);
        rst_n = 1'b1;
    end

    // Drive pdm_in and pdm_in_valid from a PDM sample file.
    // Each line contains a single bit (0 or 1).
    // pdm_in_valid is a 1-cycle-wide pulse every CLKS_PER_SAMPLE clock cycles.
    task automatic gen_pdm_from_file(input string filename);
        integer fd;
        integer code;
        integer val;

        pdm_in       = 1'b0;
        pdm_in_valid = 1'b0;

        // Wait for reset to deassert
        @(negedge rst_n);
        @(posedge rst_n);

        fd = $fopen(filename, "r");
        if (fd == 0)
            $fatal(1, "gen_pdm_from_file: cannot open '%s'", filename);

        while (!$feof(fd)) begin
            code = $fscanf(fd, "%d\n", val);
            if (code != 1) break;
            // Assert valid for exactly 1 cycle, then hold pdm_in stable for
            // the remaining CLKS_PER_SAMPLE-1 cycles.
            @(posedge clk);
            pdm_in       <= val[0];
            pdm_in_valid <= 1'b1;
            @(posedge clk);
            pdm_in_valid <= 1'b0;
            repeat (CLKS_PER_SAMPLE - 2) @(posedge clk);
        end

        $fclose(fd);
        `uvm_info("PDM_GEN", "PDM file playback complete", UVM_LOW)
    endtask : gen_pdm_from_file

    initial begin
        gen_pdm_from_file(PDM_FILE);
        #100ns;
    end

    // UVM testbench initialization
    initial begin
        `uvm_info("UVM_VERSION", $sformatf("UVM version is %0s", `UVM_VERSION_STRING), UVM_LOW)
        // Set the virtual interface in the resource database
        uvm_resource_db#(virtual interface spi_if)::set(
            uvm_top.get_full_name(), "spi_if", spi_if_inst, null);
        // Run the UVM test
        run_test();
    end

endmodule