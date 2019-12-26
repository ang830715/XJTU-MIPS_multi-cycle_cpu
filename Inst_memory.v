`include "header.h"
module Inst_memory(
    input wire[`WIDTH] Addr,
    output reg[`WIDTH] Inst
    
);
reg [7:0] mem [1023:0];
always @(*) begin
    Inst <={mem[Addr+3][7:0],mem[Addr+2][7:0],mem[Addr+1][7:0],mem[Addr][7:0]};
end

initial begin
    // mem[0]<=8'h20;
    // mem[1]<=8'h48;
    // mem[2]<=8'h4b;
    // mem[3]<=8'h01;
    $readmemh("inst.dat", mem);
end
endmodule // Inst_memory