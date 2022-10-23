module SPI_leader_receiver(clk, miso, get, data, sck, ss, busy, ready);
parameter data_length = 8;
input clk, miso, get;
output reg [data_length-1:0] data;
output reg ss=1;
output reg sck = 0;
output reg busy = 0;
output reg ready = 0;

localparam RDY = 2'b00, RECEIVE=2'b01, STOP = 2'b10;
reg [1:0] state = RDY;
reg [data_length-1:0] data_temp = 0;
reg [7:0] index = 0;
reg [7:0] clkdiv = 0;

always @(posedge clk)
    if(clkdiv==8'd25)
    begin
        clkdiv <= 0;
        sck <= ~sck;
    end
    else
        clkdiv <= clkdiv+1;
always @(posedge sck)
case(state)
RDY:
    if(get)
    begin
    ss<=0;
    state <= RECEIVE;
    busy<=1;
    ready<=0;
    data_temp<=0;
    index<=data_length-1;
    end
RECEIVE:
    begin
    if(index==0)
        state<=STOP;
    data_temp[index]<=miso;
    index<=index-1;
    end
STOP:
begin
    busy<=0;
    ready<=1;
    ss<=1;
    data_temp<=0;
    data<=data_temp;
    state<=RDY;
end
endcase
endmodule