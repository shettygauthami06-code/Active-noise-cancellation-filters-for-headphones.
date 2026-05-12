`timescale 1ns / 1ps

module delay_line #(parameter TAPS = 8);
(
    input  wire clk;
    input  wire rst;
    input  wire signed [15:0] x_in;
    output wire signed [16*TAPS-1:0] x_out
);

    reg signed [15:0] shift_reg [0:TAPS-1];
    integer i;

    always @(posedge clk) 
       begin
        if (rst) begin
            for (i = 0; i < TAPS; i = i + 1)
                shift_reg[i] <= 0;
        end 
      else 
        begin
            shift_reg[0] <= x_in;
            for (i = 1; i < TAPS; i = i + 1)
                shift_reg[i] <= shift_reg[i-1];
        end
    end

    genvar j;
    generate
        for (j = 0; j < TAPS; j = j + 1) begin : out_assign
            assign x_out[16*j +: 16] = shift_reg[j];
        end
    endgenerate
endmodule


