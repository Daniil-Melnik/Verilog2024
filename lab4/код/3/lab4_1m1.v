module lab4_1m1(clock, reset, x, y);

    input clock, reset; // входы тактового сигнала и сброса
    input x; // входной инфосигнал
    output y; // выходной сигнал

    wire [1:0] x; // входной инфосигнал
    reg y; // выходной сигнал
    reg [1:0] currentSt, nextSt; // текущее и следующее состояние
    wire reset, clock; // сброс и такт
    reg y_s; // актуальный выходной сигнал
    
    always @(posedge clock or posedge reset) begin
        if (reset) currentSt <= 0;
        else begin
            currentSt <= nextSt;
            y <= y_s;
        end 
    end

    always @(x, currentSt) begin
        case (x)
            0:
                case (currentSt)
                    0: begin nextSt <= currentSt; y_s <= 0; end
                    1, 2: begin  nextSt <= currentSt; y_s <= 1; end
                    default: begin nextSt <= 0; y_s <= 1'bz; end
                endcase

            1:
                case (currentSt)
                    0, 1: begin nextSt <= 0; y_s <= 0; end
                    2: begin nextSt <= 1; y_s <= 0; end 
                    default: begin nextSt <= 0; y_s <= 1'bz; end
                endcase
            2:
                case (currentSt)
                    0, 1: begin nextSt <= currentSt + 1; y_s <= 1; end
                    2: begin nextSt <= 1; y_s <= 0; end
                    default: begin nextSt <= 0; y_s <= 1'bz; end
                endcase
            3:
                case (currentSt)
                    0, 1: begin nextSt <= 2; y_s <= (currentSt + 1) % 2; end
                    2: begin nextSt <= 0; y_s <= 1; end
                    default: begin nextSt <= 0; y_s <= 1'bz; end
                endcase
            default: begin nextSt <= 0; y_s <= 1'bz; end
        endcase
    end
endmodule