// datapath
module datapath (
  input clock, rst_n,
  input [3:0] din,
  input A, B, C, D, en, valid,
  output [4:0] result
);

  wire [3:0] din_A, din_B, din_C, din_D;
  wire [4:0] comb_resAB, comb_resCD, comb_result;

  dff_mux_rstn captureA (
	clock,
	rst_n,
	A,
	din,
	din_A
  );

  dff_mux_rstn captureB (
	clock,
	rst_n,
	B,
	din,
	din_B
  );

  dff_mux_rstn captureC (
	clock,
	rst_n,
	C,
	din,
	din_C
  );

  dff_mux_rstn captureD (
	clock,
	rst_n,
	D,
	din,
	din_D
  );

  dff_mux_rstn #( .WIDTH(5) ) sum_din (
	clock,
	rst_n,
	en,
	comb_result,
	result
  );

  adder_4bit adderAB (
	din_A,
	din_B,
	comb_resAB
  );

  adder_4bit adderCD (
	din_C,
	din_D,
	comb_resCD
  );

  sub_5bit ABminusCD (
	comb_resAB,
	comb_resCD,
	comb_result
  );

endmodule

// adder module, takes two 4 bit inputs and outputs the 5 bit sum
module adder_4bit (
  input [3:0] a, b,
  output [4:0] sum
);

  wire [2:0] cout;

  fa bit0 ( 1'b0,    a[0], b[0], cout[0], sum[0] );
  fa bit1 ( cout[0], a[1], b[1], cout[1], sum[1] );
  fa bit2 ( cout[1], a[2], b[2], cout[2], sum[2] );
  fa bit3 ( cout[2], a[3], b[3],  sum[4], sum[3] );
 
endmodule

// subtractor module, takes two 5 bit inputs and outputs the 5 bit difference
module sub_5bit (
  input [4:0] a,
  input [4:0] b,
  output [4:0] dif
);

  assign dif = a - b;

endmodule