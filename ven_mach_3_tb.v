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
`include "Vending_Machine.v"
`include "debouncer.v"
`include "ssd.v"
`include "clk_divider.v"


module Vending_Machine_tb();

reg clk, reset, BTN1, BTN2, BTN3;
reg [2:0]Money_in;
wire product1, product2, product3, delivered;
wire a,b,c,d,e,f,g,an0,an1,an2,an3;
wire LED1, LED2, LED3;
wire [6:0]digit0;
wire [6:0]digit1;
wire [6:0]digit2; 
wire [6:0]digit3;
wire divClk;
wire BTN1out, BTN2out, BTN3out;


Vending_Machine_Board VM(
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
                 .a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g),.an0(an0),.an1(an1),.an2(an2),.an3(an3)
                  );


reg [2:0] current_state, next_state;

parameter free_state = 0, initial_state=1,tea_0=2, coffee_0=3, hot_chocolate_0=4, moreMoney_state = 5, delivered_state=6;
//**********************************************************************     
//initial begin
//$display("Time\tMoney_in\tproduct1\tproduct2\tproduct3\treset\tclk\tdelivered\ttotalChange");
//$monitor("%g\t%b\t%d\t%d",$time,Money_in,insertedMoney,totalCchange);
//$dumpvars;
//$dumpfile("file.vcd"); // Dump output file.
//end

//**********************************************************************
      //initial clk = 1;
      always #(`clk_period) clk = ~clk;       
      
      //initial clk = 0;
      //always begin
        //  #10 clk = ~clk; 
     // end  
//***********************************************************************          
      initial begin
      clk = 0;
      reset = 0;
      BTN1 = 0;
      BTN2 = 0;
      BTN3 = 0;
      Money_in = 0;
      //insertedMoney = 0;
      //totalChange = 0;
      //change = 0;
      current_state = 0;
      next_state = 0;
      #`clk_period;
      
      reset = 1;              //begin to reset
      #`clk_period;
      
      reset = 0;              
      #(`clk_period);
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

     
      
      #(`clk_period * 5);
      
      $finish;
      end
initial 
$monitor ($time, " Output for inserted money = %h and change = %h ", digit0, digit3);
endmodule

