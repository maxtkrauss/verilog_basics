`timescale 1ns / 1ps
module Generator(a,b,c,p);
input a,b,c;
output p;
assign p = a^b^c;
endmodule

module Checker(a,b,c,p,y);
input a,b,c,p;
output y;
Generator UUT(.a(a),.b(b),.c(c),.p(p));
assign y = (a^b)^(c^p);
endmodule

module Parity_Chip_tb_FPGA(input [15:0]sw, output [15:0]led);
Checker UUT(.a(sw[0]),.b(sw[1]),.c(sw[2]),.y(led[0]));
endmodule

//module Parity_Chip_tb();
//reg a,b,c;
//wire y;
//integer i;
//initial begin
//a = 0;b = 0; c = 0;#10;
//for(i = 0; i < 8; i = i+1)begin
//{a,b,c} = {a,b,c}+1; #10;
//end
//end
//Checker UUT(.a(a),.b(b),.c(c),.p(p),.y(y));
//endmodule




