
if {[file exists "work"]} {
    vdel -lib work -all
}

vlib work

vmap work work

# ---------------------------------------------------------------------------
# Simulation mode
#   $1 = UVM test name                   (required)
#   $2 = sim mode: rtl | post            (optional, default: rtl)
#   $3 = SDF timing corner (post only)   (optional, default: nom_tt_025C_1v80)
#        choices: nom_tt_025C_1v80  max_ss_100C_1v60  max_ff_n40C_1v95
#                 min_tt_025C_1v80  min_ss_100C_1v60  min_ff_n40C_1v95
#                 nom_ff_n40C_1v95  nom_ss_100C_1v60  nom_tt_025C_1v80
# ---------------------------------------------------------------------------

if {[info exists 2] && ![string equal "$2" ""]} {
    set sim_mode "$2"
} else {
    set sim_mode "rtl"
}

if {[info exists 3] && ![string equal "$3" ""]} {
    set sdf_corner "$3"
} else {
    set sdf_corner "nom_tt_025C_1v80"
}

if {[string equal $sim_mode "post"]} {
    if {![info exists env(PDK_ROOT)] || [string equal $env(PDK_ROOT) ""]} {
        puts "ERROR: PDK_ROOT environment variable is not set."
        puts "       Set it to your volare install root, e.g.:"
        puts "         set PDK_ROOT=%USERPROFILE%\\.volare"
        quit -code 1
    }
    set pdk_root $env(PDK_ROOT)
    set sky130_lib "${pdk_root}/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
    set rtl_filelist "post.f"
    set compile_flags "-sv -work work -svinputport=net +acc"
    set compile_cmd "vlog $compile_flags $sky130_lib -f $rtl_filelist -f tb.f"
} else {
    set rtl_filelist "rtl.f"
    set compile_flags "-sv -work work -lint -svinputport=net +acc"
    set compile_cmd "vlog $compile_flags -f $rtl_filelist -f tb.f"
}

if {[catch {eval $compile_cmd} compile_err]} {
    puts "ERROR: Compilation failed — $compile_err"
    quit -code 1
}

vopt work.pdm_to_pcm_top_tb -o pdm_to_pcm_top_tb_opt -designfile design.bin -debug

if {[string equal $sim_mode "post"]} {
    set sdf_file "../rtl_post/sdf/${sdf_corner}/tt_um_top__${sdf_corner}.sdf"
    vsim work.pdm_to_pcm_top_tb \
        -sv_seed random \
        -voptargs=+acc \
        -onfinish exit \
        -qwavedb=+signal+cells+uvm_configdb+class+transaction+uvm_schematic+uvm_register+uvm_factory \
        +UVM_NO_RELNOTES \
        +UVM_TESTNAME=$1 \
        +UVM_MAX_QUIT_COUNT=1 \
        -sdfmax /pdm_to_pcm_top_tb/dut/tt_um_top_inst=${sdf_file} \
} else {
    vsim work.pdm_to_pcm_top_tb \
        -sv_seed random \
        -voptargs=+acc \
        -onfinish exit \
        -qwavedb=+signal+cells+uvm_configdb+class+transaction+uvm_schematic+uvm_register+uvm_factory \
        +UVM_NO_RELNOTES \
        +UVM_TESTNAME=$1 \
        +UVM_MAX_QUIT_COUNT=1 \
}

run -all
quit
