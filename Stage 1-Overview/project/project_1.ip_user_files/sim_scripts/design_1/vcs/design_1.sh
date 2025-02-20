#!/bin/bash -f
#*********************************************************************************************************
# Vivado (TM) v2017.4 (64-bit)
#
# Filename    : design_1.sh
# Simulator   : Synopsys Verilog Compiler Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Mon Jun 24 06:48:58 +0330 2024
# SW Build 2086221 on Fri Dec 15 20:55:39 MST 2017
#
# Copyright 1986-2017 Xilinx, Inc. All Rights Reserved. 
#
# usage: design_1.sh [-help]
# usage: design_1.sh [-lib_map_path]
# usage: design_1.sh [-noclean_files]
# usage: design_1.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'design_1.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
#*********************************************************************************************************

# Directory path for design sources and include directories (if any) wrt this path
ref_dir="."

# Override directory with 'export_sim_ref_dir' env path value if set in the shell
if [[ (! -z "$export_sim_ref_dir") && ($export_sim_ref_dir != "") ]]; then
  ref_dir="$export_sim_ref_dir"
fi

# Command line options
vlogan_opts="-full64"
vhdlan_opts="-full64"
vcs_elab_opts="-full64 -debug_pp -t ps -licqueue -l elaborate.log"
vcs_sim_opts="-ucli -licqueue -l simulate.log"

# Design libraries
design_libs=(xil_defaultlib xpm axi_infrastructure_v1_1_0 smartconnect_v1_0 axi_protocol_checker_v2_0_1 axi_vip_v1_1_1 processing_system7_vip_v1_0_3 lib_cdc_v1_0_2 lib_pkg_v1_0_2 fifo_generator_v13_2_1 lib_fifo_v1_0_10 blk_mem_gen_v8_4_1 lib_bmg_v1_0_10 lib_srl_fifo_v1_0_2 axi_datamover_v5_1_17 axi_vdma_v6_3_3 axi_lite_ipif_v3_0_4 v_tc_v6_1_12 v_vid_in_axi4s_v4_0_7 v_axi4s_vid_out_v4_0_8 xlconcat_v2_1_1 proc_sys_reset_v5_0_12 generic_baseblocks_v2_1_0 axi_register_slice_v2_1_15 axi_data_fifo_v2_1_14 axi_crossbar_v2_1_16 xbip_utils_v3_0_8 axi_utils_v2_0_4 c_reg_fd_v12_0_4 xbip_dsp48_wrapper_v3_0_4 xbip_pipe_v3_0_4 xbip_dsp48_addsub_v3_0_4 xbip_addsub_v3_0_4 c_addsub_v12_0_11 c_mux_bit_v12_0_4 c_shift_ram_v12_0_11 xbip_bram18k_v3_0_4 mult_gen_v12_0_13 cmpy_v6_0_14 floating_point_v7_0_14 xfft_v9_0_14 axi_sg_v4_1_8 axi_dma_v7_1_16 xlconstant_v1_1_3 axi_protocol_converter_v2_1_15 axi_clock_converter_v2_1_14 axi_dwidth_converter_v2_1_15)

# Simulation root library directory
sim_lib_dir="vcs_lib"

# Script info
echo -e "design_1.sh - Script generated by export_simulation (Vivado v2017.4 (64-bit)-id)\n"

# Main steps
run()
{
  check_args $# $1
  setup $1 $2
  compile
  elaborate
  simulate
}

