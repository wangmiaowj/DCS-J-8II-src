dofile(LockOn_Options.script_path .. "Displays/avRwr/Indicator/definitions.lua")
IndicatorName = 'RWR'

local SHOW_MASKS                    = false

local base_simple = AddSimple()

AddCircle(nil,Width,0,360,72,nil,nil,'DBG_RED',REWRITE_LEVEL,DEFAULT_NOCLIP_LEVEL,base_simple,nil,nil,not SHOW_MASKS)

AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 0, 16, 0, 255 }),DEFAULT_NOCLIP_LEVEL,INCREASE_IF_LEVEL,base_simple)
