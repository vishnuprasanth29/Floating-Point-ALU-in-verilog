module c_normalize1(product, new_exponent, updated_exponent, updated_product,exception);

input [50:0] product;
input [8:0] new_exponent;

output reg [8:0] updated_exponent;
output reg [24:0] updated_product;

reg [24:0]temp_reg;
reg [23:0]new_sum_temp;

output reg exception;




always@(*)
begin
	temp_reg[24:0] = product[49:25];
end

always@(*)
begin

	if((new_exponent>=8'b11111111) || ((new_exponent<=8'b00000000) && (product[47:25]!=23'b0)))
	exception = 1'b1;
	else
	exception = 1'b0;
	

end

always@(*)
begin

	if(exception == 1'b0)
	begin
		if(temp_reg[24:23] == 2'b01)   //if(sum[24:23] == 2'b00 || sum[24:23] == 2'b01)
		begin
			updated_product = {1'b0,temp_reg[23:0]};
			updated_exponent = new_exponent;

		end
		else
	 	begin
			if(temp_reg[0] == 1'b0)
			begin
			updated_product = {1'b0,temp_reg[24:1]};
			updated_exponent = {1'b0,new_exponent} +1'b1;
			
			end	
			else if(temp_reg[0] == 1'b1)
			begin
			new_sum_temp = temp_reg[24:1];
			updated_product= new_sum_temp + 1'b1;
			updated_exponent = {1'b0,new_exponent} +1'b1;
		
			end
			else
			begin
			
			updated_product = 25'b0;
			updated_exponent = 8'b0;
			end
		end
	end
	else
			begin
			
			updated_product = 25'b0;
			updated_exponent = 8'b0;
			end
	
end



endmodule
