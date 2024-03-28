transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/alu.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/and_gate_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/and_gate_1bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/or_gate_1bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/or_gate_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/xor_gate_1bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/xor_gate_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/nor_gate_1bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/nor_gate_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/generate_propagate_unit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/cla_adder_4bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/cla_adder_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/subtractor_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/less_than_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/mod_dp.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/mod_cu.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/mod.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/mux_8x1_32bit.v}
vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/mux_8x1_1bit.v}

vlog -vlog01compat -work work +incdir+D:/project2 {D:/project2/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
