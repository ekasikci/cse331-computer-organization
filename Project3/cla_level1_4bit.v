module cla_level1_4bit(output[3:0] c, input[3:0] A, B, input cin);
	// c0 = cin 
	wire[3:0] G,P;
	wire p0_cin, p1_c1, p2_c2, p3_c3;
	
	//Gi = Ai * Bi ,  Pi = Ai + Bi
	and_gate_4bit and1(G[3:0],A,B);
	or_gate_4bit or1(P[3:0],A,B);
	
	// c1 = g0 +p0*cin
	and and2(p0_cin,P[0],cin);
	or or2(c[0],G[0],p0_cin);

	// c2 = g1 +p1*c1
	and and3(p1_c1,P[1],c[0]);
	or or3(c[1],G[1],p1_c1);
	
	// c3 = g2 + p2*c2
	and and4(p2_c2,P[2],c[1]);
	or or4(c[2],G[2],p2_c2);
	
	// c4 =  g3 + p3*c3
	and and5(p3_c3,P[3],c[2]);
	or or5(c[3],G[3],p3_c3);
	
endmodule
