module controlUnit
    (
        input wire start,
        input wire reset,
        input wire clock,
        input wire shiftedBit0, // сдвигаемый бит 0 (курсор)
        input wire shiftedBit1, // сдвигаемый бит 1

        output reg ready, // готовность
        output reg [2 : 0] instrCnt, // номер инструкции из счётчика
        output reg [1 : 0] instrSiftReg, // номер инструкции из регистра
		  output wire [1 : 0] currSt_out
    );
    parameter max = 4'b1000; // максимальное кол-во бит последовательности
    parameter initialNumber = 4'b0000; // начальное состояние счётчика
    reg [3:0] nShifted; // колво сдвинутых битов

    localparam [1:0] // состояния автомата
        initState = 2'b00, // начальное
        loadState = 2'b01, // загрузки
        shiftState = 2'b10, // сдвиг бита с возвратом значения бита
        finalState = 2'b11; // окончания

    reg [1:0] currentState, nextState; // состояния автомата
	 wire reset_s;
	 
	 assign reset_s = reset;
	 
    always @(posedge clock or posedge reset_s) // переход по состояниям
    begin
      currentState = reset_s ? initState: nextState; // сброс / переход
    end
	 
	 assign currSt_out = currentState;
    always @ (*)
    begin
        case (currentState)
        initState:
        begin
            // нажали старт => в состояние загрузки
            if (start)
            begin
                nextState = reset_s ? initState : loadState;
                ready = 0;
                instrSiftReg = 0;
                instrCnt = 2'b11;
            end
        end
        loadState: // загружаем последовательность
        begin
            nextState = reset_s ? initState : shiftState;
            ready = 0;
            instrSiftReg = 2'b11;
            instrCnt = 3'b100;
        end
        shiftState: // сдвигаемся
        begin
            ready = 0;
            instrCnt = {1'b0, shiftedBit0, shiftedBit1};
            instrSiftReg = 2'b10;
            nextState = reset_s ? initState : nShifted == max ? finalState : currentState;
        end
        finalState: // когда сосвсем сдвинулись - конец
        begin
            ready = 1;
            instrCnt = 2'b10;
            instrSiftReg = 2'b00;
            nextState = reset_s ? initState : initState;
        end
        default:
        begin
            nextState = loadState;
            ready = 0;
            instrSiftReg = 2'b00;
            instrCnt = 2'b11;
        end
        endcase
    end
    always @(negedge clock or posedge reset_s)
    begin
        if(reset_s)
            nShifted = initialNumber;
        else if(currentState != shiftState)
            nShifted = initialNumber;
        else 
            nShifted = nShifted + 1'b1;
    end
endmodule
