`ifndef I2S_MONITOR_SVH
`define I2S_MONITOR_SVH

class i2s_monitor extends uvm_monitor;

    `uvm_component_utils(i2s_monitor)

    typedef virtual interface i2s_if vif_t;
    typedef i2s_seq_item item_t;

    protected vif_t vif;
    protected i2s_configuration configuration;

    uvm_analysis_port #(item_t) output_ap;

    function new(string name = "i2s_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "This is monitor's build phase", UVM_DEBUG)

        if (!uvm_resource_db#(i2s_configuration)::read_by_type(
            get_full_name(), configuration, this)) begin
            `uvm_fatal(get_type_name(),
                "Failed to retrive I2S configuration from uvm_resource_db")
        end

        vif = configuration.get_vif();

        output_ap = new("output_ap", this);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        item_t item;

        `uvm_info(get_type_name(), "This is monitor's run phase", UVM_DEBUG)

        do begin
            @(posedge vif.bclk);
        end while (vif.lrclk !== 1'b0);

        forever begin
            item = item_t::type_id::create("item", this);

            foreach (item.data_left[i]) begin
                @(posedge vif.bclk);
                item.data_left[15 - i] = vif.sdata;
            end

            foreach (item.data_right[i]) begin
                @(posedge vif.bclk);
                item.data_right[15 - i] = vif.sdata;
            end

            output_ap.write(item);

            `uvm_info(get_type_name(), $sformatf("Captured I2S transaction:\n%s",
                item.convert2string()), UVM_DEBUG)
        end

    endtask : run_phase

endclass : i2s_monitor

`endif