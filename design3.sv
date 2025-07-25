module pulse_extender(
  input clk,
  input rst,
  input pulse_in,
  input [7:0] ext_width,
  output reg pulse_out
);
  reg [7:0] i_width, cur_width;
  reg flag;
  
  always @(posedge clk, posedge pulse_in) begin : pulse_ext
    if(rst) begin
      i_width <= 0;
      cur_width <= 0;
      flag <= 0;
      pulse_out <= 0;
    end
    else begin
      if(pulse_in)
      	flag <= 1;
    end
    
    if(ext_width > 0 && rst) begin
      i_width <= ext_width;
      cur_width <= ext_width;
    end
    
    if(flag) begin
      if(cur_width!=0) begin
      	pulse_out <= 1;
      	cur_width <= cur_width-1;
      end
      else begin
        cur_width <= i_width;
        pulse_out <= 0;
        flag <= 0;
      end
    end
  end
  
endmodule;
