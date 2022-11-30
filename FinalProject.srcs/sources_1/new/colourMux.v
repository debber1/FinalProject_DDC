`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 15:04:30
// Design Name: 
// Module Name: colourMux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module colourMux(
    input wire[11:0] iGPIO, iConst,
    input wire iSelect,
    output wire[11:0] oOutput
    );
    
    reg[11:0] rOut;
    
    always @(*)
    begin
    if(iSelect == 1)
    begin
        rOut = iGPIO;
    end
    else
    begin
        rOut = iConst;
    end
    end
    assign oOutput = rOut;
endmodule
