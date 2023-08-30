
dofile(LockOn_Options.script_path .. "Displays/warningPanel/def.lua")

local aspect       = GetAspect()

local contact_scale = 0.030
local pct_display_fill = 0.90

local txtsize_center = 0.005*0.85
local strdefcenter = {txtsize_center, txtsize_center / 4, -txtsize_center / 8, 0}

local maxWidth = 0.9
local maxHeight = 0.9*aspect

add_warning_info("unicode_cn_red",{-maxWidth*0.7,maxHeight*0.75},'左发失火',{{'parameter_in_range',0,0.5,1.1},},{'L_ENG_FIRE',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,maxHeight*0.75},'右发失火',{{'parameter_in_range',0,0.5,1.1},},{'R_ENG_FIRE',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,maxHeight*0.75},'起动机失火',{{'parameter_in_range',0,0.5,1.1},},{'MOTOR_FIRE',})

add_warning_info("unicode_cn_red",{-maxWidth*0.7,maxHeight*0.23},'液压失效',{{'parameter_in_range',0,0.5,1.1},},{'HYD_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,maxHeight*0.23},'雷达失效',{{'parameter_in_range',0,0.5,1.1},},{'RADAR_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,maxHeight*0.23},'IR失效',{{'parameter_in_range',0,0.5,1.1},},{'IR_FAIL',})

add_warning_info("unicode_cn_red",{-maxWidth*0.7,-maxHeight*0.3},'自动驾驶\n失效',{{'parameter_in_range',0,0.5,1.1},},{'AP_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,-maxHeight*0.23},'ECM失效',{{'parameter_in_range',0,0.5,1.1},},{'ECM_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,-maxHeight*0.3},'导弹告警\n失效',{{'parameter_in_range',0,0.5,1.1},},{'MLWS_FAIL',})

add_warning_info("unicode_cn_red",{-maxWidth*0.7,-maxHeight*0.82},'通信系统\n失效',{{'parameter_in_range',0,0.5,1.1},},{'NCS_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,-maxHeight*0.8},'系统失效',{{'parameter_in_range',0,0.5,1.1},},{'SYSTEM_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,-maxHeight*0.8},'刹车失效',{{'parameter_in_range',0,0.5,1.1},},{'BRAKE_FAIL',})