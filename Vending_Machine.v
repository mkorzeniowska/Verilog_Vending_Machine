`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2019 18:00:22
// Design Name: 
// Module Name: Vending_Machine
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

module Vending_Machine(clk, reset, BTN1, BTN2, BTN3, Money_in, product1, product2, product3, delivered, 
                       LED1, LED2, LED3, digit0, digit1, digit2, digit3
                       );
input clk;     //internal clock (50MHz)  czyli 50 mln operacji w 1s
input reset;   //reset variable
input BTN1, BTN2, BTN3;    
input [2:0] Money_in;                    //3-bit Money_in: Money_in[0] 1z³, Money_in[1] 2z³, Money_in[2] 5 z³ ???
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


wire [2:0] Money_in;
reg [7:0] insertedMoney;
reg [7:0] totalChange;
reg [7:0] change;

reg [5:0] current_state, next_state;

parameter no_coin = 0, initial_state=1,tea_0=2, coffee_0=3, hot_chocolate_0=4, moreMoney_state = 5, delivered_state=6;
//parameter ssd_0=7'b0000001, ssd_1=7'b1001111, ssd_2=7'b0010010, ssd_3=7'b0000110, ssd_4=7'b1001100, ssd_5=7'b0100010, 
          //ssd_6=7'b0100000, ssd_7=7'b1110000, ssd_8=7'b0000000, ssd_not=7'b1111110;           //??
   
//*****************************************************************************

always @(posedge clk or posedge reset)
begin
    if (reset==1) begin
       current_state <= initial_state;
       insertedMoney <= 8'b000000000;
       totalChange <= 8'b00000000;
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
           if (Money_in == 3'b001) begin insertedMoney <= insertedMoney + 1;  end      //1z³
           else if (Money_in == 3'b010) begin insertedMoney = insertedMoney + 2; end   //2zl
          // else if (Money_in == 3) insertedMoney = insertedMoney + 8'b00000011;
           //else if (Money_in == 4) insertedMoney = insertedMoney + 8'b00000100;
           else if (Money_in == 3'b100) begin insertedMoney = insertedMoney + 5; end //5z³
           //else if (Money_in == 6) insertedMoney = 8'b00000110;
           //else if (Money_in == 7) insertedMoney = 8'b00000111;
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
       else if (insertedMoney == 8'b00000101)   //5
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
       else if (insertedMoney == 8'b00001000)   //8
         begin
           digit0 = 7'b0000000;
           digit1 = 7'b1111110;
       end
       else if (insertedMoney == 8'b00001001)   //9
         begin
           digit0 = 7'b0001100;
           digit1 = 7'b1111110;
         end
       else if (insertedMoney == 8'b00000111)   //10
          begin
             digit0 = 7'b1001111;
             digit1 = 7'b0000001;
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
              if (BTN1 == 1 ) begin
                  product1 = 1;
                  product2 = 0;
                  product3 = 0;
                  next_state <= tea_0;
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
                  next_state = hot_chocolate_0;
                  end
              else begin
                  next_state = initial_state;
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
      else if (insertedMoney < 2) begin
           product1 = 1;
           product2 = 0;
           product3 = 0;
           delivered = 0;
           change = 8'b00000000;
           next_state = moreMoney_state;
           end
       else begin                     // If it did not make any choice keep your position
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
       else if (insertedMoney < 3) begin
            product1 = 0;
            product2 = 1;
            product3 = 0;
            delivered = 0;
            change = 8'b00000000;
            next_state = moreMoney_state;
           end
       else begin   // 
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
          else if (insertedMoney < 5) begin
             product1 = 0;
             product2 = 0;
             product3 = 1;
             delivered = 0;
             change = 8'b00000000;
             next_state = moreMoney_state;
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
moreMoney_state: begin
          delivered = 0;
          change = 8'b00000000;
          if (product1 == 1) next_state = tea_0;
          else if (product2 == 1) next_state = coffee_0;
          else if (product3 == 1) next_state = hot_chocolate_0;
          end         
delivered_state: begin
          change = 8'b00000000;
          delivered = 1;
          next_state = delivered_state;
          end
endcase
end
  

endmodule

