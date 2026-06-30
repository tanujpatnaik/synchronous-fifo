########################################################################
# Technology
########################################################################

source scripts/common.tcl

########################################################################
# Read Design
########################################################################

read_db db/08_global_route.db

########################################################################
# Constraints
########################################################################

read_sdc constraints/constraints.sdc

########################################################################
# RC Models
########################################################################

set_wire_rc -signal -layer met3
set_wire_rc -clock  -layer met5

########################################################################
# Detailed Routing
########################################################################

set_routing_layers -signal met1-met5 -clock met1-met5


detailed_route \
    -output_drc reports/drc.rpt \
    -output_maze reports/maze.log \
    -output_guide_coverage reports/guide_coverage.rpt \
    -verbose 1
########################################################################
# Extract RC
########################################################################

estimate_parasitics -global_routing

########################################################################
# Reports
########################################################################

puts "\n================ DETAILED ROUTING ================\n"

report_checks -path_delay max -format summary
report_checks -path_delay min -format summary

report_clock_skew

report_wire_length -detailed_route -summary

report_design_area

########################################################################
# Save
########################################################################

write_db db/09_detailed_route.db

write_def def/09_detailed_route.def
