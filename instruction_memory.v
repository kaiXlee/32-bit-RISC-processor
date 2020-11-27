
module instruction_memory(clk, reset, pc_count, instruction_in, address_out, instruction_out,
	immediat_value_out,
	destination_out, 
	s_bit_out,
	op_code_out,
	condition_out,
	src1_out,
	src2_out
	);
	input clk, reset;
	input [7:0] pc_count; // the program counter count (pointer position)
	input [31:0] instruction_in;
	output reg [15:0] address_out;
	output reg [31:0] instruction_out;
	output reg [15:0]  immediat_value_out;
	output reg [3:0] destination_out, op_code_out, condition_out;
	output reg s_bit_out;
	
	output reg [3:0] src1_out, src2_out;
	
	initial
	begin
	// $monitor($time, " instructionsss=%b",
		// instruction_in
	// );
	end
	
	always @(posedge clk) begin
		// fetch from memory
		address_out = pc_count;
		
		instruction_out = instruction_in;
		// feed data returned from memory out
		immediat_value_out = instruction_in[18:3];
		destination_out = instruction_in[22:19];
		s_bit_out = instruction_in[23];
		op_code_out = instruction_in[27:24];
		condition_out = instruction_in[31:28];
		
		src1_out = instruction_in[14:11];
		src2_out = instruction_in[18:15];		
		
	end

endmodule
