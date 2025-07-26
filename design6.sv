module seq_det_1011(
  input clk,
  input rst,
  input in_bit,
  output reg detected
);
  
  typedef enum [2:0] {IDLE=0, S1=1, S2=2, S3=3, S4=4} state;
  
  state cur_state, next_state;
  
  always @(posedge clk, posedge rst) begin : State_reg_update
    if(rst) begin
      cur_state <= IDLE;
    end
    else begin
      cur_state <= next_state;
    end
  end
  
  always @* begin : state_transition_combo
    // default initialization first
    next_state = IDLE;
    detected = 0;
    
    case(cur_state)
      IDLE: if(in_bit) next_state = S1;
      else next_state = IDLE;
      
      S1: if(in_bit) next_state = S1;
      else next_state = S2;
      
      S2: if(in_bit) next_state = S3;
      else next_state = IDLE;
      
      S3: if(in_bit) next_state = S4;
      else next_state = S2;
      
      S4: begin 
        detected = 1;
        if(in_bit) next_state = S1;
      	else next_state = S2;
      end
      
      default: next_state = IDLE;
    endcase
  end
  
endmodule;
