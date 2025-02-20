`timescale 1ns / 1ps
module Descrambler(clk, rst, in, out, R);
    input wire clk;
    input wire rst;
    input wire [15:0] in;
    output reg [15:0] out;
    
    wire [7:0] Real;
    wire [7:0] Imag;
    
    assign Imag = in[7:0];
    assign Real= in[15:8];
    
    reg [17:0] X;
    reg [17:0] Y;
    reg T1 ;
    reg T2;
    
    wire [1:0] T3;
    assign T3 = T2 << 1;
    
    output wire [1:0] R; 
    assign R = T1 + T3;
    
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            out <= 16'bx;
            X = 18'd1;
            Y = 18'd262143;
        end
        else begin
            X[16:0] <= X[17:1];
            X[17] <= (X[0] + X[7]);
            Y[16:0] <= Y[17:1];
            Y[17] <= (Y[0] + Y[5] + Y[7] + Y[10]);
            
            T1 <= X[0] + Y[0];
            T2 <= Y[15] + Y[14] + Y[13] + Y[12] + Y[11] + Y[10] + Y[9] + Y[8] + Y[6] + Y[5] + X[4] + X[6] + X[15]; 
            
            case (R)
                0: begin
                    out <= {{Real},{Imag}};
                end
                1: begin
                    out <= {{Imag},{~Real + 8'd1}};
                end
                2: begin
                    out <= {{~Real + 8'd1},{~Imag + 8'd1}};
                end
                3: begin
                    out <= {{~Imag + 8'd1},{Real}};
                end
            endcase
        end
    end
endmodule
