# Active-noise-cancellation-filters-for-headphones.
Description:
This project focuses on the design and implementation of an Active Noise Control (ANC) filter using the Normalized Least Mean Squares algorithm within the domain of digital design, targeting efficient FPGA-based realization. The system is intended for integration into modern headphones, where it actively cancels unwanted ambient noise by generating an anti-noise signal in real time. Such technology is widely used in environments like airplanes, public transport, offices, and crowded urban areas to enhance listening comfort and audio clarity. By using a 16-bit fixed-point architecture and optimized digital components, the design ensures low latency, high processing speed, and efficient hardware utilization. Overall, this project demonstrates the practical application of digital signal processing techniques in everyday consumer electronics, improving user experience through intelligent noise cancellation.

Objectives:

To implement the ANC filter using digital design techniques with a 16-bit fixed-point architecture suitable for FPGA-based systems.

To develop a real-time adaptive filtering system that continuously updates filter coefficients to minimize the error signal.

To reduce computational complexity and latency by employing pipelined structures and efficient normalization techniques.

To enhance practical applicability by targeting integration of the ANC system in real-world applications such as  noise-cancelling headphones.

Design Justification:

Why this specific ANC filter design is selected?
The proposed Active Noise Control (ANC) filter is based on the Normalized Least Mean Squares algorithm implemented using a 16-bit fixed-point architecture. This design is selected to achieve an optimal balance between real-time performance, hardware efficiency, and implementation simplicity on FPGA.

The architecture consists of the following key components:
Carry Save Adder (CSA) for accumulation
FPGA DSP slice multipliers (pipelined)
Shift register delay line using SRL/registers
Signed fixed-point adaptive weights
Pipelined fixed-point subtractor for error calculation
Normalization using power estimation + reciprocal approximation
Pipelined MAC structure for weight update
Pipelined Radix-2 FFT

How this improves over existing literature?
Compared to traditional ANC systems described by S. M. Kuo and D. R. Morgan, which primarily rely on time-domain LMS/FxLMS implementations, the proposed design introduces several improvements:
1. Reduced Computational Complexity -Lower number of arithmetic operations 
2. Improved Real-Time Performance -Achieves continuous sample-by-sample processing 
3. Efficient FPGA Utilization -Reduces LUT and register usage
4. Faster Convergence of NLMS -Improves noise cancellation performance
5. Elimination of Complex Division -Reduces hardware complexity and latency 

Tools Used
1. Algorithm Design & Analysis
Tools Used:MATLAB / Simulink 
2. Digital Design (RTL Coding)

Simulation tool Used:
Vivado xilinx ( For verilog coding)
Powerpoint (For architectural and block diagram.

Additional Supporting Data
Reference papers (IEEE)
Head-Mounted Multi-Channel Feedforward Active Noise Control System for Reducing Noise(TAKUMI MIYAKE1, KENTA IWAI 2, (Member, IEEE),AND YOSHINOBU KAJIKAWA 1, (Senior Member, IEEE)
Active Noise Cancellation Without Secondary Path Identification by Using an Adaptive Genetic Algorithm (Cheng-Yuan Chang and Deng-Rui Chen)
On FxLMS Scheme for Active Noise Control at Remote Location MUHAMMAD WAQAS MUNIR , (Member, IEEE),AND WALEED H. ABDULLA , (Senior Member, IEEE).



