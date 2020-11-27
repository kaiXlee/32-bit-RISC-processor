
module mem_control_unit (clk, pc, op_code, src1, src2, alu_result, mem_data_in,
	addr_mux_out, ldr_mux_out, rw, mem_data_out, reg_write);
	input clk;
	input [7:0] pc;
	input [3:0] op_code;
	input [31:0] src1, src2;
	input [31:0] alu_result;
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
	
	output reg reg_write;
	
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
	
	always @ (op_code) begin
		case (op_code)
            4'b0000: begin
				reg_write = 1;
            end
			
            4'b0001: begin
                reg_write = 1;
            end
			
            4'b0010: begin
                reg_write = 1;
            end
			
            4'b0011: begin
                //(R1=R2 OR R3)
                reg_write = 1;
            end
			
            4'b0100: begin
                //(R1=R2 AND R3)
                reg_write = 1;			
            end
			
            4'b0101: begin
                //(R1=R2 XOR R3)
                reg_write = 1;
            end
			
            4'b0110: begin
                //Initialize R1 with an immediate number n, 0 <= n <= (216−1)
                reg_write = 1;
            end
			
            4'b0111: begin
                //Copy R2 to R1
                reg_write = 1;
            end
			
            4'b1000: begin
                //(R1=R2 >>n), 1 <= n <= 31
                reg_write = 1;
            end
			
            4'b1001: begin
                //(R1=R2 <<n), 1 <= n <= 31
                reg_write = 1;
            end
			
            4'b1010: begin
                //(R1=Rotate right R2 by n-bit) , 1 <= n <= 31
                reg_write = 1;
            end
			
            4'b1011: begin
                //Compare R1 with R2 and set the status flags
                reg_write = 0;
            end
			
            4'b1100: begin
                //Initialize R1 with a 16-bit address n, 0 <= n <= (216−1)
                reg_write = 1;
            end
			
            4'b1101: begin
                //Load R2 with the contents at memory address R1
				reg_write = 1;
            end
			
            4'b1110: begin
                //Store R2 at memory address R1
				reg_write = 0;
            end
			
            4'b1111: begin
                //No Operation - Skip this instruction
                //remember to check the status of pc
				reg_write = 0;
			end
	
		endcase
	end
	
	
	
endmodule