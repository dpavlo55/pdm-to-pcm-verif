`ifndef PDM_SEQS_LIB_SVH
`define PDM_SEQS_LIB_SVH

interface class pdm_modulator;

    pure virtual function logic modulate();
    pure virtual function void set_parameters(real freq, real amp, real ph);

endclass : pdm_modulator

class sine_modulator extends uvm_object implements pdm_modulator;

    `uvm_object_utils(sine_modulator)

    protected real frequency;
    protected real amplitude;
    protected real phase;
    protected real error_acc;

    function new(string name = "sine_modulator");
        super.new(name);
        frequency = 1000.0;
        amplitude = 0.9;
        phase = 0.0;
        error_acc = 0.0;
    endfunction : new

    virtual function void set_parameters(real freq, real amp, real ph);
        this.frequency = freq;
        this.amplitude = amp;
        this.phase = ph;
    endfunction : set_parameters

    virtual function void get_parameters(output real freq, output real amp, output real ph);
        freq = this.frequency;
        amp = this.amplitude;
        ph = this.phase;
    endfunction : get_parameters

    virtual function logic modulate();
        // Scale $realtime from 1ns timeunits to seconds
        real time_in_seconds = $realtime * 1e-9;

        real value = amplitude * $sin(2 * 3.1415926535 * frequency * time_in_seconds + phase);

        error_acc += value;

        if (error_acc >= 0.0) begin
            error_acc -= 1.0;
            return 1'b1;
        end else begin
            error_acc += 1.0;
            return 1'b0;
        end
    endfunction : modulate

endclass : sine_modulator

class pdm_base_seq extends uvm_sequence #(pdm_seq_item);

    `uvm_object_utils(pdm_base_seq)
    `uvm_declare_p_sequencer(pdm_sequencer)

    protected pdm_modulator modulator;

    function new(string name = "pdm_base_seq");
        super.new(name);
    endfunction

    virtual function void set_modulator(pdm_modulator mod);
        this.modulator = mod;
    endfunction : set_modulator

    virtual function pdm_modulator get_modulator();
        return this.modulator;
    endfunction : get_modulator

    virtual task pre_body();
        uvm_phase phase;
        phase = starting_phase;
        if (phase != null) begin
            phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "Raising objection", UVM_LOW)
        end

        if (modulator == null) begin
            `uvm_fatal(get_type_name(), "PDM Modulator strategy was not set!")
        end
    endtask : pre_body

    virtual task post_body();
        uvm_phase phase;
        phase = starting_phase;
        if (phase != null) begin
            phase.drop_objection(this, get_type_name());
            `uvm_info(get_type_name(), "Dropping objection", UVM_LOW)
        end
    endtask : post_body

endclass : pdm_base_seq

class pdm_seq extends pdm_base_seq;

    `uvm_object_utils(pdm_seq)

    function new(string name = "pdm_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        pdm_seq_item item;
        forever begin
            p_sequencer.request_fifo.get(item);
            start_item(item);
            item.pdm_data = modulator.modulate();
            finish_item(item);
        end
    endtask : body

endclass : pdm_seq

`endif