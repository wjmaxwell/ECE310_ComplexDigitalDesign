module datapath (
  input clock, rst_n,
  input [3:0] d_in,
  input [3:0] capture,
  input op,
  output [4:0] result
);

  wire [3:0] A, B, C, D;
  wire [4:0] ApB, CpD, CpD_n;
  wire [5:0] compute;

  // these three capture A, B, C, and D
  dff_mux_rstn #(.WIDTH(4)) dff_a (
    clock, rst_n, capture[0], d_in, A );

  dff_mux_rstn #(.WIDTH(4)) dff_b (
    clock, rst_n, capture[1], d_in, B );

  dff_mux_rstn #(.WIDTH(4)) dff_c (
    clock, rst_n, capture[2], d_in, C );

  dff_mux_rstn #(.WIDTH(4)) dff_d (
    clock, rst_n, capture[3], d_in, D );

  fa_4bit AplusB ( 1'b0, A, B, ApB );
  fa_4bit CplusD ( 1'b0, C, D, CpD );

  // invert the bits and add 1 for subtraction
  assign CpD_n = ~CpD;
  fa_5bit Comp ( 1'b1, ApB, CpD_n, compute );

  // this one captures the computation
  dff_mux_rstn #(.WIDTH(5)) dff_result (
    clock, rst_n, op, compute[4:0], result );

endmodule

module fa_4bit (
  input cin,
  input [3:0] A, B,
  output [4:0] S
);

  wire [2:0] carry;

  fa bit0 ( cin,      A[0], B[0], carry[0], S[0] );
  fa bit1 ( carry[0], A[1], B[1], carry[1], S[1] );
  fa bit2 ( carry[1], A[2], B[2], carry[2], S[2] );
  fa bit3 ( carry[2], A[3], B[3],     S[4], S[3] );

endmodule

module fa_5bit (
  input cin,
  input [4:0] A, B,
  output [5:0] S
);

  wire [3:0] carry;

  fa bit0 ( cin,      A[0], B[0], carry[0], S[0] );
  fa bit1 ( carry[0], A[1], B[1], carry[1], S[1] );
  fa bit2 ( carry[1], A[2], B[2], carry[2], S[2] );
  fa bit3 ( carry[2], A[3], B[3], carry[3], S[3] );
  fa bit4 ( carry[3], A[4], B[4],     S[5], S[4] );

endmodule
