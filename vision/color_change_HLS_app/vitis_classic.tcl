set env(MAKEFLAGS) "-j1"

set script_dir [file normalize [file dirname [info script]]]
puts "INFO: Script Directory: $script_dir"

# Change to the script directory
cd $script_dir

# 1. Define Paths (Update these to your local paths)
set xsa_path      "[file normalize "$script_dir/vivado_project/system_wrapper.xsa"]"
set src_path      "[file normalize "$script_dir/vitis_source"]"
set ws_path       "./cl_ws"
set platform_name "platform"
set app_name      "pcam_app"
set proc_name     "ps7_cortexa9_0"
set os_name       "standalone"

# 2. Set Workspace
setws $ws_path

# 1. Create the Platform Project
# Note: The -part flag is technically inferred from the XSA, but can be specified.
platform create -name $platform_name \
    -hw $xsa_path \
    -proc $proc_name \
    -os $os_name \
    -out $ws_path

# 2. Create the Domain (Standard for Standalone)
# domain create -name "standalone_domain" \
#     -os $os_name \
#     -proc $proc_name
# domain create -name "standalone_domain" -os standalone -proc $proc_name
# bsp config -proc $proc_name
bsp regenerate

# Generate the platform
set extra_flags "-I../../standalone_v9_1/src -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard"
bsp config extra_compiler_flags $extra_flags
platform generate




# 3. Create the Application Project
# -template "Empty Application" is used since you have external sources
app create -name $app_name \
    -platform $platform_name \
    -domain "standalone_domain" \
    -template "Empty Application"

# 4. Import External Sources
# This links/copies your external .c and .h files into the project
importsources -name $app_name -path $src_path

# 5. Build the Application
app build -name $app_name

puts "Vitis Project Creation Complete!"