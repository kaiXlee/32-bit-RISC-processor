module program_counter(clk, reset, count);
	input clk, reset;
	output reg [7:0]  count; // 8-bit counter as specified in project description

    always @(posedge clk or negedge reset) begin
    	if (!reset)
    		count = 8'b0;
    	else begin
			count = count + 1;
    	end
    end
endmodule
