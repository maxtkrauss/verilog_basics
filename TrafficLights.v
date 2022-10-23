`timescale 1ns / 1ps

module TrafficLights(output g1,y1,r1,g2,y2,r2, input s0, s1, s2);
assign g1 = (~s0)&(~s1)&~(s2);
assign y1 = (s0)&(~s1)&(~s2);
assign g2 = (s0)&(s1)&(~s2);
assign y2 = (~s0)&(~s1)&(s2);
assign r1 = (~s0&s1&~s2)|(s0&s1&~s2)|(~s0&~s1&s2)|(s0&~s1&s2);
assign r2 = (~s0&~s1&~s2)|(s0&~s1&~s2)|(~s0&s1&~s2)|(s0&~s1&s2);
endmodule

//module TrafficLights_tb();
//reg s0,s1,s2;
//wire g1,y1,r1,g2,y2,r2;
//integer i;
//initial begin
//s0 = 0; s1 = 0; s2 = 0;#10
//for(i = 0; i<7;i=i+1)begin
//{s2,s1,s0} = {s2,s1,s0}+1;#10;
//end
//end

//TrafficLights UUT(.s0(s0),.s1(s1),.s2(s2),
//                  .g1(g1),.y1(y1),.r1(r1),
//                  .g2(g2),.y2(y2),.r2(r2));
//endmodule

module TrafficLights_FPGA_tb(input [15:0]sw, output [15:0]led);
TrafficLights dut(
                   .s0(sw[0]),.s1(sw[1]),.s2(sw[2]),
                   .r2(led[0]),.y2(led[1]),.g2(led[2]),
                   .r1(led[3]),.y1(led[4]),.g1(led[5])
                   );
endmodule
