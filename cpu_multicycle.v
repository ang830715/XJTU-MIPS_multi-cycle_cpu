`include "Regfile.v"
`include "Memory.v"
`include "Add.v"
`include "Or.v"
`include "Alucu.v"
`include "IR.v"
`include "D_ff.v"

`include "Mux.v"
`include "Mux4.v"
`include "Pc_multicycle.v"
`include "Shl2_26bits.v"
`include "Shl2_32bits.v"
`include "Sigext16_32.v"

`include "Alu.v"
`include "And.v"
`include "Controller.v"
`timescale 1ns/1ps

module cpu_multicycle(
    
);
    reg clk;
    wire[`WIDTH] mux_1_out,mux_3_out,mux_4_out,mux4_1_out;
    wire[`WIDTH] pc_in, pc_out, inst,r_data, r_data_1,r_data_2, aluout_out, d_ff_B_out, d_ff_A_out,mdr_out, sigext16_32_out,shl2_2_out,alu_out;
    wire [1:0] ALUOp, ALUSrcB, PCSrc;
    wire [2:0] ALUCtrl;
    wire PCWrCond, PCWr , IorD, MemRd, MemWr, MemtoReg, IRWr, ALUSrcA, RegWr, RegDst,alu_zero,and_out,or_out;
    wire[4:0] mux_2_out;
    wire[27:0] shl2_1_out;
    reg [`WIDTH] pc4;




    Controller controller(clk,  inst[31:26], inst[5:0],PCWrCond, PCWr , IorD, MemRd, MemWr, MemtoReg, IRWr, PCSrc, ALUOp, ALUSrcB, ALUSrcA, RegWr, RegDst);
    Pc_multicycle pc(clk, or_out,pc_in,pc_out);
    Mux mux_1(pc_out,aluout_out,IorD,mux_1_out);
    IR ir(clk,IRWr,r_data,inst);
    Memory memory(MemRd,MemWr,mux_1_out,d_ff_B_out,r_data);
    D_ff mdr(clk,r_data,mdr_out);
    Mux mux_2(inst[20:16],inst[15:11],RegDst,mux_2_out);
    Mux mux_3(aluout_out,mdr_out,MemtoReg,mux_3_out);
    Regfile regfile(clk,inst[25:21],inst[20:16],mux_2_out,mux_3_out,RegWr,r_data_1,r_data_2);
    Sigext16_32 sigext16_32(inst[15:0],sigext16_32_out);
    Shl2_32bits shl2_2(sigext16_32_out,shl2_2_out);
    D_ff d_ff_A (clk,r_data_1,d_ff_A_out);
    D_ff d_ff_B (clk,r_data_2,d_ff_B_out);
    Mux mux_4(pc_out,d_ff_A_out,ALUSrcA,mux_4_out);
    Mux4 mux4_1(d_ff_B_out,pc4,sigext16_32_out,shl2_2_out,ALUSrcB,mux4_1_out);
    Shl2_26bits shl2_1(inst[25:0],shl2_1_out);
    Alu alu(mux_4_out,mux4_1_out,ALUCtrl,alu_out,alu_zero);
    Alucu alucu(ALUOp,inst[5:0],ALUCtrl);
    D_ff aluout(clk,alu_out,aluout_out);
    Mux4 mux4_2(alu_out,aluout_out,{pc_out[31:28],shl2_1_out},d_ff_A_out,PCSrc,pc_in);
    And and1(PCWrCond,alu_zero,and_out);
    Or or1(and_out,PCWr,or_out);





always #10 
   begin     
   clk <= ~clk;  
   end
   
   initial begin    
   #0 begin         
    clk <= 1'b0;    
    pc4 <= 3'b100;  
    
    end
    #700 begin
        $finish;
    end
     end

    // initial begin
    //     assign pc_out =0;
    // end
   
    
    initial begin
        $dumpfile("cpu_multicycle.vcd");
        $dumpvars(0, cpu_multicycle);
      end
endmodule // cpu_multicycle

