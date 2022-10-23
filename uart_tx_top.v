module uart_tx_top(clk,btnC,RsTx,seg,an);
input clk, btnC;
output RsTx;
reg [7:0] initStr = 8'h41;
localparam btnWait=2'b00,btnSend=2'b01,btnSendWait=2'b10;
reg btnC_prev;
reg [7:0] uartData;
reg [1:0] state = btnWait;
wire btnC_clr;
wire uartSend;
wire uartRdy;   

integer counter = 0;
integer count = 0;

output reg [6:0] seg;
output [3:0] an;

assign an = 4'b1110;

debounce debounce_UT(.clk(clk),.btn(btnC),.btn_clr(btnC_clr));

uart_tx_ctrl #(19200) uart(.clk(clk),.send(uartSend),.data(uartData),.uart_tx(RsTx),.ready(uartRdy));

always @(posedge clk)
begin
	btnC_prev <= btnC_clr;
case(state)
btnWait:
	if(btnC_clr==1'b1 && btnC_prev==0) state <= btnSend;
btnSend:
begin
	uartData <= initStr;
	initStr <= initStr + 1'b1;
	state <= btnWait;
end
btnSendWait:
	if(uartRdy)
	begin
	state <= btnWait;
	end
	
default: state <= btnWait;
endcase
end

always@(posedge btnC_clr)
begin
if(count < 9)
    begin
    count <= count+1;
    end
else
    begin
    count <= 0;
    end	
case(count)
0:seg <= 7'b1000000;
1:seg <= 7'b1111001; 
2:seg <= 7'b0100100; 
3:seg <= 7'b0110000; 
4:seg <= 7'b0011001; 
5:seg <= 7'b0010010; 
6:seg <= 7'b0000010; 
7:seg <= 7'b1111000; 
8:seg <= 7'b0000000; 
9:seg <= 7'b0010000; 
endcase    
end

assign uartSend = (state == btnSend);
endmodule
