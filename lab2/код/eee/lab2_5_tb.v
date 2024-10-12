`timescale 1 ns / 1 ns

module lab2_5_tb;

  reg [2:0] x;
  reg  clock;
  wire  error;
  reg [2:0] takt;
  wire z;
  wire  D;


  lab2_5  lab2_5_inst (
    .x(x),
    .clock(clock),
    .error(error),
    .z(z),
    .D(D)
  );

initial begin
  clock = 1'b0;
end

always #5 clock = ~clock;

initial begin
//   x = 3'b000;
x = 3'bzzz;
for (takt = 0; takt != 8;takt = takt+1) 
  begin 
  #10
  #2.5  x = takt;
  $display("takt = ", takt, " ", x[2], x[1], x[0], " ", z);  
  end
end

endmodule
