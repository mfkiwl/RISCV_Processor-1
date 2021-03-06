`timescale 1ns / 1ps
/*******************************************************************
*
* Module: InstMem.v
* Project: RISCV_Processor
* Author:   Dalia Elnagar - daliawk@aucegypt.edu
*           Kareem A. Mohammed Talaat - kareemamr213@aucegypt.edu
*           Kirolos M. Mikhail - kirolosmorcos237@aucegypt.edu
* Description: This is a module of the instruction memory
*
* Change history: 10/29/21 – Applied coding guidelines
*
**********************************************************************/


module InstMem(
     input sclk, 
     input mem_read, 
     input mem_write,
     input [1:0] AU_inst_sel,
     input signed_inst,
     input [7:0] addr, 
     input [31:0] data_in,
     output reg [31:0] data_out
     ); 
    
    reg [31:0] inst_mem [0:63]; 
    reg [7:0] data_mem [0:63]; //Memory that has 64 slots, each slot 8 bits in width.
    
    initial begin
//     mem[0]=32'b000000000000_00000_010_00001_0000011   ;  //lw x1, 0(x0)
//     mem[1]=32'b000000000100_00000_010_00010_0000011   ;  //lw x2, 4(x0)
//     mem[2]=32'b000000001000_00000_010_00011_0000011   ;  //lw x3, 8(x0)
//     mem[3]=32'b0000000_00010_00001_110_00100_0110011  ;  //or x4, x1, x2
//     mem[4]=32'b0_000000_00011_00100_000_0100_0_1100011;  //beq x4, x3, 4
//     mem[5]=32'b0000000_00010_00001_000_00011_0110011  ;  //add x3, x1, x2
//     mem[6]=32'b0000000_00010_00011_000_00101_0110011  ;  //add x5, x3, x2
//     mem[7]=32'b0000000_00101_00000_010_01100_0100011  ;  //sw x5, 12(x0)
//     mem[8]=32'b000000001100_00000_010_00110_0000011   ;  //lw x6, 12(x0)
//     mem[9]=32'b0000000_00001_00110_111_00111_0110011  ;  //and x7, x6, x1
//     mem[10]=32'b0100000_00010_00001_000_01000_0110011 ;  //sub x8, x1, x2
//     mem[11]=32'b0000000_00010_00001_000_00000_0110011 ;  //add x0, x1, x2
//     mem[12]=32'b0000000_00001_00000_000_01001_0110011 ;  //add x9, x0, x1
     
     // Test Case 1
//     mem[0]=32'b00000000000000000000000010110011;           // add x1, x0, x0
//     mem[1]=32'b00000000000000000010000100000011;           // lw  x2, 0(x0)
//     mem[2]=32'b00000000001000001110000110110011;           // or  x3, x1, x2
//     mem[3]=32'b00000000010000000010000010000011;           // lw  x1, 4(x0)
//     mem[4]=32'b01000000001000001000000010110011;           // sub x1, x1, x2
//     mem[5]=32'b00000000000000001000010001100011;           // beq x1, x0, 8
//     mem[6]=32'b11111110000000000000110011100011;           // beq x0, x0, -8
//     mem[7]=32'b00000000001000001111000110110011;           // and x3, x1, x2
//     mem[8]=32'hffb10193;                                   // addi x3,x2,5
//     mem[9]=32'h00219193;                                   // slli x3 x3 2
//     mem[10]=32'h00000073;                                  // ecall

//     // Test Case 2
//     mem[0]=32'h00400083;           // lb x1 4(x0)
//     mem[1]=32'h00001103;           // lh x2 0(x0)
//     mem[2]=32'h018001ef;           // jal x3 24
//     mem[3]=32'h002081b3;           // add x3 x1 x2
//     mem[4]=32'h00004203;           // lbu x4 0(x0)
//     mem[5]=32'h40415133;           // sra x2 x2 x4
//     mem[6]=32'hfe011ee3;           // bne x2 x0 -4
//     mem[7]=32'b00000000000000000000000000001111;           // fence
//     mem[8]=32'h0010d093;           // srli x1 x1 1
//     mem[9]=32'h40215113;                                   // srai x2 x2 2
//     mem[10]=32'h00202423;                                   // sw x2 8(x0)
//     mem[11]=32'h00201623;                                  // sh x2 12(x0)
//     mem[12]=32'h00200823;                                  // sb x2 16(x0)
//     mem[13]=32'h000181e7;                                  // jalr x3 x3 0
     
     // Test case 3
//     mem[0]=32'h000010b7; // lui x1 1
//     mem[1]=32'h00002117; //auipc x2 2
//     mem[2]=32'h00005203; // lhu x4 0(x0)
//     mem[3]=32'h00411133; // sll x2 x2 x4
//     mem[4]=32'h00415133; // srl x2 x2 x4	
//     mem[5]=32'hfe115ee3; // bge x2 x1 -4	
//     mem[6]=32'h001121b3; // slt x3 x2 x1	
//     mem[7]=32'h0020b1b3; // sltu x3 x1 x2	
//     mem[8]=32'h0021e193; // ori x3 x3 2	
//     mem[9]=32'hfff18193; // addi x3 x3 -1	
//     mem[10]=32'hfe304ee3;// blt x0 x3 -4	
//     mem[11]=32'h001141b3;// xor x3 x2 x1	
//     mem[12]=32'b00000000000100000000000001110011; // ebreak
     
     // Test case 4
     inst_mem[0]=32'h00800083; // lb x1 8(x0)
     inst_mem[1]=32'h0805103; // lhu x2 8(x0)
     inst_mem[2]=32'h000a193; // slti x3 x1 0
     inst_mem[3]=32'h000b193; // sltiu x3 x1 0
     inst_mem[4]=32'h020e863; // bltu x1 x2 16
     inst_mem[5]=32'h0117663; // bgeu x2 x1 12
     inst_mem[6]=32'h010c093; // xori x1 x1 1
     inst_mem[7]=32'h0000073; // ecall
     inst_mem[8]=32'h0000033; // add x0 x0 x0

     data_mem[0]=4'd17; 
     data_mem[1]=4'd9;
     data_mem[2]=4'd25; 
   
     
    end    

    always@(*)begin
         if(sclk) data_out = inst_mem[addr];
          else if (mem_read == 1)
                case(AU_inst_sel) 
                    // LW case
                    2'b00 : data_out = {data_mem[addr+3], data_mem[addr+2], data_mem[addr+1], data_mem[addr]};
                    // LH, LHU cases
                    2'b01 : 
                    begin
                        case(signed_inst)
                            // LHU case (unsigned)
                            1'b0 : data_out = {16'b0, data_mem[addr+1], data_mem[addr]};
                            // LH case (signed)
                            1'b1 : data_out = {{16{data_mem[addr+1][3]}}, data_mem[addr+1], data_mem[addr]};
                            // Default case if there is an error
                            default : data_out = 32'b0;
                        endcase
                    end
                    // LB, LBU cases
                    2'b10 : 
                    begin
                        case(signed_inst)
                            // LBU case (unsigned)
                            1'b0 : data_out = {24'b0, data_mem[addr]};
                            // LB case (signed)
                            1'b1 : data_out = {{24{data_mem[addr][3]}}, data_mem[addr]};
                            // Default case if there is an error
                            default : data_out = 32'b0;
                        endcase
                    end
                    // Default case if there is an error
                    default : data_out = 32'b0;
                endcase
            else
                begin
                    data_out = 32'b0;
                end 
        end

    always @(negedge sclk) begin
          if (mem_write == 1)
            case(AU_inst_sel) 
                // SW case
                2'b00 : {data_mem[addr+3], data_mem[addr+2], data_mem[addr+1], data_mem[addr]} = data_in;
                // SH case
                2'b01 : { data_mem[addr+1], data_mem[addr] } = data_in[15:0];
                // SB case
                2'b10 : data_mem[addr] = data_in[7:0];
                // Default case if there is an error
                default : data_mem[addr] = data_mem[addr];
             endcase
        else
            begin
                data_mem[addr] = data_mem[addr];
            end 
    end
endmodule

