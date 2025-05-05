module b1(input g1, p1, g2, p2, output g_out, p_out);
  assign p_out = p1 & p2;
  assign g_out = g1 | (p1 & g2);
endmodule

module b2(input g1, p1, g2, output g_out);
  assign g_out = g1 | (p1 & g2);
endmodule
module ladner_fischer_8bit(input [7:0] A, B, output [8:0] SUM);

  wire [7:0] g, p;
  assign p = A ^ B;   
  assign g = A & B;

  wire [8:1] c;
  wire g1, p1, g2, p2, g3, p3, g4, p4;

  // Stage 1
  b2 b2_1(g[0], p[0], 1'b0, c[1]);  // base carry

  // Level 1 combinations
  b1 b1_1(g[2], p[2], g[1], p[1], g1, p1);
  b2 b2_2(g1, p1, c[1], c[2]);

  b1 b1_2(g[4], p[4], g[3], p[3], g2, p2);
  b2 b2_3(g2, p2, c[2], c[3]);

  b1 b1_3(g[6], p[6], g[5], p[5], g3, p3);
  b1 b1_4(g3, p3, g2, p2, g4, p4);
  b2 b2_4(g4, p4, c[2], c[4]);

  b2 b2_5(g[1], p[1], c[1], c[5]);

  b2 b2_6(g[3], p[3], c[2], c[6]);

  b2 b2_7(g[5], p[5], c[3], c[7]);



  //k variables
  b1 b_k1(g3, p3, g2, p2, gk1, pk1);
  b2 bk1(g1, p1, c[1], k1);
  b2 bk2(g[3], p[3], k1, k2);
  b2 bk3(g2, p2, k1, k3);
  b2 bk4(g[5], p[5] , k3, k4);
  b2 bk5(gk1, pk1, k1, k5);

  b2 b2_8(g[7], p[7], k5, c[8]);

  assign SUM[0] = p[0];
  assign SUM[1] = c[1] ^ p[1];
  assign SUM[2] = c[2] ^ p[2];
  assign SUM[3] = k1 ^ p[3];
  assign SUM[4] = k2 ^ p[4];
  assign SUM[5] = k3 ^ p[5];
  assign SUM[6] = k4 ^ p[6];
  assign SUM[7] = k5 ^ p[7];
  assign SUM[8] = c[8];

endmodule