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
    input wire [nBits - 1 : 0] in_data, // входная последовательность
    output wire [nBits - 1 : 0] outDec, 
    output wire ready, // готовность
);

wire shiftedBit0;
wire shiftedBit1;
wire [nOutputBits - 1 : 0] outBin;
wire [1 : 0] ctrl_shift_reg;
wire [2 : 0] ctrl_counter;

counter_block v1(
    .reset(reset),
    .clock(clock),
    .instruction(ctrl_counter),

    .result(outBin)
);

shift_register_block v2(
    .reset(reset),
    .clock(clock),
    .inputBits(in_data),
    .instruction(ctrl_shift_reg),

    .lastBit0(shiftedBit0),
    .lastBit1(shiftedBit1)
);

control_block v3(
    .start(start),
    .reset(reset),
    .clock(clock),
    .shiftedBit0(shiftedBit0),
    .shiftedBit1(shiftedBit1),

    .ready(ready),
    .ctrl_counter(ctrl_counter),
    .ctrl_shift_reg(ctrl_shift_reg)
);

descriptor v4 (
    .numBin(outBin),
    .result(outDec)
  );
endmodule
