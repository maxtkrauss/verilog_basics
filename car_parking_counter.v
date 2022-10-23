`timescale 1ns / 1ps

module decoder_7seg(in1,out1);
input [3:0] in1;
output reg [6:0] out1;

always @ (in1)
case(in1)
    4'b0000 : out1 = 7'b1000000; //0
    4'b0001 : out1 = 7'b1111001; //1
    4'b0010 : out1 = 7'b0100100; //2
    4'b0011 : out1 = 7'b0110000; //3
    4'b0100 : out1 = 7'b0011001; //4
    4'b0101 : out1 = 7'b0010010; //5
    4'b0110 : out1 = 7'b0000010; //6
    4'b0111 : out1 = 7'b1111000; //7
    4'b1000 : out1 = 7'b0000000; //8
    4'b1001 : out1 = 7'b0010000; //9
    4'b1010 : out1 = 7'b0001000; //A
    4'b1011 : out1 = 7'b0000011; //B
    4'b1100 : out1 = 7'b1000110; //C
    4'b1101 : out1 = 7'b0100001; //D
    4'b1110 : out1 = 7'b0000110; //E
    4'b1111 : out1 = 7'b0001110; //F
endcase
endmodule

module car_park(c,s);
input [8:0] s;
output reg [3:0] c;
always @(s)
c=s[8]+s[7]+s[6]+s[5]+s[4]+s[3]+s[2]+s[1]+s[0];
endmodule

module car_park_TM(led,sw,seg,an);

input [8:0] sw;
output [3:0] led;
output [6:0] seg;
output [3:0] an;

assign an = 4'b1110;

car_park park1(.c(led),.s(sw));
decoder_7seg ss(led,seg);

endmodule
