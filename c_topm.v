`include "c_split1.v"
`include "c_result1.v"
`include "c_booth.v"
`include "c_booth2.v"
`include "c_normalize1.v"
`include "c_normalize2.v"
`include "c_combined.v"

module c_topm(a,b,clk,reset,mul_r,mul_exception);

input [31:0] a,b;
input clk,reset;

output [31:0]mul_r;
output  mul_exception;

wire [7:0]exponent_a,exponent_b;
wire [22:0] fraction_a,fraction_b;
wire sign_a,sign_b;
wire  new_sign;
wire [8:0] new_exponent, updated_exponent; 
wire [24:0]combined_a,combined_b, combined_negative_b;
wire [50:0]product1,product2,product3,product4,product5,product6,product7,product8,product9,product10,product11,product12,product13,product14;
wire [50:0] product15,product16,product17,product18,product19,product20,product21,product22,product23,product24,product25;
wire [24:0]updated_product;
wire exception1,exception2;

wire[8:0] final_exponent;
wire [24:0] final_product;


c_split1 s1(clk,reset,a,b,exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b);
c_combine c1(exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b, new_sign, new_exponent, combined_a,combined_b, combined_negative_b);
c_booth b1(combined_a,combined_b, combined_negative_b, product1); 
c_booth2 b2(product1 ,combined_b, combined_negative_b, product2); 
c_booth2 b3(product2 ,combined_b, combined_negative_b, product3); 
c_booth2 b4(product3 ,combined_b, combined_negative_b, product4); 
c_booth2 b5(product4 ,combined_b, combined_negative_b, product5); 
c_booth2 b6(product5 ,combined_b, combined_negative_b, product6); 
c_booth2 b7(product6 ,combined_b, combined_negative_b, product7); 
c_booth2 b8(product7 ,combined_b, combined_negative_b, product8); 
c_booth2 b9(product8 ,combined_b, combined_negative_b, product9); 
c_booth2 b10(product9 ,combined_b, combined_negative_b, product10); 
c_booth2 b11(product10 ,combined_b, combined_negative_b, product11); 
c_booth2 b12(product11 ,combined_b, combined_negative_b, product12); 
c_booth2 b13(product12 ,combined_b, combined_negative_b, product13); 
c_booth2 b14(product13 ,combined_b, combined_negative_b, product14); 
c_booth2 b15(product14 ,combined_b, combined_negative_b, product15); 
c_booth2 b16(product15 ,combined_b, combined_negative_b, product16); 
c_booth2 b17(product16 ,combined_b, combined_negative_b, product17); 
c_booth2 b18(product17 ,combined_b, combined_negative_b, product18); 
c_booth2 b19(product18 ,combined_b, combined_negative_b, product19); 
c_booth2 b20(product19 ,combined_b, combined_negative_b, product20); 
c_booth2 b21(product20 ,combined_b, combined_negative_b, product21); 
c_booth2 b22(product21 ,combined_b, combined_negative_b, product22); 
c_booth2 b23(product22 ,combined_b, combined_negative_b, product23); 
c_booth2 b24(product23 ,combined_b, combined_negative_b, product24);
c_booth2 b25(product24 ,combined_b, combined_negative_b, product25);
c_normalize1 n1(product25, new_exponent, updated_exponent, updated_product,exception1);
c_normalize2 n2(updated_product,updated_exponent,final_product,final_exponent,exception2);
c_result1 r2(final_exponent, final_product, new_sign,mul_r,exception1,exception2,mul_exception);


endmodule
