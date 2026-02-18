/*
 *  HLS Color Change IP
 *
 *  Author: Beniel Thileepan
 *  Date: 18/02/2026
 *
 */

 #include "color_change.h"

void color_change(
    ap_uint<DATA_WIDTH> i_vid_data,
    bool i_vid_hsync,
    bool i_vid_vsync,
    bool i_vid_VDE,
    ap_uint<DATA_WIDTH> &o_vid_data,
    bool &o_vid_hsync,
    bool &o_vid_vsync,
    bool &o_vid_VDE,
    ap_uint<4> btn
) {
    // Port Directives: 
    // We use ap_none to act like standard wires/registers without AXI handshaking
    #pragma HLS INTERFACE ap_none port=i_vid_data
    #pragma HLS INTERFACE ap_none port=i_vid_hsync
    #pragma HLS INTERFACE ap_none port=i_vid_vsync
    #pragma HLS INTERFACE ap_none port=i_vid_VDE
    #pragma HLS INTERFACE ap_none port=o_vid_data
    #pragma HLS INTERFACE ap_none port=o_vid_hsync
    #pragma HLS INTERFACE ap_none port=o_vid_vsync
    #pragma HLS INTERFACE ap_none port=o_vid_VDE
    #pragma HLS INTERFACE ap_none port=btn
    
    // Remove the AXI-Lite control interface to behave like a raw Verilog module
    #pragma HLS INTERFACE ap_ctrl_none port=return

    #pragma HLS PIPELINE II=1
    // Extract R, G, B based on your Verilog: assign {red, blu, gre} = i_vid_data;
    // In Verilog: red = [23:16], blu = [15:8], gre = [7:0]
    ap_uint<8> red = i_vid_data(23, 16);
    ap_uint<8> blu = i_vid_data(15, 8);
    ap_uint<8> gre = i_vid_data(7, 0);
    
    bool enable = btn[0];

    if (enable) {
        // Concatenate in the order: {blu, red, gre}
        // Result: [23:16]=blu, [15:8]=red, [7:0]=gre
        o_vid_data = (blu, red, gre);
    } else {
        o_vid_data = i_vid_data;
    }

    o_vid_hsync = i_vid_hsync;
    o_vid_vsync = i_vid_vsync;
    o_vid_VDE   = i_vid_VDE;
}