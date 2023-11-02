module Hello_sim_tb;

  reg rst_n, clock;
  wire size_valid, data_valid;
  wire [31:0] size;
  wire [ 7:0] data;
  wire checksum_valid;
  wire [31:0] checksum;

  wire done;
  wire [41:0] stim;

  adler32 DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .size_valid( size_valid ),
    .size( size ),
    .data_valid( data_valid ),
    .data( data ),
    .checksum_valid( checksum_valid ),
    .checksum( checksum )
  );

  tb_player #(
    .WIDTH( 42 ),
    .PFILE( "Hello_sim_tb.dat" )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .done( done ),
    .play( stim )
  );

  assign { size_valid, size, data_valid, data } = stim;

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
