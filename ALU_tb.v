`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2026 16:54:43
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;

reg clk;
reg enable;
reg [7:0] a, b;
reg [2:0] op;
wire [7:0] y;

ALU uut (
    .clk(clk),
    .enable(enable),
    .a(a),
    .b(b),
    .op(op),
    .y(y)
);

always #5 clk = ~clk;

// Monitor whwner the value  changes it prints 
initial begin
    $monitor("Time=%0t | a=%d b=%d op=%b | y=%d", $time, a, b, op, y);
end

initial begin
    clk = 0;
    enable = 1;

    a=10; b=5; op=3'b000; #10; // ADD
    a=20; b=3; op=3'b001; #10; // SUB
    a=7;  b=2; op=3'b010; #10; // AND
    a=8;  b=1; op=3'b011; #10; // OR
    a=6;  b=3; op=3'b100; #10; // XOR
    a=4;  b=0; op=3'b101; #10; // SHIFT LEFT
    a=16; b=0; op=3'b110; #10; // SHIFT RIGHT
    a=2;  b=5; op=3'b111; #10; // SLT 

    // Disable test
    enable = 0;
    a=50; b=10; op=3'b000; #40;
    a=12; b=11; op=3'b101; #20;

    // Enable again
    enable = 1;
    a=9; b=1; op=3'b011; #30;

    #50;
    $finish;
end
endmodule
