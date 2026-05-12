module anc_nlms (
    input clk, rst;
    input signed [15:0] x_in, d_in;
    output reg signed [15:0] e_out
);
integer i;
reg signed [15:0] x[0:15], w[0:15];
reg signed [31:0] y, norm, temp;
reg signed [15:0] e, inv_norm;

parameter MU = 16'sd50;

always @(posedge clk or posedge rst)
 begin
    if(rst)
      begin
        for(i=0;i<16;i=i+1)
         begin
            x[i] <= 0;
            w[i] <= 0;
        end
        e_out <= 0;
      end
    else
     begin
      x[0] <= x_in;                  // Delay line
        for(i=1;i<16;i=i+1)
            x[i] <= x[i-1];
        y = 0;                       // FIR output
        for(i=0;i<16;i=i+1)
            y = y + x[i]*w[i];
            e = d_in - y[30:15];
            e_out <= e;
            norm = 1;                 // Normalization
        for(i=0;i<16;i=i+1)
            norm = norm + x[i]*x[i];
            inv_norm = 16'd32768 / norm[15:0];
       for(i=0;i<16;i=i+1)              // NLMS update
          begin
            temp = (MU*x[i]*e) >>> 15;
            w[i] <= w[i] + ((temp*inv_norm) >>> 15);
        end
    end
end

endmodule
