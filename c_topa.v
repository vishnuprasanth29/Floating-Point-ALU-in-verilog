`include "c_split.v"
`include "c_compare.v"
`include "c_shift.v"
`include "c_adder.v"
`include "c_a2shift.v"
`include "c_a2shift2.v"
`include "c_result.v"



module c_topa(a,b,clk,reset,add_r,add_exception);

input [31:0] a,b;
input clk,reset;

output [31:0]add_r;
output add_exception;

wire [7:0]add_exponent_a,add_exponent_b;
wire [22:0] add_fraction_a,add_fraction_b;
wire add_sign_a,add_sign_b;
wire [7:0]add_difference;
wire add_zero_flag,add_greater_flag,add_lesser_flag;
wire new_add_sign;
wire [24:0]add_sum;
wire add_exception1,add_exception2;
wire [24:0] updated_add_sum;
wire [7:0] updated_add_exponent;
wire add_exception3;
wire [24:0] final_add_sum;
wire [7:0] final_add_exponent;
wire [7:0]new_add_exponent;
wire [23:0]add_combined_a,add_combined_b;


c_split s1(clk,reset,a,b,add_exponent_a,add_exponent_b,add_fraction_a,add_fraction_b,add_sign_a,add_sign_b);
c_compare a1(add_exponent_a,add_exponent_b,add_difference,add_zero_flag,add_greater_flag,add_lesser_flag);
c_shift1 a2(add_exponent_a,add_difference,add_zero_flag,add_greater_flag,add_lesser_flag,add_fraction_a,add_fraction_b,add_combined_a,add_combined_b,new_add_exponent);
c_adder1 a3(add_sign_a,add_sign_b,add_combined_a,add_combined_b, add_sum, new_add_sign,add_greater_flag);
c_a2shift a4(add_sign_a, add_sign_b, add_sum, new_add_exponent, updated_add_exponent, updated_add_sum, add_exception1,add_exception2);
c_a2shift2 a5(add_sign_a, add_sign_b, updated_add_sum, updated_add_exponent, final_add_exponent, final_add_sum, add_exception3);
c_result a6(final_add_exponent, final_add_sum, new_add_sign, add_r,add_exception1,add_exception2,add_exception3,add_exception);

endmodule