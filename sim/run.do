
if {[file exists "work"]} {
    vdel -lib work -all
}

vlib work

vmap work work

set compile_cmd "vlog -sv \
    -work work \
    -lint \
    -svinputport=net \
    +acc \
    -f rtl.f \
    -f tb.f"

if {[catch {eval $compile_cmd} compile_err]} {
    puts "ERROR: Compilation failed — $compile_err"
    quit -code 1
}

vopt work.pdm_to_pcm_top_tb -o pdm_to_pcm_top_tb_opt -designfile design.bin -debug

vsim work.pdm_to_pcm_top_tb \
    -sv_seed random \
    -voptargs=+acc \
    -onfinish exit \
    -qwavedb=+signal+cells+uvm_configdb+class+transaction+uvm_schematic+uvm_register+uvm_factory \
    +UVM_NO_RELNOTES \

run -all
quit
