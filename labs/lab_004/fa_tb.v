// Test Bench for Full Adder

module fa_tb;

  reg Cin, A, B;
  wire Cout, Sum;

  fa DUT (
	Cin, A, B, Cout, Sum
  );

  initial begin
    $display( $time, ": A B Cin | Cout Sum" );
    $display( $time, ": --------+---------" );
    $monitor( $time, ": %b %b %b | %b %b", A, B, Cin, Cout, Sum );
  end

  initial begin
        { A, B, Cin } = 3'b000;
    #10 { A, B, Cin } = 3'b001;
    #10 { A, B, Cin } = 3'b010;
    #10 { A, B, Cin } = 3'b011;
    #10 { A, B, Cin } = 3'b100;
    #10 { A, B, Cin } = 3'b101;
    #10 { A, B, Cin } = 3'b110;
    #10 { A, B, Cin } = 3'b111;
    #10 $stop();
  end

endmodule
