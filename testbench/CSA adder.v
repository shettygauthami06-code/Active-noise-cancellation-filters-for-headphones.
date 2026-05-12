Csa adder
`timescale 1ns/1ps
module tb_top;
reg [15:0] A, B, C;
reg mode;
wire [15:0] RESULT;
wire COUT;
top_csa_adder
uut(.A(A), .B(B), .C(C), .mode(mode), .RESULT(RESULT),.COUT(COUT));
initial 
begin
$display("Starting Simulation");
// CASE 1: ADD
    mode = 0;
    A = 10; B = 20; C = 5;   // Expected: 35
    #10;
 // CASE 2: ADD
    A = 15; B = 25; C = 10;  // Expected: 50
    #10;
// CASE 3: SUB
    mode = 1;
    A = 30; B = 10; C = 5;   // Performs: (A+B+C) then subtract in final stage
    #10;
// CASE 4: Random
   mode = 0;
   A = 100; B = 50; C = 25; // Expected: 175
   #10;
 $stop;
 end
endmodule

