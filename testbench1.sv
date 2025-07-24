// Code your testbench here
// or browse Example
module tb();

  reg clk=0, rst=1, load=0;
  reg [3:0] din;
  wire [7:0] dout;
  
  //clock
  always #5 clk = !clk;
  
  //instantiate
  din4dout8 dut(
    .clk(clk),
    .rst(rst),
    .load(load),
    .din(din),
    .dout(dout)
  );
  
  initial begin
    #50 rst=0;
    repeat(10) begin
      @(posedge clk); din <= $random;
    end
    $finish;
  end
  
  initial begin
    #50;
    repeat(1) begin
      @(posedge clk); load <= 1;
      repeat(3)
      @(posedge clk); load <= 0;
    end
  end
  
  initial begin
    $dumpvars(0,tb);
    $dumpfile("surya.vcd");
  end
endmodule
