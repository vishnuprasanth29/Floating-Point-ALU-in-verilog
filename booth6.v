module booth6(clk, reset, product1 ,combined_b, combined_negative_b, product2_o,combined_b2, combined_negative_b2,new_exponent,new_exponent2,new_sign,new_sign2,add_r,add_exception_1,add_r2,add_exception_2,s,s2); 

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

input [31:0]add_r;
input add_exception_1;

output reg [31:0] add_r2;
output reg add_exception_2;


always@(posedge clk or negedge reset)
begin
	if(!reset)
		begin
		product2_o <= 50'b0;
		combined_b2 <= 25'b0;
		combined_negative_b2 <= 25'b0;
		new_exponent2 <= 8'b0;
		new_sign2<= 1'b0;
		add_r2 <= 32'b0;
		add_exception_2 <= 1'b0;
		s2 <=0;
		end
	else
		begin
		product2_o <= product2;
		combined_b2 <= combined_b;
		combined_negative_b2 <= combined_negative_b;
		new_exponent2 <= new_exponent;
		new_sign2<=new_sign;
		add_r2 <= add_r;
		add_exception_2 <= add_exception_1;
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

endmodule
