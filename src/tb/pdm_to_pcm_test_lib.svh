`ifndef PDM_TO_PCM_TEST_LIB_SVH
`define PDM_TO_PCM_TEST_LIB_SVH

class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    spi_configuration spi_config;
    spi_configuration::vif_t spi_vif;
    spi_agent spi_master;

    pdm_configuration pdm_config_left, pdm_config_right;
    pdm_configuration::vif_t pdm_vif;
    pdm_agent pdm_mic_left, pdm_mic_right;

    pdm_to_pcm_reg regs;
    spi_reg_adapter reg_adapter;
    spi_reg_predictor reg_predictor;

    uvm_status_e status;

    bit [7:0] rd_data;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is test's build phase", UVM_DEBUG)

        // SPI master configuration

        spi_config = spi_configuration::type_id::create("spi_config", this);
        spi_config.set_is_active(UVM_ACTIVE);

        if (!uvm_resource_db#(virtual interface spi_if)::read_by_type(
            get_full_name(), spi_vif, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to get virtual SPI interface from uvm_resource_db")
        end

        spi_config.set_vif(spi_vif);

        spi_master = spi_agent::type_id::create("spi_master", this);

        uvm_resource_db#(spi_configuration)::set(
            {get_full_name(), ".", spi_master.get_name()}, "configuration",
            spi_config, this);


        // PDM microphone agents configuration

        if (!uvm_resource_db#(virtual interface pdm_if)::read_by_type(
            get_full_name(), pdm_vif, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to get virtual PDM interface from uvm_resource_db")
        end

        // left side
        pdm_config_left = pdm_configuration::type_id::create("pdm_config_left", this);
        pdm_config_left.set_side(pdm_configuration::MIC_LEFT);
        pdm_config_left.set_vif(pdm_vif);

        pdm_mic_left = pdm_agent::type_id::create("pdm_mic_left", this);

        uvm_resource_db#(pdm_configuration)::set(
            {get_full_name(), ".", pdm_mic_left.get_name()}, "configuration",
            pdm_config_left, this);

        // right side
        pdm_config_right = pdm_configuration::type_id::create("pdm_config_right", this);
        pdm_config_right.set_side(pdm_configuration::MIC_RIGHT);
        pdm_config_right.set_vif(pdm_vif);

        pdm_mic_right = pdm_agent::type_id::create("pdm_mic_right", this);

        uvm_resource_db#(pdm_configuration)::set(
            {get_full_name(), ".", pdm_mic_right.get_name()}, "configuration",
            pdm_config_right, this);


        // Register model configuration

        regs = new("regs");
        regs.configure(null, "pdm_to_pcm_top_tb.dut.regs_inst");
        regs.build();
        regs.lock_model();

        reg_adapter = spi_reg_adapter::type_id::create("reg_adapter", this);
        reg_predictor = spi_reg_predictor::type_id::create("reg_predictor", this);

    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (spi_config.get_is_active() == UVM_ACTIVE) begin
            regs.default_map.set_sequencer(spi_master.get_sequencer(), reg_adapter);
        end
        reg_predictor.adapter = reg_adapter;
        reg_predictor.map = regs.default_map;
        spi_master.monitor.output_ap.connect(reg_predictor.bus_in);
    endfunction : connect_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is test's end_of_elaboration_phase", UVM_DEBUG)
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

    virtual task reset_phase(uvm_phase phase);
        regs.reset();
    endtask : reset_phase

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Hello World", UVM_MEDIUM)
    endtask
endclass

class reg_bit_bash_test extends base_test;

    `uvm_component_utils(reg_bit_bash_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        uvm_reg_bit_bash_seq seq;

        `uvm_info(get_type_name(), "This is the reg_bit_bash test's run phase", UVM_DEBUG)
        phase.phase_done.set_drain_time(this, 1us);

        phase.raise_objection(this);

        seq = uvm_reg_bit_bash_seq::type_id::create("seq");
        seq.model = regs;
        seq.start(spi_master.get_sequencer());

        phase.drop_objection(this);
    endtask : run_phase

endclass : reg_bit_bash_test

class reg_hw_reset_test extends base_test;

    `uvm_component_utils(reg_hw_reset_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        uvm_reg_hw_reset_seq seq;
        `uvm_info(get_type_name(), "This is the reg_hw_reset test's run phase", UVM_DEBUG)
        phase.phase_done.set_drain_time(this, 1us);

        phase.raise_objection(this);

        seq = uvm_reg_hw_reset_seq::type_id::create("seq");
        seq.model = regs;
        seq.start(spi_master.get_sequencer());

        phase.drop_objection(this);
    endtask : run_phase

endclass : reg_hw_reset_test

class reg_access_test extends base_test;

    `uvm_component_utils(reg_access_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        uvm_reg_access_seq seq;
        `uvm_info(get_type_name(), "This is the reg_access test's run phase", UVM_DEBUG)
        phase.phase_done.set_drain_time(this, 1us);

        phase.raise_objection(this);

        seq = uvm_reg_access_seq::type_id::create("seq");
        seq.model = regs;
        seq.start(spi_master.get_sequencer());

        phase.drop_objection(this);
    endtask : run_phase

endclass : reg_access_test

class pdm_clk_test extends base_test;

    `uvm_component_utils(pdm_clk_test)

    pdm_seq seq_left;
    pdm_modulator modulator_left;

    pdm_seq seq_right;
    pdm_modulator modulator_right;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seq_left = pdm_seq::type_id::create("seq_left");
        modulator_left = sine_modulator::type_id::create("modulator_left");
        modulator_left.set_parameters(3.3e3, 0.9, 0.0);
        seq_left.set_modulator(modulator_left);

        seq_right = pdm_seq::type_id::create("seq_right");
        modulator_right = sine_modulator::type_id::create("modulator_right");
        modulator_right.set_parameters(2.0e3, 0.9, 0.0);
        seq_right.set_modulator(modulator_right);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is the clock test's run phase", UVM_DEBUG)
        phase.phase_done.set_drain_time(this, 10ms);
        phase.raise_objection(this);

        fork
            seq_left.start(pdm_mic_left.get_sequencer());
            seq_right.start(pdm_mic_right.get_sequencer());
        join_none

        regs.nco_control.write(status, 16'd2884 * 2);

        regs.control.enable.set(1'b1);
        regs.control.update(status);

        phase.drop_objection(this);

    endtask : run_phase

endclass : pdm_clk_test

`endif