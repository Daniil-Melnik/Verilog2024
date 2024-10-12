// `timescale 1 ns / 1 ns
module lab3_0_tb;
  //Ports
  reg [3:0] x_in; // шина ввода в дешифратор
  wire [7:0] y_out; // шина вывода дешифратора
  reg [3:0] takt; // переменная счётчик для задания тестовых воздействий

  lab3_0  lab3_0_inst ( // вставка модуля-обёртки
    .x_in(x_in),
    .y_out(y_out)
  );

  initial begin
    x_in = 3'bzzz; // инициализация входной шины дешифратора в нулевой момент
    for (takt = 0; takt != 8; takt = takt+1) // перебор входных воздействий
      begin 
      #5  x_in = takt; // присвоение входного значения с задержкой 5
      end
    end

endmodule