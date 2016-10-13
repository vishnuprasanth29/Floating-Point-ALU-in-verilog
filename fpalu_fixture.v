`include "fpalu.v"
`include "validation.v"

module fixture;

reg [31:0]F[0:330];
reg [31:0]Ractual[0:165];
reg [31:0]Rexpected[0:165];
reg Exexpected[0:165];
reg Exactual[0:165];
reg [31:0]a,b;
reg clk,reset,s;

reg [31:0]F2[0:10];
reg [31:0]F3[0:10];

wire [31:0]r_expected,r_actual;
wire exception_expected,exception_actual;

integer i;
integer j=32;

integer k;
integer m,u;

topdut t1(a,b,s,clk,reset,r_actual,exception_actual);
c_toptest t2(a,b,s,clk,reset,r_expected,exception_expected);

initial 
begin
clk = 1'b1;
forever #10 clk = ~clk;
end




	
integer ab;
/*
initial
begin
		ab=$fopen("input_ab.txt","w");
		for(i=0;i<320;i=i+1)
			begin
				$fdisplay(ab,"%b",$random());
			end
		$fclose(ab);
		
end*/
	
initial
begin
		$readmemb("input_ab.txt",F);
end

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
	a <= 32'b0;
	b <= 32'b0;
	k <= 0;
	m <=0;
	u <=0;
	end
	

	else
	
		begin 
			a <= F[k];
			b <= F[k+160];
			k <= k+1;
			Rexpected[m] <= r_expected;
			Exexpected[m] <= exception_expected;
			m <= m+1;
			if(k>=29)
			begin
				Ractual[u] <= r_actual;
				Exactual[u] <= exception_actual;
				u <= u+1;
			end
		end
	
end
initial
begin
	#4330
	$display("PERFORMING ADDITION");
	for(i=1;i<79;i = i+1)
	begin
		if((Rexpected[i+1] == Ractual[i])&&(Exexpected[i+1]==Exactual[i]))
		begin
		$display("PASS actual_exception= %b Actual_R= %h Expected_Exception= %b Expected_R= %h A=%h B=%h",Exactual[i],Ractual[i],Exexpected[i+1],Rexpected[i+1],F[i-1],F[i+160-1]);
		end
		else
		$display("FAIL actual_exception= %b Actual_R= %h Expected_Exception= %b Expected_R= %h A=%h B=%h",Exactual[i],Ractual[i],Exexpected[i+1],Rexpected[i+1],F[i-1],F[i+160-1]);
		end
	
	for(i=80;i<108;i = i+1)
	begin
		if((Rexpected[i+1] == Ractual[i])&&(Exexpected[i+1]==Exactual[i]))
		begin
		$display("PASS actual_exception= %b Actual_R= %h Expected_Exception= %b Expected_R= %h A=%h B=%h",Exactual[i],Ractual[i],Exexpected[i+1],Rexpected[i+1],F[i-1],F[i+160-1]);
		end
		else
		$display("FAIL actual_exception= %b Actual_R= %h Expected_Exception= %b Expected_R= %h A=%h B=%h",Exactual[i],Ractual[i],Exexpected[i+1],Rexpected[i+1],F[i-1],F[i+160-1]);
		end
	$display("PERMORMING MULTIPLICATION");
	for(i=109;i<160;i = i+1)
	begin
		if((Rexpected[i+1] == Ractual[i])&&(Exexpected[i+1]==Exactual[i]))
		begin
		$display("PASS actual_exception= %b Actual_R= %h Expected_Exception= %b Expected_R= %h A=%h B=%h",Exactual[i],Ractual[i],Exexpected[i+1],Rexpected[i+1],F[i-1],F[i+160-1]);
		end
		else
		$display("FAIL actual_exception= %b Actual_R= %h Expected_Exception= %b Expected_R= %h A=%h B=%h",Exactual[i],Ractual[i],Exexpected[i+1],Rexpected[i+1],F[i-1],F[i+160-1]);
		end	
		
end
	
initial 
begin
		// Initialize Inputs
	reset = 1'b0;
	#30
	reset = 1'b1;
	s = 1'b0;
	#2180
	s = 1'b1;
	#1900
	s = 1'b0;
	#20
	s = 1'b1;
	#20
	s = 1'b0;
	
	
	
   end
	initial	
	begin
			#4330 $finish; 
	end

	
      
endmodule