# RUN_STEP: <compile>
compile()
{
  # Compile design files
  vlogan -work xil_defaultlib $vlogan_opts -sverilog +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
    "C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
    "C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
  2>&1 | tee -a vlogan.log

  vhdlan -work xpm $vhdlan_opts \
    "C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work axi_infrastructure_v1_1_0 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work smartconnect_v1_0 $vlogan_opts -sverilog +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/sc_util_v1_0_vl_rfs.sv" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_protocol_checker_v2_0_1 $vlogan_opts -sverilog +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/3b24/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_vip_v1_1_1 $vlogan_opts -sverilog +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/a16a/hdl/axi_vip_v1_1_vl_rfs.sv" \
  2>&1 | tee -a vlogan.log

  vlogan -work processing_system7_vip_v1_0_3 $vlogan_opts -sverilog +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work lib_cdc_v1_0_2 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work lib_pkg_v1_0_2 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work fifo_generator_v13_2_1 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c35/simulation/fifo_generator_vlog_beh.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work fifo_generator_v13_2_1 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work fifo_generator_v13_2_1 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work lib_fifo_v1_0_10 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f10a/hdl/lib_fifo_v1_0_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work blk_mem_gen_v8_4_1 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work lib_bmg_v1_0_10 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9340/hdl/lib_bmg_v1_0_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work lib_srl_fifo_v1_0_2 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work axi_datamover_v5_1_17 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/71f3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work axi_vdma_v6_3_3 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl/axi_vdma_v6_3_rfs.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work axi_vdma_v6_3_3 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl/axi_vdma_v6_3_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/design_1/ip/design_1_axi_vdma_0_0/sim/design_1_axi_vdma_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work axi_lite_ipif_v3_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work v_tc_v6_1_12 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/6694/hdl/v_tc_v6_1_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/design_1/ip/design_1_v_tc_0_0/sim/design_1_v_tc_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9097/src/mmcme2_drp.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9097/src/axi_dynclk_S00_AXI.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9097/src/axi_dynclk.vhd" \
    "$ref_dir/../../../bd/design_1/ip/design_1_axi_dynclk_0_0/sim/design_1_axi_dynclk_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work v_vid_in_axi4s_v4_0_7 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f931/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work v_axi4s_vid_out_v4_0_8 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/fc47/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_v_axi4s_vid_out_0_1/sim/design_1_v_axi4s_vid_out_0_1.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xlconcat_v2_1_1 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_xlconcat_0_2/sim/design_1_xlconcat_0_2.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work proc_sys_reset_v5_0_12 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/design_1/ip/design_1_rst_ps7_0_142M_1/sim/design_1_rst_ps7_0_142M_1.vhd" \
    "$ref_dir/../../../bd/design_1/ip/design_1_rst_ps7_0_100M_1/sim/design_1_rst_ps7_0_100M_1.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/ClockGen.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/SyncAsync.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/SyncAsyncReset.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/DVI_Constants.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/OutputSERDES.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/TMDS_Encoder.vhd" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c79/src/rgb2dvi.vhd" \
    "$ref_dir/../../../bd/design_1/ip/design_1_rgb2dvi_0_0/sim/design_1_rgb2dvi_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work generic_baseblocks_v2_1_0 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_register_slice_v2_1_15 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/3ed1/hdl/axi_register_slice_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_data_fifo_v2_1_14 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_crossbar_v2_1_16 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_xbar_1/sim/design_1_xbar_1.v" \
    "$ref_dir/../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \
    "$ref_dir/../../../bd/design_1/sim/design_1.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work xbip_utils_v3_0_8 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4173/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work axi_utils_v2_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4575/hdl/axi_utils_v2_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work c_reg_fd_v12_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/e6f0/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xbip_dsp48_wrapper_v3_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/da55/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xbip_pipe_v3_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ee5e/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xbip_dsp48_addsub_v3_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/7b8d/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xbip_addsub_v3_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/c060/hdl/xbip_addsub_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work c_addsub_v12_0_11 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1607/hdl/c_addsub_v12_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work c_mux_bit_v12_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/660b/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work c_shift_ram_v12_0_11 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/7c1c/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xbip_bram18k_v3_0_4 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9eb4/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work mult_gen_v12_0_13 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/257f/hdl/mult_gen_v12_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work cmpy_v6_0_14 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/e5f4/hdl/cmpy_v6_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work floating_point_v7_0_14 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/6041/hdl/floating_point_v7_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xfft_v9_0_14 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1d0d/hdl/xfft_v9_0_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/design_1/ip/design_1_xfft_0_0/sim/design_1_xfft_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work axi_sg_v4_1_8 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5f94/hdl/axi_sg_v4_1_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work axi_dma_v7_1_16 $vhdlan_opts \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/bf8c/hdl/axi_dma_v7_1_vh_rfs.vhd" \
  2>&1 | tee -a vhdlan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/design_1/ip/design_1_axi_dma_0_0/sim/design_1_axi_dma_0_0.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work xlconstant_v1_1_3 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/0750/hdl/xlconstant_v1_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_xlconstant_0_0/sim/design_1_xlconstant_0_0.v" \
  2>&1 | tee -a vlogan.log

  vhdlan -work xil_defaultlib $vhdlan_opts \
    "$ref_dir/../../../bd/design_1/ip/design_1_axi_dma_0_1/sim/design_1_axi_dma_0_1.vhd" \
  2>&1 | tee -a vhdlan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_xlconstant_0_1/sim/design_1_xlconstant_0_1.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_protocol_converter_v2_1_15 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ff69/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
    "$ref_dir/../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_clock_converter_v2_1_14 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/445f/hdl/axi_clock_converter_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work axi_dwidth_converter_v2_1_15 $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1cdc/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \
  2>&1 | tee -a vlogan.log

  vlogan -work xil_defaultlib $vlogan_opts +v2k +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/02c8/hdl/verilog" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/1313/hdl" +incdir+"$ref_dir/../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f8d8/hdl" +incdir+"C:/Xilinx/Vivado/2017.4/data/xilinx_vip/include" \
    "$ref_dir/../../../bd/design_1/ip/design_1_auto_us_1/sim/design_1_auto_us_1.v" \
    "$ref_dir/../../../bd/design_1/ip/design_1_auto_us_0/sim/design_1_auto_us_0.v" \
  2>&1 | tee -a vlogan.log


  vlogan -work xil_defaultlib $vlogan_opts +v2k \
    glbl.v \
  2>&1 | tee -a vlogan.log

}

