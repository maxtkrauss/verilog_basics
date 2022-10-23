`timescale 1ns / 1ps

module SR_Latch(s,r,q,qn);
input s,r;
output reg q;
output reg qn;
always @(s or r)
        if (s) {q,qn} <= 2'b10;
        else if (r) {q,qn} <=2'b01;
endmodule

module SR_Latch_tb();
reg s,r;
wire q,qn;
SR_Latch UUT(.s(s),.r(r),.q(q),.qn(qn));
initial begin
        {s,r} = 2'b10; #10;
        {s,r} = 2'b01; #10;
end
endmodule