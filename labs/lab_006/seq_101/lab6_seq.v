module lab6_seq_101 (
  input clock, rst_n,
  input d_in,
  output found
);

  reg [2:0] sr;

  always @( posedge clock ) begin
    if( !rst_n )
      sr <= 0;

    if( found ) 
      sr <= {d_in, 2'b00};
    else
      sr <= {d_in, sr[2:1]};
  end
      
  assign found = ( sr == 3'b101 );
        
endmodule
