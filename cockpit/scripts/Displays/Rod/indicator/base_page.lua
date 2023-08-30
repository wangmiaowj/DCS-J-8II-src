dofile(LockOn_Options.script_path .. "Displays/Rod/Indicator/definitions.lua")
IndicatorName = 'ROD_DISPLAY'

local base_simple          = AddSimple()
AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 128, 0, 0, 32 }),DEFAULT_NOCLIP_LEVEL,REWRITE_LEVEL,base_simple,nil,nil,true)
AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 128, 0, 0, 32 }),DEFAULT_NOCLIP_LEVEL,INCREASE_IF_LEVEL,base_simple)