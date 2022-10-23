`timescale 1ns / 1ps
module T_FlipFlop(t,clk,clr,q,qn);
input t,clk,clr;
output reg q;
output reg qn;
always@(posedge clk,negedge clr)
if(clr==0)begin
q<=0;
qn<=1;
end
else begin
q<=q^t;
qn<=~(q^t);
end
endmodule

module T_FlipFlop_tb();
reg t,clk,clr;
wire q,qn;
T_FlipFlop UUT(.t(t),.clk(clk),.clr(clr),.q(q),.qn(qn));
initial begin
clk = 0;
clr = 0;t = 0; #10;
clr = 1; t = 0; #10;
clr = 0; t = 1; #10;
clr = 1; t = 1; #10;
end
always #10 clk=~clk;
endmodule
