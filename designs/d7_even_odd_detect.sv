module even_odd_detect(
  input clk,
  input rst,
  input in_bit,
  output reg even
);
  
  typedef enum [0:0] {EVEN=0, ODD=1} state;
  
  state cur_state, next_state;
  
  always @(posedge clk, posedge rst) begin : State_reg_update
    if(rst) begin
      cur_state <= EVEN;
    end
    else begin
      cur_state <= next_state;
    end
  end
  
  always @* begin : state_transition_combo
    // default initialization first
    next_state = EVEN;
    even = 1;
    
    case(cur_state)
      EVEN: if(in_bit) begin
        next_state = ODD;
        even = 0;
      end
      else next_state = EVEN;
      
      ODD: if(in_bit) next_state = EVEN;
      else begin
        next_state = ODD;
        even = 0;
      end
        
      default: next_state = EVEN;
    endcase
  end
  
endmodule;
