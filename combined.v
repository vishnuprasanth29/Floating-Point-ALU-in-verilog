
module combined(clk,reset,exponent_a,exponent_b,fraction_a,fraction_b,sign_a,sign_b, new_sign_o, new_exponent_o, combined_a_o,combined_b_o, combined_negative_b_o,add_exponent_a,add_exponent_b,add_difference_o,add_zero_flag_o,add_greater_flag_o,add_lesser_flag_o,add_sign_a, add_sign_b, add_sign_a2, add_sign_b2,add_fraction_a,add_fraction_b,add_fraction_a2,add_fraction_b2,add_exponent_a2,s,s2);

//multiplier input
input [7:0]exponent_a,exponent_b;
input [22:0] fraction_a,fraction_b;
input sign_a,sign_b;
input clk, reset;
input s;

output reg s2;


output reg  new_sign_o;
output reg [8:0] new_exponent_o; 
output reg [24:0]combined_a_o,combined_b_o, combined_negative_b_o;

reg [25:0]temp_reg;

reg  new_sign;
reg [8:0] new_exponent; 
reg [24:0]combined_a,combined_b, combined_negative_b;
wire [8:0] temp_exponent;

//adder input

input [7:0]add_exponent_a,add_exponent_b;
input add_sign_a,add_sign_b;
input [22:0] add_fraction_a,add_fraction_b;

output reg add_sign_a2,add_sign_b2;


output reg [7:0]add_difference_o;
output reg add_zero_flag_o,add_greater_flag_o,add_lesser_flag_o;
output reg [22:0] add_fraction_a2,add_fraction_b2;
output reg [7:0]add_exponent_a2;

reg [7:0]add_difference;
reg add_zero_flag,add_greater_flag,add_lesser_flag;

assign temp_exponent = exponent_a + exponent_b;

always@(posedge clk or negedge reset)
begin

if(!reset)
begin
	new_sign_o <= 1'b0;
	new_exponent_o <= 8'b0;
	combined_a_o <= 24'b0;
	combined_b_o <= 24'b0;
	combined_negative_b_o <= 24'b0;
	s2 <= 0;
	end

else
begin
   new_sign_o <= new_sign;
	new_exponent_o <= new_exponent;
	combined_a_o <= combined_a;
	combined_b_o <= combined_b;
	combined_negative_b_o <=combined_negative_b;
	s2 <=s;
end

end


always@(*)
begin
	
	new_sign = sign_a ^ sign_b;

end

always@(*)
begin
		if((fraction_a == 23'b0)&&(fraction_b == 23'b0)&&(exponent_a == 8'b0) && (exponent_b == 8'b0))
		new_exponent = 8'b0;
		else
		new_exponent = exponent_a + exponent_b - 7'b1111111;

end

always@(*)
begin
	
	combined_a = {1'b0,1'b1, fraction_a};
	combined_b = {1'b0,1'b1, fraction_b};
	temp_reg = ((25'b1111111111111111111111111 - combined_b) + 1'b1);
	combined_negative_b = temp_reg[24:0] ;

end

always@(posedge clk or negedge reset)
begin

if(!reset)
begin
	add_difference_o <= 8'b00000000;
	add_zero_flag_o <= 1'b0;
	add_greater_flag_o <= 1'b0;
	add_lesser_flag_o <= 1'b0;
	add_fraction_a2<= 23'b0;
	add_fraction_b2 <= 23'b0;
	add_sign_a2 <= 1'b0;
	add_sign_b2 <= 1'b0;
	add_exponent_a2 <= 8'b0;
	
end

else
begin
	add_difference_o <= add_difference;
	add_zero_flag_o <= add_zero_flag;
	add_greater_flag_o <= add_greater_flag;
	add_lesser_flag_o <= add_lesser_flag;
	add_fraction_a2<=add_fraction_a;
	add_fraction_b2 <= add_fraction_b;
	add_sign_a2 <= add_sign_a;
	add_sign_b2 <= add_sign_b;
	add_exponent_a2 <= add_exponent_a;
	
end
end

always@(*)
begin
	if(add_exponent_a==add_exponent_b)
	 begin
	 add_zero_flag=1;
	 add_greater_flag=0;	
	 add_lesser_flag= 0;
	 end
	else if(add_exponent_a>add_exponent_b)
	begin
	 add_zero_flag=0;
	 add_greater_flag=1;	
	 add_lesser_flag= 0;
	 end
	else if(add_exponent_a<add_exponent_b)
	begin
	 add_zero_flag=0;
	 add_greater_flag=0;	
	 add_lesser_flag= 1;
	 end
	else
	 begin
	 add_zero_flag= 1'b0;
	 add_greater_flag= 1'b0;
	 add_lesser_flag= 1'b0;
	 end
end

always@(*)
begin
	if(add_zero_flag==1'b1)
	begin
	 add_difference = 0;
	end
	else if(add_greater_flag==1'b1)
	 add_difference = add_exponent_a-add_exponent_b;
	else 
	 add_difference = add_exponent_b-add_exponent_a;
	
end

endmodule
