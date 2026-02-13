# Color Changing App

This app is based on sample [project by Digilent](https://digilent.com/reference/programmable-logic/zybo-z7/demos/pcam-5c) for using Pcam-5c.

## 1 Build Vivado System

* Open **Vivado 2024.1** 
* run **vivado_project.tcl** file by clicking **`'Tools' menu -> Run Tcl script..`** and browsing. 
* If block design created without any error, proceed **generating bit stream**.
* Export design: click `File -> Export -> Export Hardware` and then in the **"Export Hardware Platform"** window, click `next` and select **`include bitstream`** option and export the design to the default location.

## 2 Generate Vitis Components

After successfully hardware system built expored as XSA file, above. 

* Open **Vitis Console 2024.1**
* start new terminal by `Terminal -> New Terminal` in the top menu.
* Go to the **color_change_app** directory. 
* run **`run vitis_script.py`** to generate both platform and application components.
