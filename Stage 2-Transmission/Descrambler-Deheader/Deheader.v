`timescale 1ns/1ns
module Deheader(
//-----------------------Port directions and deceleration
   input clk,
   input [15:0]in,
   output reg valid,
   output [15:0]out
    );
    reg start = 0;
    reg [10:0]Counter = 0;
    reg [2:0] next = 0;
    reg [2:0] current = 0;
    assign out = valid ? in : 16'bx;
    always @(in,current) begin
        case (current)
            0:begin
                next = 0;
                if (in == 100) 
                    next = 1;
            end
            1:begin
                next = 0;
                if (in == 100) 
                    next = 2;
            end
            2:begin
                next = 0;
                if (in == 100) 
                    next = 3;
            end
            3:begin
                next = 0;
                if (in == 100)
                    next = 4;
            end
            4:begin
                next = 0;
                if (in == 100)begin
                start = 1;
                Counter = 0;
                end
            end
            default: next = 0;
        endcase
    end
    always @(posedge clk) begin
        if(start)begin
            Counter <= Counter + 1;
            valid <= 1;
        end
        current <= next;
        if (Counter==1023)begin
            valid <= 0;
            next <= 0;
            start <= 0;
        end 
    end
endmodule
