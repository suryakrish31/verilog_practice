module mux_oneHot(
    input [3:0] sel,
    input [15:0] in0,
    input [15:0] in1,
    input [15:0] in2,
    input [15:0] in3,
    output [15:0] out
);
    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin : mux_loop
            assign out[i] = (|sel) & (sel[0]&in0[i] | sel[1]&in1[i] | sel[2]&in2[i] | sel[3]&in3[i]);
        end
    endgenerate
endmodule
