module controller (
  input clock, rst_n, start,
  output reg cap0, add, valid
);

  localparam S0 = 2'b00;
  localparam S1 = 2'b01;
  localparam S2 = 2'b10;
  localparam S3 = 2'b11;

  wire [1:0] cstate, nstate_d, cstate_n;
  reg [1:0] nstate;

  mux21 #(.WIDTH(2)) rst_mux ( S0, nstate, rst_n, nstate_d );
  dff #(.WIDTH(2)) state_vec ( clock, nstate_d, cstate, cstate_n );

  always @* begin
    case( cstate )
      S0 : begin
             {cap0, add, valid} = 3'b00_0;
             nstate = start ? S1 : S0;
           end
      S1 : begin
             {cap0, add, valid} = 3'b10_0;
             nstate = S2;
           end
      S2 : begin
             {cap0, add, valid} = 3'b01_0;
             nstate = S3;
           end
      S3 : begin
             {cap0, add, valid} = 3'b00_1;
             nstate = S0;
           end
      default : begin
                  {cap0, add, valid} = 3'b00_0;
                  nstate = S0;
                end
    endcase
  end

endmodule
