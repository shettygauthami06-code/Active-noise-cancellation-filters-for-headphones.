
Error calculation test bench:
`timescale 1ns / 1ps
module tb_error_calc;
reg clk;
reg rst;
reg signed [15:0] d_in;
reg signed [15:0] y_in;
wire signed [15:0] e_out;
error_calc uut (.clk(clk), .rst(rst),.d_in(d_in),.y_in(y_in),.e_out(e_out) );
always #5 clk = ~clk;
initial 
begin
        clk = 0;
        rst = 1;
        d_in = 0;
        y_in = 0;
 #10 rst = 0;
#10 d_in = 20;  y_in = 10;   // e = 10
    #10 d_in = 15;  y_in = -5;   // e = 20
    #10 d_in = -10; y_in = 5;    // e = -15
    #10 d_in = 0;   y_in = 25;   // e =-25
#50;
 $finish;
end
 initial 
 begin
        $monitor("Time=%0t | d=%0d | y=%0d | e=%0d", $time, d_in, y_in, e_out);
  End
  endmodule
