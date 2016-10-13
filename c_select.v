module c_select(s,mul_r,mul_exception,add_r,add_exception,r,exception);

input s;

input [31:0]mul_r,add_r;
input mul_exception,add_exception;

output reg [31:0]r;
output reg exception;

always@(*)

begin

	if(s == 1)
	begin
	r = mul_r;
	exception <= mul_exception;
	end
	else
	begin
	r = add_r;
	exception <= add_exception;
	end

end

endmodule
