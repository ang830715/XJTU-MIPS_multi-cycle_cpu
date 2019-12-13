// `define HIGH    1'b1        
// `define LOW     1'b0
// `define WIDTH   31:0
`include "header.h"

module Memory(
    // input wire clk,
    input wire MemRd,
    input wire MemWr,
    input wire[`WIDTH] addr,
    input wire[`WIDTH] W_data,
    output reg   [`WIDTH] R_data
    
    
);
reg [7:0] mem [1023:0];
always@(*) begin
    if(MemWr)begin
       #1 mem[addr+3]<=W_data[31:24];
       #1 mem[addr+2]<=W_data[23:16];
       #1 mem[addr+1]<=W_data[15:8];
       #1 mem[addr]<=W_data[7:0];
    end
end

always@(*) begin
    if(MemRd)begin
         R_data <={mem[addr+3][7:0],mem[addr+2][7:0],mem[addr+1][7:0],mem[addr][7:0]};
    end
end

initial begin
    // mem[0]<=8'h20;
    // mem[1]<=8'h48;
    // mem[2]<=8'h4b;
    // mem[3]<=8'h01;
    $readmemh("inst.dat", mem);
end


endmodule // memory
