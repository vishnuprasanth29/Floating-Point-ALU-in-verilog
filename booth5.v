module booth5(clk, reset, product1 ,combined_b, combined_negative_b, product2_o,combined_b2, combined_negative_b2,new_exponent,new_exponent2,new_sign,new_sign2,add_final_exponent, add_final_sum, add_new_sign, add_r_o,add_exception1,add_exception2,add_exception3,add_exception_o,s,s2); 

input [8:0]new_exponent;
output reg [8:0] new_exponent2;
input [24:0]combined_b, combined_negative_b;
output reg [50:0] product2_o;
input [50:0] product1;
input clk, reset;
output reg[24:0]combined_b2, combined_negative_b2;
input s;

output reg s2;

reg [51:0] product_temp3;
reg [50:0] product2,product_shift,product_temp2;

input new_sign;
output reg new_sign2;

//adder

input [24:0] add_final_sum;
input [7:0] add_final_exponent;
input add_new_sign;
input add_exception1,add_exception2,add_exception3;

output reg[31:0]add_r_o;
output reg add_exception_o;

reg[31:0]add_r;
reg add_exception;

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
	add_r_o	<= 0;
	add_exception_o <= 1'b0;
	end
	else
	begin
	add_r_o <= add_r;
	add_exception_o <= add_exception;
	end
end

always@(*)
begin
	if( (add_final_sum[22:0] != 23'b00000000000000000000000 && add_final_exponent == 8'b00000000)|| add_final_exponent == 8'b11111111 || add_exception1 == 1'b1 || add_exception2 == 1'b1 || add_exception3 == 1'b1)
	add_exception = 1'b1;
	else
	add_exception=1'b0;
end

always@(*)
begin	
	if(add_final_sum == 23'b00000000000000000000000 && add_exception==1'b0)
	begin
	add_r[31] = add_new_sign;
	add_r[30:23] = 8'b00000000;
	add_r[22:0] = add_final_sum[22:0];
	end

	else if(add_exception==1'b0)
	begin
	add_r[30:23] = add_final_exponent;
	add_r[31] = add_new_sign;
	add_r[22:0] = add_final_sum[22:0];
	end
	
	else
	begin
	add_r[30:23] = 8'b0;
	add_r[31] = 1'b0;
	add_r[22:0] = 23'b0;
	end
	
end


endmodule
