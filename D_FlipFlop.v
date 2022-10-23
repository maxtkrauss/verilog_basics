`timescale 1ns / 1ps
module D_FlipFlop(d,clk,clr,q,qn);
input d,clk,clr;
output reg q;
output reg qn;

always@(posedge clk, negedge clr)
if (clr == 0) begin
q<=0;
qn<=1;
end
else begin
q<=d;
qn<=~d;
end
endmodule

module D_FlipFlop_tb();
reg d=0;
reg clk=0;
reg clr=1;
wire q,qn;
integer i;
D_FlipFlop UUT(.d(d),.clk(clk),.clr(clr),.q(q),.qn(qn));
initial begin
    for(i=0;i<20;i=i+1)begin
    clk=~clk;
    if(i>3 & i<10) d=1;
    if(i==15) clr = 0;
    #10;
    end
end
endmodule