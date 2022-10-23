`timescale 1ns / 1ps
module PIPO(clk,pi,po);
input clk;
input [3:0] pi;
output reg [3:0] po;
always @(posedge clk)
begin
po=pi;
end
endmodule

module PIPO_tb;
reg clk;
reg [3:0] pi=4'b1101;
wire [3:0] po;
PIPO U(.clk(clk),.pi(pi),.po(po));
initial begin
clk=0;
#10;
end
always #5 clk=~clk;
endmodule
