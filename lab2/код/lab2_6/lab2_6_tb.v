`timescale 1 ns / 1 ns

module lab2_6_tb;

  reg [2:0] x;
  reg  clock;
  wire  error;
  reg [2:0] takt;
  wire z;
  wire  D_d, D_s;


  lab2_6  lab2_6_inst (
    .x(x),
    .clock(clock),
    .error(error),
    .z(z),
    .D_d(D_d),
    .D_s(D_s)
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
