/////////////////////////////////////////////////////////////
module SPI_follower_transmitter(miso,data,sck,ss,busy);
parameter data_length=8;
input miso;
input sck, ss;
output reg busy;
output [data_length-1:0] data;
localparam RDY=2'b00, TRANSMIT=2'b01,STOP=2'b10;
reg [1:0] state = RDY;
reg [7:0] index=data_length-1;

always @ (negedge sck)
case(state)
RDY:   
    if(!ss)
    begin
    miso<=data[index];
    state<=TRANSMIT;
    busy<=1;
    index<=index-1;
    end
TRANSMIT:
begin
    begin
    if(index==0)
        state<=STOP;
    miso<=data[index];
    index<=index-1;
    end
end
STOP:
begin
    index = data_length-1;
    busy<=0;
    state<=RDY;
end
endcase
endmodule
