source scripts/common.tcl

read_db db/04_pdn.db

read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
##################################################
# Global Placement
##################################################

global_placement

##################################################
# Detailed Placement
##################################################

detailed_placement

##################################################
# Reports
##################################################

check_placement

report_design_area

report_checks

##################################################
# Save
##################################################

write_db db/05_place.db
write_def def/05_place.def
