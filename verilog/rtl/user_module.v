`default_nettype none

//  Top level io for this module uses all available GPIO
//  The pin connections within the user_module can change
//  This allows use of the internal clock divider if you wish.
module user_module(
  input user_clock2,
  input [18:0] io_in, 
  output [18:0] io_out
);

  wire pdm_out;

  assign io_out[0] = pdm_out;
  assign io_out[1] = ~pdm_out;

  pdm pdm_core(
    .pdm_input(io_in[7:3]),
    .write_en(io_in[2]),
    .reset(io_in[1]),
    .clk(io_in[0]),    
    .pdm_out(pdm_out)
  );

  wire [6:0] leds;
  assign io_out[8:2] = leds;

  dice dice0(
  .Clock(io_in[8]), .nReset(io_in[9]),
  .TL(leds[0]), .ML(leds[1]), .BL(leds[2]), .MC(leds[3]),
  .TR(leds[4]), .MR(leds[5]), .BR(leds[6])
);

endmodule
