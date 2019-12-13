
module Alucu(
    input wire[1:0] ALUOp,
    input wire[5:0] Funct,
    output reg[2:0] ALUCtrl
);
always@(ALUOp,Funct)begin
    case (ALUOp)
        2'b00: ALUCtrl <= 3'b100;
        2'b01: ALUCtrl <= 3'b110;
        2'b10:begin
            case (Funct)
               6'b100000 : ALUCtrl <= 3'b100;
               6'b100001 : ALUCtrl <= 3'b101;
               6'b100010 : ALUCtrl <= 3'b110;
               6'b100100 : ALUCtrl <= 3'b000;
               6'b100101 : ALUCtrl <= 3'b001;
               6'b101010 : ALUCtrl <= 3'b011;
               6'b000100 : ALUCtrl <= 3'b010;
               6'b000110 : ALUCtrl <= 3'b111;

                
            endcase
        
        end
        2'b11: ALUCtrl <= 3'b000;
         
    endcase
end
endmodule // Alucu