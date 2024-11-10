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
    parameter chngeDetected = 3'b001; // инструкция обнаружения нуля
    reg [nBits - 1 : 0] nChngs; // кол-во посчитанных нулей
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
