
set script_dir [file normalize [file dirname [info script]]]
puts "INFO: Script Directory: $script_dir"

# Change to the script directory
cd $script_dir

# Check vivado verison
set scripts_vivado_version 2024.1
set current_vivado_version [version -short]
set valid_version [string equal $scripts_vivado_version $current_vivado_version]
if { $valid_version != 1 } {
  common::send_msg_id "BD_TCL-1002" "WARNING" "Vivado version is not $scripts_vivado_version"
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

######################## Creating Project ########################

set _project_name "pcam_filter"
set _project_dir_name "vivado_project"
create_project $_project_name $_project_dir_name -part xc7z020clg400-1

# Get project properties
set project_dir [get_property directory [current_project]]
set project_obj [current_project]

# Set project properties, XPM libaries are neede for the DVIClocking
set_property -name "target_language" -value "VHDL" -objects $project_obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $project_obj


######################## IP Repos setup ########################
# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set_property "ip_repo_paths" "[file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/ip_repo"]"  [get_filesets sources_1]

# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

############# Adding Sources for DVIClocking ###################

set files [list \
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/sources_1/DVIClocking.vhd"]\
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/sources_1/SyncAsync.vhd"]\
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/sources_1/SyncAsyncReset.vhd"]\
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/sources_1/system_wrapper.vhd"]\
]
add_files -fileset sources_1 $files

set_property -name "top" -value "system_wrapper" -objects  [get_filesets sources_1]
set_property -name "top_auto_set" -value "0" -objects  [get_filesets sources_1]

########################### Contraints #########################

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Add/Import constrs file and set constrs file properties
set files [list \
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/constrs_1/ZyboZ7_A.xdc"]\
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/constrs_1/timing.xdc"]\
  [file normalize "$script_dir/../Zybo_Z7_Z20-Pcam_5C_source/constrs_1/auto.xdc"]\
]
add_files -fileset constrs_1 $files

#################### Creat Block Designs #######################

source ./create_system_bd.tcl

######################## Finish ################################

puts "INFO: Project created: $_project_name"