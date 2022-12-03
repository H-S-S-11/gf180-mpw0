// structural model of edge triggered D type

module dtype(
  output logic Q, nQ,
  input wire D, Clk, nRst
  );

timeunit 1ns; timeprecision 10ps;

always_ff @(posedge Clk, negedge nRst) begin
  if(~nRst) begin
    Q  <= 1'b0;
    nQ <= 1'b1;
  end else begin
    Q  <= D;
    nQ <= ~D;
  end
end

endmodule
