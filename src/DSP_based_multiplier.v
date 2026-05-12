`timescale 1ns / 1ps

module dsp_multiplier (
    input  wire   clk ;                                              // clk added
    input  wire   rst ;                                             //  reset added
    input  wire signed [15:0] A,                        // 16-bit input A
    input  wire signed [15:0] B,                        // 16-bit input B
    output reg  signed [31:0] P                         // 32- Bit output P
);

    reg signed [15:0] A_reg, B_reg;                   //Pipeline registers
    reg signed [31:0] mult_reg;

    always @(posedge clk) begin
        if (rst) begin
            A_reg    <= 0;
            B_reg    <= 0;
            mult_reg <= 0;
            P        <= 0;
        end 
     else 
        begin
            A_reg <= A;                                     // Stage 1: input register
            B_reg <= B;

            mult_reg <= A_reg * B_reg;           // Stage 2: multiply (DSP slice inferred)

             P <= mult_reg;                          // Stage 3: output register
        end
    end
endmodule


