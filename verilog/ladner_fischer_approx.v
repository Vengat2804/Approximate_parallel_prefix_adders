module b2(input g1, p1, g2, output g_out);
  assign g_out = g1 | (p1 & g2);
endmodule

module ladner_fischer_approx(input [7:0] A, B, output [8:0] SUM);

  wire [7:0] g, p;
  assign p = A ^ B;   // OR instead of XOR
  assign g = A & B;

  wire [8:1] c;

  b2 b2_1(g[0], p[0], 1'b0, c[1]);  // base carry
  b2 b2_2(g[1], p[1], c[1], c[2]);
  b2 b2_3(g[2], p[2], g[1], c[3]);
  b2 b2_4(g[3], p[3], c[3], c[4]);
  b2 b2_5(g[4], p[4], g[3], c[5]);
  b2 b2_6(g[5], p[5], c[5], c[6]);
  b2 b2_7(g[6], p[6], g[5], c[7]);
  b2 b2_8(g[7], p[7], c[7], c[8]);

  assign SUM[0] = p[0];
  assign SUM[1] = c[1] ^ p[1];
  assign SUM[2] = c[2] ^ p[2];
  assign SUM[3] = c[3] ^ p[3];
  assign SUM[4] = c[4] ^ p[4];
  assign SUM[5] = c[5] ^ p[5];
  assign SUM[6] = c[6] ^ p[6];
  assign SUM[7] = c[7] ^ p[7];
  assign SUM[8] = c[8];

endmodule