`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2019 22:21:28
// Design Name: 
// Module Name: Vending_Machine_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define clk_period 10

module Vending_Machine_tb();

reg clk, reset, BTN1, BTN2, BTN3;
reg [2:0]Money_in;
wire product1, product2, product3, delivered;
wire LED1, LED2, LED3;
wire [6:0]digit0;
wire [6:0]digit1;
wire [6:0]digit2; 
wire [6:0]digit3;


vending_machine VM(
                 .clk(clk), 
                 .reset(reset), 
                 .BTN1(BTN1), 
                 .BTN2(BTN2), 
                 .BTN3(BTN3), 
                 .Money_in(Money_in), 
                 .product1(product1), 
                 .product2(product2), 
                 .product3(product3), 
                 .delivered(delivered),
                 .LED1(LED1), 
                 .LED2(LED2), 
                 .LED3(LED3), 
                 .digit0(ditit0), 
                 .digit1(digit1), 
                 .digit2(digit2), 
                 .digit3(digit3)
                  );

reg [7:0] insertedMoney;
reg [7:0] totalChange;
reg [7:0] change;

reg [1:0] current_state, next_state;

parameter free_state = 0, initial_state=1,tea_0=2, coffee_0=3, hot_chocolate_0=4, moreMoney_state = 5, delivered_state=6;
//**********************************************************************     
        initial clk = 1;
        always #(`clk_period) clk = ~clk;       
        
        //initial clk = 0;
        //always begin
          //  #10 clk = ~clk; 
       // end  
//***********************************************************************          
        initial begin
        reset = 0;
        BTN1 = 0;
        BTN2 = 0;
        BTN3 = 0;
        Money_in = 0;
        #`clk_period;
        
        reset = 1;              //begin to reset
        #`clk_period;
        
        reset = 0;              
        #(`clk_period);
//*************************************************************************        
        BTN1 = 1;       
        # 100 Money_in = 3'b010;        //2zl   waiting 10ns
        #(`clk_period);           
        
        BTN2 = 1; 
        # 100 Money_in = 3'b001;       //1z³
        #(`clk_period);
       
        # 100 Money_in = 3'b010;        //2z³
        #(`clk_period);
        
        BTN3 = 1;
        # 100 Money_in = 3'b100;         //5z³
        #(`clk_period);
        
        #(`clk_period * 5);
        
        $finish;
        end

endmodule

