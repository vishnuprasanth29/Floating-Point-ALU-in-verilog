module c_normalize2(updated_product,updated_exponent,final_product,final_exponent,exception2);

input [24:0] updated_product;
input [8:0] updated_exponent;

output reg [8:0] final_exponent;
output reg [24:0] final_product;


output reg exception2;
//reg exception2;

reg [23:0]new_sum_temp;



always@(*)
begin
	if((updated_exponent>=8'b11111111) || ((updated_exponent<=8'b00000000) && (updated_product[22:0]!=23'b0)))
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
