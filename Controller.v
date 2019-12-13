`include "header.h"
module Controller (clk,  Op,Func, PCWrCond, PCWr , IorD, MemRd, MemWr, MemtoReg, IRWr, PCSrc, ALUOp, ALUSrcB, ALUSrcA, RegWr, RegDst);
input [5:0] Op;
input [5:0] Func;
input clk;
output [1:0] ALUOp, ALUSrcB, PCSrc;
output PCWrCond, PCWr , IorD, MemRd, MemWr, MemtoReg, IRWr, ALUSrcA, RegWr, RegDst; 
reg [1:0] ALUOp, ALUSrcB, PCSrc;
reg PCWrCond, PCWr , IorD, MemRd, MemWr, MemtoReg, IRWr, ALUSrcA, RegWr, RegDst;
reg [4:0] state =0, nextstate; 
parameter S0=0;
parameter S1=1;
parameter S2=2;
parameter S3=3; 
parameter S4=4; 
parameter S5=5; 
parameter S6=6; 
parameter S7=7; 
parameter S8=8; 
parameter S9=9; 
parameter S10=10; 
parameter S11=11;
parameter S12=12;
parameter S13=13;
parameter S14=14;
parameter S15=15;

always@(posedge clk) begin 
state=nextstate;
end
always @(state, Op,Func) begin //if lack Func  nop instruction will cause error

case(state)
S0: begin
MemRd=1'b1; 
ALUSrcA=1'b0; 
IorD= 1'b0; 
IRWr=1'b1; 
ALUSrcB=2'b01; 
ALUOp= 2'b00; 
PCWr =1'b1; 
PCSrc=2'b00; 
nextstate=S1; 
RegWr = 1'b0; 
MemWr=1'b0; 
PCWrCond= 1'b0; 
MemtoReg=1'b0;
end
S1: begin 
MemRd=1'b0;
IRWr=1'b0;
ALUSrcA=1'b0;
ALUSrcB=2'b11;
PCWr =1'b0;
ALUOp= 2'b00;
if(Op==6'b100011) begin //if op code is lw or sw
nextstate=S2; 
end
if(Op==6'b101011) begin //if op code is lw or sw 
nextstate=S2;
end
if(Op==6'b000000) begin // if R type instruction
nextstate=S6; end
if(Op==6'b000100) begin //if beq instruction 
nextstate=S8;
end
if(Op==6'b000010) begin //if jump instruction 
nextstate=S9;
end

if(Op==6'b001100) begin //if ANDI
nextstate=S10; 
end
if(Op==6'b001000) begin //if ADDI
nextstate=S12; 
end
if(Op==6'b000000 && Func==6'b001000) begin //if JR
nextstate=S13; 
end
if(Op==6'b000000 && Func==6'b000000) begin //if NOP
nextstate=S0; 
end

end
S2: begin
ALUSrcA = 1'b1;
ALUSrcB= 2'b10; 
ALUOp = 2'b00;
if(Op==6'b100011) begin //if lw 
nextstate=S3;
end
if(Op==6'b101011) begin // if SW instruction 
nextstate=S5;
end 
end
S3: begin MemRd=1'b1;
IorD = 1'b1; 
nextstate=S4;

end
S4: begin
RegDst = 1'b0;
RegWr = 1'b1; 
MemtoReg= 1'b1; 
nextstate=S0; 
MemRd=1'b0;
end
S5: begin 
MemWr=1'b1;
IorD= 1'b1; 
nextstate=S0;
end
S6: begin
ALUSrcA= 1'b1;
ALUSrcB= 2'b00; 
ALUOp = 2'b10; 
nextstate = S7;
end
S7: begin
RegDst= 1'b1;
RegWr = 1'b1; 
MemtoReg = 1'b0; 
nextstate= S0;
end
S8: begin
ALUSrcA= 1'b1;
ALUSrcB= 2'b00; 
ALUOp=2'b01; 
PCWrCond= 1'b1; 
PCSrc = 2'b01; 
nextstate= S0;
end
S9: begin
PCWr = 1'b1;
PCSrc= 2'b10;
nextstate= S0; 
end
S10: begin

ALUSrcA= 1'b1; 
ALUSrcB= 2'b10; 
ALUOp = 2'b11; 
nextstate = S11;
end
S11: begin  //I type instrction register write
RegDst= 1'b0;
RegWr = 1'b1; 
MemtoReg = 1'b0; 
nextstate= S0;
end

S12: begin
ALUSrcA= 1'b1; 
ALUSrcB= 2'b10; 
ALUOp = 2'b00; 
nextstate = S11;
end

S13: begin
PCWr=1'b1;
PCSrc=2'b11;
nextstate = S0;
end

S14: begin
PCWr=1'b1;
PCSrc = 2'b01;
nextstate = S0;
end

endcase 
end
endmodule
