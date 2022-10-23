`timescale 1ns / 1ps

module Gate_tb();
reg a,b;
wire y;
xorGate dut(a,b,y);
initial begin
    a=0; b=0; #10;
    b=1;      #10;
    a=1; b=0; #10;
    b=1;      #10;
end
endmodule
