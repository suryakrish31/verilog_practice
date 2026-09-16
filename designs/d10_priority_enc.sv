`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// Project      : Verilog Practice
// Date         : 2026-09-16
// Designer     : Surya Rangavajhala
// Module Name  : priority_encoder
// Description  : Multiple priority encoder modules
// Revision     : 1.0
// Notes        : Add design notes here
// -----------------------------------------------------------------------------

module cb_penc_4x2 (
    input  logic [3:0] in,   // 4-bit input
    output logic [1:0] out,  // 2-bit output
    output logic valid       // Valid signal
);
    wire [1:0] mux2_out, mux1_out;

    assign valid = |in; // Valid if any input is high
    
    cb_mux2x1 #(2) mux_3 (
        .in0(mux2_out),
        .in1(2'b11),
        .sel(in[3]),
        .out(out)
    );
    cb_mux2x1 #(2) mux_2 (
        .in0(mux1_out),
        .in1(2'b10),
        .sel(in[2]),
        .out(mux2_out)
    );
    cb_mux2x1 #(2) mux_1 (
        .in0(2'b00),
        .in1(2'b01),
        .sel(in[1]),
        .out(mux1_out)
    );
    
endmodule

module cb_penc_8x3 (
    input  logic [7:0] in,  // 8-bit input
    output logic [2:0] out, // 3-bit output
    output logic valid      // Valid signal
);
    wire [1:0] enc_msb, enc_lsb;
    wire valid_msb, valid_lsb;

    assign valid = valid_msb | valid_lsb;

    // Instantiate two 4x2 priority encoders for the MSB and LSB halves
    cb_penc_4x2 enc_msb_inst (
        .in(in[7:4]),
        .out(enc_msb),
        .valid(valid_msb)
    );
    cb_penc_4x2 enc_lsb_inst (
        .in(in[3:0]),
        .out(enc_lsb),
        .valid(valid_lsb)
    );

    // Merge logic
    assign out = valid_msb ? {1'b1, enc_msb} : {1'b0, enc_lsb};

endmodule
