`timescale 1ns / 1ps
module VGA_topmodule(clk,vgaRed, vgaGreen,vgaBlue,Hsync,Vsync);
input clk;
output [3:0] vgaRed;
output [3:0] vgaGreen;
output [3:0] vgaBlue;
output Hsync;
output Vsync;

parameter sx=511;
parameter sy=511;

wire clk25;
wire [12:0] pixel_addr;
wire [7:0] pixel_data;

clk_wiz_0 clock (clk25,clk);


VGA VGA(
.clk(clk),
.clk25(clk25),
.pixel_data(pixel_data),
.sx(sx),
.sy(sy),
.green(vgaGreen),
.red(vgaRed),
.blue(vgaBlue),
.Hsync(Hsync),
.Vsync(Vsync),
.pixel_addr(pixel_addr)
);

endmodule
