module alu (
        clock,      //时钟端口
        reset,      //复位端口
        en,         //alu使能端口
        a,          //累加器输出寄存器
        din,        //操作数1输入   
        n,          //负标志
        z,          //0标志
        c,          //输出进位标志
        v,          //输出溢出标志
        add_en,     //加法使能运算
        sub_en,     //减法使能运算
        and_en,     //与运算
        pass_en,    //使din直通累加器A，不做运算(部分运算需要)
	);

input clock,reset,en,add_en,sub_en,and_en,pass_en;
input [7:0] din;
output n,z,c,v;
output reg [7:0] a;
reg c;

always @(posedge clock or posedge reset) 
	if (reset) begin
		a <= 0;      //复位累加器清0，
		c <= 0;
		// reset	
	end
	else begin
		if(en) begin
			if(add_en)
			    {c,a} <= a [7:0] + din;
			else if(sub_en)
			    {c,a} <= a [7:0] - din;
			else if(and_en)
			    a <= a & din;
			else if(pass_en)
			    a <= din; 
		end
	end


assign z = (a == 8'b0) ? 1: 0 ;    //0标志，如果累加器为0，z=1
assign n = (c == 1) ? 1: 0 ;       //负数标志，如果借位为1,则n=1
assign v = ((a>127) || (a<-128) ? 1:0 );  //溢出标志

endmodule
