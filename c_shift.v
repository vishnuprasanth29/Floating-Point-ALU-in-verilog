module c_shift1(exponent_a,difference,zero_flag,greater_flag,lesser_flag,fraction_a,fraction_b,combined_a,combined_b,new_exponent);

input [7:0] exponent_a,difference;
input [22:0] fraction_a,fraction_b;
//input clk;
//input clk;

reg [23:0] temp_combined_a,temp_combined_b;
//a_nonfraction,b_nonfraction
input zero_flag,greater_flag,lesser_flag;
output reg [7:0]new_exponent;
output reg [23:0]combined_a,combined_b;

//assign new_exponent = exponent_a;

always@(*)
begin
	if(zero_flag == 1 && greater_flag == 1'b0 && lesser_flag == 0)
	begin
	 
	 combined_a = {1'b1,fraction_a[22:0]};
	 combined_b = {1'b1,fraction_b[22:0]};
	 new_exponent = exponent_a;

	end
	else if(zero_flag == 0 && greater_flag == 1'b1 && lesser_flag == 0)
	begin
 	
	 combined_a = {1'b1,fraction_a[22:0]};
	 temp_combined_b = {1'b1,fraction_b[22:0]}; 	
	 combined_b = temp_combined_b>>difference;
	 new_exponent = exponent_a;
	 
	end
	else if(zero_flag == 1'b0 && greater_flag == 1'b0 && lesser_flag == 1)
	begin

	 combined_b = {1'b1,fraction_b[22:0]};
	 temp_combined_a = {1'b1,fraction_a[22:0]}; 	
	 combined_a = temp_combined_a>>difference;
	 new_exponent = exponent_a + difference;

	end

	else
	begin

	combined_a = 24'b0;
	 combined_b = 24'b0;
	new_exponent = 8'b0;
	end
end


endmodule
	