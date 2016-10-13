module c_combine(exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b, new_sign, new_exponent, combined_a,combined_b, combined_negative_b);
input [7:0]exponent_a,exponent_b;
input [22:0] fraction_a,fraction_b;
input sign_a,sign_b;


output reg  new_sign;
output reg [8:0] new_exponent; 
output reg [24:0]combined_a,combined_b, combined_negative_b;

reg [25:0]temp_reg;

//reg  new_sign;
//reg [8:0] new_exponent; 
//reg [23:0]combined_a,combined_b, combined_negative_b;




always@(*)
begin

	if( (sign_a == 1'b1 && sign_b == 1'b1) || (sign_a == 1'b0 && sign_b == 1'b0) )
	new_sign = 1'b0;
	else if( (sign_a == 1'b0 && sign_b == 1'b1) || (sign_a == 1'b1 && sign_b == 1'b0) )
	new_sign = 1'b1;
	else
	new_sign = 1'b0;

end

always@(*)
begin
		
		new_exponent = exponent_a + exponent_b - 7'b1111111;

end

always@(*)
begin
	
	combined_a = {1'b0,1'b1, fraction_a};
	combined_b = {1'b0,1'b1, fraction_b};
	temp_reg = ((25'b1111111111111111111111111 - combined_b) + 1'b1);
	combined_negative_b = temp_reg[24:0] ;

end

endmodule
