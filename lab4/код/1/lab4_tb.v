
module lab4_tb;

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
    
    #4 x = 2;
    #20 x = 0;
    #20 x = 3;
    #20 x = 2;
    #20 x = 2;
    #20 x = 1;
    #20 x = 1;
    #20 x = 0;
    #20 x = 3;
    #20 x = 0;
    #20 x = 3;
    #20 x = 1;

end

endmodule