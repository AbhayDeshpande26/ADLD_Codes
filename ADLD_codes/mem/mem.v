
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
