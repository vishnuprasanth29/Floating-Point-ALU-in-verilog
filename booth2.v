module booth2(clk, reset, product1 ,combined_b, combined_negative_b, product2_o,combined_b2, combined_negative_b2,new_exponent,new_exponent2,new_sign,new_sign2,add_sign_a,add_sign_b, add_new_a, add_new_b, add_sum_o, add_new_add_sign_o,add_sign_a3,add_sign_b3,add_new_exponent,add_new_exponent2,s,s2,add_greater_flag2); 

input [8:0]new_exponent;
output reg [8:0] new_exponent2;
input [24:0]combined_b, combined_negative_b;
output reg [50:0] product2_o;
input [50:0] product1;
input clk, reset;
output reg[24:0]combined_b2, combined_negative_b2;
input s;

output reg s2;
input add_greater_flag2;
reg [51:0] product_temp3;
reg [50:0] product2,product_shift,product_temp2;

input new_sign;
output reg new_sign2;

//adder

input [23:0]add_new_a,add_new_b;
input add_sign_a,add_sign_b;
input [7:0]add_new_exponent;

output reg [7:0] add_new_exponent2;

reg [24:0]add_temp1,add_temp_r2,add_new_b_copy,add_new_a_copy,add_temp4;
reg [23:0]add_temp3,add_temp_r;
reg [25:0]add_temp2;
output reg add_sign_a3,add_sign_b3;
output reg add_new_add_sign_o;
output reg [24:0]add_sum_o;

reg add_new_sign;
reg [24:0]add_sum;

always@(posedge clk or negedge reset)
begin
	if(!reset)
		begin
		product2_o <= 50'b0;
		combined_b2 <= 25'b0;
		combined_negative_b2 <= 25'b0;
		new_exponent2 <= 8'b0;
		new_sign2<= 1'b0;
		s2 <= 0;
		end
	else
		begin
		product2_o <= product2;
		combined_b2 <= combined_b;
		combined_negative_b2 <= combined_negative_b;
		new_exponent2 <= new_exponent;
		new_sign2<=new_sign;
		s2 <= s;
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
	add_new_add_sign_o <= 1'b0;
	add_sum_o <= 25'b0000000000000000000000000;
	add_sign_a3 <= 1'b0;
	add_sign_b3 <= 1'b0;
	add_new_exponent2 <= 8'b0;
	end
	else
	begin
	add_new_add_sign_o <= add_new_sign;
	add_sum_o <= add_sum;
	add_sign_a3 <= add_sign_a;
	add_sign_b3 <= add_sign_b;
	add_new_exponent2 <= add_new_exponent;
	end
end

	
always@(*)
begin
	if(add_sign_a == 1'b1 && add_sign_b == 1'b1)
	begin
	add_sum = add_new_a + add_new_b;
	add_new_sign = 1'b1;
	end

	else if(add_sign_a == 1'b0 && add_sign_b == 1'b0)
	begin
	add_sum = add_new_a + add_new_b;
	add_new_sign = 1'b0;
	end
	
	else if(((add_sign_a == 1'b1 && add_sign_b == 1'b0)||(add_sign_a == 1'b0 && add_sign_b == 1'b1)) && (add_new_a > add_new_b))
	begin
	add_sum = add_new_a - add_new_b;
	if(add_greater_flag2 == 1'b1)
	add_new_sign = add_sign_a;
	else
	add_new_sign = add_sign_b;
	end
	else
	begin
	add_sum = add_new_b - add_new_a;
	if(add_greater_flag2 == 1'b1)
	add_new_sign = add_sign_a;
	else
	add_new_sign = add_sign_b;
	end

end

endmodule
