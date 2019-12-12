`include "header.h"
module Pc(
    input wire clk,
    input wire[`WIDTH] D,

    output reg [`WIDTH] Q
);
reg [`WIDTH] pc;
always @(posedge clk ) begin
    Q <= D;

    
end
initial begin
    Q <=0;
end

endmodule // Pc