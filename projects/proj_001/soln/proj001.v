module proj001 (
  input clock, rst_n,
  input [3:0] d_in,
  input start,
  output [4:0] result,
  output valid
);

  wire [3:0] capture;
  wire op;

  datapath dp ( clock, rst_n, d_in, capture, op, result );
  controller ctrl (clock, rst_n, start, capture, op, valid );

endmodule
