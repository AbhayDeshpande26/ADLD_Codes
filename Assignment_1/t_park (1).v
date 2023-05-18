module t_a();
wire fsens,bsens;
wire [3:0] park;
reg start,clk;
reg [3:0] password,vn;

park dut(fsens,bsens,park,clk,start,password,vn);

always #5 clk=~clk;

initial 
 begin
 clk=1'b1;
 start=1'b0;
 password=4'b0000;
 vn=4'b0000;
#5 start=1'b1;	    
vn=4'b1000;
password=4'b1001;	 
#5  password=4'b1010;
#5 start=1'b0;
#5 password=4'b0000;
#5 start=1'b1;   
 vn=4'b1100;		
#5 password=4'b1101;
#10 password=4'b1010;
#5 start=1'b0;	
 end
initial 
 begin
	$monitor ($time,"FrontSensor=%2d,BackSensor=%2d,Parking lote=%2d",fsens,bsens,park);
	#200  $finish;
 end

endmodule


module park(fsens,bsens,park,clk,start,password,vn);

output reg fsens,bsens;
output reg [3:0] park;
input start,clk;
input [3:0] password,vn;
reg [3:0] mem[0:15];
reg [3:0] Npassword;
reg f,b,st,gate;
reg k=0;
reg [3:0]Correct_pass,CP;


assign Correct_Pass=4'b1101;
assign Correct_Pass=CP;


parameter CLOSE=1'b0 , OPEN= 1'b1;


always @(posedge clk)
begin
st<=gate;
end

always@ (*)
begin
case (st)
CLOSE: begin 
     if(start)
     begin
      fsens= 1'b1;
      Npassword = password;gate=OPEN;
     end
     else if(!start)
      begin
	fsens= 1'b0;
        bsens=1'b0;
	park=0;
	Npassword=0;gate=CLOSE;
      end
      end
OPEN: begin
    Npassword=password;
    if(Npassword == CP)
     begin
      mem[k]= vn;
      park= vn;
      k= k+1;
      bsens=1'b1;
      gate= CLOSE;
     end
     else if(Npassword!=CP)
      begin
      bsens=1'b0;
      park=0;gate=CLOSE;
	   end
	end
  default : gate=CLOSE;
 endcase
end
endmodule


 



