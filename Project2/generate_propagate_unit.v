module generate_propagate_unit(
    input a,
    input b,
    output g,
    output p
);
    and and_gate(g, a, b);  // Generate: G = A AND B
    xor xor_gate(p, a, b);  // Propagate: P = A XOR B
endmodule
