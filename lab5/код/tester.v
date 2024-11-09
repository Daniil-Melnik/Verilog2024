module tests
(
    start, // start program signal
    reset, // reset signal
    clock, // clk signal
    ready, // finish signal
    x
);
input ready;
output x, clock, start, reset;
wire ready;
reg clock, reset, start;
reg [7:0] x;
integer i, j;
parameter length = 6;
initial begin
    clock = 0;
    reset = 1;
    #5;
    reset = 0;
    #5;
    repeat (length)
    begin
        //x = $urandom%20; //в Quartus модуль тестирования не должен пользоваться
	x = 8'b01010101; //в Quartus модуль тестирования не должен пользоваться
		start = 1;
        // вечный цикл ожидания ready
        for(j = 1; j < length; j = j + 1)
        begin
            #5
            clock = 1;
            #5
            start = 0;
            #5;
            j = ready == 1? length: 1;
            clock = 0;
            // start = 0;
            // #10;
            #5;
            // start = 1;
        end
        #5;
        clock = 1;
        #10;
        clock = 0;
        #5;
    end
end
endmodule

module main_tester();
wire clock, reset, start, ready;
wire [7:0] in_data;
wire [3:0] out_data;
tests v1(
    .start(start),
    .reset(reset),
    .clock(clock),
    .ready(ready),
    .x(in_data)
);
main v2(
    .start(start),
    .reset(reset),
    .clock(clock),
    .in_data(in_data),

    .ready(ready),
    .out_data(out_data)
);
endmodule
