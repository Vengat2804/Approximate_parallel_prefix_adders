module b1(input g1, p1, g2, p2, output g_out, p_out);
  assign p_out = p1 & p2;
  assign g_out = g1 | (p1 & g2);
endmodule

module b2(input g1, p1, g2, output g_out);
  assign g_out = g1 | (p1 & g2);
endmodule

module kogge_stone_8bit(input [7:0] A, B, output [8:0] SUM);
  wire [7:0] p, g;
  assign p = A ^ B;
  assign g = A & B;

  wire [7:0] c;

  // Stage 1: B1s
  wire g01, p01, g12, p12, g23, p23, g34, p34, g45, p45, g56, p56;
  b1 b1_01(g[1], p[1], g[0], p[0], g01, p01);
  b1 b1_12(g[2], p[2], g[1], p[1], g12, p12);
  b1 b1_23(g[3], p[3], g[2], p[2], g23, p23);
  b1 b1_34(g[4], p[4], g[3], p[3], g34, p34);
  b1 b1_45(g[5], p[5], g[4], p[4], g45, p45);
  b1 b1_56(g[6], p[6], g[5], p[5], g56, p56);

  // Stage 2: B1s
  wire g13, p13, g24, p24, g35, p35, g46, p46;
  b1 b1_13(g23, p23, g01, p01, g13, p13);
  b1 b1_24(g34, p34, g12, p12, g24, p24);
  b1 b1_35(g45, p45, g23, p23, g35, p35);
  b1 b1_46(g56, p56, g34, p34, g46, p46);

  // Stage 1: B2
  b2 b2_00(g[0], p[0], 1'b0, c0);

  // Stage 2: B2s
  wire c1, c2;
  b2 b2_01(g01,p01,p[0],c1);
  b2 b2_12(g12, p12, c0, c2);

  // Stage 3: B2s
  wire c3, c4, c5, c6;
  b2 b2_03(g13, p13, p[0], c3);
  b2 b2_04(g24, p24, c0, c4);
  b2 b2_15(g35, p35, c1, c5);
  b2 b2_26(g46, p46, c2, c6);


  //k variables
  wire k1,k2,k3,k4;
  b2 bk1(g01,p01,p[0],x1);
  b2 bk2(g12,p12,c0,x2);
  b1 b_k1(g23,p23,g01,p01,gk1,pk1);
  b1 b_k2(g34,p34,g12,p12,gk2,pk2);
  b1 b_k3(g45,p45,g23,p23,gk3,pk3);
  b1 b_k4(g56,p56,g34,p34,gk4,pk4);
  b2 b2_k1(gk1,pk1,p[0],k1);
  b2 b2_k2(gk2,pk2,c0,k2);
  b2 b2_k3(gk3,pk3,x1,k3);
  b2 b2_k4(gk4,pk4,x2,k4);





  // Final B2 for SUM[8]
  b2 b2_final(g[7], p[7], k4, c7);

  // Final SUM calculation
  assign SUM[0] = p[0];
  assign SUM[1] = p[1] ^ c0;
  assign SUM[2] = p[2] ^ c1;
  assign SUM[3] = p[3] ^ c2;
  assign SUM[4] = p[4] ^ k1;
  assign SUM[5] = p[5] ^ k2;
  assign SUM[6] = p[6] ^ k3;
  assign SUM[7] = p[7] ^ k4;
  assign SUM[8] = c7;
endmodule
