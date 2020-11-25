module RB_test();
	reg clk;
    reg [3:0] destination, src1_sel, src2_sel;
    reg [31:0] ldr_mux_in;
	wire [31:0] src1_out, src2_out;
    

	initial
	begin
		$display($time, "Testing register bank");
	end

	initial
	begin
		$monitor($time, " clk=%b || destination=%d || src1_sel=%d || src2_sel=%d || ldr_mux_in=%d || src1_out=%d || src2_out=%d ",
			clk,
			destination,
			src1_sel,
            src2_sel,
			ldr_mux_in,
            src1_out,
            src2_out
		);
	end

	initial
	begin
		src1_sel = 4'd1;
		src2_sel = 4'd3;

	#5	
        destination = 4'd1;
        ldr_mux_in = 4'd12;

    #10
        destination = 4'd3;
        ldr_mux_in = 31'd22;
	#10 
		destination = 4'bz;
		src1_sel = 4'd1;
		src2_sel = 4'd3;

	#10 $finish; // Stop the simulation after 50 time units

	end

    register_banks RB1(
		.destination(destination), 
		.src1_sel(src1_sel), 
		.src2_sel(src2_sel), 
		.ldr_mux_in(ldr_mux_in), 
		.src1_out(src1_out), 
		.src2_out(src2_out)
	);
	
endmodule