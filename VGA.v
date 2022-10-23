`timescale 1ns / 1ps

module VGA(clk,clk25, pixel_data,sx,sy,red,green,blue,Hsync,Vsync,pixel_addr);
input clk;
input clk25;
input [7:0] pixel_data;
input [8:0] sx, sy;
output reg [3:0] red,green,blue;
output reg Hsync,Vsync;
output reg [12:0] pixel_addr;

localparam HDISP=640;
localparam HFP=16;
localparam HPW=96;
localparam HLIM=800;

localparam VDISP=480;
localparam VFP=10;
localparam VPW=2;
localparam VLIM=525;

reg [15:0] hcount = 0;
reg [15:0] vcount = 0;
reg enable = 0;



integer counter = 0;

reg [3:0] rval;
reg [3:0] gval;
reg [3:0] bval;

always @(posedge clk25)
begin

if(counter<=25000000)
begin
gval = 4'b0000;
bval = 4'b0000;
rval = 4'b1111;
end
if(counter>25000000 && counter<=50000000)
begin
rval = 4'b0000;
bval = 4'b1111;
gval = 4'b0000;
end
if(counter>50000000 && counter<=75000000)
begin
rval = 4'b0000;
gval = 4'b1111;
bval = 4'b0000;
end
if(counter>75000000)
begin
counter = 0;
end
if(hcount < HLIM-1)
   hcount <= hcount+1;
   else
   begin
   hcount<=0;
   if(vcount < VLIM-1)
   vcount <= vcount+1;
   else
   vcount <= 0;
   end
if(vcount > 480)
    begin
    pixel_addr <= -1;
    enable <= 0;
    end
    else
    begin
    if(hcount < 640)
    begin
    enable <= 1;
    pixel_addr<=pixel_addr+1;
    end
    else
    enable<=0;
    end
if(enable==1)
    begin
    red <= rval;
    green <= gval;
    blue <= bval;
    end
    else
    begin
    red <= 4'b0000;
    green <= 4'b0000;
    blue <= 4'b0000;
    end
if(hcount > (HDISP+HFP) && hcount <= (HDISP+HFP+HPW))
    Hsync <=0;
    else
    Hsync <=1;
if(vcount >= (VDISP+VFP) && vcount  < (VDISP+VFP+VPW))
    Vsync <= 0;
    else
    Vsync <= 1;

counter = counter + 1;    
end
endmodule
