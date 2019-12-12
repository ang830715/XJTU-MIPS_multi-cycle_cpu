`include "header.h"
module IR(
    input clk,
    input Wr,
    input [`WIDTH] D,
    output reg[`WIDTH] inst
    
);
always @(posedge clk) begin
    if (Wr==`HIGH) begin
        inst<=D;
    end
    
end

endmodule // IR