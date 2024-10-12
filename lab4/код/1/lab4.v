module lab4(clock, reset, x, y);

    input clock, reset;
    input x;
    output y;

    wire [1:0] x;
    reg y;
    reg [1:0] currentSt, nextSt;
    wire reset, clock;
    reg y_s;

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