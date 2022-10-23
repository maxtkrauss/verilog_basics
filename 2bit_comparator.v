`timescale 1ns / 1ps
module bitcomparator(x,y,g,e,l);
input x,y;
output g,e,l;
assign g = x&~y;
assign e = ~(x^y);
assign l = ~x&y;
endmodule

module twobitcomparator(x0,x1,y0,y1,g,e,l);
input x0,x1,y0,y1;
output g,e,l;
assign g = (x1&~y1)|(x0&~y1&~y0)|(x1&x0&~y0);
assign e = (~(x0^y0))&(~(x1^y1));
assign l = (~x1&y1)|(~x0&y1&y0)|(~x1&~x0&y0);
endmodule


module twobitcomparator_FPGA_tb(input [15:0]sw, output [15:0]led);
twobitcomparator dut(
    .x0(sw[0]),.y0(sw[1]),.x1(sw[2]),.y1(sw[3]),.g(led[2]),.e(led[1]),.l(led[0])
    );
endmodule
