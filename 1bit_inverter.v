`timescale 1ns / 1ps

module inverter(input x, output y);
assign y = ~x;
endmodule

module inverter_FPGA_TB(input [15:0] sw, output [15:0] led);
    inverter DUT(
                    .x(sw[0]),
                    .y(led[0])
                    );
endmodule
    
//module inverter_TB();
//reg x;
//wire y;
//inverter DUT(x,y);
//initial begin
//    x=0;#10;
//    x=1;#10;
//end
//endmodule    
