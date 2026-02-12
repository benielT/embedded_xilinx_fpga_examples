# Installation Guide for Vitis Vision Library

This guide is focusing on installing OpenCV 4.4.0 and Vitis Vision library 2024.1 - Supporting Vitis toolchain.

Testing - OS: Windows 11, Tool VItis 2024.1

## Acknowledgement

This guide is based on - [Xilinx/xup_high_level_synthesis_design_flow - vision library windows setup](github.com/Xilinx/xup_high_level_synthesis_design_flow/blob/main/source/sobel/tutorial/vision_library_win.md)

For setup on linux system check - [Xilinx/xup_high_level_synthesis_design_flow - vision library linux setup](https://github.com/Xilinx/xup_high_level_synthesis_design_flow/blob/main/source/sobel/tutorial/vision_library_linux.md)


## Setup: Step-by-Step

### 1. Install OpenCV

Pre-requisite:

1.  Install MinGW - Required to build both OpenCV and Vitis Libraries

    a) https://winlibs.com - GCC 7.5.0 POSIX threads Win64 ZIP (on GitHub archive pages, direct link below)

    https://github.com/brechtsanders/winlibs_mingw/releases/download/7.5.0-7.0.0-r1/winlibs-x86_64-posix-seh-gcc-7.5.0-mingw-w64-7.0.0-r1.7z

    b) Unzip (using 7-zip) MinGW to a location of your choice.
Add MinGW to the PATH system environment variable 

    c) Add MinGW to the PATH system environment variable.
        
    * Open the Start menu > type 'Edit the System Environment Variables' > Select Environment Variables ([Example Image](./misc/Env_Var.png)).
    * Edit 'Path' variable in sytem variables ([Example Image](./misc/edit_path.png)).
    * Click 'Browse' and point to the 'bin' folder of the the extracted MinGW folder.
    * Click 'OK' to confirm changes and close all the windows.

2. Install CMake
    
    Download latest CMake and install from: https://cmake.org/download/

3. Download OpenCV
    
    * Download https://github.com/opencv/opencv/archive/refs/tags/4.4.0.zip and extract into your choice of base folder with subfolder **'opencv'**.
    * Download https://github.com/opencv/opencv_contrib/archive/refs/tags/4.4.0.zip and extract into the same based folder as above into subfolder **'opencv_contrib'**.