`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 22.11.2022 21:14:55
// Design Name: 
// Module Name: SwitchSelect
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


module SwitchSelect(
        input wire wGPIO, wSwitch,
        output wire wOut
    );
    
    reg rOut;
    always @(*)
    begin
    
    if(wSwitch == 1)
    begin
        rOut = wSwitch;
    end
    else
    begin
        rOut = wGPIO;
    end
    end
    
    assign wOut = rOut;
endmodule
