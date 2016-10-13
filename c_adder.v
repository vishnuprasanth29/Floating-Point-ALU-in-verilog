module c_adder1(sign_a,sign_b, new_a, new_b, sum, new_sign,greater_flag);

input [23:0]new_a,new_b;
input sign_a,sign_b,greater_flag;

reg [24:0]temp1,temp4,new_a_copy,new_b_copy,temp_r2;
reg [23:0]temp3,temp_r;
reg [25:0]temp2;

output reg new_sign;
output reg [24:0]sum;

always@(*)
begin
	if(sign_a == 1'b1 && sign_b == 1'b1)
	begin
	sum = new_a + new_b;
	new_sign = 1'b1;
	end

	else if(sign_a == 1'b0 && sign_b == 1'b0)
	begin
	sum = new_a + new_b;
	new_sign = 1'b0;
	end
	
	else if(((sign_a == 1'b1 && sign_b == 1'b0)||(sign_a == 1'b0 && sign_b == 1'b1)) && (new_a > new_b))
	begin
	sum = new_a - new_b;
	if(greater_flag == 1'b1)
	new_sign = sign_a;
	else
	new_sign = sign_b;
	end
	else
	begin
	sum = new_b - new_a;
	if(greater_flag == 1'b1)
	new_sign = sign_a;
	else
	new_sign = sign_b;
	end
	

end


endmodule


