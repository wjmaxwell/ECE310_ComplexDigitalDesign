module size_count (

  input rst_n,
  input data_valid,
  input clock,
  output reg last

);

reg [31:0] count;
reg [31:0] val = 32'b0000_0000_0000_0000_0000_0000_0101_0111;

always @(posedge clock) begin
  if(!rst_n) begin
    count <= val;
    last <= 0;
  end

  if(data_valid) begin
    count <= count - 32'b0000_0000_0000_0000_0000_0000_0000_0001;
    
    if(count == 32'b0000_0000_0000_0000_0000_0000_0000_0010) begin
      last <= 1;
    end

    if(count == 32'b0000_0000_0000_0000_0000_0000_0000_0001) begin
      last <= 0;
      count <= val;
    end
  end
  else begin
    last <= 0;
  end
end

endmodule