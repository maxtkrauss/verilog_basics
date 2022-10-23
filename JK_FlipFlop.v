`timescale 1ns / 1ps
module JK_FlipFlop(j,k,clr,clk,q,qn);
input j,k,clr,clk;
output reg q;
output reg qn;
always@(posedge clk,negedge clr)
if (clr==1) begin
q<=0;
qn<=1;
end
else case({j,k})
2'b00:begin q<=q;qn<=qn; end
2'b01:begin q<=1'b0;qn<=1'b1;end
2'b10:begin q<=1'b1;qn<=1'b0;end
2'b11:begin q<=~q; qn<=~qn; end
default:{q,qn}<=2'bxx;
endcase
endmodule

module JK_FlipFlop_tb();
reg j,k,clr,clk;
wire q,qn;
JK_FlipFlop UUT(.j(j),.k(k),.clk(clk),.clr(clr),.q(q),.qn(qn));
initial begin
j=0;
k=0;
clk=0;
clr=1;
end
always #1 clk=~clk;
always #2 {j,k}={j,k}+1'b1;
initial #10 clr=1'b0;
initial #100 $finish;
endmodule