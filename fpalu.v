`include "combined.v"
`include "booth.v"
`include "booth2.v"
`include "booth3.v"
`include "booth4.v"
`include "booth5.v"
`include "booth6.v"
`include "result.v"
`include "normalize1.v"
`include "normalize2.v"

module topdut(a,b,s,clk,reset,r,exception);

input [31:0] a,b;
input clk,reset,s;

output [31:0]r;
output exception;

//adder

wire [7:0]add_exponent_a,add_exponent_b,add_exponent_a2;
wire [22:0] add_fraction_a,add_fraction_b,add_fraction_a2,add_fraction_b2;
wire add_sign_a,add_sign_b,add_sign_a2,add_sign_b2,add_sign_a3,add_sign_b3,add_sign_a4,add_sign_b4,add_sign_a5,add_sign_b5;
wire [7:0]add_difference;
wire add_zero_flag,add_greater_flag,add_lesser_flag,add_greater_flag2;
wire new_add_sign,new_add_sign2,new_add_sign3,new_add_sign4;
wire [24:0]add_sum;
wire add_exception1,add_exception2,add_exception12;
wire [24:0] updated_add_sum;
wire [7:0] updated_add_exponent;
wire add_exception3;
wire [24:0] final_add_sum;
wire [7:0] final_add_exponent;
wire [7:0]new_add_exponent,new_add_exponent2;
wire [23:0]add_combined_a,add_combined_b;

 assign add_exponent_a = a[30:23];
 assign add_exponent_b = b[30:23];
 assign add_fraction_a = a[22:0];
 assign add_fraction_b = b[22:0];
 assign add_sign_a = a[31];
 assign add_sign_b = b[31];

//multiplier
wire s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30;
wire [7:0]exponent_a,exponent_b;
wire [22:0] fraction_a,fraction_b;
wire sign_a,sign_b;
wire  new_sign;
wire [8:0] new_exponent27,new_exponent, updated_exponent; 
wire [24:0]combined_a,combined_b, combined_negative_b;
wire [24:0] combined_b2, combined_negative_b2,combined_b3, combined_negative_b3,combined_b4, combined_negative_b4,combined_b5, combined_negative_b5,combined_b6, combined_negative_b6,combined_b7, combined_negative_b7;
wire [24:0] combined_b8, combined_negative_b8,combined_b9, combined_negative_b9,combined_b10, combined_negative_b10,combined_b11, combined_negative_b11,combined_b12, combined_negative_b12,combined_b13, combined_negative_b13;
wire [24:0] combined_b14, combined_negative_b14,combined_b15, combined_negative_b15,combined_b16, combined_negative_b16,combined_b17, combined_negative_b17,combined_b18, combined_negative_b18,combined_b19, combined_negative_b19;
wire [24:0] combined_b20, combined_negative_b20,combined_b21, combined_negative_b21,combined_b22, combined_negative_b22,combined_b23, combined_negative_b23,combined_b24, combined_negative_b24,combined_b25, combined_negative_b25;
wire [24:0] combined_b26, combined_negative_b26,combined_b27, combined_negative_b27,combined_b28, combined_negative_b28,combined_b29, combined_negative_b29;

wire  new_sign2,new_sign3,new_sign4,new_sign5,new_sign6,new_sign7,new_sign8,new_sign9,new_sign10,new_sign11,new_sign12,new_sign13,new_sign14,new_sign15,new_sign16,new_sign17,new_sign18,new_sign19,new_sign20;
wire new_sign21,new_sign22,new_sign23,new_sign24,new_sign25,new_sign26,new_sign27,new_sign28,new_sign29,new_sign30,new_sign31,new_sign32;
wire [50:0]product1,product2,product3,product4,product5,product6,product7,product8,product9,product10,product11,product12,product13,product14;
wire [50:0] product15,product16,product17,product18,product19,product20,product21,product22,product23,product24;
wire [50:0] product25, product26;

wire [8:0] new_exponent2,new_exponent3,new_exponent4,new_exponent5,new_exponent6,new_exponent7,new_exponent8,new_exponent9,new_exponent10,new_exponent11,new_exponent12,new_exponent13;
wire [8:0] new_exponent14,new_exponent15,new_exponent16,new_exponent17,new_exponent18,new_exponent19,new_exponent20,new_exponent21,new_exponent22,new_exponent23,new_exponent24,new_exponent25,new_exponent26;
wire [8:0]  new_exponent28,new_exponent29,new_exponent30,new_exponent31,new_exponent32,new_exponent33,new_exponent34;

wire [24:0]updated_product;
wire exception1,exception2,exception12,add_exception_1,add_exception_2,add_exception_3,add_exception_4,add_exception_5,add_exception_6,add_exception_7;
wire add_exception_8,add_exception_9,add_exception_10,add_exception_11,add_exception_12,add_exception_13,add_exception_14;
wire add_exception_15,add_exception_16,add_exception_17,add_exception_18,add_exception_19,add_exception_20,add_exception_21,add_exception22,add_exception23;

