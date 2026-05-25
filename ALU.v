`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2026 16:52:56
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ALU (
    input clk,
    input enable,         
    input [7:0] a, b,
    input [2:0] op,
    output reg [7:0] y
);

// Stage 1 registers to store the inputs 
reg [7:0] a_reg, b_reg;
reg [2:0] op_reg;

// Stage 2 result
reg [7:0] result;

// Stage 1: captures the inputs only if enabled
always @(posedge clk) begin
    if (enable) begin
        a_reg <= a;
        b_reg <= b;
        op_reg <= op;
    end
end

// Stage 2: compute only if enabled else it doesnot do
always @(posedge clk) begin
    if (enable) begin
        case(op_reg)
            3'b000: result <= a_reg + b_reg;
            3'b001: result <= a_reg - b_reg;
            3'b010: result <= a_reg & b_reg;
            3'b011: result <= a_reg | b_reg;
            3'b100: result <= a_reg ^ b_reg;
            3'b101: result <= a_reg << 1;
            3'b110: result <= a_reg >> 1;
            3'b111: result <= (a_reg < b_reg);
        endcase
    end
end

// Stage 3: output is taken here
always @(posedge clk) begin
    if (enable)
        y <= result;
        else
        y<= y;
end

endmodule