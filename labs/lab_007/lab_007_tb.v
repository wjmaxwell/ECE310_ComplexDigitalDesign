module lab_007_tb;

  reg rst_n, clock;
  wire data_valid;
  wire last;

  wire done;

  size_count DUT (
    .clock( clock ),
    .rst_n( rst_n ),
    .data_valid( data_valid ),
    .last( last )
  );

  tb_player #(
    .WIDTH( 1 ),
    .PFILE( "lab_007.dat" )
  ) player (
    .clock( clock ),
    .rst_n( rst_n ),
    .done( done ),
    .play( data_valid )
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
