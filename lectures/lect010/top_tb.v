module top_tb;

  reg clock, rst_n;
  reg [3:0] din;
  reg start;

  wire [4:0] sum;
  wire valid;

  always #5 clock = ~clock;

  initial begin
    clock = 0;
  end

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        start = 0;
        din = 4'h5;
    #50 start = 1;
    #10 start = 0;
    #10 din = 4'h7;
    #50 $stop;
  end

  top DUT (
    clock,
    rst_n,
    din,
    start,
    valid,
    sum
  );

endmodule
