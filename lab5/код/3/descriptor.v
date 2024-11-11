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
        0: result = 8'b00000011;
        1: result = 8'b10011111;
        2: result = 8'b00100101;
        3: result = 8'b00001101;
        4: result = 8'b10011001;
        default: result = 8'b11111110;
    endcase
end

endmodule