// SystemVerilog structural model of a LFSR PRBS generator

module random(
  input wire Clock, nReset,
  output wire [1:0] Ran
);

  // SV support for arrays of instances
  // https://stackoverflow.com/questions/1378159/can-we-have-an-array-of-custom-modules

  wire [10:0] dff_inputs, dff_outputs, dff_noutputs;

  dtype lfsr[10:0] (.Clk(Clock), .nRst(nReset), .D(dff_inputs), .Q(dff_outputs), .nQ(dff_noutputs));

  // Connections - see lab book for sketches
  xor feedback (dff_inputs[10], dff_outputs[0], dff_noutputs[2]);

  assign Ran = dff_outputs[1:0];

  assign dff_inputs[9:0] = dff_outputs[10:1];

endmodule
