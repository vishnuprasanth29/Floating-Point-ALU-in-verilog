module c_split(clk,reset,a,b,exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b);

input [31:0]a,b;
input clk,reset;

output reg[7:0]exponent_a,exponent_b;
output reg[22:0] fraction_a,fraction_b;
output reg sign_a,sign_b;

always@(posedge clk or negedge reset)
begin

if(!reset)
begin
 exponent_a <= 8'b00000000;
 exponent_b <= 8'b00000000;
 fraction_a <= 23'b00000000000000000000000;
 fraction_b <= 23'b00000000000000000000000;
 sign_a <= 1'b0;
 sign_b <= 1'b0;

end
else
begin
 exponent_a <= a[30:23];
 exponent_b <= b[30:23];
 fraction_a <= a[22:0];
 fraction_b <= b[22:0];
 sign_a <= a[31];
 sign_b <= b[31];
end
end

endmodule