`include "header.h"
module Sigext16_32(
    input wire[15:0] A,
    output wire[31:0] B
);
assign B={{16{1'b0}},A[15:0]};

endmodule // Sigext16_32