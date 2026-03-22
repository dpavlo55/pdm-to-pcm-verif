
if {[file exists "work"]} {
    vdel -lib work -all
}

vlib work

vmap work work

set ::env(SRC_DIR) {//wsl.localhost/Ubuntu/home/david/pdm-to-pcm/src}

set compile_cmd "vlog -sv \
    -work work \
    -lint \
    -pedanticerrors \
    -svinputport=net \
    +acc \
    -f filelist.f"

if {[catch {eval $compile_cmd} compile_err]} {
    puts "ERROR: Compilation failed — $compile_err"
    quit -code 1
}

vopt work.tt_um_example -o tt_um_example_opt -designfile design.bin -debug

vsim work.tt_um_example \
    -sv_seed random \
    -voptargs=+acc \
    -onfinish exit \
    -qwavedb=+signal+cells \
    +UVM_NO_RELNOTES

run -all
quit
