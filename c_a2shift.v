module c_a2shift(sign_a, sign_b, sum, new_exponent, updated_exponent, updated_sum, exception1,exception2);

input [24:0]sum;
input [7:0]new_exponent;
input sign_a,sign_b;

output reg exception1,exception2;
output reg [24:0] updated_sum;
output reg [7:0] updated_exponent;

reg [23:0]new_sum_temp;

always@(*)
begin
	if(sign_a == 1'b1 && sign_b == 1'b1)
	begin
	if( (new_exponent == 8'b0) ||(new_exponent == 8'b11111111) )
	exception1 = 1'b1;
	else
	exception1 = 1'b0;
	end
	
	else if(sign_a == 1'b0 && sign_b == 1'b0)
	begin
	if( (new_exponent == 8'b0)|| (new_exponent == 8'b11111111) )
	exception1 = 1'b1;
	else
	exception1 = 1'b0;
	end
	
	
	else if(sign_a == 1'b1 && sign_b == 1'b0)
	begin
	exception1= 1'b0;
	end
	
	else if(sign_a == 1'b0 && sign_b == 1'b1)
	begin
	exception1 = 1'b0;
	end
	

end

always@(*)
begin

	if(exception1 == 1'b0)
	begin
	
		if((sign_a == 1'b1 && sign_b == 1'b1) || (sign_a == 1'b0 && sign_b == 1'b0))
		begin
	
		if(sum[24:23] == 2'b01)   //if(sum[24:23] == 2'b00 || sum[24:23] == 2'b01)
		begin
			updated_sum = {1'b0,sum[23:0]};
			updated_exponent = new_exponent;
			exception2 = 1'b0;
		end
		else
	 	begin
			if(sum[0] == 1'b0)
			begin
			updated_sum = {1'b0,sum[24:1]};
			updated_exponent = new_exponent +1'b1;
			exception2 = 1'b0;
			end	
			else if(sum[0] == 1'b1)
			begin
			new_sum_temp = sum[24:1];
			updated_sum= new_sum_temp + 1'b1;
			updated_exponent = new_exponent +1'b1;
			exception2 = 1'b0;
			end
			else
			begin
			
			updated_sum= 25'b0;
			updated_exponent = 8'b0;
			exception2 = 1'b1;
			end
		end
		end
		
		

		else if((sign_a == 1'b0 && sign_b == 1'b1) || (sign_a == 1'b1 && sign_b == 1'b0))
		begin
			
			if(sum[23] == 1'b1)
			begin
			updated_sum = {1'b0,sum[23:0]};
			updated_exponent = new_exponent;
			exception2 = 1'b0;
			end
			
			else if(sum[22:0] == 23'b0)
			begin
				updated_sum = {2'b00,sum[22:0]};
				updated_exponent= 8'b00000000;
				exception2 = 1'b0;

			end

			else if(sum[22] == 1'b1) 
			begin
				if(new_exponent>8'b00000000)
				begin
				updated_sum = {1'b0,sum[22:0],1'b0};
				updated_exponent = new_exponent-1'b1;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;	
			end	

					
			
			else if(sum[21] == 1'b1) 
			begin
				if(new_exponent>8'b00000001)
				begin
				updated_sum = {1'b0,sum[21:0],2'b00};
				updated_exponent = new_exponent-2'b10;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end	
			
			else if(sum[20] == 1'b1) 
			begin
				if(new_exponent>8'b00000010)
				begin
				updated_sum = {1'b0,sum[20:0],3'b000};
				updated_exponent = new_exponent-2'b11;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[19] == 1'b1) 
			begin
				if(new_exponent>8'b00000011)
				begin
				updated_sum = {1'b0,sum[19:0],4'b0000};
				updated_exponent = new_exponent-3'b100;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;				
			end
			
			else if(sum[18] == 1'b1)  
			begin
				if(new_exponent>8'b00000100)
				begin
				updated_sum = {1'b0,sum[18:0],5'b00000};
				updated_exponent = new_exponent-3'b101;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[17] == 1'b1) 
			begin
				if(new_exponent>8'b00000101)
				begin
				updated_sum = {1'b0,sum[17:0],6'b000000};
				updated_exponent = new_exponent-3'b110;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[16] == 1'b1) 
			begin
				if(new_exponent>8'b00000110)
				begin
				updated_sum = {1'b0,sum[20:0],7'b0000000};
				updated_exponent = new_exponent-3'b111;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[15] == 1'b1) 
			begin
				if(new_exponent>8'b00000111)
				begin
				updated_sum = {1'b0,sum[15:0],8'b00000000};
				updated_exponent = new_exponent-4'b1000;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[14] == 1'b1) 
			begin
				if(new_exponent>8'b00001000)
				begin
				updated_sum = {1'b0,sum[14:0],9'b000000000};
				updated_exponent = new_exponent-4'b1001;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[13] == 1'b1) 
			begin
				if(new_exponent>8'b00001001)
				begin
				updated_sum = {1'b0,sum[13:0],10'b0000000000};
				updated_exponent = new_exponent-4'b1010;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[12] == 1'b1) 
			begin
				if(new_exponent>8'b00001010)
				begin
				updated_sum = {1'b0,sum[12:0],11'b00000000000};
				updated_exponent = new_exponent-4'b1011;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[11] == 1'b1) 
			begin
				if(new_exponent>8'b00001011)
				begin
				updated_sum = {1'b0,sum[11:0],12'b000000000000};
				updated_exponent = new_exponent-4'b1100;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[10] == 1'b1) 
			begin
				if(new_exponent>8'b00001100)
				begin
				updated_sum = {1'b0,sum[10:0],13'b0000000000000};
				updated_exponent = new_exponent-4'b1101;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[9] == 1'b1) 
			begin
				if(new_exponent>8'b00001101)
				begin
				updated_sum = {1'b0,sum[9:0],14'b00000000000000};
				updated_exponent = new_exponent-4'b1110;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[8] == 1'b1) 
			begin
				if(new_exponent>8'b00001110)
				begin
				updated_sum = {1'b0,sum[8:0],15'b000000000000000};
				updated_exponent = new_exponent-4'b1111;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[7] == 1'b1) 
			begin
				if(new_exponent>8'b00001111)
				begin
				updated_sum = {1'b0,sum[7:0],16'b0000000000000000};
				updated_exponent = new_exponent-5'b10000;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[6] == 1'b1) 
			begin
				if(new_exponent>8'b00010000)
				begin
				updated_sum = {1'b0,sum[6:0],17'b00000000000000000};
				updated_exponent = new_exponent-5'b10001;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else if(sum[5] == 1'b1) 
			begin
				if(new_exponent>8'b00010001)
				begin
				updated_sum = {1'b0,sum[5:0],18'b000000000000000000};
				updated_exponent = new_exponent-5'b10010;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end

			else if(sum[4] == 1'b1) 
			begin
				if(new_exponent>8'b00010010)
				begin
				updated_sum = {1'b0,sum[4:0],19'b0000000000000000000};
				updated_exponent = new_exponent-5'b10011;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end

			else if(sum[3] == 1'b1) 
			begin
				if(new_exponent>8'b00010011)
				begin
				updated_sum = {1'b0,sum[3:0],20'b00000000000000000000};
				updated_exponent = new_exponent-5'b10100;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end

			else if(sum[2] == 1'b1) 
			begin
				if(new_exponent>8'b00010100)
				begin 
				updated_sum = {1'b0,sum[2:0],21'b000000000000000000000};
				updated_exponent = new_exponent-5'b10101;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end

			else if(sum[1] == 1'b1) 
			begin
				if(new_exponent>8'b00010100)
				begin
				updated_sum = {1'b0,sum[1:0],22'b0000000000000000000000};
				updated_exponent = new_exponent-5'b10110;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end

			else if(sum[0] == 1'b1) 
			begin
				if(new_exponent>8'b00010101)
				begin
				updated_sum = {1'b0,sum[0],23'b00000000000000000000000};
				updated_exponent = new_exponent-5'b10111;
				exception2 = 1'b0;
				end
				else
				exception2 = 1'b1;
			end
			
			else
			exception2 = 1'b1;
	end

	
		
		

end
end
endmodule





