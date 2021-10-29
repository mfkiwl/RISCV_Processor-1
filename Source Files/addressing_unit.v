/*******************************************************************
*
* Module: addressing_unit.v
* Project: Project 1: femtoRV32
* Author: Kareem A. Mohammed Talaat - kareemamr213@aucegypt.edu
* Description: A module that allows LB, LH, LW, LBU, LHU, SB, SH, and SW risc-v instructions to work on the 
* risc-v proccessor.
*
* Change history: 22/10/21 – First implementation of the module
*
*
**********************************************************************/


module addressing_unit (
    input [31:0] data_in,
    input [1:0] CU_inst_sel,
    input CU_signed_sel,
    output [31:0] data_out
);
    always @*) begin
        case(CU_inst_sel) 
            // LW, SW cases
            2'b00 : data_out = data_in;
            // LH, LHU, SH cases
            2'b01 : 
            begin
                case(CU_signed_sel)
                    // LHU case (unsigned)
                    1'b0 : data_out = {16'b0, data_in[15:0]};
                    // LH, SH cases (signed)
                    1'b1 : data_out = &signed(data_in[15:0]);
                    // Default case if there is an error
                    default : data_out = 32'b0;
                endcase
            end
            // LB, LBU, SB cases
            2'b10 : 
            begin
                case(CU_signed_sel)
                    // LBU case (unsigned)
                    1'b0 : data_out = {24'b0, data_in[7:0]};
                    // LB, SB cases (signed)
                    1'b1 : data_out = &signed(data_in[7:0]);
                    // Default case if there is an error
                    default : data_out = 32'b0;
            end
            // Default case if there is an error
            default : data_out = 32'b0;
        endcase
    end 

endmodule