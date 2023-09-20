
dofile(LockOn_Options.script_path .. "Displays/Rod/indicator/definitions.lua")

IndicatorName = 'ROD'

local base_simple = AddSimple()

--十字架
AddCrossHair(nil,0.8*Width,0.8*Height,0.01*Width,nil,nil,'DBG_WHITE',nil,nil,base_simple)
--杆量环
AddCircle(nil,0.08*Width,0.06*Width,360,36,{0,0.02*Height},nil,'DBG_RED',nil,nil,base_simple,
{ "ROD_STICK_PITCH_POS","ROD_STICK_ROLL_POS" },
{
	{ "move_up_down_using_parameter", 0,-0.08 },
    { "move_left_right_using_parameter", 1,0.08 }
})
--脚舵线
local rudderLine = AddSimpleLine(nil,0.01*Width,{{-Width,0},{Width,0}},{0,-0.95*Height},nil,'DBG_WHITE',nil,nil,base_simple)
--脚舵位
AddSimpleLine(nil,0.01*Width,{{0,-0.05*Height},{0,0.05*Height}},nil,nil,'DBG_RED',nil,nil,rudderLine,{'ROD_RUD_POS'},{{ "move_left_right_using_parameter", 0, 0.1 }})
--左发线
local left_throttle_line = AddSimpleLine(nil,0.01*Width,{{0,-0.9*Height},{0,0.9*Height}},{-0.96*Width,0},nil,'DBG_WHITE',nil,nil,base_simple)
--右发线
local right_throttle_line = AddSimpleLine(nil,0.01*Width,{{0,-0.9*Height},{0,0.9*Height}},{-0.86*Width,0},nil,'DBG_WHITE',nil,nil,base_simple)
--左发位
AddSimpleLine(nil,0.01*Width,{{-0.05*Width,0},{0.05*Width,0}},{0,-0.9*Height},nil,'DBG_RED',nil,nil,left_throttle_line,{'ROD_LT_POS'},{{ "move_up_down_using_parameter", 0, 0.18 }})
--右发位
AddSimpleLine(nil,0.01*Width,{{-0.05*Width,0},{0.05*Width,0}},{0,-0.9*Height},nil,'DBG_RED',nil,nil,right_throttle_line,{'ROD_RT_POS'},{{ "move_up_down_using_parameter", 0, 0.18 }})
