module booth4(clk, reset, product1 ,combined_b, combined_negative_b, product2_o,combined_b2, combined_negative_b2,new_exponent,new_exponent2,new_sign,new_sign2,add_sign_a, add_sign_b, add_updated_sum, add_updated_exponent, add_final_exponent_o, add_final_sum_o, add_exception3_o, add_new_sign2, add_new_sign3,add_exception1,add_exception2,add_exception12,add_exception22,s,s2); 

input [8:0]new_exponent;
output reg [8:0] new_exponent2;
input [24:0]combined_b, combined_negative_b;
output reg [50:0] product2_o;
input [50:0] product1;
output reg[24:0]combined_b2, combined_negative_b2;
input s;

output reg s2;

reg [51:0] product_temp3;
reg [50:0] product2,product_shift,product_temp2;

input new_sign;
output reg new_sign2;

//adder

input [24:0]add_updated_sum;
input [7:0]add_updated_exponent;
input add_sign_a,add_sign_b;
input clk,reset;
input add_new_sign2;
input add_exception1,add_exception2;

output reg add_exception12,add_exception22;
output reg add_new_sign3;
output reg add_exception3_o;
output reg [24:0] add_final_sum_o;
output reg [7:0] add_final_exponent_o;

reg add_exception3;
reg [24:0] add_final_sum;
reg [7:0] add_final_exponent;

reg [23:0]add_updated_sum_temp;

always@(posedge clk or negedge reset)
begin
	if(!reset)
		begin
		product2_o <= 50'b0;
		combined_b2 <= 25'b0;
		combined_negative_b2 <= 25'b0;
		new_exponent2 <= 8'b0;
		new_sign2<= 1'b0;
		s2<=0;
		end
	else
		begin
		product2_o <= product2;
		combined_b2 <= combined_b;
		combined_negative_b2 <= combined_negative_b;
		new_exponent2 <= new_exponent;
		new_sign2<=new_sign;
		s2 <=s;
		end
end

always@(*)
begin
	
	if(product1[50] == 1'b1)
   product_shift[50:0]= {1'b1, product1[50:1]};
	else if(product1[50] == 1'b0)
	product_shift[50:0] = {1'b0, product1[50:1]};
	else
	product_shift[50:0] = 50'b0;
	
end

 always@(*)
begin

 case(product_shift[1:0])
 
 
 
 2'b00: begin
	
	product2 = product_shift;
	product_temp2 =  50'b0;
		product_temp3 = 52'b0;
	end
	
	2'b01:  begin
		
		product_temp2 = {combined_b, 26'b0};
		product_temp3 = product_shift + product_temp2;
		product2 = product_temp3[50:0];
		end
		
	2'b10: 	begin

		product_temp2 = {combined_negative_b, 26'b0};
		product_temp3 = product_shift + product_temp2;
		product2 = product_temp3[50:0];
		end
		
		2'b11: begin
	
	product2 = product_shift;
	product_temp2 =  50'b0;
		product_temp3 = 52'b0;
	end
	
	endcase
	

end

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
	add_exception3_o <= 1'b0;
	add_final_sum_o <= 25'b0000000000000000000000000;
	add_final_exponent_o <= 8'b00000000;
	add_new_sign3 <= 1'b0;
	add_exception12<= 8'b0;
	add_exception22<= 8'b0;
	end
	else
	begin
	add_exception3_o <= add_exception3;
	add_final_sum_o <= add_final_sum;
	add_final_exponent_o <= add_final_exponent;
	add_new_sign3 <= add_new_sign2;
	add_exception12<= add_exception1;
	add_exception22<= add_exception2;
	end
end


always@(*)
begin
	if(add_sign_a == 1'b1 && add_sign_b == 1'b1)
	begin
	if((add_updated_exponent == 8'b00000000)&&(add_updated_sum[22:0]!=23'b0) ||(add_updated_exponent == 8'b11111111) )
	add_exception3 = 1'b1;
	else
	add_exception3 = 1'b0;
	end
	
	else if(add_sign_a == 1'b0 && add_sign_b == 1'b0)
	begin
	if((add_updated_exponent == 8'b00000000)&&(add_updated_sum[22:0]!=23'b0) ||(add_updated_exponent == 8'b11111111) )
	add_exception3 = 1'b1;
	else
	add_exception3 = 1'b0;
	end
	
	
	else if(add_sign_a == 1'b1 && add_sign_b == 1'b0)
	begin
	add_exception3 = 1'b0;
	end
	
	else if(add_sign_a == 1'b0 && add_sign_b == 1'b1)
	begin
	add_exception3 = 1'b0;
	end

	else
	add_exception3 = 1'b0;
	

end

always@(*)
begin

		
		if((add_sign_a == 1'b0 && add_sign_b == 1'b0) || (add_sign_a == 1'b1 && add_sign_b == 1'b1))
		begin
	
		if(add_updated_sum[24:23] == 2'b01)
		begin
			add_final_sum = {1'b0,add_updated_sum[23:0]};
			add_final_exponent = add_updated_exponent;
		end
		else
	 	begin
			if(add_updated_sum[0] == 1'b0)
			begin
			add_final_sum = {1'b0,add_updated_sum[24:1]};
			add_final_exponent = add_updated_exponent +1'b1;
			end	
			else if(add_updated_sum[0] == 1'b1)
			begin
			//add_updated_sum_temp = add_updated_sum[24:1];
			add_final_sum= add_updated_sum[24:1] + 1'b1;
			add_final_exponent = add_updated_exponent +1'b1;
			end
			else
			begin
			add_final_sum = 25'b0;
			add_final_exponent = 8'b0;
			end
		end
		end

		else if(add_sign_a == 1'b0 && add_sign_b == 1'b1)
		begin
		
		add_final_sum = add_updated_sum;
		add_final_exponent = add_updated_exponent;
		end

		else if(add_sign_a == 1'b1 && add_sign_b == 1'b0)
		begin
		
		add_final_sum = add_updated_sum;
		add_final_exponent = add_updated_exponent;
		end

		else
		begin
		add_final_sum = 25'b0;
		add_final_exponent = 8'b0;
		end

	
end

endmodule
