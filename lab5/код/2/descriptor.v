module descriptor
#
    (
        parameter nIn = 4, // размерноесть двоичного значения
        parameter nOut = 8 // размерноесть результата на цифры
    )
    (
        input wire [nIn - 1 : 0] numBin,
        output reg [nOut - 1 : 0] result
    );
always @(numBin) begin
    case (numBin)
        0: assign result = 8'b11111100;
        1: assign result = 8'b01100000;
        2: assign result = 8'b11011010;
        3: assign result = 8'b11110010;
        4: assign result = 8'b01100110;
        default: assign result = 8'b00000001;
    endcase
    end
endmodule