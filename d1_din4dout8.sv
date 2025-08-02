// Code your design here
module din4dout8 (clk,rst,load,din,dout);

input clk,rst,load;

input [3:0] din;

output reg[7:0] dout;

  reg count;
  reg [7:0] dout_buf;
  
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      count <= 2'd0;
      dout <= 8'd0;
    end
    else if(load|count) begin
        case(count)
        	1'd0: begin
              dout_buf[7:4] <= din;
              count <= 1;
            end
          	1'd1: begin
              dout_buf[3:0] <= din;
              count <= 0;
            end
          default: dout_buf <= dout;
        endcase
      end
    end
	
endmodule
