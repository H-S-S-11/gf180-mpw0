// Testbench for encoder

timeunit 1ns; timeprecision 10ps;

module tb_encoder;

logic [2:0] DiceValue;

wire L11, L12, L13, L21, L22, L23, L31, L32, L33;

encoder dut1(.DiceValue(DiceValue),
  .L11(L11), .L21(L21), .L31(L31),
  .L12(L12), .L22(L22), .L32(L32),
  .L13(L13), .L23(L23), .L33(L33)
);

// Stimuli
integer i;
initial begin
  for (i=0; i<7; i++) begin
    DiceValue = i;
	# 20;
	assert ($countones({L11, L12, L13, L21, L22, L23, L31, L32, L33})==DiceValue);
	# 20;
  end
  DiceValue = 7;
  # 20;
  assert ($countones({L11, L12, L13, L21, L22, L23, L31, L32, L33})==8);
  # 20;
  $finish();
end



endmodule