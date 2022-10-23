module threebcalc(clk,s,a,b,c,cin,digit);

//output [6:0] ssd;
//output [3:0] an;

input clk,cin;
input [2:0] a;
input [2:0] b;
output [2:0] c;
output [2:0] s;
reg ov;
output reg [3:0] digit = 4'b0000;

//carrys
assign c[0] = ((a[0]^cin)&b[0])|(((a[0]^cin)^b[0])&cin);
assign c[1] = ((a[1]^cin)&b[1])|(((a[1]^cin)^b[1])&c[0]);
assign c[2] = ((a[2]^cin)&b[2])|(((a[2]^cin)^b[2])&c[1]);
//sums or differences
assign s[0] = ((a[0]^cin)^b[0]^cin);
assign s[1] = ((a[1]^cin)^b[1]^c[0]);
assign s[2] = ((a[2]^cin)^b[2]^c[1]);

always @(posedge clk)
begin
ov <= (c[2]^c[1]);
if(ov == 1)
begin
digit = {c[2],s[2],s[1],s[0]};
end
if(ov == 0)
begin
digit = {s[2],s[2],s[1],s[0]};
end
end

endmodule

module threebcalc_fpga(input clk, input [15:0]sw, output [15:0] led, output [6:0] seg, output [3:0] an);
wire [3:0] dwire;

threebcalc dutt(
                .clk(clk),
                .cin(sw[15]),
                .a(sw[2:0]),
                .b(sw[5:3]),
                .digit(dwire)            
                );


ddisplay dut(
            .clk(clk),
            .digit(dwire),
            .ssd(seg[6:0]),
            .an(an[3:0])
            );
            assign led[3:0] = dwire;
            
endmodule

module ddisplay(clk, digit, ssd, an);
input clk;
input [3:0] digit;
output reg [6:0] ssd;
output reg [3:0] an;
reg [3:0] ann = 4'b1101;
reg [9:0] counter = 0;
parameter countermax = 1000;

always@(posedge clk)
begin
if((counter == countermax) & (ann[1] == 0) & (digit[3] == 1))
begin
an<=ann;
ssd <= 7'b0111111;
ann <= {ann[3],ann[2],ann[0],ann[1]};
an <= ann;
counter <= 0;
end
else if((counter == countermax) & (ann[1] == 0) & (digit[3] == 0))
begin
an<=ann;
ssd <= 7'b1111111;
ann <= {ann[3],ann[2],ann[0],ann[1]};
an <= ann;
counter <= 0;
end
else if((counter == countermax) & (ann[0] == 0))
begin
an<=ann;
counter <= 0;
case(digit)
0:ssd = 7'b1000000;
1:ssd = 7'b1111001; 
2:ssd = 7'b0100100; 
3:ssd = 7'b0110000; 
4:ssd = 7'b0011001; 
5:ssd = 7'b0010010; 
6:ssd = 7'b0000010; 
7:ssd = 7'b1111000; 
8:ssd = 7'b0000000; 
9:ssd = 7'b0010000; 
10:ssd = 7'b0000010;
11:ssd = 7'b0010010;
12:ssd = 7'b0011001;
13:ssd = 7'b0110000;
14:ssd = 7'b0100100;
15:ssd = 7'b1111001;
endcase
ann<={ann[3],ann[2],ann[0],ann[1]};
an <= ann;
end
else counter <= counter+1;
end
endmodule