`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2022 09:19:08
// Design Name: 
// Module Name: VGA_Timings
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


module VGA_Timings#(
      parameter WIDTH  = 640,
      parameter H_FP = 16,
      parameter H_PW = 96,
      parameter H_BP = 48,
      parameter H_TOT = WIDTH + H_FP + H_PW + H_BP,
      
      parameter HEIGHT = 480,
      parameter V_FP = 10,
      parameter V_PW = 2,
      parameter V_BP = 33,
      parameter V_TOT = HEIGHT + V_FP + V_PW + V_BP 
    )
    (
      input wire iClk, iRst,
      output wire oHS, oVS,
      output wire [$clog2(H_TOT)-1:0] oCountH,
      output wire [$clog2(V_TOT)-1:0] oCountV
    );
    reg rEn, roHS, roVS;
    counter_lim #(.LIM(H_TOT-1)) counter_lim_inst(.iClk(iClk), .iRst(iRst), .oQ(oCountH));
    counter_lim_en #(.LIM(V_TOT-1)) counter_lim_en_inst(.iClk(iClk), .iRst(iRst), .iEn(rEn),.oQ(oCountV));
    
    always @(*)
    begin
        // making the enable signal vor the Vcounter
        if (oCountH==H_TOT-1)
            rEn <= 1;
        else 
            rEn <= 0;
            
        // generating OHS
        if (oCountH <= WIDTH + H_FP -1 | oCountH >= H_TOT - H_BP)
            roHS <= 1;
        else
            roHS <= 0;
            
        // generating OVS
        if(oCountV <= HEIGHT + V_FP - 1 | oCountV >= V_TOT - V_BP)
            roVS <= 1;
        else
            roVS <= 0;
     end
     
     assign oHS = roHS;
     assign oVS = roVS;
    
endmodule
