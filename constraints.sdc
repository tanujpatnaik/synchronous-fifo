# Clock

create_clock  -name clk  -period 10  [get_ports clk]

# Input delays

set_input_delay 2  -clock clk  [get_ports {wr_en rd_en data_in[*] rst}]

# Output delays

set_output_delay 2  -clock clk  [get_ports {data_out[*] full empty}]

# Driving strength

set_driving_cell  -lib_cell sky130_fd_sc_hd__buf_4  [get_ports {wr_en rd_en data_in[*] rst}]

# Output load

set_load 0.05  [get_ports {data_out[*] full empty}]

# Clock uncertainty

set_clock_uncertainty 0.2 [get_clocks clk]

# Max transition

set_max_transition 1.0 [current_design]

# Max fanout

set_max_fanout 20 [current_design]