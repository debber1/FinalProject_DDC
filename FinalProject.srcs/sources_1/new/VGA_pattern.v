`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2022 11:25:25
// Design Name: 
// Module Name: VGA_pattern
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


module VGA_pattern#(
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
      input wire iHS, iVS,
      output wire oHS, oVS,
      input wire [$clog2(H_TOT)-1:0] iCountH,
      input wire [$clog2(V_TOT)-1:0] iCountV,
      //Adding support for memory
      input wire [11:0] iDataA,
      output wire [9:0] oAddrA,
      //12bits RGB
      output wire [3:0] oRed, oGreen, oBlue,
      input wire [15:0] iDataB,
      output wire [11:0] oAddrB,
      // Adding support for external colour control
      input wire [3:0] ibgColourRed, ibgColourGreen, ibgColourBlue, itColourRed, itColourGreen, itColourBlue
    );
    reg[3:0] roRed, roGreen, roBlue;
    reg[9:0] roAddrA;
    reg[11:0] roAddrB;
    
    always @(*)
    begin
      // generating a signal based on memory
      if (iCountH < WIDTH && iCountV < HEIGHT)
      begin
        // Making sure there is only colour while it's needed
        /*
          We want to find the adress in memory based on the iCountH and iCountV values
          The prompt gives us a 40x15 image which has to be mapped onto a 640x480 monitor.
          Each block of colour will thuss be 16x32 pixels on the screen
        */
        roAddrA = ((iCountH/16))+(iCountV/32)*40;
        // Using the incoming memory data to generate the colours
        // roRed[0] = iDataA[8];
        // roRed[1] = iDataA[9];
        // roRed[2] = iDataA[10];
        // roRed[3] = iDataA[11];
        // roGreen[0] = iDataA[4];
        // roGreen[1] = iDataA[5];
        // roGreen[2] = iDataA[6];
        // roGreen[3] = iDataA[7];
        // roBlue[0] = iDataA[0];
        // roBlue[1] = iDataA[1];
        // roBlue[2] = iDataA[2];
        // roBlue[3] = iDataA[3];

        /*
          We've now got the base address of each character. (roAddrA*32)
          We want to use this information to read from the character memory. The exact line we need to read depends on the vertical counter ofcourse.
          For each block of 16x32, we need to start at the base address, if the iCountV increases by one, we want the base address plus one. 
        */
        roAddrB = iDataA + (iCountV % 32);
        if (iDataB[16-iCountH % 16] == 1)
        begin
          roGreen = itColourGreen;
          roBlue = itColourBlue;
          roRed = itColourRed;
        end
        else
        begin
          roGreen = ibgColourGreen;
          roBlue = ibgColourBlue;
          roRed = ibgColourRed;
        end  
      end
      else
      begin
          roRed = 0;
          roGreen = 0;
          roBlue = 0;
      end

      

    end
    assign oAddrB = roAddrB;
    assign oAddrA = roAddrA;
    assign oRed = roRed;
    assign oGreen = roGreen;
    assign oBlue = roBlue;
    assign oHS = iHS;
    assign oVS = iVS;
    
endmodule
