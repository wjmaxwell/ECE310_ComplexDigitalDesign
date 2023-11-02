module hw_008_q4 (
  input rst_n, clk,
  input [7:0] data,
  output [31:0] checksum
);

  reg [15:0] B, A;
  wire [15:0] b_next, a_next;

  assign a_next = A + data;
  assign b_next = B + a_next;

  always @( posedge clk )
    if( !rst_n ) begin
      B <= 0;
      A <= 1;
    end
    else begin
      B <= b_next;
      A <= a_next;
    end

  assign checksum = {B, A};

endmodule
