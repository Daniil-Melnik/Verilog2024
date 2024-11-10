module descriptor
#
    (
        parameter nIn = 4, // размерность двоичного значения
        parameter nOut = 8 // размерность результата на цифры
    )
    (
        input wire [nIn - 1 : 0] numBin,
        output reg [nOut - 1 : 0] result
    );
    
always @(numBin) begin // мультиплексор
    case (numBin)
        0: result = 8'b11111100;
        1: result = 8'b01100000;
        2: result = 8'b11011010;
        3: result = 8'b11110010;
        4: result = 8'b01100110;
        default: result = 8'b00000001;
    endcase
end

endmodule