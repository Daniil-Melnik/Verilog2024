//`timescale 1 ns / 1 ns
module decode(x_in, y_out);
    parameter delay=0; // задержка
    parameter n=4; // число входов
    parameter u=8; // число выходов
    input x_in; output y_out; // режимы портов
        wire [n-1:0] x_in;
        reg [u-1:0] y_out; // типы портов
        reg [n:0] i;
    always @ (x_in) // оператор исполняется
                    // при любом изменении x_in
    begin # delay;
        for (i=0; i<u; i=i+1)
            y_out[i] = x_in==i ? 1:0; // в нужный бит выходной шины пишется 1,
                                      // в остальные пишутся нули
    end
endmodule