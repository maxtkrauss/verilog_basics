`timescale 1ns / 1ps

module SISO(clk,si,so);
input clk;
input si;
output so;
reg [3:0] q=0;
always @(posedge clk)
begin
    q[3]<=si;
    q[2]<=q[3];
    q[1]<=q[2];
    q[0]<=q[1];
end
assign so=q[0];
endmodule

module SISO_tb();
reg clk;
reg si;
wire so;
SISO U(.clk(clk),.si(si),.so(so));
always #5 clk=~clk;
initial begin
clk = 0; si = 1;#10;
si = 1; #10;
si = 0; #10;
si = 1;
end
endmodule


