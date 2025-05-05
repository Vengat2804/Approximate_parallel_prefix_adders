vlib work
vlog "D:/project/verilog/kogge_stone_8bit.v"
vlog "D:/project/verilog/kogge_stone_approx.v"
vlog "D:/project/verilog/ladner_fischer_8bit.v"
vlog "D:/project/verilog/ladner_fischer_approx.v"
vlog "D:/project/verilog/test_adder_tb.v"

vsim work.test_adder_tb
run -all
quit