wire [31:0] add_r,add_r2,add_r3,add_r4,add_r5,add_r6,add_r7,add_r8,add_r9,add_r10,add_r11,add_r12,add_r13,add_r14,add_r15,add_r16,add_r17,add_r18,add_r19,add_r20,add_r21,add_r22,add_r23;

wire[8:0] final_exponent;
wire [24:0] final_product;

 assign exponent_a = a[30:23];
 assign exponent_b = b[30:23];
 assign fraction_a = a[22:0];
 assign fraction_b = b[22:0];
 assign sign_a = a[31];
 assign sign_b = b[31];

//split s1(clk,reset,a,b,exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b);
combined c1(clk, reset, exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b, new_sign, new_exponent, combined_a,combined_b, combined_negative_b,add_exponent_a,add_exponent_b, add_difference,add_zero_flag,add_greater_flag,add_lesser_flag,add_sign_a, add_sign_b,add_sign_a2, add_sign_b2,add_fraction_a,add_fraction_b,add_fraction_a2,add_fraction_b2,add_exponent_a2,s,s2);
booth b1(clk, reset, combined_a,combined_b, combined_negative_b, product1,combined_b2, combined_negative_b2,new_exponent,new_exponent2,new_sign,new_sign2,add_exponent_a2,add_difference,add_zero_flag,add_greater_flag,add_lesser_flag,add_fraction_a2,add_fraction_b2,add_combined_a,add_combined_b,new_add_exponent,add_sign_a2,add_sign_b2,add_sign_a3,add_sign_b3,s2,s3,add_greater_flag2); 

booth2 b2(clk, reset, product1 ,combined_b2, combined_negative_b2, product2,combined_b3, combined_negative_b3,new_exponent2,new_exponent3,new_sign2,new_sign3,add_sign_a3,add_sign_b3, add_combined_a, add_combined_b, add_sum, new_add_sign,add_sign_a4,add_sign_b4,new_add_exponent,new_add_exponent2,s3,s4,add_greater_flag2); 

booth3 b3(clk, reset, product2 ,combined_b3, combined_negative_b3, product3,combined_b4, combined_negative_b4,new_exponent3,new_exponent4,new_sign3,new_sign4,add_sign_a4, add_sign_b4, add_sum, new_add_exponent2, updated_add_exponent, updated_add_sum, add_exception1,add_exception2, new_add_sign,new_add_sign2,add_sign_a5,add_sign_b5,s4,s5); 

booth4 b4(clk, reset, product3 ,combined_b4, combined_negative_b4, product4,combined_b5, combined_negative_b5,new_exponent4,new_exponent5,new_sign4,new_sign5,add_sign_a5, add_sign_b5, updated_add_sum, updated_add_exponent, final_add_exponent, final_add_sum, add_exception3,new_add_sign2 , new_add_sign3,add_exception1,add_exception2,add_exception12,add_exception22,s5,s6); 

booth5 b5(clk, reset, product4 ,combined_b5, combined_negative_b5, product5,combined_b6, combined_negative_b6,new_exponent5,new_exponent6,new_sign5,new_sign6,final_add_exponent, final_add_sum, new_add_sign3, add_r,add_exception12,add_exception22,add_exception3,add_exception_1,s6,s7); 

booth6 b6(clk, reset, product5 ,combined_b6, combined_negative_b6, product6,combined_b7, combined_negative_b7,new_exponent6,new_exponent7,new_sign6,new_sign7,add_r,add_exception_1,add_r2,add_exception_2,s7,s8); 

