`include "header.h"
module Mux4(
    input wire[`WIDTH] A ,
    input wire[`WIDTH] B ,
    input wire[`WIDTH] C ,
    input wire[`WIDTH] D ,
    input wire[1:0] sel,
    output reg[`WIDTH] out
    
);
always@(*) begin
case (sel)
    2'b00: out <= A;
    2'b01: out <= B; 
    2'b10: out <= C; 
    2'b11: out <= D; 
     
endcase
end 
endmodule // Mux_4x1