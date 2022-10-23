`timescale 1ns / 1ps
module bitFullAdder(s,co,x,y,ci);
input x,y,ci;
output s, co;
assign co=(x&y)|((x^y)&ci);
assign s=x^y^ci;
endmodule

module twobitFullAdder_TB();
reg [1:0]x;
reg [1:0]y;
reg ci;
wire [1:0]s;
wire co;
wire cx;
integer i;
initial begin
x[1:0]=2'b0;y[1:0]=2'b0; ci = 0;
for(i=0;i<32;i=i+1)
begin
{x,y,ci} = {x,y,ci}+1;
#10;
end
end
bitFullAdder UUT1(.ci(ci),.x(x[0]),.y(y[0]),.s(s[0]),.co(cx));
bitFullAdder UUT2(.ci(cx),.x(x[1]),.y(y[1]),.s(s[1]),.co(co));
endmodule

module twobitFA_FPGA_TB(input [15:0] sw, output [15:0] led);
twobitFullAdder dut(
                .x0(sw[0]),.y0(sw[1]),
                .x1(sw[2]),.y1(sw[3]),
                .ci(sw[4]),
                .s0(led[0]),.s1(led[1]),
                .co(led[2])
);
endmodule

module twobitFullAdder(x0,x1,y0,y1,ci,co,s0,s1);
input x0,x1,y0,y1,ci;
output co,s0,s1;
wire cx=(x0&y0)|((x0^y0)&ci);
assign s0 = (x0^y0^ci);
assign co=(x1&y1)|((x1^y1)&cx);
assign s1 = (x1^y1^cx);
endmodule