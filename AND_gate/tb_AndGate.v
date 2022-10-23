`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2022 10:40:24 AM
// Design Name: 
// Module Name: tb_AndGate
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


module tb_OrGate();
    reg a,b;
    wire y;
    OrGate dut(a,b,y);
    initial begin
        a=0; b=0;#10;
        b=1;     #10;
        a=1; b=0;#10;
        b=1;     #10;
    end
endmodule
       
