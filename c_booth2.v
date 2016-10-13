module c_booth2(product1 ,combined_b, combined_negative_b, product2); 

input [24:0]combined_b, combined_negative_b;
output reg [50:0] product2;
input [50:0] product1;


reg [51:0] product_temp3;
reg[50:0] product_shift,product_temp2;




always@(*)
begin

	if(product1[50] == 1'b1)
   product_shift = {1'b1, product1[50:1]};
	else if(product1[50] == 1'b0)
	product_shift = {1'b0, product1[50:1]};
	else
	product_shift = 50'b0;
end

always@(*)
begin
	if(product_shift[1:0] == 2'b00 || product_shift[1:0] == 2'b11)
	product2 = product_shift;
	else if(product_shift[1:0] == 2'b10)
		begin
		product_temp2 = {combined_negative_b, 26'b0};
		product_temp3 = product_shift + product_temp2;
		product2 = product_temp3[50:0];
		end
	else if(product_shift[1:0] == 2'b01)
		begin
		product_temp2 = {combined_b, 26'b0};
		product_temp3 = product_shift + product_temp2;
		product2 = product_temp3[50:0];
		end	
		else
		product2 = 51'b0;

end

endmodule
