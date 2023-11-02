module controller (
  input clock, rst_n,
  input start,
  output reg [2:0] cmd,
  output reg valid
);

  localparam WAIT_ON_START = 3'b000;
  localparam ADD_B = 3'b001;
  localparam SUB_C = 3'b010;
  localparam OPERATION = 3'b011;
  localparam ASSERT_VALID = 3'b100;

  localparam HOLD_RESULT = 3'b000;
  localparam CAPTURE_DIN = 3'b001;
  localparam ADD_DIN = 3'b010;
  localparam SUB_DIN = 3'b100;

  reg [2:0] nstate, cstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= WAIT_ON_START;
    else
      cstate <= nstate;

  always @* begin
    case( cstate )
      WAIT_ON_START: begin
                       valid = 0;
                       if( start ) begin
                         cmd = CAPTURE_DIN;
                         nstate = ADD_B;
                       end
                       else begin
                         cmd = HOLD_RESULT;
                         nstate = WAIT_ON_START;
                       end
                     end
      ADD_B:         begin
                       valid = 0;
                       cmd = ADD_DIN;
                       nstate = SUB_C;
                     end
      SUB_C:         begin
                       valid = 0;
                       cmd = SUB_DIN;
                       nstate = OPERATION;
                     end
      OPERATION:     begin
                       valid = 0;
                       cmd = SUB_DIN;
                       nstate = ASSERT_VALID;
                     end
      ASSERT_VALID:  begin
                       valid = 1;
                       cmd = HOLD_RESULT;
                       nstate = WAIT_ON_START;
                     end
      default:       begin
                       valid = 0;
                       cmd = HOLD_RESULT;
                       nstate = WAIT_ON_START;
                     end
    endcase
  end

endmodule
