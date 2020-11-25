
module addr_bus_mux (sel, pc, addr_bus_in, addr_bus_out);
	input sel;			// select(LDR=1 OR STR=1)
	input [7:0] pc; 	// 8-bit program counter
	input [15:0] addr_bus_in;	// 16-bit cause memory has 2^16 words (rows)
	output reg [15:0] addr_bus_out;	// 
	
	always @(*)
	begin
		if (sel)
			addr_bus_out = addr_bus_in;
		else
			addr_bus_out = pc;
	end
endmodule
	
