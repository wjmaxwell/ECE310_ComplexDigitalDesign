module top (
  input clock, rst_n,
  input [3:0] din,
  input start,
  output valid,
  output [4:0] sum
);

  wire cap0, cap1, add;

  datapath dp (
    clock,
    rst_n,
    din,
    cap0,
    cap1,
    add,
    valid,
    sum
  );

  controller ctrl (
    clock,
    rst_n,
    start,
    cap0,
    cap1,
    add,
    valid
  );

endmodule
