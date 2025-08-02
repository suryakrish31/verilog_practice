module vending_machine(
  input clk,
  input rst,
  input [1:0] coin,
  output reg dispense,
  output reg [1:0] change
);
  
  typedef enum [1:0] {IDLE=0, COUNT=1, PRODUCT=2, CHANGE=3} state;
  
  state cur_state, next_state;
  
  wire m5, b5, t;
  reg [3:0] bal, i_time;
  
  assign m5 = (coin<5) ? 1 : 0;
  assign b5 = (bal<5) ? 1 : 0;
  assign t = (i_time==10) ? 1 : 0;
  
  always @(posedge clk, posedge rst) begin : State_reg_update
    if(rst) begin
      cur_state <= IDLE;
      i_time <= 0;
      bal <= 0;
    end
    else begin
      cur_state <= next_state;
      
      // Timer ouput
      case(cur_state)
        COUNT, PRODUCT: i_time <= i_time+1;
        CHANGE: i_time <= 0;
        default: i_time <= 0;
      endcase
      
      // Balance Register
      case(cur_state)
        IDLE, COUNT: bal <= bal+coin;
        PRODUCT: bal <= (bal-5);
        CHANGE: bal <= 0;
        default: bal <= 0;
      endcase
    end
  end
  
  always @* begin : state_transition_combo
    // default initialization first
    next_state = IDLE;
    dispense = 0;
    change = 0;
    
    case(cur_state)
      IDLE: if(m5) next_state = COUNT;
      else next_state = PRODUCT;
      
      COUNT: if(!b5) next_state = PRODUCT;
      else begin
        if(!t)
          next_state = COUNT;
        else
          next_state = CHANGE;
      end
      
      PRODUCT: begin
        dispense = 1;
        next_state = CHANGE;
      end
      
      CHANGE: begin
        change = bal;
        next_state = IDLE;
      end
        
      default: next_state = IDLE;
    endcase
  end
  
endmodule
