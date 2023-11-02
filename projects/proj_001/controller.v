// controller
module controller (
  input clock, rst_n, start,
  output reg A, B, C, D, en, valid
);

  wire [2:0] cstate, nstate_d, cstate_n;
  reg [2:0] nstate;

  mux21 #( .WIDTH(3) ) rst_mux (
	.in_0( 3'b000 ),
	.in_1( nstate ),
	.sel( rst_n ),
	.f( nstate_d )
  );

  dff #( .WIDTH(3) ) state_vec (
	.clock( clock ),
	.d( nstate_d ),
	.q( cstate ),
	.q_n( cstate_n )
  );

  always @* begin
    case( cstate )
	3'b000 : begin
		   {A, B, C, D, en, valid} = 6'b100000;
		   nstate = start ? 3'b010 : 3'b000;
		 end
	3'b001 : begin
		   {A, B, C, D, en, valid} = 6'b100000;
		   nstate = 3'b010;
		 end
	3'b010 : begin
		   {A, B, C, D, en, valid} = 6'b010000;
		   nstate = 3'b011;
		 end
	3'b011 : begin
		   {A, B, C, D, en, valid} = 6'b001000;
		   nstate = 3'b100;
		 end
	3'b100 : begin
		   {A, B, C, D, en, valid} = 6'b000100;
		   nstate = 3'b101; 
		 end
	3'b101 : begin
		   {A, B, C, D, en, valid} = 6'b000010;
		   nstate = 3'b110;
		 end
	3'b110 : begin
		   {A, B, C, D, en, valid} = 6'b000001;
		   nstate = 3'b000;
		 end
	default : begin
		    {A, B, C, D, en, valid} = 6'b000000;
		    nstate = 3'b000;
		  end
    endcase
  end

endmodule
