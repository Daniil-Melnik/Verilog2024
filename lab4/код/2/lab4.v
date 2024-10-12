module lab4(clock, reset, x, y);

    parameter [2:0] st0 = 0, st1 = 1, st2 = 2; // кодирование состояний
    parameter [3:0] x0 = 2'b00, x1 = 2'b01, x2 = 2'b10, x3 = 2'b11; // кодирование входов

    input clock, reset;
    input x;
    output y;

    wire [1:0] x;
    reg y;
    reg [1:0] currentSt, nextSt;
    wire reset, clock;
    reg y_s;

    always @(posedge clock or posedge reset) begin
        if (reset) currentSt <= st0;
        else begin
            currentSt <= nextSt;
            y <= y_s;
        end 
    end

    always @(x, currentSt) begin
        case (x)
            x0:
                case (currentSt)
                    st0: begin nextSt <= currentSt; y_s <= 0; end
                    st1, st2: begin  nextSt <= currentSt; y_s <= 1; end
                    default: begin nextSt <= st0; y_s <= 1'bz; end
                endcase

            x1:
                case (currentSt)
                    st0, st1: begin nextSt <= st0; y_s <= 0; end
                    st2: begin nextSt <= st1; y_s <= 0; end 
                    default: begin nextSt <= st0; y_s <= 1'bz; end
                endcase
            x2:
                case (currentSt)
                    st0, st1: begin nextSt <= currentSt + 1; y_s <= 1; end
                    st2: begin nextSt <= st1; y_s <= 0; end
                    default: begin nextSt <= st0; y_s <= 1'bz; end
                endcase
            x3:
                case (currentSt)
                    st0, st1: begin nextSt <= st2; y_s <= (currentSt + 1) % 2; end
                    st2: begin nextSt <= st0; y_s <= 1; end
                    default: begin nextSt <= st0; y_s <= 1'bz; end
                endcase
            default: begin nextSt <= st0; y_s <= 1'bz; end
        endcase
    end
endmodule