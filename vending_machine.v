`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2019 21:05:15
// Design Name: 
// Module Name: vending_machine
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


module vending_machine(clk, reset, BTN1, BTN2, BTN3, Money_in, product1, product2, product3, delivered, 
                       LED1, LED2, LED3, digit0, digit1, digit2, digit3
                       );
input clk;     //internal clock (50MHz)
input reset;   //reset variable
input BTN1, BTN2, BTN3;    
input Money_in;
//BTN1: product1 - tea, BTN2: product2 - coffee, BTN3: product3 - hot chocolate
//Price: tea: 2z³, coffee: 3z³, hot chocolate: 5z³

output reg product1, product2, product3, delivered;
output reg [6:0] digit0; 
output reg [6:0] digit1;
output reg [6:0] digit2;
output reg [6:0] digit3;

output LED1, LED2, LED3;   //LEDs showing which product was selected

assign LED1 = BTN1;
assign LED2 = BTN2;
assign LED3 = BTN3;

reg [7:0] insertedMoney;
reg [7:0] totalChange;
reg [7:0] change;

reg [1:0] current_state, next_state;

parameter free_state = 0, initial_state=1,tea_0=2, coffee_0=3, hot_chocolate_0=4, delivered_state=5;
   
//*****************************************************************************

always @(posedge clk or posedge reset)
begin
    if (reset==1) begin
       current_state <= initial_state;
       insertedMoney = 8'b00000000;
       totalChange = 8'b00000000;
       //money = 8'b0000000;
       change <= 8'b00000000;
       digit0<=7'b1111110;
       digit1<=7'b1111110;
       digit2<=7'b1111110;
       digit3<=7'b1111110;
       product1<=0;
       product2<=0;
       product3<=0;
       delivered<=0;    
    end
    else begin
       if (current_state != initial_state)
       begin
           if (Money_in == 1 ) insertedMoney = 8'b00000001;
           else if (Money_in == 2) insertedMoney = 8'b00000010;
           else if (Money_in == 3) insertedMoney = 8'b00000011;
           else if (Money_in == 4) insertedMoney = 8'b00000100;
           else if (Money_in == 5) insertedMoney = 8'b00000101;
           else if (Money_in == 6) insertedMoney = 8'b00000110;
           else if (Money_in == 7) insertedMoney = 8'b00000111;
       end
       current_state <= next_state;
       totalChange <= totalChange + change;

    if (current_state != delivered_state)     //display inserted money
    begin
       if (insertedMoney == 8'b00000000)
         begin
           digit0 = 7'b0000001;   //0
           digit1 = 7'b0000001;
         end
       else if (insertedMoney == 8'b00000001)  //1
         begin
           digit0 = 7'b1001111;
           digit1 = 7'b1111110;             // -
         end
      else if (insertedMoney == 8'b00000010)    //2
        begin
           digit0 = 7'b0010010;
           digit1 = 7'b0000001;
        end
      else if (insertedMoney == 8'b00000011)    //3
        begin
          digit0 = 7'b0000110;
          digit1 = 7'b1111110;
        end
       else if (insertedMoney == 8'b00000100)    //4
         begin
           digit0 = 7'b1001100;
           digit1 = 7'b1111110;
         end
       else if (insertedMoney == 8'b00000101)  //5
         begin
           digit0 = 7'b0100100;
           digit1 = 7'b1111110;
         end
       else if (insertedMoney == 8'b00000110)   //6
         begin
           digit0 = 7'b1011111;
           digit1 = 7'b1111110;
         end
       else if (insertedMoney == 8'b00000111)   //7
         begin
           digit0 = 7'b0001111;
           digit1 = 7'b1111110;
       end
    end
else begin                        //money refunded
   digit0 = 7'b1111110;
   digit1 = 7'b1111110;
   if (totalChange == 8'b00000000)
      begin
      digit2 = 7'b0000001;
      digit3 = 7'b0000001;
      end
   else if (totalChange == 8'b00000001)  //1
      begin
      digit2 = 7'b1111110;    // -
      digit3 = 7'b1001111;    // 1
      end
   else if (totalChange == 8'b00000010)   //2
      begin
      digit2 = 7'b1111110;
      digit3 = 7'b0010010;
      end
   else if (totalChange == 8'b00000011)   //3
      begin
      digit2 = 7'b1111110;
      digit3 = 7'b0000110;
      end
   else if (totalChange == 8'b00000100)   //4
      begin
      digit2 = 7'b1111110;
      digit3 = 7'b1001100;
      end
   else if (totalChange == 8'b00000101)  //5
      begin
      digit2 = 7'b1111110;
      digit3 = 7'b0100100;
      end
   end
end
end
//***************************************************************************
// next state and output combinational logics
//****************************************************************************
always @*
begin
case (current_state)
initial_state: begin
              delivered = 0;
              change = 8'b000000000;
              if (BTN1 ==1 ) begin
                  product1 = 1;
                  product2 = 0;
                  product3 = 0;
                  next_state = tea_0;
                  end
              else if (BTN2 == 1) begin
                  product1 = 0;
                  product2 = 1;
                  product3 = 0;
                  next_state = coffee_0;
                  end
              else if (BTN3 == 1) begin
                  product1 = 0;
                  product2 = 0;
                  product3 = 1;
                  next_state <= hot_chocolate_0;
                  end
              else begin
                  next_state <= initial_state;
                  end
              end    
              
 
tea_0: begin
       if (insertedMoney >= 2 ) begin
           product1 = 1;
           product2 = 0;
           product3 = 0;
           //delivered = 1;
           change = insertedMoney - 2;
           next_state = delivered_state;
           end
       else begin
           product1 = 1;
           product2 = 0;
           product3 = 0;
           delivered = 0;
           change = 8'b00000000;
           next_state = tea_0;
           end
       end
       
coffee_0: begin
       if (insertedMoney >= 3 ) begin
           product1 = 0;
           product2 = 1;
           product3 = 0;
           //delivered = 1;
           change = insertedMoney - 3;
           next_state = delivered_state;
           end
       else begin
           product1 = 0;
           product2 = 1;
           product3 = 0;
           delivered = 0;
           change = 8'b00000000;
           next_state = coffee_0;
           end
       end
hot_chocolate_0: begin
          if (insertedMoney >= 5 ) begin
             product1 = 0;
             product2 = 0;
             product3 = 1;
             //delivered = 1;
             change = insertedMoney - 5;
             next_state = delivered_state;
             end
          else begin
             product1 = 0;
             product2 = 0;
             product3 = 1;
             delivered = 0;
             change = 8'b00000000;
             next_state = hot_chocolate_0;
             end
         end       
         
delivered_state: begin
          next_state = delivered_state;
          change = 8'b00000000;
          delivered = 1;
          end
endcase
end
  

endmodule
