########################################################################
# Technology
########################################################################

source scripts/common.tcl

########################################################################
# Read routed database
########################################################################

read_db db/09_detailed_route.db

########################################################################
# Liberty (SS)
########################################################################

read_liberty $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib

########################################################################
# Constraints
########################################################################

read_sdc constraints/constraints.sdc

########################################################################
# Read SPEF
########################################################################

read_spef spef/sync_fifo_max.spef

########################################################################
# Reports
########################################################################

set_propagated_clock [all_clocks]

file mkdir reports

report_checks -path_delay max -format full_clock_expanded > reports/ss_setup.rpt

report_checks -path_delay min -format full_clock_expanded > reports/ss_hold.rpt

report_clock_skew > reports/ss_clock_skew.rpt

report_clock_properties > reports/ss_clock_properties.rpt

report_design_area > reports/ss_area.rpt

report_parasitic_annotation > reports/ss_parasitics.rpt
