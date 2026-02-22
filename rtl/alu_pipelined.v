// Pipelined ALU Verilog module
module alu_pipelined #(parameter width = 4)(
    input clk,
    input reset,
    input [width-1:0] A,
    input [width-1:0] B,
    input [3:0] opcode,
    output reg [2*width-1:0] result
);

reg [width-1:0] A_reg, B_reg;
reg [3:0] opcode_reg;
reg [2*width-1:0] exe_result;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        A_reg <= 0;
        B_reg <= 0;
        opcode_reg <= 0;
    end
    else begin
        A_reg <= A;
        B_reg <= B;
        opcode_reg <= opcode;
    end
end

always @(*) begin
    case(opcode_reg)
        4'b0000: exe_result = A_reg + B_reg;   // ADD
        4'b0001: exe_result = A_reg - B_reg;   // SUB
        4'b0010: exe_result = A_reg & B_reg;   // AND
        4'b0011: exe_result = A_reg | B_reg;   // OR
        4'b0100: exe_result = A_reg * B_reg;   // MUL
        default: exe_result = 0;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset)
        result <= 0;
    else
        result <= exe_result;
end

endmodule
