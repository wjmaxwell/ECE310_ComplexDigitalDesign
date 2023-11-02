// top level
module proj001 (
  input clock, rst_n,
  input [3:0] din,
  input start,
  output [4:0] result,
  output valid
);

wire A, B, C, D, en;

datapath dp (
  clock,
  rst_n,
  din,
  A,
  B,
  C,
  D,
  en,
  valid,
  result
);

controller ctrl (
  clock,
  rst_n,
  start,
  A,
  B,
  C,
  D,
  en,
  valid
);

endmodule
