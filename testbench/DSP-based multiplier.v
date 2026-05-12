`timescale 1ns / 1ps
module tb_dsp_multiplier;
    reg clk;    // Inputs
    reg rst;
    reg signed [15:0] A;
    reg signed [15:0] B;
    wire signed [31:0] P;// Output
    dsp_multiplier uut (    // Instantiate DUT
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .P(P)
    );
    always #5 clk = ~clk;    // Clock generation (10ns period)
    initial begin
        clk = 0; // Initialize
        rst = 1;
        A = 0;
        B = 0;
        #10 rst = 0;       // Release reset
        #10 A = 10;     B = 5;      // 50  // Test cases
        #10 A = 15;     B = -3;     // -45
        #10 A = -7;     B = -8;     // 56
        #10 A = 0;      B = 25;     // 0
        #10 A = 32767;  B = 2;      // 65534
        #50;        // Wait for pipeline delay
        $finish;
    end
    initial begin    // Monitor output
        $monitor("Time=%0t | A=%0d | B=%0d | P=%0d", $time, A, B, P);
    end
endmodule
