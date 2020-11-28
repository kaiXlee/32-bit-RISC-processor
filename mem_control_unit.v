
module mem_control_unit (clk, pc, op_code, src1, src2, alu_result, conditions, mem_data_in,
	addr_mux_out, ldr_mux_out, rw, mem_data_out);
	input clk;
	input [7:0] pc;
	input [3:0] op_code;
	input [31:0] src1, src2;
	input [31:0] alu_result;
	input [3:0] conditions;
	input [31:0] mem_data_in;
	
	output [15:0] addr_mux_out;
	output [31:0] ldr_mux_out;
	output rw;
	output [31:0] mem_data_out;
	
	wire ldr_mux_sel, addr_mux_sel;
	wire [31:0] ldr_data;
	wire [15:0] addr_data;
	
	localparam OP_LDR = 4'b1101;
	localparam OP_STR = 4'b1110;
		
	memory_control mem_ctrl1 (
		.clk(clk), 
		.op_code(op_code),
		.src1(src1),
		.src2(src2),
		.rw(rw),
		.mem_data_in(mem_data_in),
		.mem_data_out(mem_data_out),
		.ldr_mux_sel(ldr_mux_sel),
		.ldr_data_out(ldr_data),
		.addr_mux_sel(addr_mux_sel),
		.addr_data_out(addr_data)
	);
	
	addr_bus_mux addr_mux1 (
		.sel(addr_mux_sel),
		.pc(pc),
		.addr_bus_in(addr_data),
		.addr_bus_out(addr_mux_out)
	);
	
	ldr_mux ldr_mux1 (
		.sel(ldr_mux_sel),
		.ldr_data_in(ldr_data),
		.alu_result(alu_result),
		.ldr_data_out(ldr_mux_out)
	);
	
	
endmodule