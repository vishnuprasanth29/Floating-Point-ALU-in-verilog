module booth3(clk, reset, product1 ,combined_b, combined_negative_b, product2_o,combined_b2, combined_negative_b2,new_exponent,new_exponent2,new_sign,new_sign2,add_sign_a, add_sign_b, add_sum, add_new_exponent, add_updated_exponent_o, add_updated_add_sum_o, add_exception1_o,add_exception2_o,add_new_sign,add_new_sign2,add_sign_a5,add_sign_b5,s,s2); 

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

input [24:0]add_sum;
input [7:0]add_new_exponent;
input add_sign_a,add_sign_b,add_new_sign;


output reg add_new_sign2;
output reg add_exception1_o,add_exception2_o;
output reg [24:0] add_updated_add_sum_o;
output reg [7:0] add_updated_exponent_o;
output reg add_sign_a5,add_sign_b5;

reg add_exception1,add_exception2;
reg [24:0] add_updated_add_sum;
reg [7:0] add_updated_exponent;

reg [23:0]add_new_add_sum_temp;

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
	add_updated_add_sum_o <= 25'b0000000000000000000000000;
	add_updated_exponent_o <=  8'b00000000;
	add_exception1_o <= 1'b0;
	add_exception2_o <= 1'b0;
	add_new_sign2 <= 8'b0;
	add_sign_a5 <= 1'b0;
	add_sign_b5 <= 1'b0;
	end
	else
	begin
	add_updated_add_sum_o <= add_updated_add_sum;
	add_updated_exponent_o <= add_updated_exponent;
	add_exception1_o <= add_exception1;
	add_exception2_o <= add_exception2;
	add_new_sign2 <= add_new_sign;
	add_sign_a5 <= add_sign_a;
	add_sign_b5 <= add_sign_b;
	end
end


always@(*)
begin
	if(add_sign_a == 1'b1 && add_sign_b == 1'b1)
	begin
	if(add_new_exponent == 8'b00000000 ||add_new_exponent == 8'b11111111)
	add_exception1 = 1'b1;
	else
	add_exception1 = 1'b0;
	end
	
	else if(add_sign_a == 1'b0 && add_sign_b == 1'b0)
	begin
	if(add_new_exponent == 8'b00000000 ||add_new_exponent == 8'b11111111)
	add_exception1 = 1'b1;
	else
	add_exception1 = 1'b0;
	end
	
	
	else if(add_sign_a == 1'b1 && add_sign_b == 1'b0)
	begin
	add_exception1= 1'b0;
	end
	
	else if(add_sign_a == 1'b0 && add_sign_b == 1'b1)
	begin
	add_exception1 = 1'b0;
	end

	

	else


	add_exception1 = 1'b1;
	

end

