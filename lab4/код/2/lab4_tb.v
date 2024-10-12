
module lab4_tb;

parameter [3:0] x0 = 2'b00, x1 = 2'b01, x2 = 2'b10, x3 = 2'b11;
parameter [2:0] st0 = 2'b00, st1 = 2'b01, st2 = 2'b10;

  // Parameters

  //Ports
  reg clock;
  reg  reset;
  reg [1:0] x;
  wire y;

  lab4  lab4_inst (
    .clock(clock),
    .reset( reset),
    .x(x),
    .y(y)
  );

always #10  clock = ! clock;

initial begin
    clock = 0;
    reset = 1;
    #1 reset = 0;
    
    #4 x = x2;
    #20 x = x0;
    #20 x = x3;
    #20 x = x2;
    #20 x = x2;
    #20 x = x1;
    #20 x = x1;
    #20 x = x0;
    #20 x = x3;
    #20 x = x0;
    #20 x = x3;
    #20 x = x1;

end

endmodule