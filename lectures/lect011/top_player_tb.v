module top_player_tb;

  reg rst_n, clock;
  wire start;
  wire [3:0] din;
  wire valid;
  wire [4:0] sum;

  wire done;
  wire [4:0] stim;

  tb_player #(
    .WIDTH( 5 ),
    .PFILE( "top_player.dat" )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( done ),
    .play( stim )
  );

  top DUT (
    clock,
    rst_n,
    din,
    start,
    valid,
    sum
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
