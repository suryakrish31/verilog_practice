`timescale 1ns/1ps
`include "d9_mux_oneHot.sv"

module tb_onehot_mux;

    logic [3:0]  sel;
    logic [15:0] in0, in1, in2, in3;
    logic [15:0] out;

    int error_count = 0;

    // Instantiate DUT
    mux_oneHot dut (
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );

    // Task to apply vectors and verify expected output
    task automatic check_mux(
        input logic [3:0]  t_sel,
        input logic [15:0] t_in0, t_in1, t_in2, t_in3,
        input logic [15:0] expected_out,
        input string       test_name
    );
        sel = t_sel;
        in0 = t_in0; in1 = t_in1; in2 = t_in2; in3 = t_in3;
        #1; // Allow combinational propagation

        if (out === expected_out) begin
            $display("[PASS] %-25s | sel=%b | out=16'h%04h", test_name, sel, out);
        end else begin
            $display("[FAIL] %-25s | sel=%b | Got: 16'h%04h | Expected: 16'h%04h", 
                     test_name, sel, out, expected_out);
            error_count++;
        end
    endtask

    initial begin
        $display("\n================ STARTING MUX TESTS ================");

        // Fixed test vectors
        in0 = 16'hA5A5;
        in1 = 16'h5A5A;
        in2 = 16'hFFFF;
        in3 = 16'h1234;

        // 1. One-Hot Functional Checks
        check_mux(4'b0001, in0, in1, in2, in3, in0, "Select In0 (sel[0])");
        check_mux(4'b0010, in0, in1, in2, in3, in1, "Select In1 (sel[1])");
        check_mux(4'b0100, in0, in1, in2, in3, in2, "Select In2 (sel[2])");
        check_mux(4'b1000, in0, in1, in2, in3, in3, "Select In3 (sel[3])");

        // 2. Zero Select Vector Check
        check_mux(4'b0000, in0, in1, in2, in3, 16'h0000, "All-Zero Select");

        // 3. Dynamic Random Testing (100 Iterations)
        for (int i = 0; i < 100; i++) begin
            logic [1:0] idx;
            idx = $urandom_range(0, 3);
            
            sel = 1'b1 << idx;
            in0 = $urandom(); 
            in1 = $urandom(); 
            in2 = $urandom(); 
            in3 = $urandom();

            #1;
            case (sel)
                4'b0001: if (out !== in0) error_count++;
                4'b0010: if (out !== in1) error_count++;
                4'b0100: if (out !== in2) error_count++;
                4'b1000: if (out !== in3) error_count++;
                default: ;
            endcase
        end

        // Summary
        $display("====================================================");
        if (error_count == 0) begin
            $display(" RESULT: ALL TESTS PASSED SUCCESSFULLY!");
        end else begin
            $display(" RESULT: FAILED WITH %0d ERRORS.", error_count);
        end
        $display("====================================================\n");

        $finish;
    end

endmodule
