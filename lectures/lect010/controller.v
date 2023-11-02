module controller (
  input clock, rst_n, start,
  output cap0, cap1, add, valid
);

  wire [2:0] cstate, cstate_n, nstate, nstate_d;

  assign nstate[2] =   cstate[1] & cstate[0];
  assign nstate[1] = ( cstate[1] & cstate_n[0] ) |
    ( cstate_n[1] & cstate[0] );
  assign nstate[0] = ( cstate[1] & cstate_n[0] ) |
    ( cstate_n[2] & cstate_n[0] & start );

  assign cap0 = cstate_n[1] & cstate[0];
  assign cap1 = cstate[1] & cstate_n[0];
  assign add  = cstate[1] & cstate[0];
  assign valid = cstate[2] & cstate_n[0];

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

endmodule
