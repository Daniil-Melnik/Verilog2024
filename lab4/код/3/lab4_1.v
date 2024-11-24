module lab4_1(clock, reset, x, y);

    input clock, reset; // входы тактового сигнала и сброса
    input x; // входной инфосигнал
    output y; // выходной сигнал

    wire [1:0] x; // входной инфосигнал
    reg y; // выходной сигнал
    reg [1:0] currentSt, nextSt; // текущее и следующее состояние
    wire reset, clock; // сброс и такт
    reg y_s; // актуальный выходной сигнал
    
    // тактовое изменение состояния системы
    always @(posedge clock or posedge reset) begin
        if (reset) currentSt <= 0; // сброс
        else begin
            currentSt <= nextSt; // установка актуального следующего состояния в текущее
            y <= y_s; // установка актуального выходного сигнала
        end 
    end

    always @(x, currentSt) begin // актуализация следующего состояния и выхода
                                 // при изменении входа или текущего состояния
        case (x) // смотрим по входному инфосигналу
            0: // если пришло 00
                case (currentSt) // смотрим на текущее состояние
                    // текущее состояние S0 => остаёмся в нём  
                    0: nextSt <= currentSt; 
                    // текущее состояние S1 или S2 => остаёмся в них
                    1, 2: nextSt <= currentSt;
                    default: nextSt <= 0; 
                endcase
            1: // если пришло 01
                case (currentSt)
                    // текущее S0 или S1 => преход в S0
                    0, 1: nextSt <= 0;
                    // текущее S2 => переход в S1
                    2: nextSt <= 1; 
                    default: nextSt <= 0;
                endcase
            2: // если пришло 10
                case (currentSt)
                    // текущее S0 или S1 => преход в S1 и S2
                    0, 1: nextSt <= currentSt + 1;
                    // текущее S2 => переход в S1
                    2: nextSt <= 1;
                    default: nextSt <= 0;
                endcase
            3: // если пришло 11
                case (currentSt)
                    // текущее S0 или S1 => преход в S2
                    0, 1: nextSt <= 2;
                    // текущее S2 => переход в S0
                    2: nextSt <= 0;
                    default: nextSt <= 0;
                endcase
            default: nextSt <= 0;
        endcase
    end

    always @(x, currentSt) begin
        case (x) // смотрим по входному инфосигналу
            0: // если пришло 00
                case (currentSt) // смотрим на текущее состояние
                    // текущее состояние S0 => на выход 0    
                    0:  y_s <= 0; 
                    // текущее состояние S1 или S2 => на выход 1
                    1, 2: y_s <= 1; 
                    // если сбой (S3 у нас нет), то на выход в импеданс
                    default: y_s <= 1'bz;
                endcase
            1: // если пришло 01
                case (currentSt)
                    // текущее S0 или S1 => на выход 0
                    0, 1: y_s <= 0; 
                    // текущее S2 => на выход 0
                    2: y_s <= 0;  
                    default: y_s <= 1'bz; 
                endcase
            2: // если пришло 10
                case (currentSt)
                    // текущее S0 или S1 => на выход 1
                    0, 1:  y_s <= 1; 
                    // текущее S2 => на выход 0
                    2:  y_s <= 0; 
                    default: y_s <= 1'bz; 
                endcase
            3: // если пришло 11
                case (currentSt)
                    // текущее S0 или S1 => на выход 1 и 0 соответсвенно
                    0, 1: y_s <= (currentSt + 1) % 2; 
                    // текущее S2 => на выход 1
                    2: y_s <= 1; 
                    default:  y_s <= 1'bz; 
                endcase
            default: y_s <= 1'bz;
        endcase
    end
endmodule