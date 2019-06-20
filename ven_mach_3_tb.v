`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2019 16:06:42
// Design Name: 
// Module Name: ven_mach_3_tb
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


Vending_Machine VM(
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
                 .digit0(digit0), 
                 .digit1(digit1), 
                 .digit2(digit2), 
                 .digit3(digit3)
                  );


//reg [2:0] current_state, next_state;

parameter no_coin = 0, initial_state=1,tea_0=2, coffee_0=3, hot_chocolate_0=4, moreMoney_state = 5, delivered_state=6;
//**********************************************************************     
//initial begin
//$display("Time\tMoney_in\tproduct1\tproduct2\tproduct3\treset\tclk\tdelivered\ttotalChange");
//$monitor("%g\t%b\t%d\t%d",$time,Money_in,insertedMoney,totalCchange);
//$dumpvars;
//$dumpfile("file.vcd"); // Dump output file.
//end

//**********************************************************************
      always #(`clk_period) clk = ~clk;       
      
//***********************************************************************          
      initial begin
      clk = 0;
      reset = 0;
      BTN1 = 0;
      BTN2 = 0;
      BTN3 = 0;
      Money_in = 0;
      //current_state = 0;
      //next_state = 0;
      #`clk_period;
      
      reset = 1;              //begin to reset
      #`clk_period;
      
      reset = 0;              
      #(`clk_period);
//*************************************************************************  
//                       tea without change
//*************************************************************************      
      BTN1 = 1;       
      # 100 Money_in = 3'b010;        //2zl   waiting 100ns
      #(`clk_period);         
      
      #(`clk_period *5);
      reset =1;
      BTN1 = 0;
      BTN2 = 0;
      BTN3 = 0;
      Money_in = 0;
      #(`clk_period); 
      reset =0;
      #(`clk_period); 
 //********************************************************************  
                    //tea with change
 //********************************************************************
      BTN1 = 1;       
      # 100 Money_in = 3'b101;        //5zl   
      #(`clk_period);         
 
      #(`clk_period *5);
      reset =1;
      BTN1 = 0;
      BTN2 = 0;
      BTN3 = 0;
      Money_in = 0;
      #(`clk_period);     
      
      reset = 0;
      #(`clk_period); 
//***********************************************************************
//                  tea with moreMoney_state
//***********************************************************************
      BTN1 = 1;       
      # 100 Money_in = 3'b001;        //1zl   
      #(`clk_period);       
      # 100 Money_in = 3'b001;  
 
      #(`clk_period *5);
      reset =1;
      BTN1 = 0;
      BTN2 = 0;
      BTN3 = 0;
      Money_in = 0;
      #(`clk_period);     
      
      reset = 0;
      #(`clk_period); 
//***********************************************************************
//                  coffee without change
//*********************************************************************** 
      BTN2 = 1;       
      # 100 Money_in = 3'b010;        //2zl   
      #(`clk_period);       
      # 100 Money_in = 3'b001;
      #(`clk_period);               //1z³
      
    
      #(`clk_period *5);
       reset =1;
       BTN1 = 0;
       BTN2 = 0;
       BTN3 = 0;
       Money_in = 0;
       #(`clk_period);     

       reset = 0;
       #(`clk_period);     
      
      #(`clk_period * 5);
      
      $finish;
      end
initial 
$monitor ($time, " Output for inserted money = %h and change = %h ", digit0, digit3);


endmodule

