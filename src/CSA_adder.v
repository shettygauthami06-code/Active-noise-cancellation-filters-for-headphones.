module top_csa_adder #(parameter N = 16)(
    input  [N-1:0] A;
    input  [N-1:0] B;
    input  [N-1:0] C;
    input  mode,                           
    output [N-1:0] RESULT,
    output  COUT
);

wire [N-1:0] sum_csa;
wire [N-1:0] carry_csa;

csa #(N) u1 (.A(A),.B(B),.C(C),.SUM(sum_csa), .CARRY(carry_csa));      // CSA Stage

wire [N-1:0] carry_shifted;                          // Shift carry left by 1
assign carry_shifted = carry_csa << 1;

adder_subtractor #(N) u2 (.A(sum_csa),.B(carry_shifted),.mode(mode),.SUM(RESULT),
    .COUT(COUT) );                                            // Final Adder
endmodule


