// `define HIGH    1'b1        
// `define LOW     1'b0
// `define WIDTH   31:0
`include "header.h"
module Regfile(
    input wire clk,
    input wire [4:0] r_addr_1,
    input wire [4:0] r_addr_2,
    input wire [4:0] w_addr,
    input wire [`WIDTH] data_in,
    input wire          we,
    output wire [`WIDTH] data_out_1,
    output wire [`WIDTH] data_out_2


    
);
    reg [`WIDTH] ff [`WIDTH];  
    integer i;
    assign data_out_1=ff[r_addr_1];
    assign data_out_2=ff[r_addr_2];

    always @(posedge clk) begin
        if(we == `HIGH) begin
            #1 ff[w_addr] <= data_in;
        end
    end
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
        ff[i] <= i;

        end
    end



endmodule // regfile