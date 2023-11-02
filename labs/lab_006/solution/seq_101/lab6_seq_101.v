module lab6_seq_101 (
  input clock, rst_n,
  input d_in,
  output found
);

  wire [2:0] q, q_n;
  wire [2:0] mux_in;

  // mux for the input to the regs
  assign mux_in[2] = found ? 0 : q[1];
  assign mux_in[1] = found ? 0 : q[0];
  assign mux_in[0] = d_in;

  dff_rstn d0 ( .rst_n( rst_n ), .clock( clock ), .d( mux_in[0] ), .q( q[0] ), .q_n( q_n[0] ) );
  dff_rstn d1 ( .rst_n( rst_n ), .clock( clock ), .d( mux_in[1] ), .q( q[1] ), .q_n( q_n[1] ) );
  dff_rstn d2 ( .rst_n( rst_n ), .clock( clock ), .d( mux_in[2] ), .q( q[2] ), .q_n( q_n[2] ) );

  assign found = q[2] & q_n[1] & q[0];

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
