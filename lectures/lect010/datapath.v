module datapath (
  input clock, rst_n,
  input [3:0] din,
  input cap0, cap1, add, valid,
  output [4:0] sum
);

  wire [3:0] din_cap0, din_cap1;
  wire [4:0] comb_sum;

  dff_mux_rstn capture0 (
    clock,
    rst_n,
    cap0,
    din,
    din_cap0
  );

  dff_mux_rstn capture1 (
    clock,
    rst_n,
    cap1,
    din,
    din_cap1
  );

  dff_mux_rstn #( .WIDTH(5) ) sum_din (
    clock,
    rst_n,
    add,
    comb_sum,
    sum
  );

  adder_4bit adder (
    din_cap0,
    din_cap1,
    comb_sum
  );

endmodule

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
