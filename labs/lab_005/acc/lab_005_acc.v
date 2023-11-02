module lab_005_acc (
  input rst_n, clock,
  input [3:0] d_in,
  output reg [7:0] d_out
);

  always @( posedge clock ) begin
    if( !rst_n ) begin
      d_out <= 0;
    end

    else begin
      if( d_in > 6 ) begin
	d_out <= d_out + d_in;
      end
      else begin
	d_out <= d_out;
      end
    end
  end

endmodule
