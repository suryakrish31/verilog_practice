module tb();
  reg clk, rstn;
  reg [7:0] num;
  reg [3:0] freq;
  wire pulse;
  
  //Instantiate
  pulse_gen dut(
    .clk(clk),
    .rstn(rstn),
    .num(num),
    .freq(freq),
    .pulse(pulse)
  );
  
  //Clock
  always #5 clk = !clk;
  
  //Stimulus
  initial begin : input_block
    clk <= 0;
    rstn <= 1;
    num <= 0;
    freq <= 0;
    
    #40;
    rstn <= 0;
    #10;
    rstn <= 1;
  
    #1000;
    $finish;
  end
  
  initial begin : dump_var
    $dumpfile("surya.vcd");
    $dumpvars(0,tb);
  end
