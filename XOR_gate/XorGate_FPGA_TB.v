`timescale 1ns / 1ps

module XorGate_FPGA_TB(input [15:0] sw, output [15:0] led);
    XorGate dut(
                    .a(sw[0]),
                    .b(sw[1]),
                    .y(led[0])
                );
endmodule
