// Testbench for random

timeunit 1ns; timeprecision 10ps;

module tb_random;

wire [1:0] Ran;
logic Clock, nReset;

localparam integer cycles = 2047;

logic [1:0] pr_sequence [0:cycles-1];

random dut1(.Clock(Clock), .nReset(nReset),
  .Ran(Ran)
);


// Stimuli
integer i;
initial begin
  nReset = 0;
  #2 nReset = 1;
  #10;
  
  for (i=0; i<cycles; i++) begin
    pr_sequence[i] = Ran;
    #200;
  end
  
  for (i=0; i<cycles; i++) begin
    assert (pr_sequence[i] == Ran) else $error("Expected %d got %d", pr_sequence[i], Ran);
    #200;
  end

  #100 $finish();

end

// 100 MHz clock
always begin
    Clock = 0;
    #50 Clock = 1;
    #50;
end

endmodule
