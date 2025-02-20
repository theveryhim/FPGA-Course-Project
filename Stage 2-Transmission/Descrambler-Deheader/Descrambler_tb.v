`timescale 1ns / 1ps
module Descrambler_tb();
    reg clk;
    reg rst;
    reg [15:0] in;
    wire [15:0] out;
    wire [1:0] R;
    
    reg [15:0] samples [0:1023]; 
    reg [15:0] wave_Samples [0:1023];
    reg [15:0] wave_data;
    
    Descrambler uut(.clk(clk), .rst(rst), .in(in), .out(out), .R(R));
    
    always #5 clk = ~clk;
    
    integer i;
    
    initial begin
        $dumpfile("Descrambler.vcd");
        $dumpvars;
        
        $readmemh("triangle_scrambled.txt", samples);
        $readmemh("triangle_samples.txt", wave_Samples);
        
        clk = 0;
        rst = 0;
        
        #15
        rst = 1;
        
        for (i = 0; i < 1024; i = i+1) begin
            #10;
            in = samples[i];
            wave_data = wave_Samples[i];
        end
        
        #10;
    end
endmodule
