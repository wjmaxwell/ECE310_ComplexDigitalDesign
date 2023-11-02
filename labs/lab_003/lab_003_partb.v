module lab_003_partb (
  input G, D,
  output F
);

wire notG;
wire or0;

not U1 ( notG, G);
or ( F, notG, D );

endmodule
