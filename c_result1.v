module c_result1(final_exponent, final_product, new_sign, r,exception1,exception2,exception);

input [24:0] final_product;
input [8:0] final_exponent;
input new_sign;
input exception1,exception2;


output reg[31:0]r;
output reg exception;

always@(*)
begin

	if((final_product[22:0]!=23'b0 && final_exponent == 8'b0) ||final_exponent == 8'b11111111 ||exception1 == 1'b1 || exception2 == 1'b1)
	exception = 1'b1;
	else
	exception=1'b0;
end

always@(*)
begin	
	if(final_product == 23'b00000000000000000000000 && exception==1'b0)
	begin
	r[31] = new_sign;
	r[30:23] = 8'b00000000;
	r[22:0] = final_product[22:0];
	end

	else if(exception==1'b0)
	begin
	r[30:23] = final_exponent[7:0];
	r[31] = new_sign;
	r[22:0] = final_product[22:0];
	end
	
	else
	begin
	r[30:23] = 8'b0;
	r[31] = 1'b0;
	r[22:0] = 23'b0;
	end
	
end

endmodule

