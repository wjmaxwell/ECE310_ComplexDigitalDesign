module standby_mealy (
  input clk, rst_n,
  input A,
  output F
);

  wire nstate, cstate, cstate_n;

  mux21_1bit U1( 1'b0, A, rst_n, nstate );
  dff U2( clk, nstate, cstate, cstate_n );
  and U3( F, A, cstate_n );

endmodule
