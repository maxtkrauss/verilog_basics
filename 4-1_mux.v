`timescale 1ns / 1ps
module F1mux(a,b,c,d,s0,s1,y);
input a,b,c,d,s0,s1;
output y;
assign y=s1?(s0?d:c):(s0?b:a);
endmodule

module F1mux_TB();
reg a,b,c,d,s0,s1;
wire y;
F1mux UUT(.y(y),.a(a),.b(b),.c(c),.d(d),.s0(s0),.s1(s1));
initial begin
s0=0;s1=0;a=0;b=0;c=0;d=0;#10;
a=1;#10;
s0=1;b=1;#10;
s0=0;s1=1;c=1;#10;
s0=1;s1=1;d=1;#10;
end
endmodule

//module F1mux_FPGA_tb(input [15:0]sw, output [15:0] led);
//F1mux dut(
//    .s0(sw[0]),.s1(sw[1]),
//    .a(sw[2]),.b(sw[3]),.c(sw[4]),.d(sw[5]),
//    .y(led[0])
//);
//endmodule
