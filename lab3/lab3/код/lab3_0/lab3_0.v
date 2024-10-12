//`timescale 1 ns / 1 ns
module lab3_0( x_in, y_out);
input x_in; // входная шина номера выхода дешифратора
output y_out; // выходная шина для дешифратора

wire [3:0] x_in;
wire [7:0] y_out; // внутренние связи модуля

decode  decode_inst ( // вставка дешифратора
    .x_in(x_in),      // соединения
    .y_out(y_out)
  );

endmodule