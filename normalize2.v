module normalize2(clk,reset,updated_product,updated_exponent,final_product_o,final_exponent_o,exception2_o,new_sign,new_sign2,exception1,exception12,add_r,add_exception_1,add_r2,add_exception_2,s,s2);

input [24:0] updated_product;
input [8:0] updated_exponent;
input exception1;
output reg exception12;
input s;

output reg s2;
output reg [8:0] final_exponent_o;
output reg [24:0] final_product_o;
input clk, reset;

reg [8:0] final_exponent;
reg [24:0] final_product;

output reg exception2_o;
reg exception2;

input new_sign;
output reg new_sign2;

reg [23:0]new_sum_temp;

input [31:0]add_r;
input add_exception_1;

output reg [31:0] add_r2;
output reg add_exception_2;

always@(posedge clk or negedge reset)
begin

	if(!reset)
	begin
	final_exponent_o <= 8'b0;
	final_product_o <= 25'b0;
	exception2_o <= 1'b0;
	new_sign2<= 1'b0;
	exception12 <= 1'b0;
	add_r2 <= 32'b0;
	add_exception_2 <= 1'b0;
	s2<=0;
	end

	else
	begin
   final_exponent_o <= final_exponent;
	final_product_o <= final_product;
	exception2_o <= exception2;
	new_sign2<=new_sign;
	exception12 <= exception1;
	add_r2 <= add_r;
	add_exception_2 <= add_exception_1;
	s2<=s;
	end

end


always@(*)
begin

	if((updated_exponent>=8'b11111111) || ((updated_exponent<=8'b00000000)&&(updated_product[22:0]!= 23'b0)))
	exception2 = 1'b1;
	else
	exception2 = 1'b0;

end

always@(*)
begin

	if(exception2 == 1'b0)
	begin
		if(updated_product[24:23] == 2'b01)   //if(sum[24:23] == 2'b00 || sum[24:23] == 2'b01)
		begin
			final_product = {1'b0,updated_product[23:0]};
			final_exponent = updated_exponent;
		end
		else
	 	begin
			if(updated_product[0] == 1'b0)
			begin
			final_product = {1'b0,updated_product[24:1]};
			final_exponent = updated_exponent +1'b1;
			
			end	
			else if(updated_product[0] == 1'b1)
			begin
			new_sum_temp = updated_product[24:1];
			final_product= new_sum_temp + 1'b1;
			final_exponent = updated_exponent +1'b1;
			
			end
			else
			begin
			
			final_product = 25'b0;
			final_exponent = 8'b0;
			end
		end
	end
	else
	begin
			final_product = 25'b0;
			final_exponent = 8'b0;
		end
	
end



endmodule
