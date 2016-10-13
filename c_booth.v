module c_booth(combined_a,combined_b, combined_negative_b, product); 

input [24:0]combined_a,combined_b, combined_negative_b;
output reg[50:0] product;


reg[50:0]  product_temp, product_temp2;
reg [51:0] product_temp3;


always@(*)
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


endmodule
