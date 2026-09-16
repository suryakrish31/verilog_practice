module edge_detection(
  input clk,
  input rst,
  input signal,
  output detected
);
  
  reg buff;
  
//   always @(posedge clk) begin
//     if(rst) begin
//       buff <= 0;
//     end
//     else begin
//       buff <= signal;
//     end
//   end
  
  buf #(100ps) i_buf(buff, signal);
  assign detected = signal ^ buff;
  
endmodule;
