`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2022 09:12:46
// Design Name: 
// Module Name: counter_lim
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


module counter_lim #(parameter LIM = 12, parameter N = $clog2(LIM))
    (
        input wire iClk, iRst,
        output wire [N-1:0] oQ
    );
    // signal declaration
    reg [N-1:0] r_CntCurr; // the actual counter register
    wire [N-1:0] w_CntNext;// the input to the register
    
    // the counter register
    always @(posedge iClk)
        if (iRst==1)
            r_CntCurr <= 0;
        else
            r_CntCurr <= w_CntNext;
    // the increment circuit (combinational)
    assign w_CntNext = (r_CntCurr != LIM) ? r_CntCurr + 1 : 0;
    
    // the output
    assign oQ = r_CntCurr;
endmodule
