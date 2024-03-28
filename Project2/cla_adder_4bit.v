module cla_adder_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] g, p;
    wire [9:0] c; // Array of intermediate carry signals

    // Instantiate generate and propagate units for each bit
    generate_propagate_unit gp0(a[0], b[0], g[0], p[0]);
    generate_propagate_unit gp1(a[1], b[1], g[1], p[1]);
    generate_propagate_unit gp2(a[2], b[2], g[2], p[2]);
    generate_propagate_unit gp3(a[3], b[3], g[3], p[3]);

    // Carry look-ahead logic
    and and0(c[0], p[0], cin);
    or or0(cout0, g[0], c[0]);

    and and1_0(c[1], p[1], g[0]);
    and and1_1(c[2], p[1], p[0], cin);
    or or1(cout1, g[1], c[1], c[2]);

    and and2_0(c[3], p[2], g[1]);
    and and2_1(c[4], p[2], p[1], g[0]);
    and and2_2(c[5], p[2], p[1], p[0], cin);
    or or2(cout2, g[2], c[3], c[4], c[5]);

    and and3_0(c[6], p[3], g[2]);
    and and3_1(c[7], p[3], p[2], g[1]);
    and and3_2(c[8], p[3], p[2], p[1], g[0]);
    and and3_3(c[9], p[3], p[2], p[1], p[0], cin);
    or or3(cout, g[3], c[6], c[7], c[8], c[9]);  // Final carry-out

    // Sum calculation
    xor sum0(sum[0], p[0], cin);
    xor sum1(sum[1], p[1], cout0);
    xor sum2(sum[2], p[2], cout1);
    xor sum3(sum[3], p[3], cout2);
endmodule
