module mux21_1bit (
  input i_0, i_1, s,
  output f
);

  wire w1, w2, s_n;

  not U0 ( s_n, s );
  and U1 ( w1, i_0, s_n );
  and U2 ( w2, i_1, s );
  or U3 ( f, w1, w2 );

endmodule
