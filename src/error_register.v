`timescale 1ns / 1ps

module error_calc (
    input  wire  clk;
    input  wire  rst;
    input  wire signed [15:0] d_in;   // desired signal
    input  wire signed [15:0] y_in;   // filter output
   output reg  signed [15:0] e_out   // error output
);

    reg signed [15:0] d_reg;     // stage 1  // Pipeline registers
    reg signed [15:0] y_reg;     // stage 1

    reg signed [15:0] y_comp;    // stage 2
    reg signed [15:0] d_reg2;    // stage 2 (alignment)

    always @(posedge clk) 
      begin
        if (rst) 
           begin
            d_reg   <= 0;
            y_reg   <= 0;
            y_comp  <= 0;
            d_reg2  <= 0;
            e_out   <= 0;
        end 
      else 
         begin
             d_reg <= d_in;                 // Stage 1: Register inputs
            y_reg <= y_in;

            y_comp <= ~y_reg + 1;   // 2's complement     // Stage 2: Compute -y and align d
            d_reg2 <= d_reg;        // align with y_comp

           e_out <= d_reg2 + y_comp;              // Stage 3: Final addition
        end
    end
endmodule

