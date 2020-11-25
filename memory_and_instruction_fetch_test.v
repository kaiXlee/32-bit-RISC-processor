
// eg. LDR R4, [R5] == LDR dest_reg, src1 (stores mem content into R4)
// eg. STR R4, [R5] == STR src2, src1 (stores R4 content into mem address specified by R5)

module mem_control_unit_test;
	reg clk, reset;
	reg [3:0] op_code;
	reg [31:0] src1, src2, alu_result, mem_data_in;
	reg [7:0] pc;

	wire [15:0] addr_mux_out;
	wire [31:0] ldr_mux_out, mem_data_out;
	wire rw;
	
	localparam OP_LDR = 4'b1101;
	localparam OP_STR = 4'b1110;
	
	initial
	begin
		$display($time, "Testing memory control");
	end
	
	initial
	begin
		$monitor($time, " clk=%b || reset=%b || rw=%b || addr_mux_out=%b || ldr_mux_out=%b || mem_data_out=%b",
			clk,
			reset,
			rw,
			addr_mux_out,
			ldr_mux_out,
			mem_data_out
		);
	end
	
	initial
	begin
	clk = 0;
	reset = 1;
	#5 
		// input: LDR dest, src1 
		// output: 
			// rw = 0;
			// addr_mux_out = 000000000000001
			// ldr_mux_out = 11111111111111111111111111111111
			// mem_data_out = x
			
		op_code = OP_LDR;
		src1 = 32'b000000000000000000000000000001;
		mem_data_in = 32'b11111111111111111111111111111111;
	#10
		// output: 
			// rw = 0;
			// addr_mux_out = 000000000000010
			// ldr_mux_out = 11111111111111111111111111111110
			// mem_data_out = x
		op_code = OP_LDR;
		src1 = 32'b000000000000001000000000000010;
		mem_data_in = 32'b11111111111111111111111111111110;
	#15
	// output: 
			// rw = 1;
			// addr_mux_out = 000000000000011
			// ldr_mux_out = x
			// mem_data_out = 000000000000000000000000000101
		op_code = OP_STR;
		src1 = 32'b000000000000010000000000000011; // mem addr
		src2 = 32'b000000000000000000000000000101; // content to store
		
		
		
	
	// #50 $finish; // Stop the simulation after 50 time units
	end
	
	always #5 clk =~ clk; // How to create a clk pulses of period 10
	
	
	mem_control_unit ctrl1 (
		.clk(clk),
		.pc(pc),
		.op_code(op_code),
		.src1(src1),
		.src2(src2),
		.alu_result(alu_result),
		.mem_data_in(mem_data_in),
		
		.addr_mux_out(addr_mux_out),
		.ldr_mux_out(ldr_mux_out),
		.rw(rw),
		.mem_data_out(mem_data_out)
	);
	
endmodule
