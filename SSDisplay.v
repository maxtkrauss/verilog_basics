`timescale 1ns / 1ps

module SSDisplay(input clk, input [3:0]x,
                 output reg [6:0] a_to_g,
                 output wire [3:0] an,
                 output wire dp);
reg [3:0] digit;
assign dp = 1;
assign an = 4'b1110;
always @(posedge clk)
begin
        digit<=x[3:0];
        case(digit)
        
0:a_to_g = 7'b1000000; ////0000
1:a_to_g = 7'b1111001; ////0001
2:a_to_g = 7'b0100100; ////0010
3:a_to_g = 7'b0110000; ////0011
4:a_to_g = 7'b0011001; ////0100
5:a_to_g = 7'b0010010; ////0101
6:a_to_g = 7'b0000010; ////0110
7:a_to_g = 7'b1111000; ////0111
8:a_to_g = 7'b0000000; ////1000
9:a_to_g = 7'b0010000; ////1001

default: a_to_g = 7'b0000000;
endcase
end
endmodule

module SSDisplay_tb(input clk, input [15:0]sw, output [6:0]seg, output [3:0] an);
SSDisplay DUT( .clk(clk),.x(sw[3:0]), .a_to_g(seg[6:0]),.an(an));
endmodule


