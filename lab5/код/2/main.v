module main
#
(
    parameter nOutputBits = 4,
    nBits = 8
)
(
    input wire start,
    input wire reset,
    input wire clock,
    input wire [nBits - 1 : 0] inData, // входная последовательность
    output wire [nBits - 1 : 0] outDec, 
    output wire ready // готовность
);

wire shiftedBit0;
wire shiftedBit1;
wire [nOutputBits - 1 : 0] outBin;
wire [1 : 0] instrShiftReg;
wire [2 : 0] instrCnt;

counterUnit v1(
    .reset(reset),
    .clock(clock),
    .instruction(instrCnt),

    .result(outBin)
);

shiftRegister v2(
    .reset(reset),
    .clock(clock),
    .inputBits(inData),
    .instruction(instrShiftReg),

    .lastBit0(shiftedBit0),
    .lastBit1(shiftedBit1)
);

controlUnit v3(
    .start(start),
    .reset(reset),
    .clock(clock),
    .shiftedBit0(shiftedBit0),
    .shiftedBit1(shiftedBit1),

    .ready(ready),
    .instrCnt(instrCnt),
    .instrShiftReg(instrShiftReg)
);

descriptor v4 (
    .numBin(outBin),
    .result(outDec)
  );
endmodule
