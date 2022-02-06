`timescale 1ns/1ps

module mode_max(mode, i0, i1, i2, i3, i4);
//DO NOT CHANGE!
	input  [3:0] i0, i1, i2, i3, i4;
	output [3:0] mode;
//---------------------------------------------------
	wire [3:0] case1a, case2a, case3a, case4a, case5a, case6a;
	wire [19:0] case5_subans;
	wire [39:0] case4_subans;
	wire [9:0] tmp, tmp_bar;
	wire [4:0] tmp3;
	wire [9:0] tmp2;
	wire [14:0] tmp1;
	wire case6, case5, case4, case3, case2, case1; // control signal
	wire case6_bar, case5_bar, case4_bar, case2_bar; // , case3_bar
	wire case3_0_1, case3_0_2, case3_0_3, case3_0_4, case3_1_3, case3_1_4;
	wire [3:0] max0_1, max0_2, max0_3, max0_4, max1_3, max1_4;
	//wire [3:0] max0_1_bar, max0_3_bar, max0_4_bar, max1_3_bar, max1_4_bar;
	wire [3:0] tmp_ans3_0_1, tmp_ans3_0_2, tmp_ans3_0_3, tmp_ans3_0_4, tmp_ans3_1_3, tmp_ans3_1_4;
	// wire case3_c11, case3_c12, case3_c13, case3_c14, case3_c15, case3_c16, case3_c17, case3_c18, case3_c19, case3_c1a;
	wire case3_c21, case3_c22, case3_c23, case3_c24, case3_c25, case3_c26, case3_c27, case3_c28, case3_c29, case3_c2a, case3_c2b, case3_c2c, case3_c2d, case3_c2e, case3_c2f;
	wire case3_c1, case3_c2, case3_c3, case3_c4, case3_c5, case3_c6, case3_c7, case3_c8, case3_c9, case3_ca, case3_cb, case3_cc, case3_cd, case3_ce, case3_cf;
	wire [3:0] case3_a1, case3_a2, case3_a3, case3_a4, case3_a5, case3_a6, case3_a7, case3_a8, case3_a9, case3_aa, case3_ab, case3_ac, case3_ad, case3_ae, case3_af;
	wire pre2_bar;
	wire case2_1, case2_2, case2_3, case2_4, case2_5, case2_6, case2_7, case2_8, case2_9, case2_10;
	wire case2_1n, case2_2n, case2_3n, case2_4n, case2_5n, case2_6n, case2_7n, case2_8n, case2_9n, case2_10n;
	wire case2_1c, case2_2c, case2_3c, case2_4c, case2_5c, case2_6c, case2_7c, case2_8c, case2_9c, case2_10c;
	wire [3:0] case2_1a, case2_2a, case2_3a, case2_4a, case2_5a, case2_6a, case2_7a, case2_8a, case2_9a, case2_10a;
	wire [3:0] case1_max;
	wire case1_c;
	
	equaler e0(tmp[0], i0, i1);
	equaler e1(tmp[1], i0, i2);
	equaler e2(tmp[2], i0, i3);
	equaler e3(tmp[3], i0, i4);
	equaler e4(tmp[4], i1, i2);
	equaler e5(tmp[5], i1, i3);
	equaler e6(tmp[6], i1, i4);
	equaler e7(tmp[7], i2, i3);
	equaler e8(tmp[8], i2, i4);
	equaler e9(tmp[9], i3, i4);
	IV inv_tmp0(tmp_bar[0], tmp[0]);
	IV inv_tmp1(tmp_bar[1], tmp[1]);
	IV inv_tmp2(tmp_bar[2], tmp[2]);
	IV inv_tmp3(tmp_bar[3], tmp[3]);
	IV inv_tmp4(tmp_bar[4], tmp[4]);
	IV inv_tmp5(tmp_bar[5], tmp[5]);
	IV inv_tmp6(tmp_bar[6], tmp[6]);
	IV inv_tmp7(tmp_bar[7], tmp[7]);
	IV inv_tmp8(tmp_bar[8], tmp[8]);
	IV inv_tmp9(tmp_bar[9], tmp[9]);
	
	////////// four equal case6///////////
	AN4 a461(case6, tmp[0], tmp[1], tmp[2], tmp[3]);
	cntlAND ca461(case6a, case6, i0); // if four then output 1
	ND4 n461(case6_bar, tmp[0], tmp[1], tmp[2], tmp[3]); // *****this can be optimized
	////////// three equal case5/////////
	// a is obsolete
	AN3 a531(tmp3[0], tmp[4], tmp[5], tmp[6]);
	cntlAND ca531(case5_subans[19:16], tmp3[0], i1);
	// b is obsolete
	AN3 a532(tmp3[1], tmp[1], tmp[2], tmp[3]);
	cntlAND ca532(case5_subans[15:12], tmp3[1], i0);
	// c is obsolete
	AN3 a533(tmp3[2], tmp[0], tmp[5], tmp[6]);
	cntlAND ca533(case5_subans[11:8], tmp3[2], i1);
	// d is obsolete
	AN3 a534(tmp3[3], tmp[0], tmp[1], tmp[8]);
	cntlAND ca534(case5_subans[7:4], tmp3[3], i1);
	// e is obsolete
	AN3 a535(tmp3[4], tmp[0], tmp[1], tmp[2]);
	cntlAND ca535(case5_subans[3:0], tmp3[4], i1);
	// combine five subanswer
	OR5_4 o5541(case5a, case5_subans[19:16], case5_subans[15:12], case5_subans[11:8], case5_subans[7:4], case5_subans[3:0]);
	NOR5_1 no5541(case5_bar, tmp3[0], tmp3[1], tmp3[2], tmp3[3], tmp3[4]);
	////////// two equal case4////////////
	// a, b is obsolete 23 24
	AN2 a431(tmp2[0], tmp[7], tmp[8]);
	cntlAND ca41(case4_subans[39:36], tmp2[0], i2);
	// a, c is obsolete 13 14
	AN2 a42(tmp2[1], tmp[5], tmp[6]);
	cntlAND ca42(case4_subans[35:32], tmp2[1], i1);
	// a, d is obsolete 12 14
	AN2 a43(tmp2[2], tmp[4], tmp[6]);
	cntlAND ca43(case4_subans[31:28], tmp2[2], i1);
	// a, e is obsolete 12 13
	AN2 a44(tmp2[3], tmp[4], tmp[5]);
	cntlAND ca44(case4_subans[27:24], tmp2[3], i1);
	// b, c is obsolete 03 04
	AN2 a45(tmp2[4], tmp[2], tmp[3]);
	cntlAND ca45(case4_subans[23:20], tmp2[4], i0);
	// b, d is obsolete 02 04
	AN2 a46(tmp2[5], tmp[1], tmp[3]);
	cntlAND ca46(case4_subans[19:16], tmp2[5], i0);
	// b, e is obsolete 02 03
	AN2 a47(tmp2[6], tmp[1], tmp[2]);
	cntlAND ca47(case4_subans[15:12], tmp2[6], i0);
	// c, d is obsolete 01 04
	AN2 a48(tmp2[7], tmp[0], tmp[3]);
	cntlAND ca48(case4_subans[11:8], tmp2[7], i0);
	// c, e is obsolete 01 03
	AN2 a49(tmp2[8], tmp[0], tmp[2]);
	cntlAND ca49(case4_subans[7:4], tmp2[8], i0);
	// d, e is obsolete 01 02
	AN2 a4a(tmp2[9], tmp[0], tmp[1]);
	cntlAND ca4a(case4_subans[3:0], tmp2[9], i0);
	// combine 10 subanswer
	OR10_4 or4_10_1(case4a, case4_subans[39:36], case4_subans[35:32], case4_subans[31:28], case4_subans[27:24], case4_subans[23:20], case4_subans[19:16], case4_subans[15:12], case4_subans[11:8], case4_subans[7:4], case4_subans[3:0]);
	
	NOR10_1 nor4_10_1(case4_bar, tmp2[0], tmp2[1], tmp2[2], tmp2[3], tmp2[4], tmp2[5], tmp2[6], tmp2[7], tmp2[8], tmp2[9]);
	
	
	///////////// one equal, with a, a, b, b, 0 case3 ////////////
	MAX mx3_0_1(max0_1, i0, i1);
	MAX mx3_0_2(max0_2, i0, i2);
	MAX mx3_0_3(max0_3, i0, i3);
	MAX mx3_0_4(max0_4, i0, i4);
	MAX mx3_1_3(max1_3, i1, i3);
	MAX mx3_1_4(max1_4, i1, i4);
	// use XOR=0 to check
	// make sure that previous condition isn't true	
	// IV(case6)
	// NOR5(case5)
	// NOR10(case4)
	
	
	// aabbc 1     1, 3
	// AN2 a31(tmp1[0], tmp[0], tmp[7]);
	// NOR8_1 nr31(case3_c21, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[8], tmp[9]);
	// AN2 a311(case3_c1, tmp1[0], case3_c21);
	AN10_1 or3_1(case3_c1, tmp[0], tmp[7], tmp_bar[1], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[6], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_1(case3_a1, case3_c1, max1_3);
	
	// aabcb 2     1, 4
	// AN2 a32(tmp1[1], tmp[0], tmp[8]);
	// NOR8_1 nr32(case3_c22, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[9]);
	// AN2 a312(case3_c2, tmp1[1], case3_c22);
	AN10_1 or3_2(case3_c2, tmp[0], tmp[8], tmp_bar[1], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[6], tmp_bar[7], tmp_bar[9]);
	cntlAND ca3_2(case3_a2, case3_c2, max1_4);
	
	// aacbb 3     0, 4
	// AN2 a33(tmp1[2], tmp[0], tmp[9]);
	// NOR8_1 nr33(case3_c23, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[8], tmp[7]);
	// AN2 a313(case3_c3, tmp1[2], case3_c23);
	AN10_1 or3_3(case3_c3, tmp[0], tmp[9], tmp_bar[1], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[6], tmp_bar[8], tmp_bar[7]);
	cntlAND ca3_3(case3_a3, case3_c3, max0_4);
	
	// ababc 4     0, 3 (e 8 e 8 b)
	// AN2 a34(tmp1[3], tmp[1], tmp[5]);
	// NOR8_1  nr34(case3_c24, tmp[0], tmp[2], tmp[3], tmp[4], tmp[6], tmp[7], tmp[8], tmp[9]);
	// AN2 a314(case3_c4, tmp1[3], case3_c24);
	AN10_1 or3_4(case3_c4, tmp[1], tmp[5], tmp_bar[0], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[6], tmp_bar[7], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_4(case3_a4, case3_c4, max0_3);
	
	// abacb 5     0, 1
	// AN2 a35(tmp1[4], tmp[1], tmp[6]);
	// NOR8_1  nr35(case3_c25, tmp[0], tmp[2], tmp[3], tmp[4], tmp[5], tmp[7], tmp[8], tmp[9]);
	// AN2 a315(case3_c5, tmp1[4], case3_c25);
	AN10_1 or3_5(case3_c5, tmp[1], tmp[6], tmp_bar[0], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[7], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_5(case3_a5, case3_c5, max0_1);
	
	// acabb 6     0, 4
	// AN2 a36(tmp1[5], tmp[1], tmp[9]);
	// NOR8_1  nr36(case3_c26, tmp[0], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8]);
	// AN2 a316(case3_c6, tmp1[5], case3_c26);
	AN10_1 or3_6(case3_c6, tmp[1], tmp[9], tmp_bar[0], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[6], tmp_bar[7], tmp_bar[8]);
	cntlAND ca3_6(case3_a6, case3_c6, max0_4);
	
	
	// abbac 7     0,2 ///////////
	// AN2 a37(tmp1[6], tmp[2], tmp[4]);
	// NOR8_1  nr37(case3_c27, tmp[0], tmp[1], tmp[3], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	// AN2 a317(case3_c7, tmp1[6], case3_c27);
	AN10_1 or3_7(case3_c7, tmp[2], tmp[4], tmp_bar[0], tmp_bar[1], tmp_bar[3], tmp_bar[5], tmp_bar[6], tmp_bar[7], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_7(case3_a7, case3_c7, max0_2);
	
	// abcab 8     0, 4
	// AN2 a38(tmp1[7], tmp[2], tmp[6]);
	// NOR8_1  nr38(case3_c28, tmp[0], tmp[1], tmp[3], tmp[4], tmp[5], tmp[7], tmp[8], tmp[9]);
	// AN2 a318(case3_c8, tmp1[7], case3_c28);
	AN10_1 or3_8(case3_c8, tmp[2], tmp[6], tmp_bar[0], tmp_bar[1], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[7], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_8(case3_a8, case3_c8, max0_4);
	
	// acbab 9     0, 2 ////////////////////
	// AN2 a39(tmp1[8], tmp[2], tmp[8]);
	// NOR8_1  nr39(case3_c29, tmp[0], tmp[1], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[9]);
	// AN2 a319(case3_c9, tmp1[8], case3_c29);
	AN10_1 or3_9(case3_c9, tmp[2], tmp[8], tmp_bar[0], tmp_bar[1], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[6], tmp_bar[7], tmp_bar[9]);
	cntlAND ca3_9(case3_a9, case3_c9, max0_2);
	
	// abbca 10    0, 1
	// AN2 a3a(tmp1[9], tmp[3], tmp[4]);
	// NOR8_1  nr3a(case3_c2a, tmp[0],tmp[1], tmp[2], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	// AN2 a31a(case3_ca, tmp1[9], case3_c2a);
	AN10_1 or3_a(case3_ca, tmp[3], tmp[4], tmp_bar[0],tmp_bar[1], tmp_bar[2], tmp_bar[5], tmp_bar[6], tmp_bar[7], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_a(case3_aa, case3_ca, max0_1);
	
	// abcba 11    0, 1
	// AN2 a3b(tmp1[10], tmp[3], tmp[5]);
	// NOR8_1  nr3b(case3_c2b, tmp[0], tmp[1], tmp[2], tmp[4], tmp[6], tmp[7], tmp[8], tmp[9]);
	// AN2 a31b(case3_cb, tmp1[10], case3_c2b);
	AN10_1 or3_b(case3_cb, tmp[3], tmp[5], tmp_bar[0], tmp_bar[1], tmp_bar[2], tmp_bar[4], tmp_bar[6], tmp_bar[7], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_b(case3_ab, case3_cb, max0_1);
	
	// acbba 12    0, 3
	// AN2 a3c(tmp1[11], tmp[3], tmp[7]);
	// NOR8_1  nr3c(case3_c2c, tmp[0], tmp[1], tmp[2], tmp[4], tmp[5], tmp[6], tmp[8], tmp[9]);
	// AN2 a31c(case3_cc, tmp1[11], case3_c2c);
	AN10_1 or3_c(case3_cc, tmp[3], tmp[7], tmp_bar[0], tmp_bar[1], tmp_bar[2], tmp_bar[4], tmp_bar[5], tmp_bar[6], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_c(case3_ac, case3_cc, max0_3);
	
	// caabb 13    1, 4
	// AN2 a3d(tmp1[12], tmp[4], tmp[9]);
	// NOR8_1  nr3d(case3_c2d, tmp[0], tmp[1], tmp[2], tmp[3], tmp[5], tmp[6], tmp[7], tmp[8]);
	// AN2 a31d(case3_cd, tmp1[12], case3_c2d);
	AN10_1 or3_d(case3_cd, tmp[4], tmp[9], tmp_bar[0], tmp_bar[1], tmp_bar[2], tmp_bar[3], tmp_bar[5], tmp_bar[6], tmp_bar[7], tmp_bar[8]);
	cntlAND ca3_d(case3_ad, case3_cd, max1_4);
	
	// cabab 14    1, 4
	// AN2 a3e(tmp1[13], tmp[5], tmp[8]);
	// NOR8_1  nr3e(case3_c2e, tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[6], tmp[7], tmp[9]);
	// AN2 a31e(case3_ce, tmp1[13], case3_c2e);
	AN10_1 or3_e(case3_ce, tmp[5], tmp[8], tmp_bar[0], tmp_bar[1], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[6], tmp_bar[7], tmp_bar[9]);
	cntlAND ca3_e(case3_ae, case3_ce, max1_4);
	
	// cabba 15    1, 3
	// AN2 a3f(tmp1[14], tmp[6], tmp[7]);
	// NOR8_1  nr3f(case3_c2f, tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[8], tmp[9]);
	// AN2 a31f(case3_cf, tmp1[14], case3_c2f);
	AN10_1 or3_f(case3_cf, tmp[6], tmp[7], tmp_bar[0], tmp_bar[1], tmp_bar[2], tmp_bar[3], tmp_bar[4], tmp_bar[5], tmp_bar[8], tmp_bar[9]);
	cntlAND ca3_f(case3_af, case3_cf, max1_3);
	
	// case3_0_1
	// //OR3(case3_0_1, tmp1[4], tmp1[8], tmp1[9]); // *** this can be optimized , case3_c9
	// OR3 or3_0_1(case3_0_1, case3_c5, case3_ca, case3_cb);
	// MAX mx3_0_1(max0_1, i0, i1);
	// cntlAND ca3_0_1(tmp_ans3_0_1, case3_0_1, max0_1);
	
	// case3_0_2
	// OR2 or3_0_2(case3_0_2, case3_c9, case3_c7);
	// MAX mx3_0_2(max0_2, i0, i2);
	// cntlAND ca3_0_2(tmp_ans3_0_2, case3_0_2, max0_2);
	
	// case3_0_3
	// //OR3(case3_0_3, tmp1[3], tmp1[8], tmp1[11]);
	// OR2 or3_0_3(case3_0_3, case3_c4, case3_cc);
	// MAX mx3_0_3(max0_3, i0, i3);
	// cntlAND ca3_0_3(tmp_ans3_0_3, case3_0_3, max0_3);
	
	// case3_0_4
	// // OR3(case3_0_4, tmp1[2], tmp1[5], tmp1[7]);
	// OR3 or3_0_4(case3_0_4, case3_c3, case3_c6, case3_c8);
	// MAX mx3_0_4(max0_4, i0, i4);
	// cntlAND ca3_0_4(tmp_ans3_0_4, case3_0_4, max0_4);
	
	// case3_1_3
	// // OR3(case3_1_3, tmp1[0], tmp1[6], tmp1[14]); , case3_c7
	// OR2 or3_1_3(case3_1_3, case3_c1, case3_cf);
	// MAX mx3_1_3(max1_3, i1, i3);
	// cntlAND ca3_1_3(tmp_ans3_1_3, case3_1_3, max1_3);
	
	// case3_1_4
	// // OR3(case3_1_4, tmp1[1], tmp1[12], tmp1[13]);
	// OR3 or3_1_4(case3_1_4, case3_c2, case3_cd, case3_ce);
	// MAX mx3_1_4(max1_4, i1, i4);
	// cntlAND ca3_1_4(tmp_ans3_1_4, case3_1_4, max1_4);
	
	//OR6_4 or3_5_4(case3a, tmp_ans3_0_1, tmp_ans3_0_2, tmp_ans3_0_3, tmp_ans3_0_4, tmp_ans3_1_3, tmp_ans3_1_4);
	
	OR15_4 or3_15_4(case3a, case3_a1, case3_a2, case3_a3, case3_a4, case3_a5, case3_a6, case3_a7, case3_a8, case3_a9, case3_aa, case3_ab, case3_ac, case3_ad, case3_ae, case3_af);
	
	///////////// one equal, with a, a, 0, 0, 0 case2 ////////////
	// let one same pass
	// rank0 of 5 numbers
	// make sure that previous condition wasn't true
	// IV(case6)
	// NOR5(case5)
	// NOR10(case4)
	// NOR15(case3)
	// 10 cases --> 3 3 2 2
	// AN4(pre2_bar, case3_bar, case4_bar, case5_bar, case6_bar); // this may be optimized
	// don't use precious case_bar, it may insrease critical path!
	
	// tmp[0]
	NOR9_1 nor2_1(case2_1n, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	AN2 an2_1(case2_1c, tmp[0], case2_1n);
	cntlAND ca2_1(case2_1a, case2_1c, i0);
	// tmp[1]
	NOR9_1 nor2_2(case2_2n, tmp[0], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	AN2 an2_2(case2_2c, tmp[1], case2_2n);
	cntlAND ca2_2(case2_2a, case2_2c, i0);
	// tmp[2]
	NOR9_1 nor2_3(case2_3n, tmp[1], tmp[0], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	AN2 an2_3(case2_3c, tmp[2], case2_3n);
	cntlAND ca2_3(case2_3a, case2_3c, i0);
	// tmp[3]
	NOR9_1 nor2_4(case2_4n, tmp[1], tmp[2], tmp[0], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	AN2 an2_4(case2_4c, tmp[3], case2_4n);
	cntlAND ca2_4(case2_4a, case2_4c, i0);
	// tmp[4]
	NOR9_1 nor2_5(case2_5n, tmp[1], tmp[2], tmp[3], tmp[0], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	AN2 an2_5(case2_5c, tmp[4], case2_5n);
	cntlAND ca2_5(case2_5a, case2_5c, i1);
	// tmp[5]
	NOR9_1 nor2_6(case2_6n, tmp[1], tmp[2], tmp[3], tmp[4], tmp[0], tmp[6], tmp[7], tmp[8], tmp[9]);
	AN2 an2_6(case2_6c, tmp[5], case2_6n);
	cntlAND ca2_6(case2_6a, case2_6c, i1);
	// tmp[6]
	NOR9_1 nor2_7(case2_7n, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[0], tmp[7], tmp[8], tmp[9]);
	AN2 an2_7(case2_7c, tmp[6], case2_7n);
	cntlAND ca2_7(case2_7a, case2_7c, i1);
	// tmp[7]
	NOR9_1 nor2_8(case2_8n, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[0], tmp[8], tmp[9]);
	AN2 an2_8(case2_8c, tmp[7], case2_8n);
	cntlAND ca2_8(case2_8a, case2_8c, i2);
	// tmp[8]
	NOR9_1 nor2_9(case2_9n, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[0], tmp[9]);
	AN2 an2_9(case2_9c, tmp[8], case2_9n);
	cntlAND ca2_9(case2_9a, case2_9c, i2);
	// tmp[9]
	NOR9_1 nor2_a(case2_10n, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8], tmp[0]);
	AN2 an2_a(case2_10c, tmp[9], case2_10n);
	cntlAND ca2_a(case2_10a, case2_10c, i3);
	
	OR10_4 or2_10_4(case2a, case2_1a, case2_2a, case2_3a, case2_4a, case2_5a, case2_6a, case2_7a, case2_8a, case2_9a, case2_10a);
	
	
	
	
	
	///////////// zero equal case1////////////////////
	// same check as a, a, b, b, 0 !?
	MAX5 mx1_5(case1_max, i0, i1, i2, i3, i4);
	NOR10_1 nor1_10_1(case1_c, tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7], tmp[8], tmp[9]);
	cntlAND ca1_1(case1a, case1_c, case1_max);
	
	OR6_4 or1_6_4(mode, case6a, case5a, case4a, case2a, case1a, case3a);

endmodule

module MAX(Z, A, B);
	input [3:0] A, B;
	output [3:0] Z;
	wire cntl; // whether A>B
	
	comparator com(cntl, A, B);
	MUX21H m0(Z[0],B[0],A[0],cntl);
	MUX21H m1(Z[1],B[1],A[1],cntl);
	MUX21H m2(Z[2],B[2],A[2],cntl);
	MUX21H m3(Z[3],B[3],A[3],cntl);
	
endmodule

module MAX5(Z, A, B, C, D, E);
	input [3:0] A, B, C, D, E;
	output [3:0] Z;
	wire [3:0] tmp_ansA, tmp_ansB, tmp_ansC, tmp_ansD, tmp_ansE;
	wire [3:0] tmp1, tmp2, tmp3, tmp4, tmp5;
	comparator co0(tmp1[0], A, B);
	comparator co1(tmp1[1], A, C);
	comparator co2(tmp1[2], A, D);
	comparator co3(tmp1[3], A, E);
	comparator co4(tmp2[0], B, A);
	comparator co5(tmp2[1], B, C);
	comparator co6(tmp2[2], B, D);
	comparator co7(tmp2[3], B, E);
	comparator co8(tmp3[0], C, A);
	comparator co9(tmp3[1], C, B);
	comparator co10(tmp3[2], C, D);
	comparator co11(tmp3[3], C, E);
	comparator co12(tmp4[0], D, A);
	comparator co13(tmp4[1], D, B);
	comparator co14(tmp4[2], D, C);
	comparator co15(tmp4[3], D, E);
	comparator co16(tmp5[0], E, A);
	comparator co17(tmp5[1], E, B);
	comparator co18(tmp5[2], E, C);
	comparator co19(tmp5[3], E, D);
	
	// A
	cntlAN4 ca1(tmp_ansA, A, tmp1[0], tmp1[1], tmp1[2], tmp1[3]);
	cntlAN4 ca2(tmp_ansB, B, tmp2[0], tmp2[1], tmp2[2], tmp2[3]);
	cntlAN4 ca3(tmp_ansC, C, tmp3[0], tmp3[1], tmp3[2], tmp3[3]);
	cntlAN4 ca4(tmp_ansD, D, tmp4[0], tmp4[1], tmp4[2], tmp4[3]);
	cntlAN4 ca5(tmp_ansE, E, tmp5[0], tmp5[1], tmp5[2], tmp5[3]);
	
	OR5_4 or54(Z, tmp_ansA, tmp_ansB, tmp_ansC, tmp_ansD, tmp_ansE);
	

endmodule

module cntlAN4(Z, A, c1, c2, c3, c4);
	input [3:0] A;
	input c1, c2, c3, c4;
	output [3:0] Z;
	wire [4:0] tmp; 
	
	ND4 and1(tmp[0], c1, c2, c3, c4);
	IV in01(tmp[1], A[0]);
	IV in02(tmp[2], A[1]);
	IV in03(tmp[3], A[2]);
	IV in04(tmp[4], A[3]);
	NR2 nor01(Z[0], tmp[0], tmp[1]);
	NR2 nor02(Z[1], tmp[0], tmp[2]);
	NR2 nor03(Z[2], tmp[0], tmp[3]);
	NR2 nor04(Z[3], tmp[0], tmp[4]);

endmodule

module NOR8_1(Z, A, B, C, D, E, F, G, H);
	input A, B, C, D, E, F, G, H;
	output Z;
	wire [3:0] tmp;
	
	NR3 nr1(tmp[0], A, B, C);
	NR3 nr2(tmp[1], C, D, E);
	NR2 nr3(tmp[2], F, G);
	AN3 an1(Z, tmp[0], tmp[1], tmp[2]);
	
endmodule

module NOR9_1(Z, A, B, C, D, E, F, G, H, I);
	input A, B, C, D, E, F, G, H, I;
	output Z;
	wire [2:0] tmp;
	
	NR3 nr1(tmp[0], A, B, C);
	NR3 nr2(tmp[1], D, E, F);
	NR3 nr3(tmp[2], G, H, I);
	AN3 an1(Z, tmp[0], tmp[1], tmp[2]);
	
endmodule
	

module comparator(big, A, B);
	input [3:0] A, B;
	output big;
	
	wire [12:0] tmp;
	wire [3:0] A_bar, B_bar;

	IV invA3(A_bar[3], A[3]);
	IV invA2(A_bar[2], A[2]);
	IV invA1(A_bar[1], A[1]);
	IV invA0(A_bar[0], A[0]);

	IV invB3(B_bar[3], B[3]);
	IV invB2(B_bar[2], B[2]);
	IV invB1(B_bar[1], B[1]);
	IV invB0(B_bar[0], B[0]);

	
	//A[3:2] > B[3:2]
	ND2 nand1(tmp[8], A[3], B_bar[3]);
	ND3 nand2(tmp[7], A[3], A[2], B_bar[2]);
	ND3 nand3(tmp[6], A[2], B_bar[3], B_bar[2]);
	ND3 nand4(tmp[5], tmp[8], tmp[7], tmp[6]);
	//A[1:0] > B[1:0]
	ND2 nand5(tmp[4], A[1], B_bar[1]);
	ND3 nand6(tmp[3], A[1], A[0], B_bar[0]);
	ND3 nand7(tmp[2], A[0], B_bar[1], B_bar[0]);
	ND3 nand8(tmp[1], tmp[4], tmp[3], tmp[2]);
	// A[3:2] = B[3:2]
	EO eo1(tmp[9], A[3], B[3]);
	EO eo2(tmp[10], A[2], B[2]);
	NR2 nor2(tmp[11], tmp[9], tmp[10]);
	//big = A[3:2] > B[3:2] or (A[3:2] = B[3:2] and A[1:0] > B[1:0])
	IV inv1(tmp[0], tmp[5]);
	ND2 nand9(tmp[12], tmp[11], tmp[1]);
	ND2 nand10(big, tmp[12], tmp[0]);
	

endmodule

module OR5_1(Z, A, B, C, D, E);
	// if equal then output 1
	input A, B, C, D, E;
	output Z;
	wire [1:0] tmp;

	NR3 norc1(tmp[0], A, B, C);
	NR2 norc2(tmp[1], D, E);
	ND2 nandc1(Z, tmp[0], tmp[1]);

endmodule

module NOR5_1(Z, A, B, C, D, E);
	// if equal then output 1
	input A, B, C, D, E;
	output Z;
	wire [1:0] tmp;

	NR3 norc1(tmp[0], A, B, C);
	NR2 norc2(tmp[1], D, E);
	AN2 andc1(Z, tmp[0], tmp[1]);

endmodule


module OR10_1(Z, A, B, C, D, E, F, G, H, I, J);
	input A, B, C, D, E, F, G, H, I, J;
	output Z;
	wire [2:0] tmp;

	NR4 norc1(tmp[0], A, B, C, D);
	NR3 norc2(tmp[1], E, F, G);
	NR3 norc3(tmp[2], H, I, J);
	ND3 nandc1(Z, tmp[0], tmp[1], tmp[2]);

endmodule

module AN10_1(Z, A, B, C, D, E, F, G, H, I, J);
	input A, B, C, D, E, F, G, H, I, J;
	output Z;
	wire [3:0] tmp;

	ND3 norc1(tmp[0], A, B, C);
	ND3 norc2(tmp[1], E, F, G);
	ND3 norc3(tmp[2], H, I, J);
	IV inv1(tmp[3], D);
	NR4 nandc1(Z, tmp[0], tmp[1], tmp[2], tmp[3]);

endmodule

module NOR10_1(Z, A, B, C, D, E, F, G, H, I, J);
	input A, B, C, D, E, F, G, H, I, J;
	output Z;
	wire [2:0] tmp;

	NR4 norc1(tmp[0], A, B, C, D);
	NR3 norc2(tmp[1], E, F, G);
	NR3 norc3(tmp[2], H, I, J);
	AN3 nandc1(Z, tmp[0], tmp[1], tmp[2]);

endmodule

module OR5_4(Z, A, B, C, D, E);
	// if equal then output 1
	input [3:0] A, B, C, D, E;
	output [3:0] Z;
	wire [1:0] tmp0, tmp1, tmp2, tmp3;

	NR3 norc1(tmp0[0], A[0], B[0], C[0]);
	NR2 norc2(tmp0[1], D[0], E[0]);
	ND2 nandc1(Z[0], tmp0[0], tmp0[1]);
	
	NR3 norc3(tmp1[0], A[1], B[1], C[1]);
	NR2 norc4(tmp1[1], D[1], E[1]);
	ND2 nandc2(Z[1], tmp1[0], tmp1[1]);
	
	NR3 norc5(tmp2[0], A[2], B[2], C[2]);
	NR2 norc6(tmp2[1], D[2], E[2]);
	ND2 nandc3(Z[2], tmp2[0], tmp2[1]);
	
	NR3 norc7(tmp3[0], A[3], B[3], C[3]);
	NR2 norc8(tmp3[1], D[3], E[3]);
	ND2 nandc4(Z[3], tmp3[0], tmp3[1]);

endmodule

module OR6_4(Z, A, B, C, D, E, F);
	// if equal then output 1
	input [3:0] A, B, C, D, E, F;
	output [3:0] Z;
	wire [1:0] tmp0, tmp1, tmp2, tmp3;
	wire [3:0] F_bar;
	IV inv1(F_bar[0], F[0]);
	IV inv2(F_bar[1], F[1]);
	IV inv3(F_bar[2], F[2]);
	IV inv4(F_bar[3], F[3]);

	NR3 norc1(tmp0[0], A[0], B[0], C[0]);
	NR2 norc2(tmp0[1], D[0], E[0]);
	ND3 nandc1(Z[0], tmp0[0], tmp0[1], F_bar[0]);
	
	NR3 norc3(tmp1[0], A[1], B[1], C[1]);
	NR2 norc4(tmp1[1], D[1], E[1]);
	ND3 nandc2(Z[1], tmp1[0], tmp1[1], F_bar[1]);
	
	NR3 norc5(tmp2[0], A[2], B[2], C[2]);
	NR2 norc6(tmp2[1], D[2], E[2]);
	ND3 nandc3(Z[2], tmp2[0], tmp2[1], F_bar[2]);
	
	NR3 norc7(tmp3[0], A[3], B[3], C[3]);
	NR2 norc8(tmp3[1], D[3], E[3]);
	ND3 nandc4(Z[3], tmp3[0], tmp3[1], F_bar[3]);

endmodule

module OR10_4(Z, A, B, C, D, E, F, G, H, I, J);
	input [3:0] A, B, C, D, E, F, G, H, I, J;
	output [3:0] Z;
	wire [2:0] tmp1, tmp2, tmp3, tmp0;

	NR4 norc1(tmp0[0], A[0], B[0], C[0], D[0]);
	NR3 norc2(tmp0[1], E[0], F[0], G[0]);
	NR3 norc3(tmp0[2], H[0], I[0], J[0]);
	ND3 nandc1(Z[0], tmp0[0], tmp0[1], tmp0[2]);
	
	NR4 norc4(tmp1[0], A[1], B[1], C[1], D[1]);
	NR3 norc5(tmp1[1], E[1], F[1], G[1]);
	NR3 norc6(tmp1[2], H[1], I[1], J[1]);
	ND3 nandc2(Z[1], tmp1[0], tmp1[1], tmp1[2]);
	
	NR4 norc7(tmp2[0], A[2], B[2], C[2], D[2]);
	NR3 norc8(tmp2[1], E[2], F[2], G[2]);
	NR3 norc9(tmp2[2], H[2], I[2], J[2]);
	ND3 nandc3(Z[2], tmp2[0], tmp2[1], tmp2[2]);
	
	NR4 norca(tmp3[0], A[3], B[3], C[3], D[3]);
	NR3 norcb(tmp3[1], E[3], F[3], G[3]);
	NR3 norcc(tmp3[2], H[3], I[3], J[3]);
	ND3 nandc4(Z[3], tmp3[0], tmp3[1], tmp3[2]);

endmodule

module NOR15_1(Z, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O);
	input A, B, C, D, E, F, G, H, I, J, K, L, M, N, O;
	output Z;
	wire [3:0] tmp;

	NR4 norc1(tmp[0], A, B, C, D);
	NR3 norc2(tmp[1], E, F, G);
	NR4 norc3(tmp[2], H, I, J, K);
	NR4 norc4(tmp[3], L, M, N, O);
	AN4 andc1(Z, tmp[0], tmp[1], tmp[2], tmp[3]);

endmodule

module OR15_4(Z, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O);
	input [3:0] A, B, C, D, E, F, G, H, I, J, K, L, M, N, O;
	output [3:0] Z;
	wire [3:0] tmp0, tmp1, tmp2, tmp3;

	NR4 norc1(tmp0[0], A[0], B[0], C[0], D[0]);
	NR3 norc2(tmp0[1], E[0], F[0], G[0]);
	NR4 norc3(tmp0[2], H[0], I[0], J[0], K[0]);
	NR4 norc4(tmp0[3], L[0], M[0], N[0], O[0]);
	ND4 andc1(Z[0], tmp0[0], tmp0[1], tmp0[2], tmp0[3]);
	
	NR4 norc5(tmp1[0], A[1], B[1], C[1], D[1]);
	NR3 norc6(tmp1[1], E[1], F[1], G[1]);
	NR4 norc7(tmp1[2], H[1], I[1], J[1], K[1]);
	NR4 norc8(tmp1[3], L[1], M[1], N[1], O[1]);
	ND4 andc2(Z[1], tmp1[0], tmp1[1], tmp1[2], tmp1[3]);
	
	NR4 norc9(tmp2[0], A[2], B[2], C[2], D[2]);
	NR3 norc10(tmp2[1], E[2], F[2], G[2]);
	NR4 norc11(tmp2[2], H[2], I[2], J[2], K[2]);
	NR4 norc12(tmp2[3], L[2], M[2], N[2], O[2]);
	ND4 andc3(Z[2], tmp2[0], tmp2[1], tmp2[2], tmp2[3]);
	
	NR4 norc13(tmp3[0], A[3], B[3], C[3], D[3]);
	NR3 norc14(tmp3[1], E[3], F[3], G[3]);
	NR4 norc15(tmp3[2], H[3], I[3], J[3], K[3]);
	NR4 norc16(tmp3[3], L[3], M[3], N[3], O[3]);
	ND4 andc4(Z[3], tmp3[0], tmp3[1], tmp3[2], tmp3[3]);

endmodule



module IV4(Z, A);
	// if equal then output 1
	input [3:0] A;
	output [3:0] Z;

	IV inv_tmp0(Z[0], A[0]);
	IV inv_tmp1(Z[1], A[1]);
	IV inv_tmp2(Z[2], A[2]);
	IV inv_tmp3(Z[3], A[3]);

endmodule

module cntlAND(Z, cntl, A);
	// if equal then output 1
	input [3:0] A;
	input cntl;
	output [3:0] Z;

	AN2 a1(Z[0], cntl, A[0]);
	AN2 a2(Z[1], cntl, A[1]);
	AN2 a3(Z[2], cntl, A[2]);
	AN2 a4(Z[3], cntl, A[3]);

endmodule


module equaler(eq, A, B);
	// if equal then output 1
	input [3:0] A, B;
	output eq;
	
	wire [5:0] tmp;
	wire [3:0] A_bar, B_bar;

	EO eo1(tmp[3], A[3], B[3]);
	EO eo2(tmp[2], A[2], B[2]);
	EO eo3(tmp[1], A[1], B[1]);
	EO eo4(tmp[0], A[0], B[0]);
	
	NR2 nor1(tmp[5], tmp[3], tmp[2]);
	NR2 nor2(tmp[4], tmp[1], tmp[0]);
	
	AN2 a1(eq, tmp[5], tmp[4]);

endmodule

