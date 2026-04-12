`ifndef PDM_SEQS_LIB_SVH
`define PDM_SEQS_LIB_SVH

virtual class pdm_modulator extends uvm_object;

    protected real frequency;
    protected real amplitude;
    protected real phase;
    protected real dc_offset;

    function new(string name = "pdm_modulator");
        super.new(name);
        frequency = 1000.0;
        amplitude = 0.9;
        phase = 0.0;
        dc_offset = 0.0;
    endfunction : new

    virtual function void set_parameters(real freq, real amp, real ph_deg, real dc_offs = 0.0);
        this.frequency = freq;
        this.amplitude = amp;
        this.phase = ph_deg * (3.1415926535 / 180.0);
        this.dc_offset = dc_offs;
    endfunction : set_parameters

    virtual function void get_parameters(output real freq, output real amp, output real ph_deg, output real dc_offs);
        freq = this.frequency;
        amp = this.amplitude;
        ph_deg = this.phase * (180.0 / 3.1415926535);
        dc_offs = this.dc_offset;
    endfunction : get_parameters

    pure virtual function logic modulate();

endclass : pdm_modulator

class sine_modulator extends pdm_modulator;

    `uvm_object_utils(sine_modulator)

    protected real error_acc;

    function new(string name = "sine_modulator");
        super.new(name);
        error_acc = 0.0;
    endfunction : new

    virtual function logic modulate();
        real time_in_seconds = $realtime * 1e-9;
        real value = amplitude * $sin(2 * 3.1415926535 * frequency * time_in_seconds + phase) + dc_offset;
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

// not wotking well, seems to produce too much distortion
class sine_modulator_2nd extends pdm_modulator;

    `uvm_object_utils(sine_modulator_2nd)

    protected real int1;
    protected real int2;

    function new(string name = "sine_modulator_2nd");
        super.new(name);
        int1 = 0.0;
        int2 = 0.0;
    endfunction : new

    virtual function logic modulate();
        real time_in_seconds = $realtime * 1e-9;
        real input_val = amplitude * $sin(2 * 3.1415926535 * frequency * time_in_seconds + phase);
        real y = (int2 >= 0.0) ? 1.0 : -1.0;
        real prev_int1 = int1;
        int1 += (input_val - y);
        int2 += (prev_int1 - y);
        return (y > 0.0) ? 1'b1 : 1'b0;
    endfunction : modulate

endclass : sine_modulator_2nd

// not wotking well, seems to produce too much distortion
class sine_modulator_3rd extends pdm_modulator;

    `uvm_object_utils(sine_modulator_3rd)

    protected real int1;
    protected real int2;
    protected real int3;

    function new(string name = "sine_modulator_3rd");
        super.new(name);
        int1 = 0.0;
        int2 = 0.0;
        int3 = 0.0;
    endfunction : new

    virtual function logic modulate();
        real time_in_seconds = $realtime * 1e-9;
        real input_val = amplitude * $sin(2 * 3.1415926535 * frequency * time_in_seconds + phase);
        real y = (int3 >= 0.0) ? 1.0 : -1.0;
        real prev_int1 = int1;
        real prev_int2 = int2;
        int1 += 0.3 * (input_val - y);
        int2 += 0.2 * (prev_int1  - y);
        int3 += 0.1 * (prev_int2  - y);
        return (y > 0.0) ? 1'b1 : 1'b0;
    endfunction : modulate

endclass : sine_modulator_3rd

// Triangular wave modulator using 1st-order sigma-delta
// The reference signal is a triangle wave: linearly rises from -amplitude
// to +amplitude over half a period, then falls back, repeated at frequency Hz.
class triangle_modulator extends pdm_modulator;

    `uvm_object_utils(triangle_modulator)

    protected real error_acc;

    function new(string name = "triangle_modulator");
        super.new(name);
        error_acc = 0.0;
    endfunction : new

    virtual function logic modulate();
        real time_in_seconds;
        real period;
        real t_mod;
        real value;

        time_in_seconds = $realtime * 1e-9;
        period = 1.0 / frequency;
        // Position within the current period [0, period)
        t_mod = time_in_seconds - $floor(time_in_seconds / period) * period;
        // Triangle: rises from -amp to +amp in first half, falls back in second half
        if (t_mod < period / 2.0)
            value = amplitude * (4.0 * t_mod / period - 1.0);
        else
            value = amplitude * (3.0 - 4.0 * t_mod / period);
        // Apply phase offset by shifting t_mod
        // Phase is stored in radians; convert offset: phase / (2*pi) * period
        t_mod = time_in_seconds + phase / (2.0 * 3.1415926535) * period;
        t_mod = t_mod - $floor(t_mod / period) * period;
        if (t_mod < period / 2.0)
            value = amplitude * (4.0 * t_mod / period - 1.0);
        else
            value = amplitude * (3.0 - 4.0 * t_mod / period);

        error_acc += value;
        if (error_acc >= 0.0) begin
            error_acc -= 1.0;
            return 1'b1;
        end else begin
            error_acc += 1.0;
            return 1'b0;
        end
    endfunction : modulate

