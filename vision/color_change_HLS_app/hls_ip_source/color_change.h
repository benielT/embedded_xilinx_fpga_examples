/*
 *  HLS Color Change IP
 *
 *  Author: Beniel Thileepan
 *  Date: 18/02/2026
 * 
 */

#ifndef COLOUR_CHANGE_H_
#define COLOUR_CHANGE_H_

#include <ap_int.h>

#define DATA_WIDTH 24

// struct video_signals {
//     ap_uint<DATA_WIDTH> data;
//     bool hsync;
//     bool vsync;
//     bool vde;
// };

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
);

#endif