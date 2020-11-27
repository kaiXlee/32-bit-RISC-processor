module ALU(src1, src2, op_code, immediate_value, conditions, s, flags, result);
    input [31:0] src1, src2;
    input [3:0] op_code;
    input [15:0] immediate_value;
    input [3:0] conditions;
    input s;
    output reg [31:0] result;
	output reg [3:0] flags;
	reg N, Z, C, V;
	
	reg [4:0] shift_bits;
	reg reg_write;


    always @(*) begin
		//flags = {N,Z,C,V};
        //if(conditions==flags) begin
		
		shift_bits = immediate_value[7:3];
		
        case (op_code)
            4'b0000: begin
                //(R1=R2+R3)
                result = src1 + src2;
				
				// calculate flags
				{C, result} = src1 + src2;
                N = result[31];
                Z = result==0;
                V = s&&((result[31]^src1[31])&&(src1[31]~^src2[31]));
                //$display($time, "NZCV:%b%b%b%b",N,Z,C,V);
            end
			
            4'b0001: begin
                //(R1=R2-R3)
                 result = src1 - src2;
				
				// calculate flags
				 {C, result} = src1 - src2;
                N = result[31];
                Z = result==0;
                V = s&&((result[31]^src1[31])&&(src1[31]~^src2[31]));
            end
			
            4'b0010: begin
                //(R1=R2*R3)
                //(assume the result is 32-bit maximum)
                result = src1 * src2;
				
				
                {C, result} = src1 * src2;
                N = result[31];
                Z = result==0;
                V = s&&((result[31]^src1[31])&&(src1[31]~^src2[31]));
            end
			
            4'b0011: begin
                //(R1=R2 OR R3)
                result = src1|src2;
            end
			
            4'b0100: begin
                //(R1=R2 AND R3)
                result = src1&src2;				
            end
			
            4'b0101: begin
                //(R1=R2 XOR R3)
                result = src1^src2;
            end
			
            4'b0110: begin
                //Initialize R1 with an immediate number n, 0 <= n <= (216−1)
				// $display("immediate_value=%b", immediate_value);
                result = immediate_value;
            end
			
            4'b0111: begin
                //Copy R2 to R1
                result = src1;
            end
			
            4'b1000: begin
                //(R1=R2 >>n), 1 <= n <= 31
                // result = {src1>>immediate_value};
				
				{result, C} = {{src1,1'b0} >> shift_bits};
                N = result[31];
                Z = result==0;
                V = 1'b0;
            end
			
            4'b1001: begin
                //(R1=R2 <<n), 1 <= n <= 31
                // result = {src1<<immediate_value};
				// MOV R4, R2, LSL#2
				// MOV dest, src2, N/A
				$display("source 2 = %d", src2);
				$display("immediate_value = %b", immediate_value);
				
				{C, result} = {{1'b0,src2} << shift_bits};
                N = result[31];
                Z = result==0;
                V = 1'b0;
            end
			
            4'b1010: begin
                //(R1=Rotate right R2 by n-bit) , 1 <= n <= 31
                // result = {{src1,src1}>>immediate_value};
				
				{result,C} = {{src1,src1,1'b0} >> shift_bits};
                N = result[31];
                Z = result==0;
                V = 1'b0;
            end
			
            4'b1011: begin
                //Compare R1 with R2 and set the status flags
                {C, result} = src1 - src2;
                N = result[31];
                Z = result==0;
                V = s&&((result[31]^src1[31])&&(src1[31]~^src2[31]));
				result = 32'bz;
            end
			
            // 4'b1100: begin
                // //Initialize R1 with a 16-bit address n, 0 <= n <= (216−1)
                // result = immediate_value;
            // end
			
            // 4'b1101: begin
                // //Load R2 with the contents at memory address R1
            // end
			
            // 4'b1110: begin
                // //Store R2 at memory address R1
            // end
			
            // 4'b1111: 
                // //No Operation - Skip this instruction
                // //remember to check the status of pc
			
			default: begin
				// do nothing
			end
        endcase
        flags = {N,Z,C,V};
		$display("flags N,Z,C,V: %b", flags);
        //    end
    end
endmodule

