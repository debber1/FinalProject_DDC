`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2022 09:58:22
// Design Name: 
// Module Name: num_capture_4bit
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


module num_capture_4bit(
    input wire iClk, iRst, iPush, iStop,
    output wire oWe,
    output wire[9:0] oAddr,
    output wire[11:0] oData
    );
    // 0. State definition
  localparam sInit    = 3'b000;
  localparam sIdle    = 3'b001;
  localparam sPush    = 3'b010;
  localparam sToggle  = 3'b011;
  localparam sStop    = 3'b100;
  localparam sWriteOff = 3'b101;
  
  reg[2:0] rFSM_current, wFSM_next;
  reg[3:0] rNumber;
  reg rEn;
  reg [9:0] roAddr;
  reg [11:0] roData;
  
  counter_lim #(.LIM(600-1)) counter_lim_inst(.iClk(iStop), .iRst(iRst),.oQ(oAddr));

  // 1. State register
  //  - with synchronous reset
  always @(posedge iClk)
  begin
    if (iRst == 1)
      rFSM_current <= sInit;
    else
      rFSM_current <= wFSM_next;
  end
  
  // 2. Next state logic
  //  - only defines the value of wFSM_next
  //  - in function of inputs and rFSM_current
  always @(*)
  begin
    case (rFSM_current)
    
      sInit:    wFSM_next <= sIdle;
      
      sIdle:    if (iPush == 0 && iStop == 0)
                  begin
                  wFSM_next <= sIdle;
                  end
                else if (iStop == 1)
                  wFSM_next <= sStop;
                else
                  wFSM_next <= sPush;
                
      sPush:    if (iPush == 1)
                  wFSM_next <= sPush;
                else
                  wFSM_next <= sToggle;

      sStop:    if (iStop == 1)
                  wFSM_next <= sWriteOff;
                else
                  wFSM_next <= sWriteOff;
      sWriteOff: if(iStop == 1)
                   wFSM_next <= sWriteOff;
                 else
                   wFSM_next <= sInit;
      sToggle:  wFSM_next <= sIdle;
      
      default:  wFSM_next <= sInit;
    endcase
  end
  
  // 3. Output logic
  // In this case, we need a register to keep track of the toggling
  
  // 3.1 Define the register
  reg  rToggle_current, wToggle_next;
  
  always @(posedge iClk)
  begin
    rToggle_current <= wToggle_next;
  end
  
  // 3.2 Define the value of wToggle_next
  //  - in function of rFSM_current
  //    * when sInit, we reset the register
  //    * when sToggle, we toggle the register
  //    * when others, we keep the value in the register
  reg [3:0] rOutput;

  always @(negedge iClk)
  begin
    if (rFSM_current == sInit)
    begin
      rNumber = 0;
      rOutput = 0; 
      rEn = 0;
    end
    else if(rNumber == 15 && rFSM_current == sToggle)
      rNumber = 0;
    else if (rFSM_current == sToggle)
      rNumber = rNumber + 1;
    else if (rFSM_current == sStop)
    begin
      rOutput = rNumber;
      rEn = 1;
    end
    else if (rFSM_current == sWriteOff)
    begin
        rOutput = rNumber;
        rEn = 0;
    end
    else
      wToggle_next = rToggle_current;
  end
  
  /*
  We need to take care of the logic which generates the data to insert into block memory.
  */
  
  always @(*)
  begin
    // This takes care of generating the data.
    if (rNumber <= 9)
    begin
        roData = 512 + rNumber*32;
    end
    else
    begin
        roData = 736 + rNumber*32;
    end
  end
  
  assign oData = roData;
  assign oWe = rEn;
endmodule
