dofile(LockOn_Options.script_path .. "Displays/avRadar/Indicator/definitions.lua")

local SHOW_MASKS = false

local base_simple          = AddSimple()

IndicatorName = 'RADAR'

AddCircle(nil,Width,0,360,72,nil,nil,'DBG_RED',REWRITE_LEVEL,DEFAULT_NOCLIP_LEVEL,base_simple,nil,nil,not SHOW_MASKS)

AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 91, 255, 211, 32 }),DEFAULT_NOCLIP_LEVEL,INCREASE_IF_LEVEL,base_simple)
