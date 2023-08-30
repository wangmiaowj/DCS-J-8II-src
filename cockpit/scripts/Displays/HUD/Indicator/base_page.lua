dofile(LockOn_Options.script_path .. "Displays/HUD/Indicator/hud_def.lua")

IndicatorName = "HUD_DIS_ENABLE"
local base_simple = AddSimple()
AddBox(nil,Width,Height,nil,nil,'DBG_RED',DEFAULT_NOCLIP_LEVEL,REWRITE_LEVEL,base_simple,nil,nil,true)
AddBox(nil,Width,Height,nil,nil,'DBG_CLEAR',DEFAULT_NOCLIP_LEVEL,INCREASE_IF_LEVEL,base_simple)