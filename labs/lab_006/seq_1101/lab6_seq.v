module lab6_seq_1101 (
  input clock, rst_n,
  input d_in,
  output reg found
);

  localparam INIT = 3'b000;
  localparam FIRST_ONE = 3'b001;
  localparam SECOND_ONE = 3'b010;
  localparam ZERO = 3'b011;
  localparam END = 3'b100;

  reg [2:0] cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= INIT;
    else
      cstate <= nstate;

  always @* begin
    case( cstate )

      INIT : begin
          found = 0;
          nstate = d_in ? FIRST_ONE : INIT;
        end

      FIRST_ONE : begin
          found = 0;
          nstate = d_in ? SECOND_ONE : INIT;
        end

      SECOND_ONE : begin
          found = 0;
          nstate = d_in ? SECOND_ONE : ZERO;
        end

      ZERO : begin
          found = 0;
          nstate = d_in ? END : INIT;
        end

      END : begin
          found = 1;
          nstate = d_in ? SECOND_ONE : INIT;
        end

      default : begin
          found = 0;
          nstate = INIT;
        end
    endcase
  end

endmodule
