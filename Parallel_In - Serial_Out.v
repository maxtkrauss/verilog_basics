`timescale 1ns / 1ps
module PISO(clk,pi,load,so);
input clk, load;
input [3:0] pi;
output reg so;
reg [3:0] tmp;
always @(posedge clk)
begin
    if(load)
        tmp<=pi;
    else
    begin
        so<=tmp[0];
        tmp<={1'b0, tmp[3:1]};
    end
end
endmodule

module PISO_tb();
reg clk;
reg [3:0] pi=4'b1101;
wire so;
reg load;
PISO U(.clk(clk),.pi(pi),.so(so),.load(load));
initial begin
clk = 0; load = 1;#10;
load = 0;
end
always #5 clk=~clk;
endmodule
