module lab4_1m1_tb;

parameter [3:0] x0 = 2'b00, x1 = 2'b01, x2 = 2'b10, x3 = 2'b11;
  reg clock; // тактовый сигнал
  reg  reset; // сброс
  reg [1:0] x; // инфовход
  wire y; // выход

  lab4_1m1  lab4_1m1_inst ( // вставка тестируемого модуля
    .clock(clock),
    .reset( reset),
    .x(x),
    .y(y)
  );

always #10  clock = ! clock; // Т сигнала = 20 ед. вр.

initial begin
    clock = 0; // первоначальная установка такта в 0
    reset = 1; // первичный сброс для определения стартовго состояния как S0
    #1 reset = 0;
    
    #4 x = x2;  // S0 => S1  1
    #20 x = x0; // S1 => S1  1
    #20 x = x3; // S1 => S2  0
    #20 x = x2; // S2 => S1  0
    #20 x = x2; // S1 => S2  1
    #20 x = x1; // S2 => S1  0
    #20 x = x1; // S1 => S0  0
    #20 x = x0; // S0 => S0  0
    #20 x = x3; // S0 => S2  1
    #20 x = x0; // S2 => S2  1
    #20 x = x3; // S2 => S0  1
    #20 x = x1; // S0 => S0  0

end

endmodule