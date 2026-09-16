`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// Project      : Verilog Practice
// Date         : 2026-09-16
// Designer     : Surya Rangavajhala
// Module Name  : testbench10
// Description  : testbench for priority encoder logic
// Revision     : 1.0
// Notes        : Add design notes here
// -----------------------------------------------------------------------------

`include "d10_priority_enc.sv"

module tb_cb_penc_8x3;
    logic [7:0] in;
    logic [2:0] out;
    logic       valid;

    cb_penc_8x3 dut (
        .in    (in),
        .out   (out),
        .valid (valid)
    );

    // Reference model: plain behavioral priority encoder
    task automatic ref_model(input logic [7:0] din,
                             output logic [2:0] dout,
                             output logic dvalid);
        integer i;
        begin
            dvalid = |din;
            dout   = 3'd0;
            for (i = 7; i >= 0; i = i - 1) begin
                if (din[i]) begin
                    dout = i[2:0];
                    i = -1; // break
                end
            end
        end
    endtask

    logic [2:0] exp_out;
    logic       exp_valid;
    integer     errors;
    integer     k;

    initial begin
        errors = 0;

        // Directed cases
        test_vec(8'b0000_0000);
        test_vec(8'b0000_0001);
        test_vec(8'b0000_1000); // lsb-half boundary top bit
        test_vec(8'b0001_0000); // msb-half boundary bottom bit
        test_vec(8'b1000_0000);
        test_vec(8'b1111_1111);
        test_vec(8'b0110_0110); // tie-break check: msb half must win

        // Exhaustive check (256 cases — cheap enough)
        for (k = 0; k < 256; k = k + 1)
            test_vec(k[7:0]);

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("FAILED: %0d mismatches", errors);

        $finish;
    end

    task automatic test_vec(input logic [7:0] din);
        begin
            in = din;
            #1; // settle combinational logic
            ref_model(din, exp_out, exp_valid);
            if (out !== exp_out || valid !== exp_valid) begin
                errors = errors + 1;
                $display("MISMATCH in=%b : got out=%0d valid=%b | exp out=%0d valid=%b",
                          din, out, valid, exp_out, exp_valid);
            end
        end
    endtask

endmodule
