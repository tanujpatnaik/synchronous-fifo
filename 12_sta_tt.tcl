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
# Reports
########################################################################

file mkdir reports

report_checks -path_delay max -format full_clock_expanded > reports/tt_setup.rpt

report_checks -path_delay min -format full_clock_expanded > reports/tt_hold.rpt

report_clock_skew > reports/tt_clock_skew.rpt

report_clock_properties > reports/tt_clock_properties.rpt

report_design_area > reports/tt_area.rpt

report_parasitic_annotation > reports/tt_parasitics.rpt