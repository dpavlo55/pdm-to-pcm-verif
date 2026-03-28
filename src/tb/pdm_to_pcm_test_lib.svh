`ifndef PDM_TO_PCM_TEST_LIB_SVH
`define PDM_TO_PCM_TEST_LIB_SVH

class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    spi_configuration spi_config;
    spi_agent spi;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is test's build phase", UVM_DEBUG)

        spi_config = spi_configuration::type_id::create("spi_config", this);
        spi_config.set_is_active(UVM_ACTIVE);

        begin
            spi_configuration::vif_t vif;

            if (!uvm_resource_db#(virtual interface spi_if)::read_by_type(
                get_full_name(), vif, this)) begin
                `uvm_fatal(get_type_name(),
                    "Failed to get virtual AXI4-Lite interface from uvm_resource_db")
            end

            spi_config.set_vif(vif);

        end

    endfunction : build_phase

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Hello World", UVM_MEDIUM)
    endtask
endclass

`endif