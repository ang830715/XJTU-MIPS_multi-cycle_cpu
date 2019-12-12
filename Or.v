module Or(
    input A,
    input B,
    output reg C
);
always @(*)begin
    C <= A | B;
end
endmodule // Or