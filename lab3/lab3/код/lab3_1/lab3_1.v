module lab3_1( x_in, z_0, z_1, z_2);
    input x_in; // входные воздействия на дешифратор
    output z_0,z_1,z_2 ; // выходные значения лог. функций
    wire [3:0] x_in; // шина на 4 бита
    wire z_0,z_1,z_2; // одиночные сигналы
    wire [7:0] y; // внутренние связи модуля
                  // для взаимодействия с выходами дешифратора

    decode # (.n(4), .delay(0)) // вставка модуля дешифратора
        decode_inst(.x_in(x_in), .y_out(y));

    // вставка модулей or
    or or4(z_0, y[0], y[3], y[4], y[5]); // z0 = 10011100
    
    or or6(z_1, y[2], y[3], y[4], y[6]); // z1 = 00111010
    
    or or1(z_2, y[0], y[6]); // z2 = 10000010
endmodule