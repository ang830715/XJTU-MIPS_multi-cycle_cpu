`include "header.h"
module D_ff(
    input clk,
    input [`WIDTH] D ,
    output reg[`WIDTH] Q

);
always @(posedge clk ) begin
    Q<=D;
end

endmodule // D flip flop