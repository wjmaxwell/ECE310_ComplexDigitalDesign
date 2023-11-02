module proj001_tb;

  reg rst_n, clock;
  wire start;
  wire [3:0] din;
  wire valid;
  wire [4:0] result;

  wire done;
  wire [4:0] stim;

  tb_player #(
    .WIDTH( 5 ),
    .PFILE( "single_comp.dat" )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( done ),
    .play( stim )
  );

  proj001 #( .WIDTH(4) )
    DUT (
      .clock(clock),
      .rst_n(rst_n),
      .d_in(din),
      .start(start),
      .result(result),
      .valid(valid)
    );

  assign { start, din } = stim;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial clock = 0;
  always #5 clock <= ~clock;

  initial begin
        wait( done );
    #50 $stop();
  end

endmodule
