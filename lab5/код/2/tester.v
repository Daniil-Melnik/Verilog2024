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
        //x = $urandom%20;
	x = 8'b01010101;
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
wire [7:0] inData;
wire [7:0] outData;
tests v1(
    .start(start),
    .reset(reset),
    .clock(clock),
    .ready(ready),
    .x(inData)
);
main v2(
    .start(start),
    .reset(reset),
    .clock(clock),
    .inData(inData),

    .ready(ready),
    .outDec(outData)
);
endmodule
