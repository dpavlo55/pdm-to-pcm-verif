import uvm_pkg::*;
`include "uvm_macros.svh"

import pdm_to_pcm_test_pkg::*;

module pdm_to_pcm_top_tb;

    timeunit 1ns/1ps;

    // Clock and reset
    logic clk;
    logic rst_n;
    logic pdm_in;

    // interfaces
    spi_if spi_if_inst();

    pdm_to_pcm_top dut (
        .clk (clk),
        .rst_n (rst_n),
        .pdm_in (pdm_in),
        .spi_clk (spi_if_inst.clk),
        .spi_mosi (spi_if_inst.mosi),
        .spi_miso (spi_if_inst.miso),
        .spi_cs_n (spi_if_inst.cs_n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5ns clk = ~clk; // 100 MHz clock
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

    // Randomize pdm_in
    task automatic gen_pdm_in();

        pdm_in = 1'b0;

        // Wait for reset to deassert
        @(negedge rst_n);
        @(posedge rst_n);

        // Randomize pdm_in every clock cycle
        forever @(posedge clk) begin
            int delay;
            if (!std::randomize(delay) with { delay inside {[0:10]}; }) begin
                $fatal("Randomization failed for delay");
            end
            wait_clk(delay);
            pdm_in <= ~pdm_in;
        end
    endtask : gen_pdm_in

    initial begin
        fork
            gen_pdm_in();
        join_none
        #100ns;
        $finish;
    end

    // UVM testbench initialization
    initial begin
        `uvm_info("UVM_VERSION", $sformatf("UVM version is %0s", `UVM_VERSION_STRING), UVM_LOW)
        // Set the virtual interface in the resource database
        uvm_resource_db#(virtual interface spi_if)::set(
            uvm_top.get_full_name(), "spi_if", spi_if_inst, null);
        // Run the UVM test
        run_test("base_test");
    end

endmodule