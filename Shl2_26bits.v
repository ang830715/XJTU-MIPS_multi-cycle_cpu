`include "header.h"
module Shl2_26bits(
    input wire[25:0] A,
    output wire[27:0] B 
    
);
assign B={A[25:0],2'b00};

endmodule // Shl2_26bits