module traffic_light(
  input clk,
  input rst,
  output reg r,
  output reg y,
  output reg g
);
  
  parameter WAIT=32'd10;
  
  enum [1:0] {RED, YELLOW, GREEN} light_state;
  
  reg [31:0] i_count;
  
  always @(posedge clk, posedge rst) begin : state_logic
    if(rst) begin
      light_state <= RED;
      i_count <= 0;
      {r,y,g} <= 3'b000;
    end
    else begin
      i_count <= i_count+1;
      
      case(light_state)
        RED: begin
          {r,y,g} <= 3'b100;
          if(i_count == WAIT-1) begin
            light_state <= YELLOW;
            i_count <= 0;
          end
        end
        
        YELLOW: begin
          {r,y,g} <= 3'b010;
          if(i_count == WAIT-1) begin
            light_state <= GREEN;
            i_count <= 0;
          end
        end
        
        GREEN: begin
          {r,y,g} <= 3'b001;
          if(i_count == WAIT-1) begin
            light_state <= RED;
            i_count <= 0;
          end
        end
        
        default: begin
          light_state <= RED;
          {r,y,g} <= 3'b000;
        end
      endcase
    end
  end
  
  
endmodule;
