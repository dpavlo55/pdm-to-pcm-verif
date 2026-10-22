`ifndef CIC_DUAL_FOLDED_MODEL_SVH
`define CIC_DUAL_FOLDED_MODEL_SVH

// ---------------------------------------------------------------------------
// cic_dual_folded_model — bit-accurate CIC decimation filter reference model
//
//   new()                                 — constructor; calls reset().
//   reset()                               — zeros all internal state.
//   step(pdm_left, pdm_right, ... ) : bit — process one PDM input bit per channel.
//                                           Sets pcm outputs and returns 1 every R calls;
//                                           returns 0 on all other calls.
// ---------------------------------------------------------------------------
class cic_dual_folded_model;

    // -----------------------------------------------------------------------
    // Parameters (baked in at generation time)
    // -----------------------------------------------------------------------
    localparam int N    = 3;
    localparam int R    = 32;
    localparam int M    = 1;
    localparam int Bout = 8;
    localparam int WIDTH = 16; // Folded architecture uses uniform 16-bit width

    // -----------------------------------------------------------------------
    // Internal state
    // -----------------------------------------------------------------------
    protected longint _integ_left[3];
    protected longint _integ_right[3];
    protected longint _comb_dly_left[3][1];
    protected longint _comb_dly_right[3][1];
    protected int     _dec_cnt;

    // -----------------------------------------------------------------------
    // Constructor
    // -----------------------------------------------------------------------
    function new();
        reset();
    endfunction

    // -----------------------------------------------------------------------
    // reset — zero all internal state
    // -----------------------------------------------------------------------
    function void reset();
        for (int i = 0; i < N; i++) begin
            _integ_left[i]  = 0;
            _integ_right[i] = 0;
            for (int m = 0; m < M; m++) begin
                _comb_dly_left[i][m]  = 0;
                _comb_dly_right[i][m] = 0;
            end
        end
        _dec_cnt = 0;
    endfunction

    // -----------------------------------------------------------------------
    // step — process one PDM sample pair
    //
    //   pdm_in_left  : 1-bit PDM input (0 or 1) for left channel
    //   pdm_in_right : 1-bit PDM input (0 or 1) for right channel
    //   pcm_out_left : signed int; written when return value is 1
    //   pcm_out_right: signed int; written when return value is 1
    //   returns      : 1 when new PCM samples are ready, 0 otherwise
    // -----------------------------------------------------------------------
    function bit step(input bit pdm_in_left, input bit pdm_in_right, output int pcm_out_left, output int pcm_out_right);
        longint feed_l;
        longint feed_r;
        longint comb_val_l;
        longint comb_val_r;
        bit     dec_en;
        longint dly_out;

        // --- Integrators (Sequential cascade mirroring the single-ALU carousel) ---
        // Unlike the parallel normal CIC, the folded CIC immediately feeds
        // the freshly updated stage into the next stage during the same cycle.

        // Left Channel Integrators
        feed_l = pdm_in_left ? longint'(1) : longint'(-1);
        _integ_left[0] = wrap_bits(_integ_left[0] + feed_l, WIDTH);
        _integ_left[1] = wrap_bits(_integ_left[1] + _integ_left[0], WIDTH);
        _integ_left[2] = wrap_bits(_integ_left[2] + _integ_left[1], WIDTH);

        // Right Channel Integrators
        feed_r = pdm_in_right ? longint'(1) : longint'(-1);
        _integ_right[0] = wrap_bits(_integ_right[0] + feed_r, WIDTH);
        _integ_right[1] = wrap_bits(_integ_right[1] + _integ_right[0], WIDTH);
        _integ_right[2] = wrap_bits(_integ_right[2] + _integ_right[1], WIDTH);

        // --- Decimation counter ---
        dec_en   = (_dec_cnt == R - 1);
        _dec_cnt = dec_en ? 0 : _dec_cnt + 1;
        if (!dec_en) return 0;

        // --- Comb stages (run every R-th input) ---
        // The folded architecture uses the newly computed integrator state
        // (ch_left_int_last / ch_right_int_last) directly into the first comb.

        // Left Channel Combs
        comb_val_l = _integ_left[N-1];
        for (int i = 0; i < N; i++) begin
            dly_out = _comb_dly_left[i][M-1];
            for (int m = M-1; m > 0; m--) _comb_dly_left[i][m] = _comb_dly_left[i][m-1];
            _comb_dly_left[i][0] = comb_val_l;
            comb_val_l = wrap_bits(comb_val_l - dly_out, WIDTH);
        end

        // Right Channel Combs
        comb_val_r = _integ_right[N-1];
        for (int i = 0; i < N; i++) begin
            dly_out = _comb_dly_right[i][M-1];
            for (int m = M-1; m > 0; m--) _comb_dly_right[i][m] = _comb_dly_right[i][m-1];
            _comb_dly_right[i][0] = comb_val_r;
            comb_val_r = wrap_bits(comb_val_r - dly_out, WIDTH);
        end

        // --- Output: top Bout bits (16-bit to 8-bit MSB extraction)
        pcm_out_left  = int'(top_bits(comb_val_l, WIDTH, Bout));
        pcm_out_right = int'(top_bits(comb_val_r, WIDTH, Bout));

        return 1;
    endfunction

    // -----------------------------------------------------------------------
    // wrap_bits — wrap v to w signed bits (SV register truncation equivalent)
    // -----------------------------------------------------------------------
    protected function longint wrap_bits(input longint v, input int w);
        longint mask;
        if (w <= 0 || w >= 64) return v;
        mask = (longint'(1) << w) - 1;
        v    = v & mask;
        if ((v >> (w - 1)) & 1) v = v | ~mask;  // sign-extend
        return v;
    endfunction

    // -----------------------------------------------------------------------
    // top_bits — extract top to_w bits from a from_w-bit signed value
    //            equivalent to SV bit-select v[from_w-1 : from_w-to_w]
    // -----------------------------------------------------------------------
    protected function longint top_bits(input longint v, input int from_w, input int to_w);
        v = wrap_bits(v, from_w);
        if (from_w > to_w) v = v >>> (from_w - to_w);  // arithmetic right-shift
        return wrap_bits(v, to_w);
    endfunction

endclass : cic_dual_folded_model

`endif  // CIC_DUAL_FOLDED_MODEL_SVH