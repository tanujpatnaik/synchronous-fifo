########################################################################
# Project
########################################################################

set DESIGN_NAME sync_fifo

########################################################################
# PDK
########################################################################

set PDK_ROOT $::env(PDK_ROOT)
set PDK      $::env(PDK)

########################################################################
# File Paths
########################################################################

set TECH_LEF "$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef"

set STD_LEF "$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef"

set LIBERTY "$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"

set SDC "constraints/constraints.sdc"

set NETLIST "synthesis/synth.v"

########################################################################
# Load Technology
########################################################################

read_lef $TECH_LEF
read_lef $STD_LEF

read_liberty $LIBERTY

########################################################################
# Load Constraints
########################################################################