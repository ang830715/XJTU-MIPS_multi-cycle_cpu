`include "header.h"
module Alu(
    input wire[`WIDTH] A,
    input wire[`WIDTH] B,
    input wire[2:0] M,
    output reg[`WIDTH] C,
    output reg Z
);
initial begin
    Z <=`LOW;
end
always @(*)begin
case (M)
    3'b100: C <= $signed(A)+$signed(B);
    3'b110: C <= $signed(A)-$signed(B);
    3'b101: C <= A+B;
    3'b000: C <= A&B;
    3'b001: C <= A|B;
    3'b011: C <=A<B? 32'b1:32'b0;
    3'b010: C <=B << A;
    3'b111: C <=B >> A;
    
endcase
end 

always @(C) begin
    Z <= (C==0)?`HIGH:`LOW;
end


endmodule // Alu