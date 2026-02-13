# Installation Guide for Vitis Vision Library

This guide is focusing on installing OpenCV 4.4.0 and Vitis Vision library 2024.1 - Supporting Vitis toolchain.

Testing - OS: Windows 11, Tool VItis 2024.1

## Acknowledgement

This guide is based on - [Xilinx/xup_high_level_synthesis_design_flow - vision library windows setup](https://github.com/Xilinx/xup_high_level_synthesis_design_flow/blob/main/source/sobel/tutorial/vision_library_win.md) and [openCV install post](https://adaptivesupport.amd.com/s/article/000035890?language=en_US) from AMD support.

For setup on linux system check - [Xilinx/xup_high_level_synthesis_design_flow - vision library linux setup](https://github.com/Xilinx/xup_high_level_synthesis_design_flow/blob/main/source/sobel/tutorial/vision_library_linux.md)


## Setup: Step-by-Step

### Pre-requisite:

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


### 1. Install OpenCV

#### I. CMake Setup:

* Open CMake (cmake-gui) from the Start Menu
* Set "Where is the source code" to the extracted opencv folder.
* Set "Where to build the binaries" to the extracted opencv folder, and append /build to the end. This will be the build location for compiled files, you can set it to any folder you wish
* Click "Configure" ([Example Image](./misc/openCV_cmake.png))
    * Select "Yes" to create the build directory if a pop-up appears stating it does not exist
    * Choose "MinGW Makefiles" as the default native compiler if prompted.
    * The compiler will run tests to ensure functionality and gather attributes. Wait for completion. (Took me 10 mins).
* After configure complete, search for these configs and set accordingly,
    * **BUILD_PROTOBUF** – uncheck
    * **WITH_PROTOBUF** – uncheck
    * **BUILD_TESTS** – uncheck
    * **WITH_OPENEXR** – uncheck
    * **BUILD_OPENEXR** – uncheck
    * **OPENCV_ENABLE_ALLOCATOR_STATS** – uncheck
    * **CMAKE_BUILD_TYPE** – RELEASE
    * **CMAKE_INSTALL_PREFIX** - Set the path opencv needs to be installed. By defualt it will be **`../opencv/build/install`**
    * **OPENCV_EXTRA_MODULES_PATH** - VERY IMPORTANT. Set the path to extracted **opencv_contrib/modules** folder. In our case it is **`../opencv_contrib/modules`**
* After setting above, click **"generate"** (Will take 1-2 minutes).
* Verify the changes and close CMake GUI.

#### II. MinGW Make and Install:

* Open command prompt and navidate to **`opencv/build`** folder.
* Run **`mingw32-make`** to make openCV. (Took me about 1 hour)
* Run **`mingw32-make install`** to install build openCV to the configured location earlier in the [CMake setup](#i-cmake-setup).





