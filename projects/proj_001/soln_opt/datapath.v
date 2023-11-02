module datapath #(
  parameter WIDTH = 4
) (
  input clock, rst_n,
  input [WIDTH-1:0] d_in,
  input [2:0] cmd,
  output reg [WIDTH:0] result
);

  localparam HOLD_RESULT = 3'b000;
  localparam CAPTURE_DIN = 3'b001;
  localparam ADD_DIN = 3'b010;
  localparam SUB_DIN = 3'b100;

  always @( posedge clock )
    if( !rst_n )
      result <= '0;
    else
      case( cmd )
        HOLD_RESULT: result <= result;
        CAPTURE_DIN: result <= d_in;
        ADD_DIN:     result <= result + d_in;
        SUB_DIN:     result <= result - d_in;
        default:     result <= result;
      endcase
      
endmodule
