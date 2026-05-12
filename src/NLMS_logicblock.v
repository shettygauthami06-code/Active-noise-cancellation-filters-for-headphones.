`timescale 1ns / 1ps

module nlms_update #(
    parameter TAPS  = 8;
    parameter MU = 16'sd10;      // increased for visibility
    parameter SHIFT = 4            // reduced scaling
)(
    input  wire   clk;
    input  wire   rst;
    input  wire signed [15:0]  e_in,
    input  wire signed [16*TAPS-1:0] x_in,
    output wire signed [16*TAPS-1:0] w_out
);

    reg signed [15:0] w [0:TAPS-1];            // Internal storage
    reg signed [15:0] x [0:TAPS-1];

    reg signed [31:0] mult_ex [0:TAPS-1];       // Pipeline registers
    reg signed [31:0] mult_mu [0:TAPS-1];

    integer i;

   always @(*) begin
        for (i = 0; i < TAPS; i = i + 1) begin
            x[i] = x_in[16*i +: 16];
        end
    end
   always @(posedge clk) begin         // main lms pipeline
        if (rst) begin
            for (i = 0; i < TAPS; i = i + 1) begin
                w[i]       <= 0;
                mult_ex[i] <= 0;
                mult_mu[i] <= 0;
            end
        end 
      else 
          begin
             for (i = 0; i < TAPS; i = i + 1)            // Stage 1: mu * (e*x)
                begin
                mult_ex[i] <= e_in * x[i];
              end
            for (i = 0; i < TAPS; i = i + 1)            // Stage 2: mu * (e*x)
               begin
