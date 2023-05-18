module t_vend();
reg clk;
reg reset;
reg [1:0]coin,pro_sel;
wire chn_5;
wire chn_10;
wire dis;

vend dut(clk,reset,coin,pro_sel,dis,chn_5,chn_10);

always #5 clk= ~clk;

initial begin
clk=1'b1;
reset=1;
#20 reset=0;
end

initial begin
  #10 pro_sel=2'b00;//product a
    #10 coin=2'b00;//inserted coin is 5

 #10 pro_sel=2'b00;//product a
    #10 coin=2'b01;//inserted coin is 10

 #10 pro_sel=2'b00;//product b
    #10 coin=2'b11;//inserted coin is 20

 #10 pro_sel=2'b11;//product d
    #10 coin=2'b11;//inserted coin is 20

 #10 pro_sel=2'b10;//product c
    #10 coin=2'b11;//inserted coin is 20
end

initial 
 begin
	$monitor ($time,"change of 5=%2d,change of 10 =%2d,dispacthed=%2d",chn_5,chn_10,dis);
	#200  $finish;
 end
endmodule


///////////////////////////////////////////////////////

module vend(clk,reset,coin,pro_sel,dis,chn_5,chn_10);
input clk,reset;
input [1:0]coin,pro_sel;
output reg dis,chn_5,chn_10;

parameter [2:0] p_a= 3'b001,p_b =3'b010,p_c=3'b011,p_d=3'b100;

reg [1:0]sel_pro=2'b00;
reg [1:0]sel_pro_p=2'b00;

reg [4:0] t_amu=5'b0000,change=5'b0000;


reg [3:0] nu_5 =4'b0000;
reg[3:0] nu_10=4'b0000;

parameter idle=2'b00;
parameter product_sel=2'b01;
parameter coin_in=2'b10;
parameter dis_pro=2'b11;

reg[1:0]state = idle;

always @(posedge clk)
begin
  if(reset)
	begin
	state<=idle;
	end
  else
     begin 
       case(state)
        idle: begin
		if (pro_sel!=2'b00)
		  begin
		   sel_pro<=pro_sel;
		   case(pro_sel)
	   	    2'b00:sel_pro_p<=p_a;
	            2'b01: sel_pro_p<= p_b;
		    2'b10: sel_pro_p<= p_c;
                    2'b11: sel_pro_p<= p_d;
                   endcase
		   state<= product_sel;
                  end
              end
       product_sel : begin
                if(t_amu >=sel_pro_p) 
	        begin
                  change<= t_amu - sel_pro_p;
		   state<= dis_pro;
	       end
              else begin
              state <= coin_in;
              end
	  end
 
      coin_in :
  	    	begin
 	    	 if(coin == 2'b00)
 	  	  	begin
			 nu_5<=nu_5+1;
 	   	  	 t_amu<=t_amu+5;
     	 	  	end
                else if (coin==2'b01)
		  begin
 	 	   nu_10<=nu_10+1;
                   t_amu<=t_amu+10;
                  end
                if(t_amu>=sel_pro_p)
 	 	 begin
 	 	  change<=t_amu-sel_pro_p;
	         end
	      end
	endcase
   end
end
endmodule
	
		



















                           







