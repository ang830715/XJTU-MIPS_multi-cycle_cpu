module Shl2_32bits(
    input wire[31:0] A,
    output wire[31:0] B 
);
assign B ={A[29:0],2'b00};
endmodule // Shl2_32bits