// LDR R5, [R1]
// LDR R6, [R1, 4]
// STR

module memory_control(
	clk, op_code, src1, src2, rw, mem_data_in, mem_data_out,
	ldr_mux_sel, ldr_data_out, addr_mux_sel, addr_data_out
	);
	input clk;
	input [3:0] op_code;
	input [31:0] src1, src2;
	input [31:0] mem_data_in;
	
	// output to directly to RAM
	output reg rw;							// read = 0, write = 1
	output reg [31:0] mem_data_out;
	
	// output to LDR MUX
	output reg ldr_mux_sel;					// select=(LDR)? 1:0
	output reg [31:0] ldr_data_out;
	
	// output to Addr Bus MUX
	output reg addr_mux_sel;				// select=(STR||LDR)? 1:0
	output reg [15:0] addr_data_out;  		// there are only 16 words in memory
	
	
	
	always @(posedge clk) begin
		if (op_code == 4'b1101)	begin // LDR
			// fetch from memory
			// eg. LDR R4, [R5] == LDR dest_reg, src1 (stores mem content into R4)
			
			addr_mux_sel = 1;
			addr_data_out = src1[15:0];
			rw = 0;				// read
			
			// feed ldr data to LDR Mux
			ldr_mux_sel = 1;
			ldr_data_out = mem_data_in;
		end
			
		else if (op_code == 4'b1110) begin //STR
			// write to memory
			// eg. STR R4, [R5] == STR src2, src1 (stores R4 content into mem of R5)
			ldr_mux_sel = 0;		// TODO: do we need to set this to 0? or z? or omit any value assignment?	
			rw = 1;			// write == 1
			addr_mux_sel = 1;
			addr_data_out = src1[15:0];
			mem_data_out = src2;	

		end
		else begin
			// TODO: do we need to explicitly assign all to z? or does implicily default to it?
			rw = 1'bz;
			ldr_mux_sel = 1'bz;
			ldr_data_out = 32'bz;
			addr_mux_sel = 1'bz;
			addr_data_out = 16'bz;
		end
	end
endmodule
