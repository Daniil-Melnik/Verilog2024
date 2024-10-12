module lab2_3(
    input [2:0] x,
    input wire clock,
    output wire error,
    output reg z
);

parameter truth_table = 8'b00111001;

assign error = (z == truth_table[x[2] * 4 + x[1] * 2 + x[0]]) ? 0 : 1;

always @(x) 
begin
    case (x)
        3'b000 : z = 1'b1;
        3'b001 : z = 1'b0;
        3'b010 : z = 1'b0;
        3'b011 : z = 1'b1;
        3'b100 : z = 1'b1;
        3'b101 : z = 1'b1;
        3'b110 : z = 1'b0;
        3'b111 : z = 1'b0;

        default: z = 1'bz;
    endcase
end

endmodule