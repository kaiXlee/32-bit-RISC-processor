module register_banks(destination, src1_sel, src2_sel, ldr_mux_in, src1_out, src2_out);
    input [3:0] destination, src1_sel, src2_sel;
    input [31:0] ldr_mux_in;
    output [31:0] src1_out, src2_out;
	
    wire [15:0] enable;
    reg [31:0] registers [0:15];

    MUX mux1(src1_sel, registers[0], registers[1], registers[2], registers[3], registers[4], registers[5], registers[6], registers[7], registers[8], registers[9],
		registers[10], registers[11], registers[12], registers[13], registers[14], registers[15], src1_out);
    MUX mux2(src2_sel, registers[0], registers[1], registers[2], registers[3], registers[4], registers[5], registers[6], registers[7], registers[8], registers[9],
		registers[10], registers[11], registers[12], registers[13], registers[14], registers[15], src2_out);
    DECODER decoder1(destination, enable);

    always @(enable) begin
        // if (rw) begin
		case (enable)
			16'b0000000000000001: registers[0] = ldr_mux_in;
			16'b0000000000000010: registers[1] = ldr_mux_in;
			16'b0000000000000100: registers[2] = ldr_mux_in;
			16'b0000000000001000: registers[3] = ldr_mux_in;
			16'b0000000000010000: registers[4] = ldr_mux_in;
			16'b0000000000100000: registers[5] = ldr_mux_in;
			16'b0000000001000000: registers[6] = ldr_mux_in;
			16'b0000000010000000: registers[7] = ldr_mux_in;
			16'b0000000100000000: registers[8] = ldr_mux_in;
			16'b0000001000000000: registers[9] = ldr_mux_in;
			16'b0000010000000000: registers[10] = ldr_mux_in;
			16'b0000100000000000: registers[11] = ldr_mux_in;
			16'b0001000000000000: registers[12] = ldr_mux_in;
			16'b0010000000000000: registers[13] = ldr_mux_in;
			16'b0100000000000000: registers[14] = ldr_mux_in;
			16'b1000000000000000: registers[15] = ldr_mux_in;
			default: begin
				// do nothing
			end
		endcase
        // end
    end
endmodule





module MUX (sel, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, Y);
	 input [3:0] sel;
	 input [31:0]I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16;
	 output reg [31:0]Y;
	 always @(*) begin
		if (sel == 4'b0000) Y = I1;
		else if (sel == 4'b0001) Y = I2;
		else if (sel == 4'b0010) Y = I3;
		else if (sel == 4'b0011) Y = I4;
		else if (sel == 4'b0100) Y = I5;
		else if (sel == 4'b0101) Y = I6;
		else if (sel == 4'b0110) Y = I7;
		else if (sel == 4'b0111) Y = I8;
		else if (sel == 4'b1000) Y = I9;
		else if (sel == 4'b1001) Y = I10;
		else if (sel == 4'b1010) Y = I11;
		else if (sel == 4'b1011) Y = I12;
		else if (sel == 4'b1100) Y = I13;
		else if (sel == 4'b1101) Y = I14;
		else if (sel == 4'b1110) Y = I15;
		else if (sel == 4'b1111) Y = I16;
		else begin
		// do nothing
		end
	 end
endmodule





module DECODER(destination, enable_out);

    input [3:0] destination;
    output reg [15:0] enable_out;

	always @(*) begin
		case(destination)
			4'b0000: begin enable_out=16'b0000000000000001; end
			4'b0001: begin enable_out=16'b0000000000000010; end
			4'b0010: begin enable_out=16'b0000000000000100; end
			4'b0011: begin enable_out=16'b0000000000001000; end
			4'b0100: begin enable_out=16'b0000000000010000; end
			4'b0101: begin enable_out=16'b0000000000100000; end
			4'b0110: begin enable_out=16'b0000000001000000; end
			4'b0111: begin enable_out=16'b0000000010000000; end
			4'b1000: begin enable_out=16'b0000000100000000; end
			4'b1001: begin enable_out=16'b0000001000000000; end
			4'b1010: begin enable_out=16'b0000010000000000; end
			4'b1011: begin enable_out=16'b0000100000000000; end
			4'b1100: begin enable_out=16'b0001000000000000; end
			4'b1101: begin enable_out=16'b0010000000000000; end
			4'b1110: begin enable_out=16'b0100000000000000; end
			4'b1111: begin enable_out=16'b1000000000000000; end
			default: begin 
				// do nothing
			end
		endcase
	end
endmodule
