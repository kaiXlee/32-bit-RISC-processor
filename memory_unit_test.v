
module memory_unit_test;
	reg clk, reset;
	wire rw;
	wire [15:0] address;
	wire [31:0] memory_word;
	wire [7:0] pc_count;
	wire [31:0] current_instruction;
	reg [31:0] data_in;
	
	initial
	begin
		$display($time, "Testing memory_instruction_unit");
	end
	
	initial
	begin
		$monitor($time, " clk=%b || reset=%b || rw=%b || address=%b || memory_word=%b || current_instruction=%b",
			clk,
			reset,
			rw,
			address,
			memory_word,
			current_instruction
		);
	end
	
	initial	begin
	clk = 0;
	reset = 1;
	#3 reset = 0;
	#4 reset = 1;
	
	#50 $finish; // Stop the simulation after 50 time units
	end
	
	always #5 clk =~ clk; // How to create a clk pulses of period 10
	
	
	ram ram1 (
		.clk(clk),
		.rw(rw),
		.address(address),
		.data_in(data_in),
		.data_out(memory_word)
	);
	
	instruction_memory instr_mem1 (
		.clk(clk),
		.reset(reset),
		.pc_count(pc_count),
		.instruction_in(memory_word),
		.rw_out(rw), 
		.address_out(address),
		.instruction_out(current_instruction)
	);	
	
	program_counter pc1 (
		.clk(clk),
		.reset(reset),
		.count(pc_count)
	);
	
endmodule
