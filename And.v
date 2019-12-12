module And(
    input wire A,
    input wire B,
    output reg  C
);
always @(*)begin
    C <= A & B;
end

endmodule // And