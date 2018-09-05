module pc (clock,reset,en,pc);
input clock, reset, en;
output reg [4:0] pc;

wire [4:0] pc_next;                       //欲寻址的下一条指令

//always过程快
always@ (posedge clock or posedge reset)
begin
  if(reset)                              //系统复位，pc清0
      pc <= 0;
  else
      if(en)                             //如果使能pc模块，则将下一条指令付给pc端口输出
            pc <= pc_next;
      else
            pc <= pc;                    //否则，pc保持即不工作
end

//assign持续赋值语句
assign pc_next = pc + 1;                 //本处理器中下一条指令的地址为当前地址加1
endmodule 