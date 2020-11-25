
module processor_32_bit(clk);
	input clk;
	reg reset;
	wire rw;
	wire [15:0] address;
	wire [31:0] data_out;
	wire [7:0] pc_count;
	wire [31:0] current_instruction;
	reg [31:0] data_in;
	
	ram ram1 (
		.clk(clk),
		.rw(rw),
		.address(address),
		.data_in(mem_data_out),
		.data_out(data_out)
	);
	
	instruction_memory instr_mem1 (
		.clk(clk),
		.reset(reset),
		.pc_count(pc_count),
		.instruction_in(data_out),
		.rw_out(rw), 
		.address_out(address),
		.instruction_out(current_instruction)
	);	
	
	program_counter pc1 (
		.clk(clk),
		.reset(reset),
		.count(pc_count)
	);
	
	
	
	mem_control_unit ctrl1 (
		.clk(clk),
		.pc(pc),
		.op_code(op_code),
		.src1(src1),
		.src2(src2),
		.alu_result(alu_result),
		.mem_data_in(data_out),
		
		.addr_mux_out(addr_mux_out),
		.ldr_mux_out(ldr_mux_out),
		.rw(rw),
		.mem_data_out(mem_data_out)
	);


	register_banks RB1(
		.destination(destination), 
		.src1_sel(src1_sel), 
		.src2_sel(src2_sel), 
		.ldr_mux_in(ldr_mux_in), 
		.src1_out(src1_out), 
		.src2_out(src2_out)
	);
	
	ALU ALU(
		.src1(src1),
		.src2(src2),
		.op_code(op_code),
		.immediate_value(immediate_value),
		.conditions(conditions),
		.s(s),
		.flags(flags),
		.result(result)
	);



endmodule