source scripts/common.tcl

read_db db/01_design.db

initialize_floorplan -site unithd -die_area {0 0 110 110} -core_area {10 10 100 100}

make_tracks

place_pins -hor_layers met1 -ver_layers met2

write_db db/02_floorplan.db
write_def def/02_floorplan.def
