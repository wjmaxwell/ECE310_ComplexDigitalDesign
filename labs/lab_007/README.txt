The encrypted solution may be simulated with the following

% cd path/to/lab_007
% module load modelsim
% export MODELSIM=modelsim.ini
% vlib work
% vmap work work
% vlog encrypted_soln/size.vp lab_007_tb.v
% vsim -c -voptargs="+acc" -L ece310_lib lab_007_tb

VSIM> log -r *
VSIM> run -all
VSIM> quit

% vsim vsim.wlf
