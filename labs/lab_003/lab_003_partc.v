module lab_003_partc (
  input A, B, C, D,
  output F
);

wire connect_to_G;

lab_003_parta U1 ( 
	.A (A),
	.B (B),
	.C (C),
	.G (connect_to_G)
);

lab_003_partb U2 (
	.G (connect_to_G),
	.D (D),
	.F (F)
);

endmodule
