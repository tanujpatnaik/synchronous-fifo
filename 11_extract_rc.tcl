########################################################################
# Technology
########################################################################

source scripts/common.tcl

read_db db/09_detailed_route.db

read_sdc constraints/constraints.sdc

########################################################################
# Nominal RC (TT)
########################################################################

extract_parasitics -ext_model_file $PDK_ROOT/$PDK/libs.tech/openlane/rules.openrcx.sky130A.nom.spef_extractor

write_spef spef/sync_fifo_nom.spef

########################################################################
# Minimum RC (FF)
########################################################################

extract_parasitics -ext_model_file $PDK_ROOT/$PDK/libs.tech/openlane/rules.openrcx.sky130A.min.spef_extractor

write_spef spef/sync_fifo_min.spef

########################################################################
# Maximum RC (SS)
########################################################################

extract_parasitics -ext_model_file $PDK_ROOT/$PDK/libs.tech/openlane/rules.openrcx.sky130A.max.spef_extractor

write_spef spef/sync_fifo_max.spef
