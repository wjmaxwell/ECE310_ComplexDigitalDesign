module lab_002_partb (
  input A,
  input B,
  input C,
  output F
);

  /* put your variable declarations here */
  wire and0, and1;
  wire notA;

  /* put your gate instances here */
  not U1 ( notA, A );
  and U2 ( and0, notA, B );
  and U3 ( and1, B, C );
  or U4 ( F, and0, and1 );

endmodule
