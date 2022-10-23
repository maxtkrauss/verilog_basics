`timescale 1ns / 1ps


module VGALAB(clk,clk25, pixel_data,sx,sy,red,green,blue,Hsync,Vsync,pixel_addr);
input clk;
input clk25;
input [7:0] pixel_data;
input [8:0] sx, sy;
output reg [3:0] red;
output reg [3:0] green;
output reg [3:0] blue;
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

integer boundary;
integer move1 = 36;
integer move2 = 41;
integer counter = 0;

always @(posedge clk25)
begin
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
    
    if(hcount > 31 && hcount < 36)
    begin
    red <= 4'b0000;
    green <= 4'b1111;
    blue <= 4'b0000;
    end
    else if((counter <= 250000) && (hcount > move1 && hcount < move2) && (vcount > 199 && vcount < 251))
    begin
    red <= 4'b1111;
    green <= 4'b0000;
    blue <= 4'b0000;
    end
    else if(counter > 250000 && move2 <= boundary)
    begin
    boundary = 600;
    counter = 0;
    move1 <= move1 + 1;
    move2 <= move2 + 1;
    end
    else if(counter > 250000 && move2 >= boundary)
    begin
    boundary = 41;
    counter = 0;
    move1 <= move1 - 1;
    move2 <= move2 - 1;
    end
    else
    begin
    red <= 4'b1111;
    green <= 4'b1111;
    blue <= 4'b1111;
    end
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
