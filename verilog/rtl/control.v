// control module. Can't get out of error states except with reset

timeunit 1ns; timeprecision 10ps;

module control(
    input wire Clock, nReset,
    input wire [1:0] Ran,
    output wire [2:0] DiceValue
);

logic [2:0] dice_val, next_dice_value;
logic n_1_or_6, n_2_or_5, n_3_or_4, enable_reg;

logic [2:0] gated[0:5];

assign n_1_or_6 = !((dice_val==3'd1) | (dice_val==3'd6));
assign n_2_or_5 = !((dice_val==3'd2) | (dice_val==3'd5));
assign n_3_or_4 = !((dice_val==3'd3) | (dice_val==3'd4));

//assign n_1_or_6 = !((!dice_val[2] & !dice_val[1]) | ( dice_val[2] &  dice_val[1]));
//assign n_2_or_5 = !((!dice_val[2] & !dice_val[0]) | ( dice_val[2] &  dice_val[0]));
//assign n_3_or_4 = !(( dice_val[1] &  dice_val[0]) | (!dice_val[1] & !dice_val[0]));

//assign n_1_or_6 = !(dice_val[2] == dice_val[1]);
//assign n_2_or_5 = !(dice_val[2] == dice_val[0]);
//assign n_3_or_4 = !(dice_val[1] == dice_val[0]);

assign DiceValue = dice_val;

assign gated[0] = 3'd1 & {3{n_1_or_6 &  Ran[0] &  !Ran[1] }};
assign gated[1] = 3'd2 & {3{n_2_or_5 &  Ran[0] & ( Ran[1]^n_3_or_4) }};
assign gated[2] = 3'd3 & {3{n_3_or_4 &  Ran[0] &   Ran[1] }};
assign gated[3] = 3'd4 & {3{n_3_or_4 & !Ran[0] &   Ran[1] }};
assign gated[4] = 3'd5 & {3{n_2_or_5 & !Ran[0] & ( Ran[1]^n_3_or_4) }};
assign gated[5] = 3'd6 & {3{n_1_or_6 & !Ran[0] &  !Ran[1] }};

assign next_dice_value = gated[0] | gated[1] | gated[2] | gated[3] | gated[4] | gated[5];

always_ff @(posedge Clock, negedge nReset) begin
  if (!nReset) begin
    enable_reg <= 1'b0;
    dice_val <= 3'd1;
  end else begin
    enable_reg <= !enable_reg;
    if(enable_reg) begin
      dice_val <= next_dice_value;
    end
  end
end

endmodule
