module standby_tb;

  reg clk, rst_n, A;
  wire FMOORE, FMEALY;

  standby_moore DUTMOORE ( clk, rst_n, A, FMOORE );
  standby_mealy DUTMEALY ( clk, rst_n, A, FMEALY );

  always #5 clk = ~clk;

  initial begin
        clk   = 0;
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        A = 0;
    #50 A = 1;
    #60 A = 0;
    #20 $stop();
  end

endmodule