booth6 b7(clk, reset, product6 ,combined_b7, combined_negative_b7, product7,combined_b8, combined_negative_b8,new_exponent7,new_exponent8,new_sign7,new_sign8,add_r2,add_exception_2,add_r3,add_exception_3,s8,s9); 
booth6 b8(clk, reset, product7 ,combined_b8, combined_negative_b8, product8,combined_b9, combined_negative_b9,new_exponent8,new_exponent9,new_sign8,new_sign9,add_r3,add_exception_3,add_r4,add_exception_4,s9,s10); 
booth6 b9(clk, reset, product8 ,combined_b9, combined_negative_b9, product9,combined_b10, combined_negative_b10,new_exponent9,new_exponent10,new_sign9,new_sign10,add_r4,add_exception_4,add_r5,add_exception_5,s10,s11); 
booth6 b10(clk, reset, product9 ,combined_b10, combined_negative_b10, product10,combined_b11, combined_negative_b11,new_exponent10,new_exponent11,new_sign10,new_sign11,add_r5,add_exception_5,add_r6,add_exception_6,s11,s12); 
booth6 b11(clk, reset, product10 ,combined_b11, combined_negative_b11, product11,combined_b12, combined_negative_b12,new_exponent11,new_exponent12,new_sign11,new_sign12,add_r6,add_exception_6,add_r7,add_exception_7,s12,s13); 
booth6 b12(clk, reset, product11 ,combined_b12, combined_negative_b12, product12,combined_b13, combined_negative_b13,new_exponent12,new_exponent13,new_sign12,new_sign13,add_r7,add_exception_7,add_r8,add_exception_8,s13,s14); 
booth6 b13(clk, reset, product12 ,combined_b13, combined_negative_b13, product13,combined_b14, combined_negative_b14,new_exponent13,new_exponent14,new_sign13,new_sign14,add_r8,add_exception_8,add_r9,add_exception_9,s14,s15); 
booth6 b14(clk, reset, product13 ,combined_b14, combined_negative_b14, product14,combined_b15, combined_negative_b15,new_exponent14,new_exponent15,new_sign14,new_sign15,add_r9,add_exception_9,add_r10,add_exception_10,s15,s16); 
booth6 b15(clk, reset, product14 ,combined_b15, combined_negative_b15, product15,combined_b16, combined_negative_b16,new_exponent15,new_exponent16,new_sign15,new_sign16,add_r10,add_exception_10,add_r11,add_exception_11,s16,s17); 
booth6 b16(clk, reset, product15 ,combined_b16, combined_negative_b16, product16,combined_b17, combined_negative_b17,new_exponent16,new_exponent17,new_sign16,new_sign17,add_r11,add_exception_11,add_r12,add_exception_12,s17,s18); 
booth6 b17(clk, reset, product16 ,combined_b17, combined_negative_b17, product17,combined_b18, combined_negative_b18,new_exponent17,new_exponent18,new_sign17,new_sign18,add_r12,add_exception_12,add_r13,add_exception_13,s18,s19); 
booth6 b18(clk, reset, product17 ,combined_b18, combined_negative_b18, product18,combined_b19, combined_negative_b19,new_exponent18,new_exponent19,new_sign18,new_sign19,add_r13,add_exception_13,add_r14,add_exception_14,s19,s20); 
booth6 b19(clk, reset, product18 ,combined_b19, combined_negative_b19, product19,combined_b20, combined_negative_b20,new_exponent19,new_exponent20,new_sign19,new_sign20,add_r14,add_exception_14,add_r15,add_exception_15,s20,s21); 
booth6 b20(clk, reset, product19 ,combined_b20, combined_negative_b20, product20,combined_b21, combined_negative_b21,new_exponent20,new_exponent21,new_sign20,new_sign21,add_r15,add_exception_15,add_r16,add_exception_16,s21,s22); 
booth6 b21(clk, reset, product20 ,combined_b21, combined_negative_b21, product21,combined_b22, combined_negative_b22,new_exponent21,new_exponent22,new_sign21,new_sign22,add_r16,add_exception_16,add_r17,add_exception_17,s22,s23); 
booth6 b22(clk, reset, product21 ,combined_b22, combined_negative_b22, product22,combined_b23, combined_negative_b23,new_exponent22,new_exponent23,new_sign22,new_sign23,add_r17,add_exception_17,add_r18,add_exception_18,s23,s24); 
booth6 b23(clk, reset, product22 ,combined_b23, combined_negative_b23, product23,combined_b24, combined_negative_b24,new_exponent23,new_exponent24,new_sign23,new_sign24,add_r18,add_exception_18,add_r19,add_exception_19,s24,s25); 
booth6 b24(clk, reset, product23 ,combined_b24, combined_negative_b24, product24,combined_b25, combined_negative_b25,new_exponent24,new_exponent25,new_sign24,new_sign25,add_r19,add_exception_19,add_r20,add_exception_20,s25,s26);
booth6 b25(clk, reset, product24 ,combined_b25, combined_negative_b25, product25,combined_b26, combined_negative_b26,new_exponent25,new_exponent26,new_sign25,new_sign26,add_r20,add_exception_20,add_r21,add_exception_21,s26,s27);
normalize1 n1(clk,reset,product25, new_exponent26, updated_exponent, updated_product,exception1,new_sign26,new_sign28,add_r21,add_exception_21,add_r22,add_exception_22,s27,s28);
normalize2 n2(clk,reset,updated_product,updated_exponent,final_product,final_exponent,exception2,new_sign28,new_sign29,exception1,exception12,add_r22,add_exception_22,add_r23,add_exception_23,s28,s29);
result r2(clk,reset,final_exponent, final_product, new_sign29, r,exception12,exception2,exception,add_r23,add_exception_23,s29);


endmodule
