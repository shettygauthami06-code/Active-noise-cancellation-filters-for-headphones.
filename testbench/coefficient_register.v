`timescale 1ns/1ps
module tb();
reg clk=0, rst;
reg signed [15:0] x_in, d_in;
wire signed [15:0] e_out;
anc_nlms uut (.clk(clk),.rst(rst),.x_in(x_in),.d_in(d_in),.e_out(e_out));
always #5 clk = ~clk;

initial
  begin

    rst = 1;
    x_in = 0;
    d_in = 0;

    #10 rst = 0;

    #10 x_in=100; d_in=120;
    #10 x_in=200; d_in=210;
    #10 x_in=300; d_in=290;
    #10 x_in=400; d_in=380;

    #100 $finish;

end

initial
 $monitor("t=%0t x=%d d=%d e=%d",
          $time,x_in,d_in,e_out);
endmodule
