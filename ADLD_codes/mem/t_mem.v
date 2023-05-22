module t_mem();
reg [9:0]adr;
reg [7:0]d_in;
wire [7:0]d_out;
reg wr,cs;
integer k,mys;
ram r1(d_out,d_in,adr,wr,cs);
initial mys=35;
initial
 begin
	for(k=0;k<=1023;k=k+1)
	begin 
		 #2 wr=1;cs=1;
		  adr=k;
		d_in=(k+k)%256;
		#2 wr=0;cs=0;
	end

repeat(20)
	begin
	adr=$random(mys)%1024;
	wr=0;cs=1;
	$display("adr:%5d,dat:%d",adr,d_out);
 end       
 end

endmodule


module ram(d_out,d_in,adr,wr,cs);
input [9:0]adr;
input [7:0]d_in;
output[7:0]d_out;
input wr,cs;
reg [7:0]mem[0:1023];
assign d_out=mem[adr];
always@(wr or cs)
if(wr)
mem[adr]=d_in;
endmodule


