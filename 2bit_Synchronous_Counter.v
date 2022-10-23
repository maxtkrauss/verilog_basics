`timescale 1ns / 1ps
module Counter(x,clk,q,y);
input x,clk;
output reg [1:0] q;
output reg y;

initial begin
q=2'b00;
y=1'b0;
end

always @ (negedge clk)
if (x==1) {y,q} <= q+1'b1;

endmodule

module Counter_tb();
reg clk;
reg x;
wire [1:0] q;
wire y;
Counter U(.clk(clk),.x(x),.q(q),.y(y));
initial begin
clk = 1;
x = 0;
#10;
end
always #5 clk=~clk;
always #5 x=~x;
endmodule