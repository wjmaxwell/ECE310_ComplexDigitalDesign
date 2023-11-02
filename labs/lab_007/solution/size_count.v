module size_count (
  input rst_n, clock,
  input data_valid,
  output last
);

  reg [31:0] count;

  always @( posedge clock )
    if( !rst_n )
      count <= 87;
    else
      if( data_valid )
        if( count == 1 )
          count <= 87;
        else
          count <= count - 1;
      else
        count <= count;

  assign last = ( data_valid && (count == 1) );

endmodule
