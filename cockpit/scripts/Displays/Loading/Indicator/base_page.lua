dofile(LockOn_Options.script_path .. "Displays/Loading/Indicator/definitions.lua")

local base_simple          = AddSimple()

AddBox(nil,Width,Height,nil,nil,'DBG_CLEAR',DEFAULT_NOCLIP_LEVEL,REWRITE_LEVEL,base_simple,{ "LOADING_DISPLAY" },{{ "parameter_in_range", 0,0.9,1.1}},true)
AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 128, 0, 0, 32 }),DEFAULT_NOCLIP_LEVEL,INCREASE_IF_LEVEL,base_simple)