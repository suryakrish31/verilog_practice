module tb;

  reg clk;
  reg rst;
  reg [1:0] coin;
  
  wire dispense;
  wire [1:0] change;
  
  //Instantiate DUT
  vending_machine dut(
    .clk(clk),
    .rst(rst),
    .coin(coin),
    .dispense(dispense),
    .change(change)
  );
  
  initial begin
    clk <= 0;
    rst <= 0;
    coin <= 0;
    
    #15;
    rst = 1;
    #10;
    rst = 0;
    
    #10;
    repeat(100) begin
      @(posedge clk); coin <= $urandom_range(3,0);
      @(posedge clk); coin <= $urandom_range(3,0);
      @(posedge clk); coin <= $urandom_range(3,0);
      @(posedge clk); coin <= 0;
      #100;
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
