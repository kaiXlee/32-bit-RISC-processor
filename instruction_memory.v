
module instruction_memory(clk, reset, pc_count, instruction_in, rw_out, address_out, instruction_out);
	input clk, reset;
	input [7:0] pc_count; // the program counter count (pointer position)
	input [31:0] instruction_in;
	output reg rw_out;
	output reg [15:0] address_out;
	output reg [31:0] instruction_out;
	
	always @(posedge clk) begin
		// fetch from memory
		rw_out = 0;	// read
		address_out = pc_count;
		
		// feed data returned from memory out
		instruction_out = instruction_in;
	end

endmodule
