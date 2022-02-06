module div (
	input  clk,
	input  rst_n,
	input  i_in_valid,
	input  [7:0] i_a,
	input  [4:0] i_b,
	output [7:0] o_q,
	output [4:0] o_r,
	output       o_out_valid,
	output [50:0] number
);
	wire [4:0] reg_b [0:7];
	wire [12:0] tmp [0:7];
	wire [12:0] tmp_intoFF [0:7];
	wire [5:0] tmp_D [0:7];
	wire bug [0:7]; // if == 1 then A < B
	wire enable [0:7];
	wire [50:0] num_of_trans[0:24];
	wire [50:0] num_of_FF_trans [0:7];
	// 8 bit --> 8 cycles
	// stage1
	assign tmp[0][7:0] = i_a;
	assign tmp[0][12:8] = 5'b0;
	assign reg_b[0] = i_b;
	FS1 fs6_0(tmp[0][12:7], {1'b0, i_b}, tmp_D[0], bug[0], num_of_trans[0]); // may use my own comparator
	// MUX5 mx5_0(tmp_intoFF[0][11:7],tmp_D[0][4:0],tmp[0][11:7], bug[0], num_of_trans[1]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	MUX1 mx5_0(tmp_intoFF[0][7],tmp_D[0][0],tmp[0][7], bug[0], num_of_trans[1]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	IV inv0(tmp_intoFF[0][12], bug[0], num_of_trans[2]);
	assign tmp_intoFF[0][6:0] = tmp[0][6:0];
	
	// DFF15 dfm19_0({tmp[1][12], tmp[1][7:0], enable[1], reg_b[1]} , {tmp_intoFF[0][12], tmp_intoFF[0][7:0], i_in_valid, reg_b[0]}, clk, rst_n, num_of_FF_trans[7]);
	assign tmp[1][12] = tmp_intoFF[0][12];
	assign tmp[1][11:8] = 4'b0;
	assign tmp[1][7:0] = tmp_intoFF[0][7:0];
	
	///////////////////
	// assign tmp[1] = tmp_intoFF[0];
	assign enable[1] = i_in_valid;
	assign reg_b[1] = reg_b[0];
	//////////////////
	
	// stage2
	// assign tmp[1] = tmp_intoFF[1];
	FS2 fs6_1(tmp[1][11:6], {1'b0, reg_b[1]}, tmp_D[1], bug[1], num_of_trans[3]); // may use my own comparator
	MUX2 mx5_1(tmp_intoFF[1][7:6], tmp_D[1][1:0], tmp[1][7:6], bug[1], num_of_trans[4]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	IV inv1(tmp_intoFF[1][11], bug[1], num_of_trans[5]);
	assign tmp_intoFF[1][12] = tmp[1][12];
	assign tmp_intoFF[1][5:0] = tmp[1][5:0];
	
	// DFF16 dfm19_1({tmp[2][12:11], tmp[2][7:0], enable[2], reg_b[2]} , {tmp_intoFF[1][12:11], tmp_intoFF[1][7:0], enable[1], reg_b[1]}, clk, rst_n, num_of_FF_trans[0]);
	DFF15 dfm19_1({tmp[2][12:11], tmp[2][7:0], reg_b[2]} , {tmp_intoFF[1][12:11], tmp_intoFF[1][7:0], reg_b[1]}, clk, rst_n, num_of_FF_trans[0]);
	// assign tmp[2][12:11] = tmp_intoFF[1][12:11];
	assign tmp[2][10:8] = 3'b0;
	// assign tmp[2][7:0] = tmp_intoFF[1][7:0];
	
	///////////////////
	// assign tmp[2] = tmp_intoFF[1];
	// assign enable[2] = enable[1];
	// assign reg_b[2] = reg_b[1];
	//////////////////
	
	// stage3
	FS3 fs6_2(tmp[2][10:5], {1'b0, reg_b[2]}, tmp_D[2], bug[2], num_of_trans[6]); // may use my own comparator
	MUX3 mx5_2(tmp_intoFF[2][7:5],tmp_D[2][2:0],tmp[2][7:5],bug[2], num_of_trans[7]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	IV inv2(tmp_intoFF[2][10], bug[2], num_of_trans[8]);
	assign tmp_intoFF[2][12:11] = tmp[2][12:11];
	assign tmp_intoFF[2][4:0] = tmp[2][4:0];
	// DFF17 dfm19_2({tmp[3][12:10], tmp[3][7:0], enable[3], reg_b[3]} , {tmp_intoFF[2][12:10], tmp_intoFF[2][7:0], enable[2], reg_b[2]}, clk, rst_n, num_of_FF_trans[6]);
	DFF16 dfm19_2({tmp[3][12:10], tmp[3][7:0], reg_b[3]} , {tmp_intoFF[2][12:10], tmp_intoFF[2][7:0], reg_b[2]}, clk, rst_n, num_of_FF_trans[6]);
	assign tmp[3][9:8] = 2'b0;
	///////////////////
	// assign tmp[3] = tmp_intoFF[2];
	// assign enable[3] = enable[2];
	// assign reg_b[3] = reg_b[2];
	//////////////////
	
	
	// stage4
	FS4 fs6_3(tmp[3][9:4], {1'b0, reg_b[3]}, tmp_D[3], bug[3], num_of_trans[9]); // may use my own comparator
	MUX4 mx5_3(tmp_intoFF[3][7:4], tmp_D[3][3:0], tmp[3][7:4],bug[3], num_of_trans[10]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	IV inv3(tmp_intoFF[3][9], bug[3], num_of_trans[11]);
	assign tmp_intoFF[3][12:10] = tmp[3][12:10];
	assign tmp_intoFF[3][3:0] = tmp[3][3:0];
	// DFF18 dfm19_3({tmp[4][12:9], tmp[4][7:0], enable[4], reg_b[4]} , {tmp_intoFF[3][12:9], tmp_intoFF[3][7:0], enable[3], reg_b[3]}, clk, rst_n, num_of_FF_trans[1]);
	DFF17 dfm19_3({tmp[4][12:9], tmp[4][7:0], reg_b[4]} , {tmp_intoFF[3][12:9], tmp_intoFF[3][7:0], reg_b[3]}, clk, rst_n, num_of_FF_trans[1]);
	assign tmp[4][8] = 1'b0;
	///////////////////
	// assign tmp[4] = tmp_intoFF[3];
	// assign enable[4] = enable[3];
	// assign reg_b[4] = reg_b[3];
	//////////////////
	
	// stage5
	FS5 fs6_4(tmp[4][8:3], {1'b0, reg_b[4]}, tmp_D[4], bug[4], num_of_trans[12]); // may use my own comparator
	MUX5 mx5_4(tmp_intoFF[4][7:3], tmp_D[4][4:0],tmp[4][7:3],bug[4], num_of_trans[13]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	IV inv4(tmp_intoFF[4][8], bug[4], num_of_trans[14]);
	assign tmp_intoFF[4][12:9] = tmp[4][12:9];
	assign tmp_intoFF[4][2:0] = tmp[4][2:0];
	// DFF19 dfm19_4({tmp[5], enable[5], reg_b[5]} , {tmp_intoFF[4], enable[4], reg_b[4]}, clk, rst_n, num_of_FF_trans[5]);
	DFF18 dfm19_4({tmp[5], reg_b[5]} , {tmp_intoFF[4], reg_b[4]}, clk, rst_n, num_of_FF_trans[5]);
	///////////////////
	// assign tmp[5] = tmp_intoFF[4];
	// assign enable[5] = enable[4];
	// assign reg_b[5] = reg_b[4];
	//////////////////
	
	
	// stage6
	FS6 fs6_5(tmp[5][7:2], {1'b0, reg_b[5]}, tmp_D[5], bug[5], num_of_trans[15]); // may use my own comparator
	MUX5_6 mx5_5(tmp_intoFF[5][6:2], tmp_D[5][4:0], tmp[5][6:2],bug[5], num_of_trans[16]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	// IV inv5(tmp_intoFF[5][7], bug[5], num_of_trans[17]);
	assign num_of_trans[17] = 51'b0;
	assign tmp_intoFF[5][7] = bug[5];
	assign tmp_intoFF[5][12:8] = tmp[5][12:8];
	assign tmp_intoFF[5][1:0] = tmp[5][1:0];
	// DFF19 dfm19_5({tmp[6], enable[6], reg_b[6]} , {tmp_intoFF[5], enable[5], reg_b[5]}, clk, rst_n, num_of_FF_trans[2]);
	DFF18 dfm19_5({tmp[6], reg_b[6]} , {tmp_intoFF[5], reg_b[5]}, clk, rst_n, num_of_FF_trans[2]);
	///////////////////
	// assign tmp[6] = tmp_intoFF[5];
	// assign enable[6] = enable[5];
	// assign reg_b[6] = reg_b[5];
	//////////////////
	
	// stage7
	FS6 fs6_6(tmp[6][6:1], {1'b0, reg_b[6]}, tmp_D[6], bug[6], num_of_trans[18]); // may use my own comparator
	MUX5_6 mx5_6(tmp_intoFF[6][5:1], tmp_D[6][4:0],tmp[6][5:1], bug[6], num_of_trans[19]);	// MUX21H(Z,A,B,CTRL,number); if 1 then output B, B is the result of FS
	// IV inv6(tmp_intoFF[6][6], bug[6], num_of_trans[20]);
	assign num_of_trans[20] = 51'b0;
	assign tmp_intoFF[6][6] = bug[6];
	assign tmp_intoFF[6][12:7] = tmp[6][12:7];
	assign tmp_intoFF[6][0] = tmp[6][0];
	//assign tmp_intoFF[0][6] = tmp[0][6];
	// DFF19 dfm19_6({tmp[7], enable[7], reg_b[7]} , {tmp_intoFF[6], enable[6], reg_b[6]}, clk, rst_n, num_of_FF_trans[4]);
	DFF18 dfm19_6({tmp[7], reg_b[7]} , {tmp_intoFF[6], reg_b[6]}, clk, rst_n, num_of_FF_trans[4]);
	///////////////////
	// assign tmp[7] = tmp_intoFF[6];
	// assign enable[7] = enable[6];
	// assign reg_b[7] = reg_b[6];
	//////////////////
	
	
	// stage8
	FS6 fs6_7(tmp[7][5:0], {1'b0, reg_b[7]}, tmp_D[7], bug[7], num_of_trans[21]); // may use my own comparator
	MUX5_6 mx5_7(tmp_intoFF[7][4:0], tmp_D[7][4:0], tmp[7][4:0], bug[7], num_of_trans[22]);	// 
	// IV inv7(tmp_intoFF[7][5], bug[7], num_of_trans[23]);
	assign num_of_trans[23] = 51'b0;
	assign tmp_intoFF[7][5] = bug[7];
	assign tmp_intoFF[7][12:6] = tmp[7][12:6];
	wire myenable;
	OR5_1 or51(myenable, reg_b[7][0], reg_b[7][1], reg_b[7][2], reg_b[7][3], reg_b[7][4], num_of_trans[24]);
	
	//assign tmp_intoFF[0][7] = tmp[0][7];
	// DFF14 dfm14_7({o_q, o_r, o_out_valid} , {tmp_intoFF[7][12:5], tmp_intoFF[7][4:0], enable[7]}, clk, rst_n, num_of_FF_trans[3]);
	DFF14 dfm14_7({o_q, o_r, o_out_valid} , {tmp_intoFF[7][12:5], tmp_intoFF[7][4:0], myenable}, clk, rst_n, num_of_FF_trans[3]);
	///////////////////
	// assign o_q = tmp_intoFF[7][12:5];
	// assign o_r = tmp_intoFF[7][4:0];
	// assign o_out_valid = enable[7];
	// assign num_of_FF_trans[3] = 51'b0;
	//////////////////
	
	//sum number of transistors
	reg [50:0] sum1;
	integer j;
	always @(*) begin
		sum1 = 0;
		for (j = 0; j < 25; j = j + 1) begin 
			sum1 = sum1 + num_of_trans[j];
		end
		// $display(" number of FS gates: %d", sum1);
	end
	
	reg [50:0] sum2;
	integer k;
	always @(*) begin
		sum2 = 0;
		for (k = 0; k < 7; k = k + 1) begin 
			sum2 = sum2 + num_of_FF_trans[k];
		end
		// $display(" number of FF gates: %d", sum2);
	end
	assign number = sum1 + sum2;

endmodule

module DFF14(Q,D,CLK,RESET,number);
	// tmp, enable, B
	output [13:0] Q;
	output [50:0] number;
	input [13:0] D;
	input CLK;
	input RESET;
	wire [50:0] FF_num[0:13];
	
	FD2 df14_0(Q[0],D[0],CLK,RESET,FF_num[0]);
	FD2 df14_1(Q[1],D[1],CLK,RESET,FF_num[1]);
	FD2 df14_2(Q[2],D[2],CLK,RESET,FF_num[2]);
	FD2 df14_3(Q[3],D[3],CLK,RESET,FF_num[3]);
	FD2 df14_4(Q[4],D[4],CLK,RESET,FF_num[4]);
	FD2 df14_5(Q[5],D[5],CLK,RESET,FF_num[5]);
	FD2 df14_6(Q[6],D[6],CLK,RESET,FF_num[6]);
	FD2 df14_7(Q[7],D[7],CLK,RESET,FF_num[7]);
	FD2 df14_8(Q[8],D[8],CLK,RESET,FF_num[8]);
	FD2 df14_9(Q[9],D[9],CLK,RESET,FF_num[9]);
	FD2 df14_10(Q[10],D[10],CLK,RESET,FF_num[10]);
	FD2 df14_11(Q[11],D[11],CLK,RESET,FF_num[11]);
	FD2 df14_12(Q[12],D[12],CLK,RESET,FF_num[12]);
	FD2 df14_13(Q[13],D[13],CLK,RESET,FF_num[13]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 14; j = j + 1) begin 
			sum = sum + FF_num[j];
		end
	end

	assign number = sum;
	
endmodule

module DFF15(Q,D,CLK,RESET,number);
	// tmp, enable, B
	output [14:0] Q;
	output [50:0] number;
	input [14:0] D;
	input CLK;
	input RESET;
	wire [50:0] FF_num[0:14];
	
	FD2 df19_0(Q[0],D[0],CLK,RESET,FF_num[0]);
	FD2 df19_1(Q[1],D[1],CLK,RESET,FF_num[1]);
	FD2 df19_2(Q[2],D[2],CLK,RESET,FF_num[2]);
	FD2 df19_3(Q[3],D[3],CLK,RESET,FF_num[3]);
	FD2 df19_4(Q[4],D[4],CLK,RESET,FF_num[4]);
	FD2 df19_5(Q[5],D[5],CLK,RESET,FF_num[5]);
	FD2 df19_6(Q[6],D[6],CLK,RESET,FF_num[6]);
	FD2 df19_7(Q[7],D[7],CLK,RESET,FF_num[7]);
	FD2 df19_8(Q[8],D[8],CLK,RESET,FF_num[8]);
	FD2 df19_9(Q[9],D[9],CLK,RESET,FF_num[9]);
	FD2 df19_10(Q[10],D[10],CLK,RESET,FF_num[10]);
	FD2 df19_11(Q[11],D[11],CLK,RESET,FF_num[11]);
	FD2 df19_12(Q[12],D[12],CLK,RESET,FF_num[12]);
	FD2 df19_13(Q[13],D[13],CLK,RESET,FF_num[13]);
	FD2 df19_14(Q[14],D[14],CLK,RESET,FF_num[14]);
	// FD2(Q[19],D[19],CLK,RESET,number);
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 15; j = j + 1) begin 
			sum = sum + FF_num[j];
		end
	end

	assign number = sum;
	
endmodule

module DFF16(Q,D,CLK,RESET,number);
	// tmp, enable, B
	output [15:0] Q;
	output [50:0] number;
	input [15:0] D;
	input CLK;
	input RESET;
	wire [50:0] FF_num[0:15];
	
	FD2 df19_0(Q[0],D[0],CLK,RESET,FF_num[0]);
	FD2 df19_1(Q[1],D[1],CLK,RESET,FF_num[1]);
	FD2 df19_2(Q[2],D[2],CLK,RESET,FF_num[2]);
	FD2 df19_3(Q[3],D[3],CLK,RESET,FF_num[3]);
	FD2 df19_4(Q[4],D[4],CLK,RESET,FF_num[4]);
	FD2 df19_5(Q[5],D[5],CLK,RESET,FF_num[5]);
	FD2 df19_6(Q[6],D[6],CLK,RESET,FF_num[6]);
	FD2 df19_7(Q[7],D[7],CLK,RESET,FF_num[7]);
	FD2 df19_8(Q[8],D[8],CLK,RESET,FF_num[8]);
	FD2 df19_9(Q[9],D[9],CLK,RESET,FF_num[9]);
	FD2 df19_10(Q[10],D[10],CLK,RESET,FF_num[10]);
	FD2 df19_11(Q[11],D[11],CLK,RESET,FF_num[11]);
	FD2 df19_12(Q[12],D[12],CLK,RESET,FF_num[12]);
	FD2 df19_13(Q[13],D[13],CLK,RESET,FF_num[13]);
	FD2 df19_14(Q[14],D[14],CLK,RESET,FF_num[14]);
	FD2 df19_15(Q[15],D[15],CLK,RESET,FF_num[15]);
	// FD2(Q[19],D[19],CLK,RESET,number);
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 16; j = j + 1) begin 
			sum = sum + FF_num[j];
		end
	end

	assign number = sum;
	
endmodule

module DFF17(Q,D,CLK,RESET,number);
	// tmp, enable, B
	output [16:0] Q;
	output [50:0] number;
	input [16:0] D;
	input CLK;
	input RESET;
	wire [50:0] FF_num[0:16];
	
	FD2 df19_0(Q[0],D[0],CLK,RESET,FF_num[0]);
	FD2 df19_1(Q[1],D[1],CLK,RESET,FF_num[1]);
	FD2 df19_2(Q[2],D[2],CLK,RESET,FF_num[2]);
	FD2 df19_3(Q[3],D[3],CLK,RESET,FF_num[3]);
	FD2 df19_4(Q[4],D[4],CLK,RESET,FF_num[4]);
	FD2 df19_5(Q[5],D[5],CLK,RESET,FF_num[5]);
	FD2 df19_6(Q[6],D[6],CLK,RESET,FF_num[6]);
	FD2 df19_7(Q[7],D[7],CLK,RESET,FF_num[7]);
	FD2 df19_8(Q[8],D[8],CLK,RESET,FF_num[8]);
	FD2 df19_9(Q[9],D[9],CLK,RESET,FF_num[9]);
	FD2 df19_10(Q[10],D[10],CLK,RESET,FF_num[10]);
	FD2 df19_11(Q[11],D[11],CLK,RESET,FF_num[11]);
	FD2 df19_12(Q[12],D[12],CLK,RESET,FF_num[12]);
	FD2 df19_13(Q[13],D[13],CLK,RESET,FF_num[13]);
	FD2 df19_14(Q[14],D[14],CLK,RESET,FF_num[14]);
	FD2 df19_15(Q[15],D[15],CLK,RESET,FF_num[15]);
	FD2 df19_16(Q[16],D[16],CLK,RESET,FF_num[16]);
	// FD2(Q[19],D[19],CLK,RESET,number);
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 17; j = j + 1) begin 
			sum = sum + FF_num[j];
		end
	end

	assign number = sum;
	
endmodule

module DFF18(Q,D,CLK,RESET,number);
	// tmp, enable, B
	output [17:0] Q;
	output [50:0] number;
	input [17:0] D;
	input CLK;
	input RESET;
	wire [50:0] FF_num[0:17];
	
	FD2 df19_0(Q[0],D[0],CLK,RESET,FF_num[0]);
	FD2 df19_1(Q[1],D[1],CLK,RESET,FF_num[1]);
	FD2 df19_2(Q[2],D[2],CLK,RESET,FF_num[2]);
	FD2 df19_3(Q[3],D[3],CLK,RESET,FF_num[3]);
	FD2 df19_4(Q[4],D[4],CLK,RESET,FF_num[4]);
	FD2 df19_5(Q[5],D[5],CLK,RESET,FF_num[5]);
	FD2 df19_6(Q[6],D[6],CLK,RESET,FF_num[6]);
	FD2 df19_7(Q[7],D[7],CLK,RESET,FF_num[7]);
	FD2 df19_8(Q[8],D[8],CLK,RESET,FF_num[8]);
	FD2 df19_9(Q[9],D[9],CLK,RESET,FF_num[9]);
	FD2 df19_10(Q[10],D[10],CLK,RESET,FF_num[10]);
	FD2 df19_11(Q[11],D[11],CLK,RESET,FF_num[11]);
	FD2 df19_12(Q[12],D[12],CLK,RESET,FF_num[12]);
	FD2 df19_13(Q[13],D[13],CLK,RESET,FF_num[13]);
	FD2 df19_14(Q[14],D[14],CLK,RESET,FF_num[14]);
	FD2 df19_15(Q[15],D[15],CLK,RESET,FF_num[15]);
	FD2 df19_16(Q[16],D[16],CLK,RESET,FF_num[16]);
	FD2 df19_17(Q[17],D[17],CLK,RESET,FF_num[17]);
	// FD2(Q[19],D[19],CLK,RESET,number);
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 18; j = j + 1) begin 
			sum = sum + FF_num[j];
		end
	end

	assign number = sum;
	
endmodule

module DFF19(Q,D,CLK,RESET,number);
	// tmp, enable, B
	output [18:0] Q;
	output [50:0] number;
	input [18:0] D;
	input CLK;
	input RESET;
	wire [50:0] FF_num[0:18];
	
	FD2 df19_0(Q[0],D[0],CLK,RESET,FF_num[0]);
	FD2 df19_1(Q[1],D[1],CLK,RESET,FF_num[1]);
	FD2 df19_2(Q[2],D[2],CLK,RESET,FF_num[2]);
	FD2 df19_3(Q[3],D[3],CLK,RESET,FF_num[3]);
	FD2 df19_4(Q[4],D[4],CLK,RESET,FF_num[4]);
	FD2 df19_5(Q[5],D[5],CLK,RESET,FF_num[5]);
	FD2 df19_6(Q[6],D[6],CLK,RESET,FF_num[6]);
	FD2 df19_7(Q[7],D[7],CLK,RESET,FF_num[7]);
	FD2 df19_8(Q[8],D[8],CLK,RESET,FF_num[8]);
	FD2 df19_9(Q[9],D[9],CLK,RESET,FF_num[9]);
	FD2 df19_10(Q[10],D[10],CLK,RESET,FF_num[10]);
	FD2 df19_11(Q[11],D[11],CLK,RESET,FF_num[11]);
	FD2 df19_12(Q[12],D[12],CLK,RESET,FF_num[12]);
	FD2 df19_13(Q[13],D[13],CLK,RESET,FF_num[13]);
	FD2 df19_14(Q[14],D[14],CLK,RESET,FF_num[14]);
	FD2 df19_15(Q[15],D[15],CLK,RESET,FF_num[15]);
	FD2 df19_16(Q[16],D[16],CLK,RESET,FF_num[16]);
	FD2 df19_17(Q[17],D[17],CLK,RESET,FF_num[17]);
	FD2 df19_18(Q[18],D[18],CLK,RESET,FF_num[18]);
	// FD2(Q[19],D[19],CLK,RESET,number);
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 19; j = j + 1) begin 
			sum = sum + FF_num[j];
		end
	end

	assign number = sum;
	
endmodule

module MUX1(Z, A, B, cntl, number);
	input A, B;
	output Z;
	output [50:0] number;
	input cntl; 
	// wire [50:0] MUX5_num;
	MUX21H m0(Z,A,B,cntl, number);
	
	//sum number of transistors
	// reg [50:0] sum;
	// integer j;
	// always @(*) begin
		// sum = 0;
		// for (j = 0; j < 1; j = j + 1) begin 
			// sum = sum + MUX5_num[j];
		// end
	// end

	// assign number = sum;
	
endmodule

module MUX2(Z, A, B, cntl, number);
	input [1:0] A, B;
	output [1:0] Z;
	output [50:0] number;
	input cntl; 
	wire [50:0] MUX5_num[0:1];
	MUX21H m0(Z[0],A[0],B[0],cntl, MUX5_num[0]);
	MUX21H m1(Z[1],A[1],B[1],cntl, MUX5_num[1]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 2; j = j + 1) begin 
			sum = sum + MUX5_num[j];
		end
	end

	assign number = sum;
	
endmodule

module MUX3(Z, A, B, cntl, number);
	input [2:0] A, B;
	output [2:0] Z;
	output [50:0] number;
	input cntl; 
	wire [50:0] MUX5_num[0:2];
	MUX21H m0(Z[0],A[0],B[0],cntl, MUX5_num[0]);
	MUX21H m1(Z[1],A[1],B[1],cntl, MUX5_num[1]);
	MUX21H m2(Z[2],A[2],B[2],cntl, MUX5_num[2]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 3; j = j + 1) begin 
			sum = sum + MUX5_num[j];
		end
	end

	assign number = sum;
	
endmodule

module MUX4(Z, A, B, cntl, number);
	input [3:0] A, B;
	output [3:0] Z;
	output [50:0] number;
	input cntl; 
	wire [50:0] MUX5_num[0:3];
	MUX21H m0(Z[0],A[0],B[0],cntl, MUX5_num[0]);
	MUX21H m1(Z[1],A[1],B[1],cntl, MUX5_num[1]);
	MUX21H m2(Z[2],A[2],B[2],cntl, MUX5_num[2]);
	MUX21H m3(Z[3],A[3],B[3],cntl, MUX5_num[3]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 4; j = j + 1) begin 
			sum = sum + MUX5_num[j];
		end
	end

	assign number = sum;
	
endmodule

module MUX5(Z, A, B, cntl, number);
	input [4:0] A, B;
	output [4:0] Z;
	output [50:0] number;
	input cntl; 
	wire [50:0] MUX5_num[0:4];
	MUX21H m0(Z[0],A[0],B[0],cntl, MUX5_num[0]);
	MUX21H m1(Z[1],A[1],B[1],cntl, MUX5_num[1]);
	MUX21H m2(Z[2],A[2],B[2],cntl, MUX5_num[2]);
	MUX21H m3(Z[3],A[3],B[3],cntl, MUX5_num[3]);
	MUX21H m4(Z[4],A[4],B[4],cntl, MUX5_num[4]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 5; j = j + 1) begin 
			sum = sum + MUX5_num[j];
		end
	end

	assign number = sum;
	
endmodule

module MUX5_6(Z, A, B, cntl, number);
	input [4:0] A, B;
	output [4:0] Z;
	output [50:0] number;
	input cntl; 
	wire [50:0] MUX5_num[0:4];
	MUX21H m0(Z[0],B[0],A[0],cntl, MUX5_num[0]);
	MUX21H m1(Z[1],B[1],A[1],cntl, MUX5_num[1]);
	MUX21H m2(Z[2],B[2],A[2],cntl, MUX5_num[2]);
	MUX21H m3(Z[3],B[3],A[3],cntl, MUX5_num[3]);
	MUX21H m4(Z[4],B[4],A[4],cntl, MUX5_num[4]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 5; j = j + 1) begin 
			sum = sum + MUX5_num[j];
		end
	end

	assign number = sum;
	
endmodule

module MUX6(Z, A, B, cntl, number);
	input [5:0] A, B;
	output [5:0] Z;
	output [50:0] number;
	input cntl; 
	wire [50:0] MUX6_num[0:5];
	MUX21H m0(Z[0],A[0],B[0],cntl, MUX6_num[0]);
	MUX21H m1(Z[1],A[1],B[1],cntl, MUX6_num[1]);
	MUX21H m2(Z[2],A[2],B[2],cntl, MUX6_num[2]);
	MUX21H m3(Z[3],A[3],B[3],cntl, MUX6_num[3]);
	MUX21H m4(Z[4],A[4],B[4],cntl, MUX6_num[4]);
	MUX21H m5(Z[5],A[5],B[5],cntl, MUX6_num[5]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 6; j = j + 1) begin 
			sum = sum + MUX6_num[j];
		end
	end

	assign number = sum;
	
endmodule


module FS6(
	input [5:0] X,
	input [5:0] Y,
	output [5:0] D, 
	output Bo, 
	output [50:0] number
);

	wire [50:0] FS6_5_num [0:7];
	wire Bin_tmp[0:4];
	wire  X5_bar;
	wire tmpp;
	
	HS fs6_1(X[0], Y[0], D[0], Bin_tmp[0], FS6_5_num[0]);
	FS fs6_2(X[1], Y[1], Bin_tmp[0], D[1], Bin_tmp[1], FS6_5_num[1]);
	FS fs6_3(X[2], Y[2], Bin_tmp[1], D[2], Bin_tmp[2], FS6_5_num[2]);
	FS fs6_4(X[3], Y[3], Bin_tmp[2], D[3], Bin_tmp[3], FS6_5_num[3]);
	FS fs6_5(X[4], Y[4], Bin_tmp[3], D[4], Bin_tmp[4], FS6_5_num[4]);
	// EO eo0(D[5], X[5], Bin_tmp[4], FS6_5_num[5]);
	IV inv0(X5_bar, X[5], FS6_5_num[5]);
	ND2 an0(Bo, X5_bar, Bin_tmp[4], FS6_5_num[6]);
	
	
	
	// FS fs6_6(X[5], Y[5], Bin_tmp[4], D[5], Bo, FS6_5_num[5]); // this can be optimize further!!!
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 7; j = j + 1) begin 
			sum = sum + FS6_5_num[j];
		end
	end

	assign number = sum;

endmodule

module FS1(
	input  [5:0] X,
	input  [5:0] Y,
	output [5:0] D, 
	output Bo, 
	output [50:0] number
);
	wire [50:0] FS1_num [0:7];
	wire HS_Bo, HS_Bo_bar;
	wire tmp;
	HS fs6_1(X[0], Y[0], D[0], HS_Bo, FS1_num[0]);
	IV inv0(HS_Bo_bar, HS_Bo, FS1_num[1]);
	NR4 nr4_0(tmp, Y[4], Y[3], Y[2], Y[1], FS1_num[2]);
	ND2 nd2_0(Bo, HS_Bo_bar, tmp, FS1_num[3]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 4; j = j + 1) begin 
			sum = sum + FS1_num[j];
		end
	end

	assign number = sum;
	

endmodule

module FS2(
	input  [5:0] X,
	input  [5:0] Y,
	output [5:0] D, 
	output Bo, 
	output [50:0] number
);
	wire [50:0] FS2_num [0:4];
	wire Bin_tmp[0:1];
	wire HS_Bo, HS_Bo_bar;
	wire tmp;
	HS fs6_1(X[0], Y[0], D[0], Bin_tmp[0], FS2_num[0]);
	FS fs6_2(X[1], Y[1], Bin_tmp[0], D[1], Bin_tmp[1], FS2_num[1]);
	IV inv0(HS_Bo_bar, Bin_tmp[1], FS2_num[2]);
	NR3 nr4_0(tmp, Y[4], Y[3], Y[2], FS2_num[3]);
	ND2 nd2_0(Bo, HS_Bo_bar, tmp, FS2_num[4]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 5; j = j + 1) begin 
			sum = sum + FS2_num[j];
		end
	end

	assign number = sum;
	

endmodule

module FS3(
	input  [5:0] X,
	input  [5:0] Y,
	output [5:0] D, 
	output Bo, 
	output [50:0] number
);
	wire [50:0] FS3_num [0:5];
	wire Bin_tmp[0:2];
	wire HS_Bo, HS_Bo_bar;
	wire tmp;
	HS fs6_1(X[0], Y[0], D[0], Bin_tmp[0], FS3_num[0]);
	FS fs6_2(X[1], Y[1], Bin_tmp[0], D[1], Bin_tmp[1], FS3_num[1]);
	FS fs6_3(X[2], Y[2], Bin_tmp[1], D[2], Bin_tmp[2], FS3_num[2]);
	IV inv0(HS_Bo_bar, Bin_tmp[2], FS3_num[3]);
	NR2 nr4_0(tmp, Y[4], Y[3], FS3_num[4]);
	ND2 nd2_0(Bo, HS_Bo_bar, tmp, FS3_num[5]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 6; j = j + 1) begin 
			sum = sum + FS3_num[j];
		end
	end

	assign number = sum;
	

endmodule

module FS4(
	input  [5:0] X,
	input  [5:0] Y,
	output [5:0] D, 
	output Bo, 
	output [50:0] number
);
	wire [50:0] FS4_num [0:4];
	wire Bin_tmp[0:3];
	wire HS_Bo, HS_Bo_bar;
	wire tmp;
	HS fs6_1(X[0], Y[0], D[0], Bin_tmp[0], FS4_num[0]);
	FS fs6_2(X[1], Y[1], Bin_tmp[0], D[1], Bin_tmp[1], FS4_num[1]);
	FS fs6_3(X[2], Y[2], Bin_tmp[1], D[2], Bin_tmp[2], FS4_num[2]);
	FS fs6_4(X[3], Y[3], Bin_tmp[2], D[3], Bin_tmp[3], FS4_num[3]);
	// IV inv0(HS_Bo_bar, Bin_tmp[3], FS4_num[4]);
	// IV nr4_0(tmp, Y[4], FS4_num[5]);
	OR2 nd2_0(Bo, Bin_tmp[3], Y[4], FS4_num[4]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 5; j = j + 1) begin 
			sum = sum + FS4_num[j];
		end
	end

	assign number = sum;
	

endmodule

module FS5(
	input  [5:0] X,
	input  [5:0] Y,
	output [5:0] D, 
	output Bo, 
	output [50:0] number
);
	wire [50:0] FS5_num [0:4];
	wire Bin_tmp[0:3];
	wire HS_Bo, HS_Bo_bar;
	wire tmp;
	HS fs6_1(X[0], Y[0], D[0], Bin_tmp[0], FS5_num[0]);
	FS fs6_2(X[1], Y[1], Bin_tmp[0], D[1], Bin_tmp[1], FS5_num[1]);
	FS fs6_3(X[2], Y[2], Bin_tmp[1], D[2], Bin_tmp[2], FS5_num[2]);
	FS fs6_4(X[3], Y[3], Bin_tmp[2], D[3], Bin_tmp[3], FS5_num[3]);
	FS fs6_5(X[4], Y[4], Bin_tmp[3], D[4], Bo, FS5_num[4]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 5; j = j + 1) begin 
			sum = sum + FS5_num[j];
		end
	end

	assign number = sum;
	

endmodule



// 1-bit half subtractor
module HS(
	input X,
	input Y,
	output D,
	output Bout,
	output [50:0] number
);

	wire [50:0] HS_num[2:0];
	wire [2:0] tmp;

	EO xor0(D, X, Y, HS_num[0]);
	IV inv0(tmp[0], X, HS_num[1]);
	AN2 and0(Bout, tmp[0], Y, HS_num[2]);

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 3; j = j + 1) begin 
			sum = sum + HS_num[j];
		end
	end

	assign number = sum;
	
endmodule


module FS(A, B, Bi, D, Bo, number);
	input A, B, Bi;
	output Bo, D;
	output[50:0] number;
	wire A_bar, B_bar;
	wire [2:0] tmp;
	wire [50:0] FS_num[0:5];
	
	IV inv0(A_bar, A, FS_num[0]);
	EO3 eo0(D, A, B, Bi, FS_num[1]);
	ND2 nd1(tmp[0], A_bar, Bi, FS_num[2]);
	ND2 nd2(tmp[1], A_bar, B, FS_num[3]);
	ND2 nd3(tmp[2], B, Bi, FS_num[4]);
	ND3 nd4(Bo, tmp[0], tmp[1], tmp[2], FS_num[5]);

	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 6; j = j + 1) begin 
			sum = sum + FS_num[j];
		end
	end

	assign number = sum;
	
endmodule



module comparator(big_or_eq, A, B, number);
// A is 6 bit while B is 5 bit, this is for divider sub compare
	input [5:0] A;
	input [4:0] B;
	output big_or_eq;
	output [50:0] number;
	
	wire [12:0] tmp;
	wire [3:0] tmp54;
	wire [2:0] tmp10;
	wire [7:0] tmp_final;
	wire [5:0] A_bar;
	wire [4:0] B_bar;
	wire [50:0] com_num[0:33];

	IV invA5(A_bar[5], A[5], com_num[0]);
	IV invA4(A_bar[4], A[4], com_num[1]);
	IV invA3(A_bar[3], A[3], com_num[2]);
	IV invA2(A_bar[2], A[2], com_num[3]);
	IV invA1(A_bar[1], A[1], com_num[4]);
	IV invA0(A_bar[0], A[0], com_num[5]);

	IV invB4(B_bar[4], B[4], com_num[6]);
	IV invB3(B_bar[3], B[3], com_num[7]);
	IV invB2(B_bar[2], B[2], com_num[8]);
	IV invB1(B_bar[1], B[1], com_num[9]);
	IV invB0(B_bar[0], B[0], com_num[10]);

	//A[5:4] > B[5:4]
	ND2 nd5_1(tmp54[0], A[4], B_bar[4], com_num[11]);
	ND2 nd5_2(tmp54[1], A_bar[5], tmp54[0], com_num[12]);
	// A[5:4] == B[5:4]
	EO eo5_0(tmp54[2], A[4], B[4], com_num[13]);
	NR2 nr5_2(tmp54[3], tmp54[2], A[5], com_num[14]);
	
	//A[3:2] > B[3:2]
	ND2 nand1(tmp[8], A[3], B_bar[3], com_num[15]);
	ND3 nand2(tmp[7], A[3], A[2], B_bar[2], com_num[16]);
	ND3 nand3(tmp[6], A[2], B_bar[3], B_bar[2], com_num[17]);
	ND3 nand4(tmp[5], tmp[8], tmp[7], tmp[6], com_num[18]);
	// A[3:2] = B[3:2]
	EO eo1(tmp[9], A[3], B[3], com_num[19]);
	EO eo2(tmp[10], A[2], B[2], com_num[20]);
	NR2 nor2(tmp[11], tmp[9], tmp[10], com_num[21]);
	
	//A[1:0] > B[1:0]
	ND2 nand5(tmp[4], A[1], B_bar[1], com_num[22]);
	ND3 nand6(tmp[3], A[1], A[0], B_bar[0], com_num[23]);
	ND3 nand7(tmp[2], A[0], B_bar[1], B_bar[0], com_num[24]);
	ND3 nand8(tmp[1], tmp[4], tmp[3], tmp[2], com_num[25]);
	// A[1:0] == B[1:0]
	EO eo11(tmp10[0], A[1], B[1], com_num[26]);
	EO eo10(tmp10[1], A[0], B[0], com_num[27]);
	NR2 nr10(tmp10[2], tmp10[1], tmp10[0], com_num[28]);
	
	
	
	
	//big = (A[5:4] > B[5:4]) or (A[5:4] = B[5:4] and A[3:2] > B[3:2]) or (A[5:4] = B[5:4] and A[3:2] = B[3:2] and A[1:0] > B[1:0])
	IV ivv1(tmp_final[0], tmp54[1], com_num[29]);
	ND2 ndd2(tmp_final[1], tmp54[3], tmp[5], com_num[30]);
	ND3 ndd3_1(tmp_final[2], tmp54[3], tmp[11], tmp[1], com_num[31]);
	ND3 ndd3_2(tmp_final[3], tmp54[3], tmp[11], tmp10[2], com_num[32]); // three are equal
	ND4 ndd4_1(big_or_eq, tmp_final[0], tmp_final[1], tmp_final[2], tmp_final[3], com_num[33]);
	
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 34; j = j + 1) begin 
			sum = sum + com_num[j];
		end
	end

	assign number = sum;
	

endmodule

//BW-bit FD2
module REGP#(
	parameter BW = 2
)(
	input clk,
	input rst_n,
	output [BW-1:0] Q,
	input [BW-1:0] D,
	output [50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule

module OR5_1(Z, A, B, C, D, E, number);
	// if equal then output 1
	output [50:0] number;
	wire [50:0] number_t[0:2];
	input A, B, C, D, E;
	output Z;
	wire [1:0] tmp;

	NR3 norc1(tmp[0], A, B, C, number_t[0]);
	NR2 norc2(tmp[1], D, E, number_t[1]);
	ND2 nandc1(Z, tmp[0], tmp[1], number_t[2]);
	//sum number of transistors
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j = 0; j < 3; j = j + 1) begin 
			sum = sum + number_t[j];
		end
	end

	assign number = sum;
	


endmodule







