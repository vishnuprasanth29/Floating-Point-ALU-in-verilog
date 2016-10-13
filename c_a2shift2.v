module c_a2shift2(sign_a, sign_b, updated_sum, updated_exponent, final_exponent, final_sum, exception3);


input [24:0]updated_sum;
input [7:0]updated_exponent;
input sign_a,sign_b;

output reg exception3;
output reg [24:0] final_sum;
output reg [7:0] final_exponent;

reg [23:0]updated_sum_temp;

always@(*)
begin
	if(sign_a == 1'b1 && sign_b == 1'b1)
	begin
	if(((updated_sum[22:0] != 23'b0 )&&(updated_exponent == 8'b0)) || (updated_exponent == 8'b11111111) ) 
	exception3 = 1'b1;
	else
	exception3 = 1'b0;
	end
	
	else if(sign_a == 1'b0 && sign_b == 1'b0)
	begin
	if(((updated_sum[22:0] != 23'b0 )&&(updated_exponent == 8'b0)) || (updated_exponent == 8'b11111111) ) 
	exception3 = 1'b1;
	else
	exception3 = 1'b0;
	end
	
	
	else if(sign_a == 1'b1 && sign_b == 1'b0)
	begin
	exception3 = 1'b0;
	end
	
	else if(sign_a == 1'b0 && sign_b == 1'b1)
	begin
	exception3 = 1'b0;
	end
	

end

always@(*)
begin


	if(exception3 == 1'b0)
	begin
	
		if((sign_a == 1'b1 && sign_b == 1'b1) || (sign_a == 1'b0 && sign_b == 1'b0))
		begin
	
		if(updated_sum[24:23] == 2'b01)   //if(sum[24:23] == 2'b00 || sum[24:23] == 2'b01)
		begin
			final_sum = {1'b0,updated_sum[23:0]};
			final_exponent = updated_exponent;
		end
		else
	 	begin
			if(updated_sum[0] == 1'b0)
			begin
			final_sum = {1'b0,updated_sum[24:1]};
			final_exponent = updated_exponent +1'b1;
			end	
			else if(updated_sum[0] == 1'b1)
			begin
			//updated_sum_temp = updated_sum[24:1];
			final_sum= updated_sum[24:1] + 1'b1;
			final_exponent = updated_exponent +1'b1;
			end
			else
			begin
			//updated_sum_temp = updated_sum[24:1];
			final_sum= 25'b0;
			final_exponent = 8'b0;
			end
		end
		end
		
		

		else if(sign_a == 1'b0 && sign_b == 1'b1)
		begin
		
		final_sum = updated_sum;
		final_exponent = updated_exponent;
		end

		else if(sign_a == 1'b1 && sign_b == 1'b0)
		begin
		
		final_sum = updated_sum;
		final_exponent = updated_exponent;
		end

		

end
end

endmodule