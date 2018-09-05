module idec (
       clock,   //时钟端口
       reset,   //复位端口
       en,      //译码使能端口
       instruction,  //指令输入端口
       opcode,       //操作吗输入端口
       addr,         //存储器地址输入端口
	);

input clock,reset,en;
input [7:0] instruction;
output reg [2:0] opcode;
output reg [4:0] addr;

always @(posedge clock or posedge reset) begin
	if (reset) begin
	    opcode <= 0;
	    addr <= 0;
		// reset		
	end
	else if (en) begin
	    opcode <= instruction [7:5];
	    addr <= instruction [4:0];
		
	end
end
endmodule
