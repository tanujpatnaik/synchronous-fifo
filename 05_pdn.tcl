source scripts/common.tcl

read_db db/03_tapcell.db

##################################################
# Global Connections
##################################################

add_global_connection -defer_connection -net VDD -pin_pattern {VPWR} -power
add_global_connection -defer_connection -net VDD -pin_pattern {VPB}  -power

add_global_connection -defer_connection -net VSS -pin_pattern {VGND} -ground
add_global_connection -defer_connection -net VSS -pin_pattern {VNB}  -ground

global_connect

##################################################
# Voltage Domain
##################################################

set_voltage_domain -name CORE -power VDD -ground VSS

##################################################
# PDN Grid
##################################################

define_pdn_grid -name core_grid -voltage_domains {CORE}

##################################################
# Follow-pin rails
##################################################

add_pdn_stripe -grid core_grid -layer met1 -width 0.48 -pitch 5.44 -offset 0 -followpins

##################################################
# Vertical mesh
##################################################

add_pdn_stripe -grid core_grid -layer met4 -width 1.6 -pitch 27.14 -offset 13.57

##################################################
# Horizontal mesh
##################################################

add_pdn_stripe -grid core_grid -layer met5 -width 1.6 -pitch 27.20 -offset 13.60

##################################################
# Connections
##################################################

add_pdn_connect -grid core_grid -layers {met1 met4}

add_pdn_connect -grid core_grid -layers {met4 met5}

##################################################
# Generate
##################################################

pdngen

write_db db/04_pdn.db
write_def def/04_pdn.def