endclass : triangle_modulator

// Sawtooth wave modulator using 1st-order sigma-delta.
// The reference signal rises linearly from -amplitude to +amplitude over
// one full period, then resets. Phase offset shifts the starting position.
class sawtooth_modulator extends pdm_modulator;

    `uvm_object_utils(sawtooth_modulator)

    protected real error_acc;

    function new(string name = "sawtooth_modulator");
        super.new(name);
        error_acc = 0.0;
    endfunction : new

    virtual function logic modulate();
        real time_in_seconds;
        real period;
        real t_mod;
        real value;

        time_in_seconds = $realtime * 1e-9;
        period = 1.0 / frequency;
        // Apply phase offset by shifting the time reference
        t_mod = time_in_seconds + phase / (2.0 * 3.1415926535) * period;
        // Position within the current period [0, period)
        t_mod = t_mod - $floor(t_mod / period) * period;
        // Sawtooth: linearly ramps from -amplitude to +amplitude over one period
        value = amplitude * (2.0 * t_mod / period - 1.0);

        error_acc += value;
        if (error_acc >= 0.0) begin
            error_acc -= 1.0;
            return 1'b1;
        end else begin
            error_acc += 1.0;
            return 1'b0;
        end
    endfunction : modulate

endclass : sawtooth_modulator

// Sinc pulse modulator using 1st-order sigma-delta.
// Generates a single sinc(x) = sin(π*f*t) / (π*f*t) pulse centred at t_center.
// - frequency  : controls null spacing; zero crossings occur every 1/frequency seconds
// - amplitude  : peak value at the pulse centre
// - phase      : shifts the pulse centre in time by phase/(2π) / frequency seconds
class sinc_modulator extends pdm_modulator;

    `uvm_object_utils(sinc_modulator)

    protected real error_acc;

    function new(string name = "sinc_modulator");
        super.new(name);
        error_acc = 0.0;
    endfunction : new

    virtual function logic modulate();
        real time_in_seconds;
        real t_center;
        real t_rel;
        real arg;
        real value;

        time_in_seconds = $realtime * 1e-9;
        // Centre of the pulse: shifted by phase/(2π) periods
        t_center = phase / (2.0 * 3.1415926535) / frequency;
        t_rel = time_in_seconds - t_center;
        arg   = 3.1415926535 * frequency * t_rel;
        // sinc(0) = 1 by definition; avoid divide-by-zero
        if (arg == 0.0)
            value = amplitude;
        else
            value = amplitude * $sin(arg) / arg;

        error_acc += value;
        if (error_acc >= 0.0) begin
            error_acc -= 1.0;
            return 1'b1;
        end else begin
            error_acc += 1.0;
            return 1'b0;
        end
    endfunction : modulate

endclass : sinc_modulator

// DC modulator using 1st-order sigma-delta.
// Converts a constant level to a PDM bit stream.
// - amplitude : the DC level in [-1.0, +1.0]
//               +1.0  → all 1s,  0.0 → alternating,  -1.0 → all 0s
// - frequency and phase are unused.
class dc_modulator extends pdm_modulator;

    `uvm_object_utils(dc_modulator)

    protected real error_acc;

    function new(string name = "dc_modulator");
        super.new(name);
        error_acc = 0.0;
    endfunction : new

    virtual function logic modulate();
        error_acc += amplitude;
        if (error_acc >= 0.0) begin
            error_acc -= 1.0;
            return 1'b1;
        end else begin
            error_acc += 1.0;
            return 1'b0;
        end
    endfunction : modulate

endclass : dc_modulator

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
        uvm_phase phase_obj;
        phase_obj = starting_phase;
        if (phase_obj != null) begin
            phase_obj.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "Raising objection", UVM_LOW)
        end
        if (modulator == null) begin
            `uvm_fatal(get_type_name(), "PDM Modulator strategy was not set!")
        end
    endtask : pre_body

    virtual task post_body();
        uvm_phase phase_obj;
        phase_obj = starting_phase;
        if (phase_obj != null) begin
            phase_obj.drop_objection(this, get_type_name());
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
