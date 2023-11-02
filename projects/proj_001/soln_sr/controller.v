module controller (
  input clock, rst_n,
  input start,
  output [2:0] capture,
  output op,
  output valid
);

  localparam WAIT_ON_START = 1'b0;
  localparam WAIT_ON_VALID = 1'b1;

  reg nstate, cstate;
  reg getst, clr, a;

  reg [3:0] sr;

  always @( posedge clock )
    if( !rst_n )
      sr <= '0;
    else
      if( clr )
        sr <= '0;
      else
        if( getst )
          sr <= {start, sr[3:1]};
        else
          sr <= {1'b0, sr[3:1]};

  assign capture[0] = a;
  assign capture[1] = sr[3];
  assign capture[2] = sr[2];
  assign op         = sr[1];
  assign valid      = sr[0];

  always @( posedge clock )
    if( !rst_n )
      cstate <= WAIT_ON_START;
    else
      cstate <= nstate;

  always @* begin
    case( cstate )
      WAIT_ON_START: begin
		       getst = 1'b1;
		       clr = 1'b0;
                       if( start ) begin
                         a = 1'b1;
                         nstate = WAIT_ON_VALID;
                       end
                       else begin
                         a = 1'b0;
                         nstate = WAIT_ON_START;
                       end
                     end
      WAIT_ON_VALID: begin
		       getst = 1'b0;
		       a = 1'b0;
                       if( valid ) begin
                         clr = 1'b1;
                         nstate = WAIT_ON_START;
                       end
                       else begin
                         clr = 1'b0;
                         nstate = WAIT_ON_VALID;
                       end
                     end
      default:       begin
                       getst = 1'b0;
                       a = 1'b0;
                       clr = 1'b0;
                       nstate = WAIT_ON_START;
                     end
    endcase
  end

endmodule
