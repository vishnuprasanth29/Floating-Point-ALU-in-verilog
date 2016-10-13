module c_compare(exponent_a,exponent_b,difference,zero_flag,greater_flag,lesser_flag);
input [7:0]exponent_a,exponent_b;
//input clk;
output reg [7:0]difference;
output reg zero_flag,greater_flag,lesser_flag;

always@(*)
begin
	if(exponent_a==exponent_b)
	 begin
	 zero_flag=1;
	 greater_flag=0;	
	 lesser_flag= 0;
	 end
	else if(exponent_a>exponent_b)
	begin
	 zero_flag=0;
	 greater_flag=1;	
	 lesser_flag= 0;
	 end
	else if(exponent_a<exponent_b)
	begin
	 zero_flag=0;
	 greater_flag=0;	
	 lesser_flag= 1;
	 end
	else
	 begin
	 zero_flag= 1'b0;
	 greater_flag= 1'b0;
	 lesser_flag= 1'b0;
	 end
end

always@(*)
begin
	if(zero_flag==1'b1)
	begin
	 difference = 0;
	end
	else if(greater_flag==1'b1)
	 difference = exponent_a-exponent_b;
	else if(lesser_flag==1'b1)
	 difference = exponent_b-exponent_a;
	else
	 difference = 1'bx;
end

endmodule