module tb();

  reg clk;
  reg rst;
  reg pulse_in;
  reg [7:0] ext_width;
  wire pulse_out;
  
  //Instantiate
  pulse_extender dut(
    .clk(clk),
    .rst(rst),
    .pulse_in(pulse_in),
    .ext_width(ext_width),
    .pulse_out(pulse_out)
  );
  
  always #0.5 clk = !clk;
  
  initial begin
	clk <= 0;
	rst <= 0;
    pulse_in <= 0;
    ext_width <= 0;
    
    #5;
    rst <= 1;
    ext_width <= 5;
    @(posedge clk); pulse_in <= 1;
    @(posedge clk); pulse_in <= 0;
    
    #5;
    rst <= 0;
    ext_width <= 10;
    
    #5;
    repeat(10) begin
      @(posedge clk); pulse_in <= 1;
      @(posedge clk); pulse_in <= 0;
      #25;
    end
      
    
    #100;
    $finish;
  end
  
  initial begin : dump_var
    $dumpfile("surya.vcd");
    $dumpvars(0,tb.dut);
  end
endmodule;
