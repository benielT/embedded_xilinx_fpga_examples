set env(MAKEFLAGS) "-j1"
set script_dir [file normalize [file dirname [info script]]]
cd $script_dir

set xsa_path    [file normalize "$script_dir/vivado_project/system_wrapper.xsa"]
set src_path    [file normalize "$script_dir/vitis_source"]
set ws_path     "./cl_ws"
set platform_name "platform_pcam"
set app_name      "pcam_app"
set proc_name     "ps7_cortexa9_0"
set os_name       "standalone"

setws $ws_path

# 1. Create the Platform Project
platform create -name $platform_name \
    -hw $xsa_path \
    -proc $proc_name \
    -os $os_name \
    -out $ws_path

# 2. Select platform and domain
platform active $platform_name
domain active "standalone_domain"

# 3. Generate and Write
platform active $platform_name
platform generate
platform write

# 4. Create the Application Project
app create -name $app_name \
    -platform $platform_name \
    -domain "standalone_domain" \
    -template "Empty Application."

# 5. Import and Build
importsources -name $app_name -path "$src_path/main.cc"
app build -name $app_name

puts "Vitis Project Creation Complete!"
