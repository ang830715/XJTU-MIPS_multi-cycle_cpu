`include "header.h"
module Mux(
    input wire[`WIDTH] A ,
    input wire[`WIDTH] B ,
    input wire sel,
    output reg[`WIDTH] out
    
);
always@(*) begin
case (sel)
    1'b0: out <= A;
    1'b1: out <= B; 
     
endcase
end 
endmodule // Mux_2x1
