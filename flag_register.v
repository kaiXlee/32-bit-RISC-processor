// been imported to ALU, don't need this module
module status_registers(conditions, op_code, s, immediate_value, R2, R3, flags);
    output reg[3:0] flags;
    reg N,Z,C,V;
    input s;
    input [31:0] R2, R3;
    reg [31:0] source1, source2;
    reg [3:0] R4;
    input [3:0] conditions;
    input [15:0] immediate_value;
    reg [31:0] result;
    input [3:0] op_code;

    initial begin
        source1 = R2;
        source2 = R3;
        case (op_code)
            4'b0000: begin
                //(R1=R2+R3)
                assign {C, result} = source1 + source2;
                assign N = result[31];
                assign Z = result==0;
                assign V = s&&((result[31]^source1[31])&&(source1[31]~^source2[31]));


            end
            4'b0001: begin
                //(R1=R2-R3)
                assign {C, result} = source1 - source2;
                assign N = result[31];
                assign Z = result==0;
                assign V = s&&((result[31]^source1[31])&&(source1[31]~^source2[31]));


            end
            4'b0010: begin
                //(R1=R2*R3)
                //(assume the result is 32-bit maximum)
                assign {C, result} = source1 * source2;
                assign N = result[31];
                assign Z = result==0;
                assign V = s&&((result[31]^source1[31])&&(source1[31]~^source2[31]));

            end
            4'b0011: begin
                //(R1=R2 OR R3)
                assign result = source1|source2;

            end
            4'b0100: begin
                //(R1=R2 AND R3)
                assign result = source1&source2;

            end
            4'b0101: begin
                //(R1=R2 XOR R3)
                assign result = source1^source2;

            end
            4'b0110: begin
                //Initialize R1 with an immediate number n, 0 <= n <= (216−1)
                assign result = immediate_value;

            end
            4'b0111: begin
                //Copy R2 to R1
                result <= source1;

            end
            4'b1000: begin
                //(R1=R2 >>n), 1 <= n <= 31
                {result, C} <= {{source1,1'b0}>>immediate_value};
                assign N = result[31];
                assign Z = result==0;
                assign V = 1'b0;
            end
            4'b1001: begin
                //(R1=R2 <<n), 1 <= n <= 31
                {C, result} <= {{1'b0,source1}<<immediate_value};
                assign N = result[31];
                assign Z = result==0;
                assign V = 1'b0;


            end
            4'b1010: begin
                //(R1=Rotate right R2 by n-bit) , 1 <= n <= 31
                assign {result,C} = {{source1,source1,1'b0}>>immediate_value};
                assign N = result[31];
                assign Z = result==0;
                assign V = 1'b0;

            end
            4'b1011: begin
                //Compare R1 with R2 and set the status flags
                assign {C, result} = source1 - source2;
                assign N = result[31];
                assign Z = result==0;
                assign V = s&&((result[31]^source1[31])&&(source1[31]~^source2[31]));

            end
            4'b1100: begin
                //Initialize R1 with a 16-bit address n, 0 <= n <= (216−1)
                assign source1 = immediate_value;

            end
            4'b1101: begin
                //Load R2 with the contents at memory address R1
            end
            4'b1110: begin
                //Store R2 at memory address R1
            end
            4'b1111: begin
                //No Operation - Skip this instruction
                //remember to check the status of pc

            end

        endcase
        flags = {N,Z,C,V};
    end


endmodule       // flags



