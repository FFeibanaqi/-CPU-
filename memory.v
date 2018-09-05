module memory (
	    clock,
	    reset,
	    addr,
	    din,
	    dout,
	    wr,
	    rd
	);

input clock;       //时钟信号线
input reset;       //复位信号，高电平有效
input [4:0] addr;  //存储器地址
input [7:0] din;   //数据线输入
output reg [7:0] dout;  //数据线输出
input wr;          //写使能端，高电平有效
input rd;          //读使能端，高电平有效
//input [7:0] IN；
//input [7:0] OUT;


reg [7:0] mem [0:31];  //内部的存储空间
//reg [7:0] mem [30:0];

always @(posedge clock or posedge reset) begin
	if (reset) begin
	    mem [0] <= 'b00001011;      //LDA 01011
	    mem [1] <= 'b01001100;      //ADD 01100
	    mem [2] <= 'b00101101;      //STA 01101
	    mem [3] <= 'b00001011;      //LDA 01011
	    //mem [3] <= 'b00011111;从IN端口读数至累加器A  LDA 31
	    mem [4] <= 'b10001100;      //AND 01100
	    mem [5] <= 'b00101110;      //STA 01110
	    //mem [5] <= 'b00111111;输出数据到OUT端口  STA 31
	    mem [6] <= 'b00001011;      //LDA 01011
	    mem [7] <= 'b01101100;      //SUB 01100
	    mem [8] <= 'b00101111;      //STA 01111
	    mem [9] <= 'b10100000;      //HLT
	    mem [10] <= 'b00000000;
	    mem [11] <= 'b10010101;
	    mem [12] <= 'b01100101;
	    mem [13] <= 'b00000000;
	    mem [14] <= 'b00000000;
	    mem [15] <= 'b00000000;
	    mem [16] <= 'b00000000;
	    mem [17] <= 'b00000000;
	    mem [18] <= 'b00000000;
	    mem [19] <= 'b00000000;
	    mem [20] <= 'b00000000;
	    mem [21] <= 'b00000000;
	    mem [22] <= 'b00000000;
	    mem [23] <= 'b00000000;
	    mem [24] <= 'b00000000;
	    mem [25] <= 'b00000000;
	    mem [26] <= 'b00000000;
	    mem [27] <= 'b00000000;
	    mem [28] <= 'b00000000;
	    mem [29] <= 'b00000000;
	    mem [30] <= 'b00000000;
	    mem [31] <= 'b00000000;
		// reset
		
	end
	else begin
	   if (wr)
	      mem [addr] <= din;
	   if (rd)
	      dout <= mem [addr];		
	end
end
endmodule
