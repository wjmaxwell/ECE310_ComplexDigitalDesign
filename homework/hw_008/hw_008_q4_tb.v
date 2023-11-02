module hw_008_q4_tb;

  reg rst_n, clock;
  wire [7:0] data;
  wire [31:0] checksum;

  wire done;

  hw_008_q4 DUT (
    .clk( clock ),
    .rst_n( rst_n ),
    .data( data ),
    .checksum( checksum )
  );

  tb_player #(
    .WIDTH( 8 ),
    .PFILE( "hw_008_q4.dat" )
  ) player (
    .clock( clock ),
    .rst_n( rst_n ),
    .done( done ),
    .play( data )
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        wait( done );
    #10 $stop();
  end

endmodule
