module proj001 #(
  parameter WIDTH = 4
) (
  input clock, rst_n,
  input [WIDTH-1:0] d_in,
  input start,
  output [WIDTH:0] result,
  output valid
);

  wire [2:0] cmd;

  datapath #( .WIDTH(WIDTH) ) dp ( clock, rst_n, d_in, cmd, result );
  controller ctrl (clock, rst_n, start, cmd, valid );

endmodule
