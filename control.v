module control (
       input clock,
       input reset,         //异步复位端端口
       output reg s0,       //分别作用各阶段的使能信号个端口
       output reg s1,
       output reg s2,
       output reg s3,
       output reg s4,
       output reg s5,
       output reg addrsel,   //选择程序的地址或者选择数据的地址
       output reg instr_add, //加法端口使能信号，以下类似
       output reg instr_sub,
       output reg instr_and,
       output reg instr_pass,
       input [2:0] opcode    //解码器解码后将指令码传给控制器
	);

parameter [2:0]  LDA = 3'b000, STA = 3'b001, ADD = 3'b010, SUB = 3'b011, AND = 3'b100 , HLT = 3'b101;

reg [2:0] cnt;  //指令执行需要6个阶段，用cnt计数来表示不同的阶段

always @(posedge clock or posedge reset) 
	if (reset) 
		// reset
		cnt <= 0;
	else
	    if (cnt==5)
	       cnt <= 0;
	else 
	    cnt <= cnt+1;
		

always@ *
    begin
    	case(cnt)
    	   0: begin     //取指
    	   	  s0<=1; s1<=0; s2<=0; s3<=0; s4<=0; s5<=0;
    	   	  addrsel<=0;
    	   end

    	   1:begin      //解码
    	   	  s0<=0; s1<=1; s2<=0; s3<=0; s4<=0; s5<=0;
    	   	  addrsel<=0;
    	   end

    	   2:begin      //根据操作码决定是否从存储器中读取数据
    	   	  s0<=0; s1<=0; s2<=1; s3<=0; s4<=0; s5<=0;
    	   	  addrsel<=1;
    	   	  if( (opcode==LDA)  ||
    	   	  	  (opcode==ADD)  ||
    	   	  	  (opcode==SUB)  ||
    	   	  	  (opcode==AND)   )
    	   	     s2<=1;
    	   	  else
    	   	      s2<=0;
    	   end

    	   3:begin     //确定ALU的运算
    	   	  s0<=0; s1<=0; s2<=0; s3<=1; s4<=0; s5<=0;
    	   	  addrsel<=1;
    	   	  if (opcode==LDA) begin
    	   	  	instr_add<=0;
    	   	  	instr_sub<=0;
    	   	  	instr_and<=0;
    	   	  	instr_pass<=1;
    	   	  end

    	   	  else if(opcode==ADD) begin
    	   	  	instr_add<=1;
    	   	  	instr_sub<=0;
    	   	  	instr_and<=0;
    	   	  	instr_pass<=0;
    	   	  end

    	   	  else if(opcode==SUB) begin
    	   	  	instr_add<=0;
    	   	  	instr_sub<=1;
    	   	  	instr_and<=0;
    	   	  	instr_pass<=0;
    	   	  end

    	   	  else if(opcode==AND) begin
    	   	  	instr_add<=0;
    	   	  	instr_sub<=0;
    	   	  	instr_and<=1;
    	   	  	instr_pass<=0;
    	   	  end

    	   	  else if(opcode==STA) begin
    	   	  	instr_add<=0;
    	   	  	instr_sub<=0;
    	   	  	instr_and<=0;
    	   	  	instr_pass<=0;
    	   	  end

    	   	  else begin
    	   	  	instr_add<=0;
    	   	  	instr_sub<=0;
    	   	  	instr_and<=0;
    	   	  	instr_pass<=0;
    	   	  end
    	   end


    	   4:begin   //必要时往存储器中写数据
    	   	 s0<=0; s1<=0; s2<=0; s3<=0; s4<=1; s5<=0;
    	   	 addrsel<=1;
    	   	 if(opcode==STA)
    	   	    s4<=1;
    	   	 else
    	   	    s4<=0;
    	   end

    	   5:begin   //使能PC准备开始读取下一条指令
    	   	  s0<=0; s1<=0; s2<=0; s3<=0; s4<=0; s5<=1;
    	   	  addrsel<=1;
    	   end
    	endcase


    end


endmodule