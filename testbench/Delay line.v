timescale 1ns / 1ps

module tb_delay_line;

    reg clk;
    reg rst;
    reg signed [15:0] x_in;

wire signed [127:0] x_out;                                                   // Flattened output (8 taps × 16 bits = 128 bits)
                                  
delay_line #(.TAPS(8)) uut ( .clk(clk),.rst(rst),.x_in(x_in),.x_out(x_out));                 // Instantiate DUT
       

always #5 clk = ~clk;                                                           // Clock generation (10ns period)

initial 
     begin
    clk = 0;
    rst = 1;
    x_in = 0;
    #10 rst = 0;                                                                         // Release reset

     #10 x_in = 1;                                                                       // Apply input sequence
     #10 x_in = 2;
     #10 x_in = 3;
     #10 x_in = 4;
     #10 x_in = 5;

    #50;
    $finish;
    end

    always @(posedge clk) begin                                                                                `    // Display outputs every clock                                            
    $display("Time=%0t | x0=%0d x1=%0d x2=%0d x3=%0d x4=%0d x5=%0d x6=%0d x7=%0d",
            $time,
            x_out[15:0],
            x_out[31:16],
            x_out[47:32],
            x_out[63:48],
            x_out[79:64],
            x_out[95:80],
            x_out[111:96],
            x_out[127:112]
        );
    end

endmodule
