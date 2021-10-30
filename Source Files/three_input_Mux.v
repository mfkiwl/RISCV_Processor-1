`timescale 1ns / 1ps
`include "C:\Users\Kirolos Mikhail\Downloads\RISCV_Processor-main\RISCV_Processor-main\Defines\defines.v"
/******************************************************************* * 
* Module:   three_Input_Mux.v 
* Project:  RISCV_PROCESSOR 
* Author:   Dalia Elnagar - daliawk@aucegypt.edu
*           Kareem A. Mohammed - kareemamr213@aucegypt.edu
*           Kirolos M. Mikhail - kirolosmorcos237@aucegypt.edu
*
* Description: this a multiplexer that only takes 3 inputs and gives zero
*              otherwise 
* 
* Change history: 10/29/21 – created a three input nbit multiplexer
*                 10/29/21 – minor modifications to follow guidlines
*
**********************************************************************/ 



module three_input_Mux_nbit #(parameter n=32)(
input  [1:0] sel,
input  [n-1:0] a,
input  [n-1:0] b,
input  [n-1:0] c,
output reg [n-1:0] out
);

    always@(*)
        begin
        case(sel)
            2'b00:
                out = a;
            2'b01:
                out = b;
            2'b10:
                out = c;
            default:
                out = `ZERO;
        endcase
        end

endmodule