always@(*)
begin

	
	
		if((add_sign_a == 1'b1 && add_sign_b == 1'b1) || (add_sign_a == 1'b0 && add_sign_b == 1'b0))
		begin
	
		if(add_sum[24:23] == 2'b01)   //if(add_sum[24:23] == 2'b00 || add_sum[24:23] == 2'b01)
		begin
			add_updated_add_sum = {1'b0,add_sum[23:0]};
			add_updated_exponent = add_new_exponent;
			add_exception2 = 1'b0;
		end
		else
	 	begin
			if(add_sum[0] == 1'b0)
			begin
			add_updated_add_sum = {1'b0,add_sum[24:1]};
			add_updated_exponent = add_new_exponent +1'b1;
			add_exception2 = 1'b0;
			end	
			else if(add_sum[0] == 1'b1)
			begin
			add_new_add_sum_temp = add_sum[24:1];
			add_updated_add_sum= add_new_add_sum_temp + 1'b1;
			add_updated_exponent = add_new_exponent +1'b1;
			add_exception2 = 1'b0;
			end
			else
			begin
			add_exception2 = 1'b1;
			add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
		end
		end
		
		

		else if((add_sign_a == 1'b0 && add_sign_b == 1'b1) || (add_sign_a == 1'b1 && add_sign_b == 1'b0))
		begin
			
			if(add_sum[23] == 1'b1)
			begin
			add_updated_add_sum = {1'b0,add_sum[23:0]};
			add_updated_exponent = add_new_exponent;
			add_exception2 = 1'b0;
			end
			
			else if(add_sum[22:0] == 23'b0)
			begin
				add_updated_add_sum = {2'b00,add_sum[22:0]};
				add_updated_exponent= 8'b00000000;
				add_exception2 = 1'b0;

			end

			else if(add_sum[22] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000000)
				begin
				add_updated_add_sum = {1'b0,add_sum[22:0],1'b0};
				add_updated_exponent = add_new_exponent-1'b1;
				add_exception2 = 1'b0;
				end
				else
				begin
				add_exception2 = 1'b1;	
					add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
				end
			end	

					
			
			else if(add_sum[21] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000001)
				begin
				add_updated_add_sum = {1'b0,add_sum[21:0],2'b00};
				add_updated_exponent = add_new_exponent-2'b10;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end	
			
			else if(add_sum[20] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000010)
				begin
				add_updated_add_sum = {1'b0,add_sum[20:0],3'b000};
				add_updated_exponent = add_new_exponent-2'b11;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[19] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000011)
				begin
				add_updated_add_sum = {1'b0,add_sum[19:0],4'b0000};
				add_updated_exponent = add_new_exponent-3'b100;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end				
			end
			
			else if(add_sum[18] == 1'b1)  
			begin
				if(add_new_exponent>8'b00000100)
				begin
				add_updated_add_sum = {1'b0,add_sum[18:0],5'b00000};
				add_updated_exponent = add_new_exponent-3'b101;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[17] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000101)
				begin
				add_updated_add_sum = {1'b0,add_sum[17:0],6'b000000};
				add_updated_exponent = add_new_exponent-3'b110;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[16] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000110)
				begin
				add_updated_add_sum = {1'b0,add_sum[20:0],7'b0000000};
				add_updated_exponent = add_new_exponent-3'b111;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[15] == 1'b1) 
			begin
				if(add_new_exponent>8'b00000111)
				begin
				add_updated_add_sum = {1'b0,add_sum[15:0],8'b00000000};
				add_updated_exponent = add_new_exponent-4'b1000;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[14] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001000)
				begin
				add_updated_add_sum = {1'b0,add_sum[14:0],9'b000000000};
				add_updated_exponent = add_new_exponent-4'b1001;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[13] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001001)
				begin
				add_updated_add_sum = {1'b0,add_sum[13:0],10'b0000000000};
				add_updated_exponent = add_new_exponent-4'b1010;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[12] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001010)
				begin
				add_updated_add_sum = {1'b0,add_sum[12:0],11'b00000000000};
				add_updated_exponent = add_new_exponent-4'b1011;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[11] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001011)
				begin
				add_updated_add_sum = {1'b0,add_sum[11:0],12'b000000000000};
				add_updated_exponent = add_new_exponent-4'b1100;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[10] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001100)
				begin
				add_updated_add_sum = {1'b0,add_sum[10:0],13'b0000000000000};
				add_updated_exponent = add_new_exponent-4'b1101;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[9] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001101)
				begin
				add_updated_add_sum = {1'b0,add_sum[9:0],14'b00000000000000};
				add_updated_exponent = add_new_exponent-4'b1110;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[8] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001110)
				begin
				add_updated_add_sum = {1'b0,add_sum[8:0],15'b000000000000000};
				add_updated_exponent = add_new_exponent-4'b1111;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[7] == 1'b1) 
			begin
				if(add_new_exponent>8'b00001111)
				begin
				add_updated_add_sum = {1'b0,add_sum[7:0],16'b0000000000000000};
				add_updated_exponent = add_new_exponent-5'b10000;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[6] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010000)
				begin
				add_updated_add_sum = {1'b0,add_sum[6:0],17'b00000000000000000};
				add_updated_exponent = add_new_exponent-5'b10001;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else if(add_sum[5] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010001)
				begin
				add_updated_add_sum = {1'b0,add_sum[5:0],18'b000000000000000000};
				add_updated_exponent = add_new_exponent-5'b10010;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end

			else if(add_sum[4] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010010)
				begin
				add_updated_add_sum = {1'b0,add_sum[4:0],19'b0000000000000000000};
				add_updated_exponent = add_new_exponent-5'b10011;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end

			else if(add_sum[3] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010011)
				begin
				add_updated_add_sum = {1'b0,add_sum[3:0],20'b00000000000000000000};
				add_updated_exponent = add_new_exponent-5'b10100;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end

			else if(add_sum[2] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010100)
				begin 
				add_updated_add_sum = {1'b0,add_sum[2:0],21'b000000000000000000000};
				add_updated_exponent = add_new_exponent-5'b10101;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end

			else if(add_sum[1] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010100)
				begin
				add_updated_add_sum = {1'b0,add_sum[1:0],22'b0000000000000000000000};
				add_updated_exponent = add_new_exponent-5'b10110;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end

			else if(add_sum[0] == 1'b1) 
			begin
				if(add_new_exponent>8'b00010101)
				begin
				add_updated_add_sum = {1'b0,add_sum[0],23'b00000000000000000000000};
				add_updated_exponent = add_new_exponent-5'b10111;
				add_exception2 = 1'b0;
				end
				else
				begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
			end
			
			else
			begin
			add_exception2 = 1'b1;
				add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
			end
	end

	

		else
		begin
		add_exception2 = 1'b0;
			add_updated_add_sum = 25'b0;
			add_updated_exponent = 8'b0;
		end


	

end

endmodule
