module pulse_gen(
  input clk,
  input rstn,
  input [7:0] num,
  input [3:0] freq,
  output pulse
);
  
  reg [1:0] rst_count=0;
  reg [7:0] i_num=1, p_num;
  reg [3:0] i_freq=0, p_freq;
  wire load;
  
  assign load = (rst_count==2'b11);
  assign pulse = (p_num<i_num && rstn==1)? ((p_freq==0) ? 1'b1 : 1'b0) : 1'b0;
  
  always @(negedge rstn) begin : load_values
    if(!rstn)
      rst_count <= rst_count+1;
    
    if(load) begin
      i_num <= num;
      i_freq <= freq;
    end
  end
 
  always @(posedge clk, negedge rstn) begin : pulse_gen
    if(!rstn) begin
//       pulse <= 0;
      p_num <= 0;
      p_freq <= 0;
    end
    else begin
      if(pulse)
        p_num <= p_num+1;
      
      if(p_freq < i_freq-1)
        p_freq <= p_freq+1;
      else
        p_freq <= 0;
    end
  end
  
endmodule;
