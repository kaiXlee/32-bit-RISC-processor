
module processor_32_bit_test;
	reg clk, reset;
	wire [3:0] alu_flags_out;

	
	initial
	begin
		$display($time, "Testing processor");
	end
	
	// initial
	// begin
		// $monitor($time, " clk=%b || reset=%b",
			// clk,
			// reset
		// );
	// end
	
	initial	begin
	clk = 0;
	reset = 1;
	#3 reset = 0;
	#4 reset = 1;
	
	#100 $finish; // Stop the simulation after 50 time units
	end
	
	always #5 clk =~ clk; // How to create a clk pulses of period 10
	
	
	processor_32_bit processor1 (
		.clk(clk),
		.reset(reset)	
	);
	
endmodule
