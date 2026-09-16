// -----------------------------------------------------------------------------
// Project      : Verilog Practice
// Date         : 2026-09-15
// Designer     : Surya Rangavajhala
// Module Name  : priority_encoder
// Description  : A simple priority encoder
// Revision     : 1.0
// Notes        : Add design notes here
// -----------------------------------------------------------------------------

module priority_encoder (
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
