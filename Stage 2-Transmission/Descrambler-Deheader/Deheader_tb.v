`timescale 1ns/1ns

module Deheader_tb();
//------------------generating clock signal in 50MHz
   reg clk = 1'b0;
   always @(clk)
      clk <= #10 ~clk;
   wire valid;
   wire [15:0] out;
   reg [15:0] in;
   integer i;
//-------------------------------------- reg declaration 
   initial begin
        in = 0;
        #30;
        in = 1000;
        #20;
        in = 100;
        #20;
        in = 100;
        #20;
        in = 100;
        #20;
        in = 100;
        #20;
        for(i=0;i<1024;i=i+1) begin
            in = i;
            #20;
        end  
   end
    Deheader uut (     
        .clk(clk),
        .valid(valid),
        .in(in),
        .out(out)
    );


endmodule