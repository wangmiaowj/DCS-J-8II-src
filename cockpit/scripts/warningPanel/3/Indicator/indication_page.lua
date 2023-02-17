
dofile(LockOn_Options.script_path .. "warningPanel/def.lua")


local contact_scale = 0.030
local pct_display_fill = 0.90

local txtsize_center = 0.005*0.85
local strdefcenter = {txtsize_center, txtsize_center / 4, -txtsize_center / 8, 0}

local aspect       = GetAspect()
local maxWidth = 0.9
local maxHeight = 0.9*aspect

add_warning_info("unicode_cn_green",{-maxWidth*0.5,maxHeight*0.87},'左发加力',{{'parameter_in_range',0,0.5,1.1},},{'L_AB',})
add_warning_info("unicode_cn_green",{maxWidth*0.53,maxHeight*0.87},'右发加力',{{'parameter_in_range',0,0.5,1.1},},{'R_AB',})

add_warning_info("unicode_cn_yellow",{-maxWidth*0.5,maxHeight*0.52},'左发过热',{{'parameter_in_range',0,0.5,1.1},},{'L_ENG_HOT',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.53,maxHeight*0.52},'右发过热',{{'parameter_in_range',0,0.5,1.1},},{'R_ENG_HOT',})

add_warning_info("unicode_cn_red",{-maxWidth*0.5,maxHeight*0.16},'环控故障',{{'parameter_in_range',0,0.5,1.1},},{'ENV_CONTROL_FAIL',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.53,maxHeight*0.16},'设备过热',{{'parameter_in_range',0,0.5,1.1},},{'DEV_HOT',})

add_warning_info("unicode_cn_red",{-maxWidth*0.5,-maxHeight*0.18},'氧气供给',{{'parameter_in_range',0,0.5,1.1},},{'OXY_SUPPLY',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.53,-maxHeight*0.18},'滚转增稳',{{'parameter_in_range',0,0.5,1.1},},{'ROLL_STAB_FAIL',})

add_warning_info("unicode_cn_yellow",{-maxWidth*0.5,-maxHeight*0.55},'俯仰增稳',{{'parameter_in_range',0,0.5,1.1},},{'PITCH_STAB_FAIL',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.53,-maxHeight*0.55},'偏航增稳',{{'parameter_in_range',0,0.5,1.1},},{'YAW_STAB_FAIL',})

add_warning_info("unicode_cn_green",{-maxWidth*0.5,-maxHeight*0.9},'自动驾驶',{{'parameter_in_range',0,0.5,1.1},},{'AP',})
add_warning_info("unicode_cn_yellow",{maxWidth*0.53,-maxHeight*0.9},'前轮转向',{{'parameter_in_range',0,0.5,1.1},},{'NWS',})