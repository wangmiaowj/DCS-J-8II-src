
dofile(LockOn_Options.script_path .. "warningPanel/def.lua")


local contact_scale = 0.030
local pct_display_fill = 0.90

local txtsize_center = 0.005*0.85
local strdefcenter = {txtsize_center, txtsize_center / 4, -txtsize_center / 8, 0}

local aspect       = GetAspect()
local maxWidth = 0.9
local maxHeight = 0.9*aspect

add_warning_info("unicode_cn_red",{-maxWidth*0.85,maxHeight*0.75},'左发电机',{{'parameter_in_range',0,0.5,1.1},},{'L_GEN',})
add_warning_info("unicode_cn_green", { -maxWidth * 0.28, maxHeight * 0.75 }, '电瓶',
    { { 'parameter_in_range', 0, 0.5, 1.1 }, 
    { 'change_color_when_parameter_equal_to_number', 1, 0, 1, 0, 0, 1 },
    { 'change_color_when_parameter_equal_to_number', 1, 1, 1, 1, 0, 1 },
    { 'change_color_when_parameter_equal_to_number', 1, 2, 0, 1, 0, 1 }}, { 'BATT', 'BATT_COLOR'})
add_warning_info("unicode_cn_red",{maxWidth*0.3,maxHeight*0.75},'右发电机',{{'parameter_in_range',0,0.5,1.1},},{'R_GEN',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.87,maxHeight*0.75},'座舱\n未密封',{{'parameter_in_range',0,0.05,0.89},},{'CANOPY',})

add_warning_info("unicode_cn_red",{-maxWidth*0.85,maxHeight*0.25},'左逆变器',{{'parameter_in_range',0,0.5,1.1},},{'L_INV',})
add_warning_info("unicode_cn_green",{-maxWidth*0.28,maxHeight*0.25},'直流电',{{'parameter_in_range',0,0.5,1.1},},{'DC',})
add_warning_info("unicode_cn_red",{maxWidth*0.3,maxHeight*0.25},'右逆变器',{{'parameter_in_range',0,0.5,1.1},},{'R_INV',})
add_warning_info("unicode_cn_green",{maxWidth*0.87,maxHeight*0.25},'交流电',{{'parameter_in_range',0,0.5,1.1},},{'AC',})

add_warning_info("unicode_cn_yellow",{-maxWidth*0.85,-maxHeight*0.28},'发电机\n互联',{{'parameter_in_range',0,0.5,1.1},},{'GEN_INTER',})
add_warning_info("unicode_cn_green",{-maxWidth*0.28,-maxHeight*0.28},nil,{{'parameter_in_range',0,0,100.1},{'text_using_parameter',1}},{'MOTOR_DIS_RPM','MOTOR_DIS_RPM'},{'起动机\n%.1f%%',"%s"})
add_warning_info("unicode_cn_red",{maxWidth*0.3,-maxHeight*0.28},'燃油不足',{{'parameter_in_range',0,0.5,1.1},},{'FUEL_LOW',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.87,-maxHeight*0.28},'飞控过热',{{'parameter_in_range',0,0.5,1.1},},{'FCS_HOT',})

add_warning_info("unicode_cn_red",{-maxWidth*0.85,-maxHeight*0.78},'左进气道',{{'parameter_in_range',0,0.5,1.1},},{'L_INTAKE',})
add_warning_info("unicode_cn_red",{-maxWidth*0.28,-maxHeight*0.78},'右进气道',{{'parameter_in_range',0,0.5,1.1},},{'R_INTAKE',})
add_warning_info("unicode_cn_green",{maxWidth*0.3,-maxHeight*0.78},'ECM',{{'parameter_in_range',0,0.5,1.1},},{'ECM',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.87,-maxHeight*0.78},'弹射逃生\n系统',{{'parameter_in_range',0,0.5,1.1},},{'EJECT_SYSTEM',})
