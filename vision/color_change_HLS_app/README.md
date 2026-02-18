# Color Changing App

This app is based on sample [project by Digilent](https://digilent.com/reference/programmable-logic/zybo-z7/demos/pcam-5c) for using Pcam-5c. But using a custom HLS IP for color change.

## 1 Build Vitis HLS IP
* Open **Vitis Console 2024.1** commandline tool.
* go to **`color_change_HLS_app\hls_ip_source`** directory.
* generate vitis HLS by running **`run vitis_hls.py`**.
* Wait for script to complete. Check inside the  **`color_change_HLS_app\hls_ip_repo`** for extractacted file, **color_change** containing generated IP files.

## 2 Build Vivado System

* Open **Vivado 2024.1** 
* run **vivado_project.tcl** file by clicking **`'Tools' menu -> Run Tcl script..`** and browsing. 

### Adding Color_chage  hls IP
* If initial block design created withou error. Add **hls_ip_repo**.
    
    * go to Menu **`Window -> Ip catlog`** and in the catlog window **`right click -> Add repository`**
* Go to *block design diagram* and **`right click -> Add IP..`**. In the search bar search for **Color_change** and add the HLS IP.

* Reconnect wires as shown [here](reconnect_hls_ip.png).

* Right click **"Color_change_0"** and select **Make external** as shown [here](make_external.png)

* **Save Block Design** changes and Run **Generate Block Design**

### Rest of the flow

* If block design created without any error, proceed **generating bit stream**.
* Export design: click `File -> Export -> Export Hardware` and then in the **"Export Hardware Platform"** window, click `next` and select **`include bitstream`** option and export the design to the default location.

## 3 Generate Vitis Components

After successfully hardware system built expored as XSA file, above. We are going to use vitis classic for this project.  

* Open **Xilinx XSCT 2024.1** console.
* Go to the **color_change_app** directory. 
* run **`source vitis_classic.tcl`** to generate both platform and application components.
* After the script run sucessfully, close the XSCT conlole. 
* Open **Vitis Classic 2024.1** and locate the workspace inside **`color_change_app/cl_ws`** and build and run the application on hardware. 

### Known issues:

If you're using Windows, the path can only have 260 charters as Vitis and Vivado tools uses full paths. Make sure the repository is in shallow path closer to `C:/`. Otherwise you'll encounter random errors. 
