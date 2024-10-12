`timescale 1 ns / 1 ns

module lab2_2_tb;

reg [2:0] x;
reg clock;
reg [2:0] takt;
wire error;
wire z;

lab2_2 lab2_2_inst (
  .x(x),
  .clock(clock),
  .error(error),
  .z(z)
);

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
