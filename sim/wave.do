onerror resume
wave tags 
wave update off
wave zoom range 0 10052000000
wave group Transaction -backgroundcolor #006666
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.spi_if_inst -backgroundcolor #004466
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.cs_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.cs_n -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.pdm_if_inst -backgroundcolor #004466
wave add -group pdm_to_pcm_top_tb.pdm_if_inst pdm_to_pcm_top_tb.pdm_if_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.pdm_if_inst pdm_to_pcm_top_tb.pdm_if_inst.data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.pdm_if_inst pdm_to_pcm_top_tb.pdm_if_inst.pdm_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.pdm_if_inst pdm_to_pcm_top_tb.pdm_if_inst.pdm_en -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut -backgroundcolor #226600
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_cs_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_req -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_req_is_wr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_addr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_rd_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.hwif_out -tag F0 -radix string
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_cs_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_req -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_req_is_wr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_addr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_rd_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.hwif_out -tag F0 -radix string
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.spi_inst -backgroundcolor #666600
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.cs_n -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_data_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_reg -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_data_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.CNT_MAX -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_reg -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_re -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_fe -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt_ovf -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt_ovf_reg -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.cs_n -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_data_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_reg -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_data_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.CNT_MAX -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_reg -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_re -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_fe -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt_ovf -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt_ovf_reg -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.regs_inst -backgroundcolor #004466
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_req -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_req_is_wr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_addr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_wr_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_rd_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_wr_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.hwif_out -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.wr_strobe_control -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.wr_strobe_control_low -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.wr_strobe_control_high -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_enable -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_divider -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_test -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_low_value -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_high_value -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_req -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_req_is_wr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_addr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_wr_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_rd_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.s_cpuif_wr_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.hwif_out -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.wr_strobe_control -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.wr_strobe_control_low -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.wr_strobe_control_high -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_enable -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_divider -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_test -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_low_value -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.control_high_value -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.regs_inst pdm_to_pcm_top_tb.dut.regs_inst.hwif_out -tag F0 -radix hexadecimal -expand -subitemconfig { pdm_to_pcm_top_tb.dut.regs_inst.hwif_out.control {-radix hexadecimal} pdm_to_pcm_top_tb.dut.regs_inst.hwif_out.control_low {-radix hexadecimal} pdm_to_pcm_top_tb.dut.regs_inst.hwif_out.control_high {-radix hexadecimal} pdm_to_pcm_top_tb.dut.regs_inst.hwif_out.nco_control {-expand -radix hexadecimal} pdm_to_pcm_top_tb.dut.regs_inst.hwif_out.nco_control.high {-radix hexadecimal} pdm_to_pcm_top_tb.dut.regs_inst.hwif_out.nco_control.low {-radix hexadecimal} }
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst -backgroundcolor #004466
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.N -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.enable -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.step -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.pdm_clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.pdm_clk_re -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.pdm_clk_fe -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.acc -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst.carry -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.pdm_sampler_inst -backgroundcolor #004466
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_clk_re -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_clk_fe -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst {pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_data_left[0]} -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_data_left_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst {pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_data_right[0]} -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.pdm_sampler_inst pdm_to_pcm_top_tb.dut.pdm_sampler_inst.pdm_data_right_valid -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.cic_left_inst -backgroundcolor #006666
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst pdm_to_pcm_top_tb.dut.cic_left_inst.PIPELINE_ENABLE -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst pdm_to_pcm_top_tb.dut.cic_left_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst pdm_to_pcm_top_tb.dut.cic_left_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst {pdm_to_pcm_top_tb.dut.cic_left_inst.sig_in[0]} -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst pdm_to_pcm_top_tb.dut.cic_left_inst.sig_in_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst pdm_to_pcm_top_tb.dut.cic_left_inst.sig_out -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_left_inst pdm_to_pcm_top_tb.dut.cic_left_inst.sig_out_valid -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.cic_right_inst -backgroundcolor #226600
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst pdm_to_pcm_top_tb.dut.cic_right_inst.PIPELINE_ENABLE -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst pdm_to_pcm_top_tb.dut.cic_right_inst.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst pdm_to_pcm_top_tb.dut.cic_right_inst.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst {pdm_to_pcm_top_tb.dut.cic_right_inst.sig_in[0]} -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst pdm_to_pcm_top_tb.dut.cic_right_inst.sig_in_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst pdm_to_pcm_top_tb.dut.cic_right_inst.sig_out -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.cic_right_inst pdm_to_pcm_top_tb.dut.cic_right_inst.sig_out_valid -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut.cic_right_inst -collapse
wave group pdm_to_pcm_top_tb.dut.cic_left_inst -collapse
wave group pdm_to_pcm_top_tb.dut.pdm_sampler_inst -collapse
wave group pdm_to_pcm_top_tb.dut.pdm_clk_gen_inst -collapse
wave group pdm_to_pcm_top_tb.dut.regs_inst -collapse
wave group pdm_to_pcm_top_tb.dut.spi_inst -collapse
wave group pdm_to_pcm_top_tb.dut -collapse
wave group pdm_to_pcm_top_tb.pdm_if_inst -collapse
wave group pdm_to_pcm_top_tb.spi_if_inst -collapse
wave update on
wave top 0
