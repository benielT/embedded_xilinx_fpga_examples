# Color Changing App

This app is based on sample [project by Digilent](https://digilent.com/reference/programmable-logic/zybo-z7/demos/pcam-5c) for using Pcam-5c.

## 1 Build Vivado System

* Open **Vivado 2024.1** 
* run **vivado_project.tcl** file by clicking **`'Tools' menu -> Run Tcl script..`** and browsing. 
* If block design created without any error, proceed **generating bit stream**.
* Export design: click `File -> Export -> Export Hardware` and then in the **"Export Hardware Platform"** window, click `next` and select **`include bitstream`** option and export the design to the default location.

## 2 Generate Vitis Components

After successfully hardware system built expored as XSA file, above. We are going to use vitis classic for this project.  

* Open **Xilinx XSCT 2024.1** console.
* Go to the **color_change_app** directory. 
* run **`source vitis_classic.tcl`** to generate both platform and application components.
* After the script run sucessfully, close the XSCT conlole. 
* Open **Vitis Classic 2024.1** and locate the workspace inside **`color_change_app/cl_ws`** and build and run the application on hardßware. 

### Known issues:

If you're using Windows, the path can only have 260 charters as Vitis and Vivado tools uses full paths. Make sure the repository is in shallow path closer to `C:/`. Otherwise you'll encounter random errors. 
