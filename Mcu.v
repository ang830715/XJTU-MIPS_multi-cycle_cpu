`include "header.h"
module Mcu(
    input wire[5:0] OP_Code,
    output reg RegDst,
    output reg Jump,
    output reg RegWr,
    output reg Branch,
    output reg MemtoReg,
    output reg[1:0] ALUOp,
    output reg MemWr,
    output reg MemRd,
    output reg ALUSrc


);
always@(OP_Code)begin
    RegDst<=`LOW;
    RegWr<=`LOW;
    ALUSrc<=`LOW;
    MemRd<=`LOW;
    MemWr<=`LOW;
    MemtoReg<=`LOW;
    Branch<=`LOW;
    Jump<=`LOW;
    ALUOp<=2'bxx;
    case (OP_Code)
        6'b000000:begin
            RegDst<=`HIGH;
            RegWr<=`HIGH;
            ALUSrc<=`LOW;
            MemRd<=`LOW;
            MemWr<=`LOW;
            MemtoReg<=`LOW;
            Branch<=`LOW;
            Jump<=`LOW;
            ALUOp<=2'b10;


        end 
        6'b100011:begin
            RegDst<=`LOW;
            RegWr<=`HIGH;
            ALUSrc<=`HIGH;
            MemRd<=`HIGH;
            MemWr<=`LOW;
            MemtoReg<=`HIGH;
            Branch<=`LOW;
            Jump<=`LOW;
            ALUOp<=2'b00;
        end
        6'b101011:begin
            
            RegWr<=`LOW;
            ALUSrc<=`HIGH;
            MemRd<=`LOW;
            MemWr<=`HIGH;
            
            Branch<=`LOW;
            Jump<=`LOW;
            ALUOp<=2'b00;
        end
        6'b000100:begin
            
            RegWr<=`LOW;
            ALUSrc<=`LOW;
            MemRd<=`LOW;
            MemWr<=`LOW;
            
            Branch<=`HIGH;
            Jump<=`LOW;
            ALUOp<=2'b01;
            
        end
        6'b000010:begin
            
            RegWr<=`LOW;
            
            MemRd<=`LOW;
            MemWr<=`LOW;
            
            Branch<=`LOW;
            Jump<=`HIGH;
            
        end
    endcase
end

endmodule // Mcu