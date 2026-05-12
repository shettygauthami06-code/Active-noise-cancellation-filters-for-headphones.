`timescale 1ns / 1ps
module tb_lms_update;
    parameter TAPS = 8;
    reg clk;
    reg rst;
    reg signed [15:0] e_in;
    reg signed [16*TAPS-1:0] x_in; // Flattened input taps (delay line output)
    wire signed [16*TAPS-1:0] w_out;// Output weights
   lms_update #(     // Instantiate DUT
        .TAPS(TAPS),
        .MU(16'sd1),
        .SHIFT(8)
    ) uut (
        .clk(clk),
        .rst(rst),
        .e_in(e_in),
        .x_in(x_in),
        .w_out(w_out)
    );
    always #5 clk = ~clk;  // Clock generation
    initial begin
        clk = 0;
        rst = 1;
        e_in = 0;
        x_in = 0;
        #10 rst = 0; // Release reset
        e_in = 16'sd10; // Apply constant error
        x_in = {16'sd8,16'sd7,16'sd6,16'sd5,  // Apply sample input pattern
                16'sd4,16'sd3,16'sd2,16'sd1}; // x = [1,2,3,4,5,6,7,8]
        #20;
        x_in = {16'sd2,16'sd2,16'sd2,16'sd2,
                16'sd2,16'sd2,16'sd2,16'sd2};       // Change input
        #20;
        e_in = -16'sd5;// Change error
        #40;
        $finish;
    end
    always @(posedge clk) begin    // Display weights
        $display("Time=%0t | w0=%0d w1=%0d w2=%0d w3=%0d w4=%0d w5=%0d w6=%0d w7=%0d",
            $time,
            w_out[15:0],
            w_out[31:16],
            w_out[47:32],
            w_out[63:48],
            w_out[79:64],
            w_out[95:80],
            w_out[111:96],
            w_out[127:112]
        );
    end
endmodule
