module lab2_5(
    input [2:0] x,
    input wire clock,
    output wire error,
    output reg D,
    output reg z
);

parameter truth_table = 8'b00111001;

assign error = (z == truth_table[x[2] * 4 + x[1] * 2 + x[0]]) ? 0 : 1;

always @(x) 
begin
    z = ~x[2] && (~x[1] && ~x[0] || x[1] && x[0]) || x[2] && ~x[1];
end

always @(z, clock) begin
    if (clock) begin
        D = z;
    end
end

endmodule