# RUN_STEP: <elaborate>
elaborate()
{
  vcs $vcs_elab_opts xil_defaultlib.design_1 xil_defaultlib.glbl -o design_1_simv
}

# RUN_STEP: <simulate>
simulate()
{
  ./design_1_simv $vcs_sim_opts -do simulate.do
}

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./design_1.sh -help\" for more information)\n"
        exit 1
      fi
      create_lib_mappings $2
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
      create_lib_mappings $2
  esac

  create_lib_dir

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Define design library mappings
create_lib_mappings()
{
  file="synopsys_sim.setup"
  if [[ -e $file ]]; then
    if [[ ($1 == "") ]]; then
      return
    else
      rm -rf $file
    fi
  fi

  touch $file

  lib_map_path=""
  if [[ ($1 != "") ]]; then
    lib_map_path="$1"
  fi

  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    mapping="$lib:$sim_lib_dir/$lib"
    echo $mapping >> $file
  done

  if [[ ($lib_map_path != "") ]]; then
    incl_ref="OTHERS=$lib_map_path/synopsys_sim.setup"
    echo $incl_ref >> $file
  fi
}

# Create design library directory paths
create_lib_dir()
{
  if [[ -e $sim_lib_dir ]]; then
    rm -rf $sim_lib_dir
  fi

  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    lib_dir="$sim_lib_dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
    fi
  done
}

# Delete generated data from the previous run
reset_run()
{
  files_to_remove=(ucli.key design_1_simv vlogan.log vhdlan.log compile.log elaborate.log simulate.log .vlogansetup.env .vlogansetup.args .vcs_lib_lock scirocco_command.log 64 AN.DB csrc design_1_simv.daidir)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done

  create_lib_dir
}

# Check command line arguments
check_args()
{
  if [[ ($1 == 1 ) && ($2 != "-lib_map_path" && $2 != "-noclean_files" && $2 != "-reset_run" && $2 != "-help" && $2 != "-h") ]]; then
    echo -e "ERROR: Unknown option specified '$2' (type \"./design_1.sh -help\" for more information)\n"
    exit 1
  fi

  if [[ ($2 == "-help" || $2 == "-h") ]]; then
    usage
  fi
}

# Script usage
usage()
{
  msg="Usage: design_1.sh [-help]\n\
Usage: design_1.sh [-lib_map_path]\n\
Usage: design_1.sh [-reset_run]\n\
Usage: design_1.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

# Launch script
run $1 $2
