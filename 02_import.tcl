source scripts/common.tcl

read_lef $TECH_LEF
read_lef $STD_LEF

read_liberty $LIBERTY

read_verilog $NETLIST

link_design $DESIGN_NAME

read_sdc $SDC

write_db db/01_design.db
