`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2019 17:59:52
// Design Name: 
// Module Name: Vending_Machine_Board
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
module Vending_Machine_Board(clk, reset, BTN1 ,BTN2 ,BTN3,Money_in, product1, product2, product3, delivered, Money_out,
							 a,b,c,d,e,f,g,an0,an1,an2,an3);
	
	input clk, reset, BTN1, BTN2, BTN3, Money_in;		
	output product1, product2, product3, delivered, Money_out;
	output a,b,c,d,e,f,g,an0,an1,an2,an3;

	wire divClk;
	wire BTN1out, BTN2out, BTN3out;
	wire [2:0] Money_in;
	wire [2:0] Money_out;
	wire [6:0] digit0;
	wire [6:0] digit1;
	wire [6:0] digit2;
	wire [6:0] digit3;
	wire LED1, LED2, LED3;
	
	clk_divider Div (.clk_in(clk), .rst(reset), .divided_clk(divClk));
	
	debouncer 	DB1 (.clk(divClk), .rst(reset), .noisy_in(BTN1), .clean_out(BTN1out));
	debouncer 	DB2 (.clk(divClk), .rst(reset), .noisy_in(BTN2), .clean_out(BTN2out));
	debouncer 	DB3 (.clk(divClk), .rst(reset), .noisy_in(BTN3), .clean_out(BTN3out));
	
	Vending_Machine vending (.clk(divClk), .reset(reset), .BTN1(BTN1out), .BTN2(BTN2out), .BTN3(BTN3out), .Money_in(Money_in), 
							 .product1(product1), .product2(product2), .product3(product3), .delivered(delivered),.Money_out(Money_out), .LED1(LED1),
							 .LED2(LED2), .LED3(LED3),
							 .digit0(digit0), .digit1(digit1), .digit2(digit2), .digit3(digit3));
	
	ssd SSD_END(.clk(clk), .reset(reset), 
				.a0(digit0[6]),.a1(digit1[6]),.a2(digit2[6]),.a3(digit3[6]),
				.b0(digit0[5]),.b1(digit1[5]),.b2(digit2[5]),.b3(digit3[5]),
				.c0(digit0[4]),.c1(digit1[4]),.c2(digit2[4]),.c3(digit3[4]),
				.d0(digit0[3]),.d1(digit1[3]),.d2(digit2[3]),.d3(digit3[3]),
				.e0(digit0[2]),.e1(digit1[2]),.e2(digit2[2]),.e3(digit3[2]),
				.f0(digit0[1]),.f1(digit1[1]),.f2(digit2[1]),.f3(digit3[1]),
				.g0(digit0[0]),.g1(digit1[0]),.g2(digit2[0]),.g3(digit3[0]),
				.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g),.an0(an0),.an1(an1),.an2(an2),.an3(an3));
	
endmodule
