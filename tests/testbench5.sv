module tb;

  reg clk;
  reg rst;
  wire red, yellow, green;

  defparam dut.WAIT=32'd5;
  
  // Instantiate DUT
  traffic_light dut (
    .clk(clk),
    .rst(rst),
    .r(red),
    .y(yellow),
    .g(green)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    $display("Time\tRed\tYellow\tGreen");
    $monitor("%0t\t%b\t%b\t%b", $time/10, red, yellow, green);

    // Initial reset
    rst = 1;
    #20;
    rst = 0;

    // Observe a few transitions
    #1000;

    // Finish simulation
    $finish;
  end
	
  initial begin
    $dumpfile("surya.vcd");
    $dumpvars(0,tb.dut);
  end
endmodule
