module tb;

  reg clk;
  reg rst;
  reg in_bit;
  wire detected;
  
  //Instantiate DUT
  seq_det_1011 dut(
    .clk(clk),
    .rst(rst),
    .in_bit(in_bit),
    .detected(detected)
  );
  
  initial begin
    clk <= 0;
    rst <= 0;
    in_bit <= 0;
    
    $monitor("Detected: %0b\n", detected);
    
    #15;
    rst = 1;
    #10;
    rst = 0;
    
    #10;
    repeat(50) begin
      @(posedge clk); in_bit <= $urandom_range(1,0);
    end
    
    #1000;
    $finish;
  end
  
  always #5 clk = !clk;
	
  initial begin
    $dumpfile("surya.vcd");
    $dumpvars(0,tb.dut);
  end
endmodule
