/**
Инструкции:
100 - Загрузка
001 - Нашли переход => счёт + 1
остальные - ничего не делаем
*/
module counterUnit
#
    (
        parameter nBits = 4 // размерноесть результата
    )
    (
        input wire reset,
        input wire clock,
        input wire [2 : 0] instruction, // номер инструкции к исполнению
        output wire [nBits - 1 : 0] result // кол-во переходов
    );
    parameter load = 3'b100; // инструкция загрузки
    parameter chngeDetected = 3'b001; // инструкция обнаружения перехода
    reg [nBits - 1 : 0] nChngs; // кол-во посчитанных переходов
    assign result = nChngs;
    always @(posedge clock or posedge reset)begin
    $display("instr = %b", instruction);
    if (reset)
        nChngs <= 0; //начальное состояние счетчика
    else if (instruction == 3'b100) begin
	$display("loading %b %b %b", instruction, instruction & 3'b100, load);
        nChngs <= 0; //начальное состояние счетчика
	end
    else if (instruction == chngeDetected) begin
        nChngs <= nChngs + 1'b1;
	$display("Change detected");
	end
    end
endmodule
