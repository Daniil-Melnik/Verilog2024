module lab2_2(
    input [2:0] x,
    input wire clock,
    output wire error,
    output reg z
);

parameter truth_table = 8'b00111001;

assign error = (z == truth_table[x[2] * 4 + x[1] * 2 + x[0]]) ? 0 : 1;

always @(x) 
begin
    if (~x[2]) 
        z = ~(x[1] ^ x[0]);
    else 
        z = ~x[1];
end

endmodule