`include "Regfile.v"
`include "Memory.v"
`include "Add.v"
`include "Alucu.v"
`include "Mcu.v"
`include "Mux.v"
`include "Pc.v"
`include "Shl2_26bits.v"
`include "Shl2_32bits.v"
`include "Sigext16_32.v"
`include "Inst_memory.v"
`include "Alu.v"
`include "And.v"
`timescale 1ns/1ps
module cpu(
    
);  
    reg clk;
    reg[`WIDTH] pc4 ;
    wire[`WIDTH] pc_in, pc_out, instruction, add1_out,add2_out,r_data,r_data1,r_data2,sigext16_32_out,mux2_out,mux3_out,mux5_out,alu_out,shl2_2_out;
    wire[4:0] mux1_out;
    wire[27:0] shl2_1_out;
    wire RegDst, Jump, RegWr, Branch, MemtoReg, MemWr, MemRd, ALUSrc,alu_zero,and_out;
    wire[1:0] ALUOp ;
    wire[2:0] ALUCtrl;



   Pc pc(clk,pc_in,pc_out);
   Inst_memory inst_mem(pc_out, instruction);
   Add add1(pc4,pc_out,add1_out);
   Mux mux1(instruction[20:16],instruction[15:11],RegDst,mux1_out);
   Regfile regfile(clk,instruction[25:21],instruction[20:16],mux1_out,mux5_out,RegWr,r_data1,r_data2);
   Shl2_26bits shl2_1(instruction[25:0],shl2_1_out);
   Shl2_32bits shl2_2(sigext16_32_out,shl2_2_out);
   Add add2(add1_out,shl2_2_out,add2_out);
   And and1(Branch,alu_zero,and_out);
   Mux mux3(add1_out,add2_out,and_out,mux3_out);
   Mux mux4(mux3_out,{add1_out[31:28],shl2_1_out},Jump,pc_in);
   Sigext16_32 sigext16_32(instruction[15:0],sigext16_32_out);
   Mcu mcu(instruction[31:26],RegDst,Jump,RegWr,Branch,MemtoReg,ALUOp,MemWr,MemRd,ALUSrc);
   Mux mux2(r_data2,sigext16_32_out,ALUSrc,mux2_out);
   Alucu alucu(ALUOp,instruction[5:0],ALUCtrl);
   Alu alu(r_data1,mux2_out,ALUCtrl,alu_out,alu_zero);
   Memory memory(MemRd,MemWr,alu_out,r_data2,r_data);
   Mux mux5(alu_out,r_data,MemtoReg,mux5_out);





   
   always #10 
   begin     
   clk <= ~clk;  
   end
   
   initial begin    
   #0 begin         
    clk <= 1'b0;    
    pc4 <= 3'b100;  
    
    end
    #220 begin
        $finish;
    end
     end

    // initial begin
    //     assign pc_out =0;
    // end
   
    
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu);
      end
    


endmodule // cpu