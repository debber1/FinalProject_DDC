`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2022 09:13:08
// Design Name: 
// Module Name: eq_comp_Nb
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


module eq_comp_Nb #(parameter N = 8)
    (
    input wire[N-1:0] iA, iB,
    output wire oY
    );
    assign oY = (iA == iB) ? 1:0;
endmodule
