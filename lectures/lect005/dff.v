module dff (
  input clk, d,
  output reg q,
  output q_n
);

  always @ (posedge clk )
    q <= d;

  not U1 ( q_n, q );

endmodule
