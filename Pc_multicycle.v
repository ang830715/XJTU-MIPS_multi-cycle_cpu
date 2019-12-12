`include "header.h"
module Pc_multicycle(
    input wire clk,
    input wire Wr,
    input wire[`WIDTH] D,

    output reg [`WIDTH] Q
);

always @(posedge clk ) begin
if(Wr==`HIGH)
    Q <= D;

    
end
initial begin
    Q <=0;
end
endmodule 