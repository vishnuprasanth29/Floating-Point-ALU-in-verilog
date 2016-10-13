module normalize1(clk,reset,product, new_exponent, updated_exponent_o, updated_product_o,exception_o,new_sign,new_sign2,add_r,add_exception_1,add_r2,add_exception_2,s,s2);

input [50:0] product;
input [8:0] new_exponent;
input s;

output reg s2;
output reg [8:0] updated_exponent_o;
output reg [24:0] updated_product_o;
input clk, reset;

reg [8:0] updated_exponent;
reg [24:0] updated_product;
reg exception;

reg [24:0]temp_reg;
reg [23:0]new_sum_temp;

input new_sign;
output reg new_sign2;

output reg exception_o;

input [31:0]add_r;
input add_exception_1;

output reg [31:0] add_r2;
output reg add_exception_2;

always@(posedge clk or negedge reset)
begin

	if(!reset)
	begin
	updated_exponent_o <= 8'b0;
	updated_product_o <= 25'b0;
	exception_o <= 1'b0;
	new_sign2<= 1'b0;
	add_r2 <= 32'b0;
	add_exception_2 <= 1'b0;
	s2 <=0;
	end

	else
	begin
   updated_exponent_o <= updated_exponent;
	updated_product_o <= updated_product;
	exception_o <= exception;
	new_sign2<=new_sign;
	add_r2 <= add_r;
	add_exception_2 <= add_exception_1;
	s2<=s;
	end

end

always@(*)
begin
	temp_reg[24:0] = product[49:25];
end

always@(*)
begin

	if((new_exponent>=8'b11111111) || ((new_exponent<=8'b00000000)&& (product[47:25]!= 23'b0)))
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
			updated_exponent = {1'b0,new_exponent};

		end
		else
	 	begin
			if(temp_reg[0] == 1'b0)
			begin
			updated_product = {1'b0,temp_reg[24:1]};
			updated_exponent = {1'b0,new_exponent} + 1'b1;
			
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
