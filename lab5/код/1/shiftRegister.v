/**
Инструкции:
10, 01 - cдвиг
11 - загрузка последовательности в локальую память
00 - Инструкция, в которой мы никак на блок не влияем
*/
module shiftRegister
#
(
    parameter nBits = 8, // кол-во битов результата
    shiftLength = 1 // шаг сдвига
)
(
    input wire reset,
    input wire clock,
    input wire [nBits - 1 : 0] inputBits, // входная последовательность
    input wire [1 : 0] instruction, // инструкция к выполнению

    output wire lastBit0, // сдвинутый бит по обратной связи
    output wire lastBit1
);
reg [nBits - 1 : 0] localMemory; // локальная память
assign lastBit0 = localMemory[nBits - 1];
assign lastBit1 = localMemory[nBits - 2];
always @(posedge clock, posedge reset)
begin
    if (reset) // сброс
        localMemory <= 0;
    else if (instruction == 2'b11) // загружаем последовательность
        localMemory <= inputBits;
    else if (instruction == 2'b10 || instruction == 2'b01) // сдвигаем
        localMemory <= localMemory << shiftLength;
end
endmodule
