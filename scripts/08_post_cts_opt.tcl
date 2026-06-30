########################################################################
# Load technology
########################################################################

source scripts/common.tcl

########################################################################
# Read CTS database
########################################################################

read_db db/06_cts.db

########################################################################
# Constraints
########################################################################

read_sdc constraints/constraints.sdc

########################################################################
# Estimate parasitics
########################################################################

# More realistic than assuming zero RC
set_wire_rc -signal -layer met3
set_wire_rc -clock  -layer met5

estimate_parasitics -placement

########################################################################
# Initial Timing
########################################################################

puts "\n================ BEFORE REPAIR ================\n"

report_checks -path_delay max -format summary
report_checks -path_delay min -format summary

########################################################################
# Repair Timing
########################################################################

repair_timing \
    -setup \
    -hold \
    -repair_tns 100 \
    -max_passes 10 \
    -max_buffer_percent 20 \
    -verbose

########################################################################
# Legalize placement after timing repair
########################################################################

detailed_placement -incremental
########################################################################
# Update RC
########################################################################


estimate_parasitics -placement

########################################################################
# Reports
########################################################################

puts "\n================ AFTER REPAIR ================\n"

report_checks -path_delay max -format summary
report_checks -path_delay min -format summary

report_design_area
report_clock_skew
report_clock_properties

########################################################################
# Save
########################################################################

write_db db/07_post_cts.db
write_def def/07_post_cts.def
