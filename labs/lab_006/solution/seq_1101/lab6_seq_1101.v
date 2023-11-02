module lab6_seq_1101 (
  input clock, rst_n,
  input d_in,
  output found
);

  wire [3:0] q, q_n;

  dff_rstn d0 ( .rst_n( rst_n ), .clock( clock ), .d( d_in ), .q( q[0] ), .q_n( q_n[0] ) );
  dff_rstn d1 ( .rst_n( rst_n ), .clock( clock ), .d( q[0] ), .q( q[1] ), .q_n( q_n[1] ) );
  dff_rstn d2 ( .rst_n( rst_n ), .clock( clock ), .d( q[1] ), .q( q[2] ), .q_n( q_n[2] ) );
  dff_rstn d3 ( .rst_n( rst_n ), .clock( clock ), .d( q[2] ), .q( q[3] ), .q_n( q_n[3] ) );

  assign found = q[3] & q[2] & q_n[1] & q[0];

endmodule

module dff_rstn (
  input rst_n, clock,
  input d,
  output reg q,
  output q_n
);

  always @( posedge clock )
    if( !rst_n )
      q <= 0;
    else
      q <= d;

  assign q_n = ~q;

endmodule
