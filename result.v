
module result(clk,reset,final_exponent, final_product, new_sign, r_o,exception1,exception2,exception_o,add_r,add_exception_1,s);

input [24:0] final_product;
input [8:0] final_exponent;
input new_sign;
input exception1,exception2;
input clk,reset,s;

output reg[31:0]r_o;
output reg exception_o;

reg[31:0]r;
reg exception;

input [31:0]add_r;
input add_exception_1;

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
	r_o	<= 23'b00000000000000000000000;
	exception_o <= 1'b0;
	end
	else
	begin
	r_o <= r;
	exception_o <= exception;
	end
end

always@(*)
begin
	if(s == 1)
	begin
	if( (final_product[22:0] != 23'b00000000000000000000000 && final_exponent == 8'b00000000)|| final_exponent == 8'b11111111 || exception1 == 1'b1 || exception2 == 1'b1)
	exception = 1'b1;
	else
	exception=1'b0;
	end
	else if(s == 0)
	begin
	if(add_exception_1 == 1'b1)
	exception = 1'b1;
	else
	exception=1'b0;
	end
	else
	exception=1'b0;
	end

always@(*)
begin	
	if(s == 1)
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
	else
	r = add_r;
	
end

endmodule


