// Structural top-level module of dice

timeunit 1ns; timeprecision 10ps;

module dice(
  input wire Clock, nReset,
  output wire TL, ML, BL, MC, TR, MR, BR
);
  wire [1:0] Ran;
  wire [2:0] DiceValue;
  
  random rand1(.Clock(Clock), .nReset(nReset), .Ran(Ran));
  control cont1(.Clock(Clock), .nReset(nReset), .Ran(Ran), .DiceValue(DiceValue));
  encoder enc1(.DiceValue(DiceValue),
    .L11(TL), .L31(TR),
    .L12(ML), .L22(MC), .L32(MR),
    .L13(BL), .L33(BR)
  );
  
endmodule
