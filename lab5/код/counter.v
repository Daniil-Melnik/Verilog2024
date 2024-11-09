/**
Инструкции:
00 - Инструкция, когда мы обнаружили, что сдвинутый бит - ноль
11 - Загрузка (Сбрасываем значение в ноль)
10, 01 - Инструкции, в которых мы никак на счетчик не влияем
*/
module counter_block
#
    (
        parameter nBits = 4 // размерноесть результата
    )
    (
        input wire reset,
        input wire clock,
        input wire [2 : 0] instruction, // номер инструкции к исполнению
        output wire [nBits - 1 : 0] result // кол-во нулей
    );
    parameter load = 3'b100; // инструкция загрузки
    parameter zeroDetected = 3'b001; // инструкция обнаружения нуля
    reg [nBits - 1 : 0] nZeros; // кол-во посчитанных нулей
    assign result = nZeros;
    always @(posedge clock or posedge reset)begin
    $display("instr = %b", instruction);
    if (reset)
        nZeros <= 0; //начальное состояние счетчика
    else if (instruction == 3'b100) begin
	$display("loading %b %b %b", instruction, instruction & 3'b100, load);
        nZeros <= 0; //начальное состояние счетчика
	end
    else if (instruction == zeroDetected) begin
        nZeros <= nZeros + 1'b1;
	$display("Zero detected");
	end
    end
endmodule
