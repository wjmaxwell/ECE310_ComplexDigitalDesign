module standby_moore (
  input clk, rst_n,
  input A,
  output F
);

  wire w1, w2;
  wire [1:0] d;
  wire [1:0] nstate, cstate;
  wire [1:0] cstate_n;

  // next state logic
  and U1( w1, cstate[1], A );
  and U2( w2, cstate[0], A );
  or U3( nstate[1], w1, w2 );

  and U4( nstate[0], A, cstate_n[0], cstate_n[1] );

  // reset muxes
  mux21_1bit U8( 1'b0, nstate[1], rst_n, d[1] );
  mux21_1bit U9( 1'b0, nstate[0], rst_n, d[0] );

  // D flip flops
  dff U6( clk, d[1], cstate[1], cstate_n[1] );
  dff U7( clk, d[0], cstate[0], cstate_n[0] );

  // output logic
  and U5( F, cstate_n[1], cstate[0] );

endmodule
