module lab2_4(
    input [2:0] x,
    input wire clock,
    output wire error,
    output reg z
);

parameter truth_table = 8'b00111001;

my_logic udp (
    .zt(z),
    .a(x[2]),
    .b(x[1]),
    .c(x[0])
);

assign error = (z == truth_table[x[2] * 4 + x[1] * 2 + x[0]]) ? 0 : 1;

endmodule



primitive my_logic(zt,a,b,c);
output zt;
input a,b,c;
table
       // a, b, c : zt;
          0  0  0 : 1;
          0  0  1 : 0;
          0  1  0 : 0;
          0  1  1 : 1;
          1  0  0 : 1;
          1  0  1 : 1;
          1  1  0 : 0;
          1  1  1 : 0;
endtable
endprimitive
