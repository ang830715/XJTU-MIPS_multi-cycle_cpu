`include "header.h"
module Add(
    input wire[`WIDTH] A,
    input wire[`WIDTH] B,
    output wire[`WIDTH] C
    
);

assign C=A+B;
endmodule // Add
