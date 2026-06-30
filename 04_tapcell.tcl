source scripts/common.tcl

read_db db/02_floorplan.db

tapcell -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1 -distance 14

write_db db/03_tapcell.db
write_def def/03_tapcell.def
