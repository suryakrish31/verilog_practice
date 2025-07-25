module tb();

  reg clk;
  reg rst;
  reg signal;
  wire detected;
  
  //Instantiate
  edge_detection dut(
    .clk(clk),
    .rst(rst),
    .signal(signal),
    .detected(detected)
  );
  
  always #1 clk = !clk;
  
  initial begin
	clk <= 0;
	rst <= 0;
    signal <= 0;
    
   	#10; rst <= 1;
    #10; rst <= 0;
    
    #100;
    $finish;
  end
  
  initial begin
    #25;
    repeat(10) begin
      signal <= !signal;
      #100;
    end
  end
  
  initial begin : dump_var
    $dumpfile("surya.vcd");
    $dumpvars(0,tb.dut);
  end
endmodule;
