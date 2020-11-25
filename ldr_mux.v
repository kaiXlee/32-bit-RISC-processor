
module ldr_mux (sel, ldr_data_in, alu_result, ldr_data_out);
	input sel;		// select=(LDR)? 1:0
	input [31:0] ldr_data_in, alu_result;	// result from ALU
	output reg [31:0] ldr_data_out;		// ldr_data_output into register bank
	
	always @(*)
	begin
		if (sel)
			ldr_data_out = ldr_data_in;
		else
			ldr_data_out = alu_result;
	end
endmodule
	
	
	
	
	