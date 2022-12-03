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

endmodule
