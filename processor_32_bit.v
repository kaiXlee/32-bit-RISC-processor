
module processor_32_bit(clk, reset);
	input clk;
	input reset;
	wire rw;
	wire [15:0] address;
	wire [31:0] data_out;
	wire [7:0] pc_count;
	reg [31:0] data_in;
	
	// Instruction memory
	wire [31:0] instruction;
	wire [15:0] intr_address_out;
	wire [31:0] intr_instruction_out;
	wire [15:0] intr_immediat_value_out;
	wire [3:0] intr_destination_out, intr_condition_out;
	wire intr_s_bit_out;
	wire [3:0] intr_src1_out, intr_op_code_out, intr_src2_out;
	
	// Register Bank
	wire [31:0] rb_src1_out, rb_src2_out;
	
	// ALU
	wire [31:0] alu_result_out;
	wire [3:0] alu_flags_out;	// one of the final outputs
	
	// Memory Control Unit
	wire [15:0] mem_ctrl_addr_mux_out;
	wire [31:0] mem_ctrl_ldr_mux_out;
	wire mem_ctrl_rw;
	wire [31:0] mem_ctrl_data_out;
	wire reg_write;
	
	ram ram1 (
		.clk(clk),
		.rw(mem_ctrl_rw),
		.address(mem_ctrl_addr_mux_out),
		.data_in(mem_ctrl_data_out),
		.data_out(data_out),
		.pc_addr(pc_count),
		.fetch_instruction_out(instruction)
	);
	
	instruction_memory instr_mem1 (
		.clk(clk),
		.reset(reset),
		.pc_count(pc_count),
		.instruction_in(instruction),
		.address_out(intr_address_out),
		.instruction_out(intr_instruction_out),
		.immediat_value_out(intr_immediat_value_out),
		.destination_out(intr_destination_out), 
		.s_bit_out(intr_s_bit_out),
		.op_code_out(intr_op_code_out),
		.condition_out(intr_condition_out),
		.src1_out(intr_src1_out),
		.src2_out(intr_src2_out)
	);	
	
	program_counter pc1 (
		.clk(clk),
		.reset(reset),
		.count(pc_count)
	);
	
	
	
	mem_control_unit ctrl1 (
		.clk(clk),
		// .pc(pc_count),
		.op_code(intr_op_code_out),
		.src1(rb_src1_out),
		.src2(rb_src2_out),
		.alu_result(alu_result_out),
		.mem_data_in(data_out),
		.addr_mux_out(mem_ctrl_addr_mux_out),
		.ldr_mux_out(mem_ctrl_ldr_mux_out),
		.rw(mem_ctrl_rw),
		.mem_data_out(mem_ctrl_data_out),
		.reg_write(reg_write)
	);


	register_banks RB1(
		.destination(intr_destination_out), 
		.src1_sel(intr_src1_out), 
		.src2_sel(intr_src2_out),
		.reg_write(reg_write),
		.ldr_mux_in(mem_ctrl_ldr_mux_out), 
		.src1_out(rb_src1_out), 
		.src2_out(rb_src2_out)
	);
	
	ALU ALU(
		.src1(rb_src1_out),
		.src2(rb_src2_out),
		.op_code(intr_op_code_out),
		.immediate_value(intr_immediat_value_out),
		.conditions(intr_condition_out),
		.s(intr_s_bit_out),
		.flags(alu_flags_out),
		.result(alu_result_out)
	);



endmodule