// Testbench for dice

timeunit 1ns; timeprecision 10ps;

module dice_stim();

logic Clock, nReset;
wire TL, TR, ML, MC, MR, BL, BR;

dice dut1(.Clock(Clock), .nReset(nReset),
  .TL(TL), .TR(TR),
  .ML(ML), .MC(MC), .MR(MR),
  .BL(BL), .BR(BR)
);

// Probe
task display_signals;
  $display($time, "  %d   %d         %b  %b  %b  %b  %b  %b  %b  ", dut1.Ran, dut1.DiceValue, TL, TR, ML, MC, MR, BL, BR);
endtask

initial begin
  $display("                Time  Ran DiceValue TL TR ML MC MR BL BR");
  $display("                ====  ============= ====================");
  display_signals();
  forever begin
    // Print signals every 10 clock cycles
    #100;
    display_signals();
    // Pause the sim
    `ifndef NOPAUSE
    $stop();
    `endif 
  end
end

// Stimuli
initial begin
  nReset = 0;
  #2 nReset = 1;
  // If stop is not included, there needs to be something to stop the sim
  `ifdef NOPAUSE
  #2400 $finish();
  `endif
end

// 100 MHz clock
always begin
    Clock = 0;
    #5 Clock = 1;
    #5;
end

// Self-checking every 2 clock cycles
integer ones, prev_count=0;
always begin
  #20;  
  // Check DiceValue matches number of active LEDs
  // Doesn't check the pattern, but doing so would amount to asserting the inverse of the design
  ones =  $countones({TL, TR, ML, MC, MR, BL, BR});
  assert (dut1.DiceValue == ones) else $error("DiceValue %d != number of active LEDs (%d)", dut1.DiceValue, ones);
  // Check that the dice has not stayed on the same side
  assert (ones != prev_count) else $error("Dice Value did not change in this cycle");
  //Check for illegal rolls, ie to the opposite side of the dice
  assert ((ones+prev_count)!= 7) else $error("Rolling from %d to %d not allowed", prev_count, ones);
  prev_count = ones;

end

endmodule