
module ram (clk, rw, address, data_in, data_out);    
	input clk;   
	input rw;   
	input  [15:0] address;   //16-bit address input
	input  [31:0] data_in;   //32-bit data input
	output reg [31:0] data_out;   //32-bit data output
	reg    [31:0] ram [0:65535]; // 2^16 == 65536 thus, Ram is 65536 by 32
	 
	initial begin
		$readmemb("Data File Example 2020W_32bit.txt", ram);
		$display(ram[1]);
	end
	
	// for memory control read, write
	always @(posedge clk) begin
		if(!rw) //rw==0 is read
			data_out = ram[address];   // read
		else
			ram[address] = data_in;  // write 
	end	
endmodule