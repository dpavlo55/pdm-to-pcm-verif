`ifndef PDM_TO_PCM_TEST_LIB_SVH
`define PDM_TO_PCM_TEST_LIB_SVH

class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    spi_configuration spi_config;
    spi_configuration::vif_t spi_vif;
    spi_agent spi_master;

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

        regs = new("regs");
        regs.build();
        regs.lock_model();
        regs.default_map.set_auto_predict(1'b1);

        reg_adapter = spi_reg_adapter::type_id::create("reg_adapter", this);
        reg_predictor = spi_reg_predictor::type_id::create("reg_predictor", this);

    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (spi_config.get_is_active() == UVM_ACTIVE) begin
            regs.default_map.set_sequencer(spi_master.get_sequencer(), reg_adapter);
            reg_predictor.adapter = reg_adapter;
            reg_predictor.map = regs.default_map;
        end
    endfunction : connect_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is test's end_of_elaboration_phase", UVM_DEBUG)
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Hello World", UVM_MEDIUM)
        phase.phase_done.set_drain_time(this, 10ms);

        phase.raise_objection(this);

        regs.control.write(status, 8'hAB);
        regs.data.write(status, 8'hDA);

        regs.control.read(status, rd_data);
        regs.data.read(status, rd_data);

        phase.drop_objection(this);
    endtask
endclass

`endif