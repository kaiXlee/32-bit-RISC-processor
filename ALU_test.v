module ALU_test();
    reg [31:0] src1, src2;
    reg [3:0] op_code;
    reg [15:0] immediate_value;
    reg [3:0] conditions;
	reg s;
	wire [3:0] flags;
    wire [31:0] result;
	
	reg [7:0] pc;
	reg clk, reset;


	parameter op_add = 4'b0000;
	parameter op_sub = 4'b0001;
	parameter op_mul = 4'b0010;
	parameter op_orr = 4'b0011;
	parameter op_and = 4'b0100;
	parameter op_xor = 4'b0101;
	parameter op_mov_n = 4'b0110;
	parameter op_mov = 4'b0111;
	parameter op_lsr = 4'b1000;
	parameter op_lsl = 4'b1001;
	parameter op_ror = 4'b1010;
	parameter op_cmp = 4'b1011;
	parameter op_adr = 4'b1100;
	parameter op_ldr = 4'b1101;
	parameter op_str = 4'b1110;
	parameter op_nop = 4'b1111;


	initial
	begin
		$display($time, "Testing ALU");
	end

	initial
	begin
		$monitor(" opcode=%b || conditions=%b || src1=%d || src2=%d || result=%d || flags(NZCV)=%b",
			op_code,
			conditions,
			src1,
			src2,
			result,
			flags
		);
	end

	initial
	begin
		clk = 0;
		conditions = 4'bxxxx;

	#5	op_code = op_add;
		//$display("Instruction: ADD Expected Result: result = 20 NZCV = 0000");
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'b1000;
		src2 = 32'b1100;
		//output:
		//result = 20 NZCV = 0000

	#10 op_code = op_add;
		//$display("Instruction: ADD Expected Result: result = 20 NZCV = 0000");
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'b11111111_11111111_11111111_11111111;
		src2 = 32'b1111;
		//output:
		//result =14 NZCV:0010

	#15 op_code = op_sub;
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'd26;
		src2 = 32'd26;
		//output:
		//result = 0 NZCV = 0100

	#20 op_code = op_mul;
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'd26;
		src2 = 32'd26;
		//output:
		//result = 676 NZCV = 0000

	#25 op_code = op_orr;
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'b101010;
		src2 = 32'b110100;
		//output:
		//result = 62

	#30 op_code = op_and;
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'd26;
		src2 = 32'd26;
		//output:
		//result = 26

	#30 op_code = op_xor;
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'b1100;
		src2 = 32'b1010;
		//output:
		//result = 6

	#30 op_code = op_mov_n;
		s = 1'b0;
		immediate_value = 1126;
		src1 = 32'd26;
		src2 = 32'd26;
		//output:
		//result = 1126

	#35 op_code = op_mov;
		s = 1'b0;
		immediate_value = 0;
		src1 = 32'd26;
		src2 = 32'd26;
		//output:
		//result = 26

	#40 op_code = op_lsr;
		s = 1'b0;
		immediate_value = 4;
		src1 = 32'b11000;
		src2 = 32'd0;
		//output:
		//result = 1 NZCV = 0010

	#45 op_code = op_lsl;
		s = 1'b0;
		immediate_value = 4;
		src1 = 32'b11000;
		src2 = 32'b0;
		//output:
		//result = 384 NZCV = 0000

	#50 op_code = op_ror;
		s = 1'b0;
		immediate_value = 8;
		src1 = 32'b11111100_10100101_00110110_10010000;
		src2 = 32'd0;
		//output:
		//result = 2771816700 NZCV = 1010

	#55 op_code = op_cmp;
		s = 1'b0;
		immediate_value = 8;
		src1 = 32'b1111;
		src2 = 32'b11111;
		//output:
		//result = xx NZCV = 1000

	#60 op_code = op_nop;
		//output: z
		//result = xx NZCV = xx



	#100 $finish; // Stop the simulation after 50 time units
	end

	always #5 clk =~ clk; // How to create a clk pulses of period 10



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

	// status_registers Status_Registers(
		// clk,
		// conditions,
		// op_code,
		// s,
		// immediate_value,
		// R2,
		// R3,
		// flags
	// );
endmodule