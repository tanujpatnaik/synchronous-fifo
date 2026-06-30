########################################################################
# Technology
########################################################################

source scripts/common.tcl

########################################################################
# Read routed database
########################################################################

read_db db/09_detailed_route.db

########################################################################
# Liberty (TT)
########################################################################

read_liberty $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

########################################################################
# Constraints
########################################################################

read_sdc constraints/constraints.sdc

########################################################################
# Read SPEF
########################################################################

read_spef spef/sync_fifo_nom.spef

########################################################################
# Reports
########################################################################

set_propagated_clock [all_clocks]



########################################################################
# OCV Derates
########################################################################

set_timing_derate -early -cell_delay 0.95
set_timing_derate -late  -cell_delay 1.05

set_timing_derate -early -net_delay 0.95
set_timing_derate -late  -net_delay 1.05


########################################################################
# Reports
########################################################################

file mkdir reports

puts "\n================ OCV STA ================\n"

report_checks -path_delay max -format full_clock_expanded > reports/ocv_setup.rpt

report_checks -path_delay min -format full_clock_expanded > reports/ocv_hold.rpt

report_clock_skew > reports/ocv_clock_skew.rpt