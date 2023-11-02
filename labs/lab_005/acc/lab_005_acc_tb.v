module lab_005_acc_tb;

  reg rst_n, clock;
  wire [3:0] d_in;
  wire [7:0] d_out;
  wire done;

  lab_005_acc DUT (
    rst_n,
    clock,
    d_in,
    d_out
  );

  tb_player #(
    .WIDTH( 4 ),
    .PFILE( "lab_005_acc_tb.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    rst_n,
    clock,
    done,
    d_in
  );

  initial clock <= 0;
  always #5 clock <= ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
    wait( done );
    #10 $stop();
  end

endmodule
