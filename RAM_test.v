module RAM_test();
    reg clk, rw;
    reg [15:0] address;
    reg [31:0] data_in;
    wire [31:0] data_out;

    initial
	begin
		$display($time, "  Testing ALU");
	end

    initial
	begin
		$monitor($time, " Read(1)/Write(0)=%b || address=%d || data_in=%d || data_out=%d",
			rw,
			address,
			data_in,
			data_out
		);
	end

    initial
	begin
		clk = 0;

	#5	rw = 1'b1;
		address = 16'd0;
		data_in = 31'd10;
		//data_out: x

	#10 rw = 1'b1;
		address = 16'd1;
        data_in = 32'd20;
		//data_out: x

    #10	rw = 1'b1;
		address = 16'd2;
        data_in = 31'd30;
		//data_out: x

	#10 rw = 1'b1;
		address = 16'd3;
        data_in = 32'd40;
		//data_out: x

    #10	rw = 1'b0;
		address = 16'd0;
		//data_out: data_out = 10

	#10 rw = 1'b0;
		address = 16'd1;
		//data_out: data_out = 20

    #10	rw = 1'b0;
		address = 16'd2;
		//data_out: data_out = 30

	#10 rw = 1'b0;
		address = 16'd3;
		//data_out: data_out = 40

	end

    always #5 clk =~ clk;

    ram RAM(clk, rw, address, data_in, data_out);
    endmodule