module lab2_6(
    input [2:0] x,
    input wire clock,
    output wire error,
    output reg D_s, D_d,
    output reg z
);

parameter truth_table = 8'b00111001;

assign error = (z == truth_table[x[2] * 4 + x[1] * 2 + x[0]]) ? 0 : 1;

always @(x) 
begin
    z = ~x[2] && (~x[1] && ~x[0] || x[1] && x[0]) || x[2] && ~x[1];
end

always @(clock, z)
    if (clock) D_s = z;

always @(posedge clock)
    D_d = z;


endmodule