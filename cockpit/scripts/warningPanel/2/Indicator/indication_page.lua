
dofile(LockOn_Options.script_path .. "warningPanel/def.lua")


local contact_scale = 0.030
local pct_display_fill = 0.90

local txtsize_center = 0.005*0.85
local strdefcenter = {txtsize_center, txtsize_center / 4, -txtsize_center / 8, 0}

local aspect       = GetAspect()
local maxWidth = 0.9
local maxHeight = 0.9*aspect

add_warning_info("unicode_cn_red",{-maxWidth*0.7,maxHeight*0.75},'防滑',{{'parameter_in_range',0,0.5,1.1},},{'ANTI_SKID',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,maxHeight*0.75},'整流器',{{'parameter_in_range',0,0.5,1.1},},{'RECTIFIER_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,maxHeight*0.75},'防喘振',{{'parameter_in_range',0,0.5,1.1},},{'ANTI_SURGE_FAIL',})

add_warning_info("unicode_cn_red",{-maxWidth*0.7,maxHeight*0.23},'飞控-1',{{'parameter_in_range',0,0.5,1.1},},{'FCS1_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,maxHeight*0.23},'飞控-2',{{'parameter_in_range',0,0.5,1.1},},{'FCS2_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,maxHeight*0.23},'飞控-3',{{'parameter_in_range',0,0.5,1.1},},{'FCS3_FAIL',})

add_warning_info("unicode_cn_red",{-maxWidth*0.7,-maxHeight*0.23},'除冰系统',{{'parameter_in_range',0,0.5,1.1},},{'ANTI_ICE',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,-maxHeight*0.23},'航电系统',{{'parameter_in_range',0,0.5,1.1},},{'AVION_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,-maxHeight*0.23},'皮托管',{{'parameter_in_range',0,0.5,1.1},},{'PITOR_FAIL',})

add_warning_info("unicode_cn_red",{-maxWidth*0.7,-maxHeight*0.8},'燃油泵',{{'parameter_in_range',0,0.5,1.1},},{'OIL_PUMP_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.0,-maxHeight*0.8},'滑油泵',{{'parameter_in_range',0,0.5,1.1},},{'LUB_OIL_FAIL',})
add_warning_info("unicode_cn_red",{maxWidth*0.7,-maxHeight*0.8},'舱内压力',{{'parameter_in_range',0,0.5,1.1},},{'COCKPIT_PRESS',})