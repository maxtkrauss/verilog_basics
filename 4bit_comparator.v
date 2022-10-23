`timescale 1ns / 1ps
module four_bit_Comparator(x,y,g,e,l);
input [3:0] x,y;
output g,e,l;
reg g,e,l;
always @(x or y)
begin
g=0; e=0; l=0;
if(x==y)
g=1;
else if (x>y)
e=1;
else
l=1;
end
endmodule

module four_bit_Comparator_tb();
reg [3:0]x,y;
wire g,e,l;
integer i;
initial begin
x[3:0]=4'b0000; y[3:0]=4'b0000;
for(i=0;i<256;i=i+1)
begin
{x,y} = {x,y}+1;
#10;
end
end
four_bit_Comparator UUT(.x(x),.y(y),.g(g),.e(e),.l(l));
endmodule

