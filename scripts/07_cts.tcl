source scripts/common.tcl

read_db db/05_place.db

read_sdc constraints/constraints.sdc

clock_tree_synthesis \
    -buf_list {
        sky130_fd_sc_hd__clkbuf_2
        sky130_fd_sc_hd__clkbuf_4
        sky130_fd_sc_hd__clkbuf_8
        sky130_fd_sc_hd__clkbuf_16
    } \
    -root_buf sky130_fd_sc_hd__clkbuf_16 \
    -sink_clustering_enable \
    -sink_clustering_size 20 \
    -sink_clustering_max_diameter 40

estimate_parasitics -placement

report_cts
report_clock_properties
report_clock_skew
report_checks -path_delay max -format summary

write_db db/06_cts.db
write_def def/06_cts.def
