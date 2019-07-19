onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_tb/clk
add wave -noupdate /counter_tb/areset_n
add wave -noupdate /counter_tb/pwm_clk
add wave -noupdate /counter_tb/dut/pwm_clk
add wave -noupdate -radix unsigned /counter_tb/dut/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {407 ps}
