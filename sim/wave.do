onerror resume
wave tags  F0
wave update off
wave zoom range 0 69100000
wave group pdm_to_pcm_top_tb.spi_if_inst -backgroundcolor #004466
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.spi_if_inst pdm_to_pcm_top_tb.spi_if_inst.cs_n -tag F0 -radix hexadecimal
wave group pdm_to_pcm_top_tb.spi_if_inst:Transaction -backgroundcolor #006666
wave add -group pdm_to_pcm_top_tb.spi_if_inst:Transaction uvm_test_top.spi_master.sequencer.default_parent_seq -tag F0 -radix string -expand -subitemconfig { cmd {-radix string} reg {-radix string} addr {-radix hexadecimal} data {-radix hexadecimal} }
wave insertion [expr [wave index insertpoint] + 1]
wave insertion [expr [wave index insertpoint] + 1]
wave group pdm_to_pcm_top_tb.dut -backgroundcolor #226600
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.clk -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.rst_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.pdm_in -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.spi_cs_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.sck_meta -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.sck -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.mosi_meta -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.mosi -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.cs_n_meta -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.cs_n -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.miso -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_req -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_req_is_wr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_addr -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_rd_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_rd_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_ack -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut pdm_to_pcm_top_tb.dut.s_cpuif_wr_err -tag F0 -radix hexadecimal
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
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_data -tag F0 -radix hexadecimal -subitemconfig { {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[7]} {-radix hexadecimal} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[6]} {-radix hexadecimal} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[5]} {-radix hexadecimal -select} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[4]} {-radix hexadecimal} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[3]} {-radix hexadecimal} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[2]} {-radix hexadecimal} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[1]} {-radix hexadecimal} {pdm_to_pcm_top_tb.dut.spi_inst.mosi_data[0]} {-radix hexadecimal} }
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_data_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.mosi_reg -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_data -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_data_valid -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.CNT_MAX -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.miso_reg -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_re -tag F0 -radix hexadecimal -select
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_fe -tag F0 -radix hexadecimal
wave spacer -group pdm_to_pcm_top_tb.dut.spi_inst {}
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt_ovf -tag F0 -radix hexadecimal
wave add -group pdm_to_pcm_top_tb.dut.spi_inst pdm_to_pcm_top_tb.dut.spi_inst.sck_cnt_ovf_reg -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave add pdm_to_pcm_top_tb.dut.spi_inst.CNT_MAX -tag F0 -radix hexadecimal
wave group pdm_to_pcm_top_tb.dut -collapse
wave update on
wave top 0
