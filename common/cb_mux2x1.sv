`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// Project      : Verilog Practice
// Date         : 2026-09-15
// Designer     : Surya Rangavajhala
// Module Name  : cb_mux2x1
// Description  : Combinational Block - A 2x1 multiplexer
// Revision     : 1.0
// Notes        : Inputs and Outputs are parameterized
// -----------------------------------------------------------------------------

module cb_mux2x1 #(
    parameter int WIDTH = 1
) (
    input logic [WIDTH-1:0] in0,            // Input a
    input logic [WIDTH-1:0] in1,            // Input b
    input logic sel,                      // Select signal
    output logic [WIDTH-1:0] out             // Output y
);

    assign out = (sel == 0) ? in0 : in1; // Multiplexer logic

endmodule
