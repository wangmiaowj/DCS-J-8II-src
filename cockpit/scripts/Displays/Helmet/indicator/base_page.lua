dofile(LockOn_Options.script_path .. "Displays/Helmet/Indicator/definitions.lua")
local base_simple = AddSimple()

AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 128, 0, 0, 32 }),DEFAULT_NOCLIP_LEVEL,REWRITE_LEVEL,base_simple,nil,nil,true)
AddBox(nil,Width,Height,nil,nil,MakeMaterial(nil, { 0, 0, 0, 0 }),DEFAULT_NOCLIP_LEVEL,INCREASE_IF_LEVEL,base_simple)