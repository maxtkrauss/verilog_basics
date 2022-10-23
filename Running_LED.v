`timescale 1ns / 1ps
//module Running_LED(input clk, output reg[3:0]led=4'b0001);
module Running_LED(clk, led);
input clk;
output reg [3:0] led=4'b0001;
parameter cntmax=32'd100000000;//declare a constant as the max # for the counter
reg [31:0]cnt;//declare nonport var, a counter
always @(posedge clk)
if(cnt==cntmax)
begin
    cnt<=32'd0;
    led<={led[2:0],led[3]}; 
/// Shifts MSB to LSB and shifts remaining 3 bits left.
/// ex = 0001 => 0010 => 0100 => 1000 => 0001 
end
else
begin  
        cnt<=cnt+1;
        led<=led;
end
endmodule

module Running_LED_fpga_tb(input clk, output [15:0]led);
Running_LED dut( 
    .clk(clk),.led(led[3:0])
);
endmodule
