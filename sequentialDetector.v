`timescale 1ns / 1ps
module sequenceDetector_2(y,x,clk,clr,state);
input x,clr,clk;
output reg y;
output reg [1:0] state = 2'b00;
parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;

always @(posedge clk)
begin
        if(clr==1) state<=A;
        else
        begin
            if(x==0)
                case(state)
                    A:state<=A;
                    B:state<=A;
                    C:state<=D;
                    D:state<=A;
                endcase
            else
                case(state)
                A:state<=B;
                B:state<=C;
                C:state<=C;
                D:state<=B;
            endcase
            if((x==1)&&(state==D)) y<=1;
            else y<=0;
    end
end
endmodule

module sequenceDetector_2_tb;
reg x = 0;
reg clr = 1;
reg clk = 0;
wire y;
wire [1:0] state;
integer i;

sequenceDetector_2 UUT(.x(x),.clk(clk),.clr(clr),.y(y),.state(state));

initial begin
    for(i=0;i<20;i=i+1)begin
        clk=~clk;
        if(i>5 & i<10)
        begin
            clr=0; x=1;
        end
        else if(i==11) x=0;
        else if(i==12) x=1;
        else x=0;
        #10;
    end
end
endmodule
