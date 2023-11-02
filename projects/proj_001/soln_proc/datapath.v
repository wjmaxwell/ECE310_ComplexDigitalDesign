module datapath (
  input clock, rst_n,
  input [3:0] d_in,
  input [2:0] capture,
  input op,
  output reg [4:0] result
);

  reg [3:0] A, B, C;

  always @( posedge clock )
    if( !rst_n )
      A <= '0;
    else if( capture[0] )
      A <= d_in;
    else
      A <= A;
      
  always @( posedge clock )
    if( !rst_n )
      B <= '0;
    else if( capture[1] )
      B <= d_in;
    else
      B <= B;
      
  always @( posedge clock )
    if( !rst_n )
      C <= '0;
    else if( capture[2] )
      C <= d_in;
    else
      C <= C;

  always @( posedge clock )
    if( !rst_n )
      result <= '0;
    else if( op )
      result <= (A+B)-(C+d_in);
    else
      result <= result;
      
endmodule
