module controller (
  input clock, rst_n,
  input start,
  output reg [3:0] capture,
  output reg op,
  output reg valid
);

  localparam WAIT_ON_START = 3'b000;
  localparam CAPTURE_B = 3'b001;
  localparam CAPTURE_C = 3'b010;
  localparam CAPTURE_D = 3'b011;
  localparam OPERATION = 3'b100;
  localparam ASSERT_VALID = 3'b101;

  reg [2:0] nstate, cstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= WAIT_ON_START;
    else
      cstate <= nstate;

  always @* begin
    case( cstate )
      WAIT_ON_START: begin
                       valid = 0; op = 0;
                       if( start ) begin
                         capture = 4'b0001;
                         nstate = CAPTURE_B;
                       end
                       else begin
                         capture = 4'b0000;
                         nstate = WAIT_ON_START;
                       end
                     end
      CAPTURE_B:     begin
                       valid = 0; op = 0;
                       capture = 4'b0010;
                       nstate = CAPTURE_C;
                     end
      CAPTURE_C:     begin
                       valid = 0; op = 0;
                       capture = 4'b0100;
                       nstate = CAPTURE_D;
                     end
      CAPTURE_D:     begin
                       valid = 0; op = 0;
                       capture = 4'b1000;
                       nstate = OPERATION;
                     end
      OPERATION:     begin
                       valid = 0; op = 1;
                       capture = 4'b0000;
                       nstate = ASSERT_VALID;
                     end
      ASSERT_VALID:  begin
                       valid = 1; op = 0;
                       capture = 4'b0000;
                       nstate = WAIT_ON_START;
                     end
      default:       begin
                       valid = 0; op = 0;
                       capture = 4'b0000;
                       nstate = WAIT_ON_START;
                     end
    endcase
  end

endmodule
