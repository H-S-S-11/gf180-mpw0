// Behavioural model of LED encoder

module encoder(
  input wire [2:0] DiceValue,
  output wire L11, L12, L13, L21, L22, L23, L31, L32, L33
 );
   logic [8:0] output_leds;
 
   // Reading left to right then down
   assign {L11, L21, L31, L12, L22, L32, L13, L23, L33} = output_leds;
   
   always@(*) begin
     case (DiceValue)
       3'd0: output_leds = 9'b000_000_000;
       3'd1: output_leds = 9'b000_010_000;
       3'd2: output_leds = 9'b100_000_001;
       3'd3: output_leds = 9'b100_010_001;
       3'd4: output_leds = 9'b101_000_101;
       3'd5: output_leds = 9'b101_010_101;
       3'd6: output_leds = 9'b101_101_101;
       3'd7: output_leds = 9'b111_101_111;
     endcase
  end

endmodule
