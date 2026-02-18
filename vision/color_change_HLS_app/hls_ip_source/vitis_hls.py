"""
@autor: Beniel Thileepan
@data: 18-02-2026
@description: Vitis script for Lab3 CLI

example: adaptivesupport.amd.com/s/article/HLS-Series-4-Scripting-HLS-projects?language=en_US
"""

import os
import shutil
import zipfile
import subprocess
import time

import vitis
import xsdb

script_dir = os.path.dirname(os.path.abspath(__file__))
ip_out_dir = os.path.join(script_dir, "../hls_ip_repo")
ws_dir = os.path.join(script_dir, "vitis_ws")

def create_vitis_ws():
    if not os.path.exists(ws_dir):
        os.makedirs(ws_dir)
    os.chdir(ws_dir)
    print(f"INFO: Created and switched to Vitis workspace: {ws_dir}")

client = vitis.create_client()
create_vitis_ws()

client.set_workspace(ws_dir)

comps = client.list_components()
print("INFO: Existing components in the workspace:")
for comp in comps:
    print(f"- {comp}")

comp_name = "color_change_hls"
if comp_name not in [comp["name"] for comp in comps]:
    hls_comp = client.create_hls_component(name=comp_name)
else:
    hls_comp = client.get_component(name=comp_name)

cfg = client.get_config_file(path=f'{ws_dir}/{comp_name}/hls_config.cfg')

cfg.set_value(section="hls", key="part", value="xc7z020clg400-1")
cfg.set_value(section="hls", key="package.output.format", value="ip_catalog")
cfg.set_value(section="hls", key= "package.output.syn", value="false")
cfg.set_value(section='hls', key='syn.top', value='color_change')
cfg.set_values(section='hls', key='syn.file', values=[f'{script_dir}\color_change.h', f'{script_dir}\color_change.cpp'])
cfg.set_value(section="hls", key="clock", value="10ns")
cfg.set_value(section='hls', key='flow_target', value='vivado')

print("INFO: Running Synthesis")
hls_comp.run(operation="SYNTHESIS")
hls_comp.run(operation="PACKAGE")

print(f"INFO: IP Generation Complete. Find it in: {ws_dir}/{comp_name}")

if not os.path.exists(ip_out_dir):
    os.makedirs(ip_out_dir)
    print(f"INFO: created IP repo directory {ip_out_dir}")

ip_location_dir = os.path.join(ws_dir, "color_change_hls", "color_change_hls")
ip_name = "color_change"
# print(f"INFO: moving ip, {ip_name}.zip to {ip_out_dir} from {ip_location_dir}")
zip_src = os.path.join(ip_location_dir, f"{ip_name}.zip")
# zip_dest = os.path.join(ip_out_dir, f"{ip_name}.zip")
# shutil.copy2(zip_src, zip_dest)

dest_dir = os.path.join(ip_out_dir, f"{ip_name}")
print(f"INFO: extracting zip file {zip_src} -> {dest_dir}")
if not os.path.exists(dest_dir):
    os.makedirs(dest_dir)
with zipfile.ZipFile(os.path.abspath(zip_src)) as zf:
    zf.extractall(dest_dir)
print(f"INFO: extraction complete: {dest_dir}")

print(f"Successfully completed")
