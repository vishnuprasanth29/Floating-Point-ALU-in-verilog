`include "c_topm.v"
`include "c_topa.v"
`include "c_select.v"

module c_toptest(a,b,s,clk,reset,r,exception);

input [31:0] a,b;
input clk,reset,s;

output [31:0]r;
output exception;

wire [31:0]mul_r,add_r;
wire mul_exception,add_exception;

c_topm m1(a,b,clk,reset,mul_r,mul_exception);
c_topa a1(a,b,clk,reset,add_r,add_exception);
c_select s1(s,mul_r,mul_exception,add_r,add_exception,r,exception);

endmodule

