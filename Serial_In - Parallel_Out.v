`timescale 1ns / 1ps

module SIPO(clk,si,po);
input clk, si;
output [3:0] po;
reg [3:0] tmp;
always @(posedge clk)
begin 
    tmp = {si,tmp[3:1]};
end
assign po = tmp;
endmodule

module SIPO_tb();
reg clk;
reg si;
wire [3:0] po;
SIPO U(.clk(clk),.si(si),.po(po));
initial begin
clk=0;si=1;#10;
si=1; #10;
si=0; #10;
si=1; #10;
end
always #5 clk=~clk;
endmodule
