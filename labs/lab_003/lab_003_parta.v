module lab_003_parta (
  input A, B, C,
  output G
);

wire notA, notB, notC;
wire and0, and1, and2, and3;
wire or0, or1;

not U1 ( notA, A );
not U2 ( notB, B );
not U3 ( notC, C );

and U4 ( and0, notA, C );
and U5 ( and1, notA, B );
and U6 ( and2, B, C );
and U7 ( and3, A, notB, notC );

or ( G, and0, and1, and2, and3 );

endmodule
