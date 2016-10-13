module booth(clk, reset, combined_a,combined_b, combined_negative_b, product_o,combined_b2, combined_negative_b2, new_exponent, new_exponent2,new_sign,new_sign2,add_exponent_a,add_difference,add_zero_flag,add_greater_flag,add_lesser_flag,add_fraction_a,add_fraction_b,add_combined_a_o,add_combined_b_o,new_add_exponent_o,add_sign_a2,add_sign_b2,add_sign_a3,add_sign_b3,s,s2,add_greater_flag2); 

input [8:0]new_exponent;
output reg [8:0] new_exponent2;
input [24:0]combined_a,combined_b, combined_negative_b;
output reg[50:0] product_o;
input clk, reset;
output reg[24:0]combined_b2, combined_negative_b2;
reg[50:0] product, product_temp, product_temp2;
reg [51:0] product_temp3;
input new_sign;
output reg new_sign2;

input s;

output reg s2;

output reg add_greater_flag2;

input [7:0] add_exponent_a,add_difference;
input [22:0] add_fraction_a,add_fraction_b;


input add_sign_a2,add_sign_b2;
output reg add_sign_a3,add_sign_b3;
reg [23:0] temp_add_combined_a,temp_add_combined_b;
//a_nonfraction,b_nonfraction
input add_zero_flag,add_greater_flag,add_lesser_flag;

output reg [7:0]new_add_exponent_o;
output reg [23:0]add_combined_a_o,add_combined_b_o;

reg [7:0]new_add_exponent;
reg [23:0]add_combined_a,add_combined_b;

always@(posedge clk or negedge reset)
begin

	if(!reset)
		begin
		product_o <= 50'b0;
		combined_b2 <= 25'b0;
		combined_negative_b2 <= 25'b0;
		new_exponent2 <= 8'b0;
		new_sign2<= 1'b0;
		s2 <= 0;
		end
	else
		begin
		product_o <= product;
		combined_b2 <= combined_b;
		combined_negative_b2 <= combined_negative_b;
		new_exponent2 <= new_exponent;
		new_sign2<=new_sign;
		s2 <=s;
		end

end

always@(combined_a)
begin

	product_temp = {25'b0,combined_a[24:0],1'b0};

end

always@(*)
begin

	if(product_temp[1:0] == 2'b00)
		product = product_temp;
	else if(product_temp[1:0] == 2'b10)
	begin
		product_temp2 = {combined_negative_b, 26'b0};
		product_temp3 = product_temp + product_temp2;
		product = product_temp3[50:0];
	end
	else
	product = 50'b0;
end

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
	new_add_exponent_o <= 1'b0;
	add_combined_a_o <= 24'b000000000000000000000000;
	add_combined_b_o <= 24'b000000000000000000000000;
	add_sign_a3 <= 1'b0;
	add_sign_b3 <= 1'b0;
	add_greater_flag2 <= 1'b0;
	end
	else
	begin
	new_add_exponent_o <= new_add_exponent;
	add_combined_a_o <= add_combined_a;
	add_combined_b_o <= add_combined_b;
	add_sign_a3 <= add_sign_a2;
	add_sign_b3 <= add_sign_b2;
	add_greater_flag2 <= add_greater_flag;
	end
end

always@(*)
begin
	if(add_zero_flag == 1 && add_greater_flag == 0 && add_lesser_flag == 0)
	begin
	 new_add_exponent = add_exponent_a;
	 add_combined_a = {1'b1,add_fraction_a[22:0]};
	 add_combined_b = {1'b1,add_fraction_b[22:0]};

	end
	else if(add_zero_flag == 0 && add_greater_flag == 1 && add_lesser_flag == 0)
	begin
 	
	 add_combined_a = {1'b1,add_fraction_a[22:0]};
	 temp_add_combined_b = {1'b1,add_fraction_b[22:0]}; 	
	 add_combined_b = temp_add_combined_b>>add_difference;
	 new_add_exponent = add_exponent_a;
	 
	end
	else if(add_zero_flag == 0 && add_greater_flag == 0 && add_lesser_flag == 1)
	begin

	 add_combined_b = {1'b1,add_fraction_b[22:0]};
	 temp_add_combined_a = {1'b1,add_fraction_a[22:0]}; 	
	 add_combined_a = temp_add_combined_a>>add_difference;
	 new_add_exponent = add_exponent_a + add_difference;
	 end
	 
	 else
	 begin
	 add_combined_b = 24'b0;
	 add_combined_a = 24'b0;
	 new_add_exponent = 8'b0;
	end
end



endmodule
