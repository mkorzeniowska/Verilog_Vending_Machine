`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2019 11:17:32
// Design Name: 
// Module Name: ssd
// Project Name: 
// Target Devices: 
// Tool Versions:
// Description: This module drives the seven segment displays. It has got 4 different inputs
//						for the 4 digits on the board. It's inputs are not directly the binary numbers.
//						You need to convert 4-bit hex values to their seven segment display equivalents.
//						 
//						a0,b0,c0,d0,e0,f0,g0 belongs to digit0, left most digit on the board.
//						a1,b1,c1,d1,e1,f1,g1 belongs to digit1, 3. from the rigth digit on the board.
//						a2,b2,c2,d2,e2,f2,g2 belongs to digit2, 2. from the rigth digit on the board.
//						a3,b3,c3,d3,e3,f3,g3 belongs to digit3, right most digit on the board.	
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
///////////////////////////////////////////////////////////////////////////////////


module ssd( clk, reset, a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3, e0, e1, e2, e3, 
       f0, f1, f2, f3, g0, g1, g2, g3, a, b, c, d, e, f, g, an0, an1, an2, an3
    );
    
    input clk, reset;            //set clock and reset as input(1 bit)
    input a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3, e0, e1, e2, e3,  //set display data as input (1 bit)
           f0, f1, f2, f3, g0, g1, g2, g3;
    output reg a, b, c, d, e, f, g, an0, an1, an2, an3;  // set outputs as reg (1 bit)
    
    reg [2:0] state;  //hold state number (3 bit)
    reg [14:0] counter;  ////counter to slow the input clock(15 bit)
    
    //in this always block the speed of the clock reduced by 25000 times so that display works properly
    always @(posedge clk) begin            //state counter
            if (reset) begin              //synchronus reset 
                     state <= 0;         //if reset set state and counter to zero
                     counter <= 0;
            end else begin              //else the counter untill 25000
                    if (counter == 15'h61A8) begin           //if equal to 25000
                             if (state == 3'b100)            //if it is the last state return to state 1
                             state <= 1;
                             else                          // go on state up
                             state <= state + 1;
                    counter <= 0;                       //0 the counter because after it reaches 25000
                    end
                    else 
                    counter <= counter + 1;          //if not 25000 add 1
            end
     end
     
    //in this always block we give the inputs to the leds by choosing 
    //different display segment in each time
    always @(posedge clk) 
    begin
          if (reset)       //if reset initilize the outputs
          begin
          an0 <= 1;
          an1 <= 1;
          an2 <= 1;
          an3 <= 1;
          a <= 1;
          b <= 1;
          c <= 1;
          d <= 1;
          e <= 1;
          f <= 1;
          g <= 1;
          end
          else if (state == 3'b001)   //state 1 gives the led outputs to the AN0
          begin
          an0 <= 1;
          an1 <= 1;
          an2 <= 1;
          an3 <= 0;
          a <= a0;
          b <= b0;
          c <= c0;
          d <= d0;
          e <= e0;
          f <= f0;
          g <= g0;
          end
          else if (state == 3'b010)    //state 2 gives the led outputs to the AN1
          begin
          an0 <= 0;
          an1 <= 1;
          an2 <= 1;
          an3 <= 1;
          a <= a1;
          b <= b1;
          c <= c1;
          d <= d1;
          e <= e1;
          f <= f1;
          g <= g1;
          end
          else if (state == 3'b011)   //state 3 gives the led outputs to the AN2
          begin
          an0 <= 1;
          an1 <= 0;
          an2 <= 1;
          an3 <= 1;
          a <= a2;
          b <= b2;
          c <= c2;
          d <= d2;
          e <= e2;
          f <= f2;
          g <= g2;
          end
          else if (state == 3'b100)    //state 4 gives the led outputs to the AN3
          begin
          an0 <= 1;
          an1 <= 1;
          an2 <= 0;
          an3 <= 1;
          a <= a3;
          b <= b3;
          c <= c3;
          d <= d3;
          e <= e3;
          f <= f3;
          g <= g3;
          end
          else   //for other states default inputs and outputs
          begin
          an0 <= 1;
          an1 <= 1;
          an2 <= 1;
          an3 <= 1;
          a <= 1;
          b <= 1;
          c <= 1;
          d <= 1;
          e <= 1;
          f <= 1;
          g <= 1;
          end
    end    
endmodule
