dofile(LockOn_Options.script_path .. "Displays/avRadar/Indicator/definitions.lua")
local base_simple = AddSimple()
--local MARK_MATERIAL   = MakeMaterial(nil,{255,120,0,255})
RS = RADAR_SCALE

local ud_scale      = 0.000015 * 0.1 * RS --0.00001
local lr_scale      = 0.095 * 0.1 * 2 * RS --0.2		--0.085
local life_time     = 1 --1
local life_time_low = 0

IndicatorName = 'RADAR_LIGHTNESS'


-------------------------------------------------------------
for i = 1, 4 do
	AddCircle(nil,i*0.45*RS,i*0.45*RS-0.005,360,72,{ 0, -0.9 * RS, 0 },nil,MakeMaterial(nil,{25, 255, 25, 128}),nil,nil,base_simple)
end

--	for ia = 1,999 do
for i = 1, 900 do
	AddBox(nil, 0.01 * 2*Width,0.01 * 2*Height,{ 0, -0.90 * RS, 0 },nil,MakeMaterial(nil, { 0, 15, 0, 255 }),nil,nil,base_simple,
		{
			string.format('RADAR_CONTACT_%02.0f_ELEVATION',i),
			string.format('RADAR_CONTACT_%02.0f_AZIMUTH',i),
			string.format('RADAR_CONTACT_%02.0f_RANGE',i),
			string.format('RADAR_CONTACT_%02.0f_TIME',i),
			string.format('RADAR_CONTACT_%02.0f_FRIENDLY',i),
			string.format('RADAR_CONTACT_%02.0f_RCS',i),
			string.format('RADAR_CONTACT_%02.0f_LGT',i),
		},
		{
			--{"move_up_down_using_parameter"		,0,1.0},
			{ "move_left_right_using_parameter", 1, lr_scale },
			{ "move_up_down_using_parameter", 2, ud_scale },
			{ "parameter_in_range", 2, 30, 120000 },
			{ "parameter_in_range", 3, life_time_low, life_time },
			{ "change_color_when_parameter_equal_to_number", 4, 1, 1.0, 1.0, 0.0 },
			{ "parameter_in_range", 5, -1,100},
			{ "opacity_using_parameter", 6}
		}
	)
end
--------------------------------------------------------------------------


local x_size = 0.04*Width
local y_size = 0.05*Height

local TDC_cursor = AddMultiLine(nil,nil,nil,{{-x_size,-y_size},{-x_size,y_size},{x_size,-y_size},{x_size,y_size}},{0,1,2,3},{ 0, -0.90 * RS, 0 },nil,'DBG_BLACK','CenterCenter',nil,nil,base_simple,
	{
		"RADAR_TDC_RANGE",
		"RADAR_TDC_AZIMUTH",
		"RADAR_MODE",
	},
	{
		{ "move_up_down_using_parameter", 0, ud_scale },
		{ "move_left_right_using_parameter", 1, lr_scale },
		{ "parameter_in_range", 2, -0.1, 2.1 },
	}
)

local TDC_cursor = AddMultiLine(nil,nil,nil,{{-x_size,-y_size},{-x_size,y_size},{x_size,-y_size},{x_size,y_size}},{0,1,2,3},{ 0, -0.90 * RS, 0 },nil,'DBG_BLACK','CenterCenter',nil,nil,base_simple,
	{
		"RADAR_TDC_RANGE",
		"RADAR_TDC_AZIMUTH",
		"RADAR_MODE",
	},
	{
		{ "move_up_down_using_parameter", 0, ud_scale },
		{ "move_left_right_using_parameter", 1, lr_scale },
		{ "parameter_in_range", 2, -0.1, 2.1 },
	}
)

AddSimpleLine(nil,0.008,{{0,0},{0,0}},{ 0, -0.90 * RS},nil,'DBG_BLACK',nil,nil,base_simple,
	{"RADAR_MODE","RADAR_TDC_AZIMUTH","RADAR_TDC_RANGE","RADAR_TDC_AZIMUTH_2","RADAR_TDC_RANGE_2"},
	{
		{"parameter_in_range",0,-0.1,2.1},
		{"line_object_set_point_using_parameters",0,1,2,lr_scale,ud_scale},
		{"line_object_set_point_using_parameters",1,3,4,lr_scale,ud_scale},
	}
)
--扫描扇区
AddCircle(nil,1.9*Width,0,100,72,{0,-0.9*RS},{50,0},MakeMaterial(nil, { 0, 0, 0, 64 }),nil,nil,base_simple,
	{'SCAN_ZONE_ORIGIN_AZIMUTH'},
	{{'rotate_using_parameter',0,1}}
)

local radar_STT = AddBox(nil,0.03*Width,0.03*Height,{ 0, -0.90 * RS, 0 },nil,'DBG_BLACK',nil,nil,base_simple,
	{
		"RADAR_STT_RANGE",
		"RADAR_STT_AZIMUTH",
		"RADAR_STT_ELEVATION",
		"RADAR_MODE",
	},
	{
		{ "move_up_down_using_parameter", 0, ud_scale },
		{ "move_left_right_using_parameter", 1, lr_scale },
		--{"move_up_down_using_parameter"		,3,1.0},
		{ "parameter_in_range", 3, 2.9, 3.1 },
	}
)

AddText(nil,'test',RDR_FONT_INV,{ -0.1, 0.0 },'RightCenter',DEFAULT_FONT_SIZE_2[6],nil,nil,radar_STT,
	 {"%.0fM" },
	 { "RADAR_STT_RANGE" },
	 {
		{ "text_using_parameter", 0,},
	}
)

AddCrossHair(nil,0.09*Width,0.09*Height,0.005*Width,nil,nil,'DBG_BLACK',nil,nil,base_simple,
{
	"RADAR_STT_RANGE",
	"RADAR_STT_AZIMUTH",
	"RADAR_STT_ELEVATION",
	"RADAR_MODE",
},
{
	{ "move_left_right_using_parameter", 1, lr_scale },
	{ "move_up_down_using_parameter", 2, lr_scale },
	{ "parameter_in_range", 3, 2.9, 3.1 },
})

AddBox(nil,0.08*Width,0.004*Height,nil,nil,'DBG_BLACK',nil,nil,radar_STT,
{ "RADAR_STT_FRIENDLY", },
{
	{ "parameter_in_range", 0, 0.9, 1.1 },
	{ "change_color_when_parameter_equal_to_number", 0, 1, 1.0, 1.0, 0.0 },
})
AddText(nil,'test',RDR_FONT_INV,{ -0.1*Width, 0 },'RightCenter',DEFAULT_FONT_SIZE_2[6],nil,nil,TDC_cursor,
{ "%.0f" },
{ "RADAR_TDC_RANGE", },
{ 
	{ "text_using_parameter", 0,},
})

--雷达上半球角
AddText(nil,'test',RDR_FONT_INV,{ 0.1*Width, 0.1*Height },'LeftCenter',DEFAULT_FONT_SIZE_2[6],nil,nil,TDC_cursor,
{ "%.0f" },
{ "SCAN_ZONE_ORIGIN_ELEVATION_DEG_UP", },
{ 
	{ "text_using_parameter", 0,},
})
--雷达下半球角
AddText(nil,'test',RDR_FONT_INV,{ 0.1*Width, -0.1*Height },'LeftCenter',DEFAULT_FONT_SIZE_2[6],nil,nil,TDC_cursor,
{ "%.0f" },
{ "SCAN_ZONE_ORIGIN_ELEVATION_DEG_DN", },
{ 
	{ "text_using_parameter", 0,},
})

--AddText(nil,'test',RDR_FONT_INV,{ 0.25, 0.05, 0 },'RightCenter',DEFAULT_FONT_SIZE_2[6],nil,nil,TDC_cursor,{ "%.4f", "%s" },{ "RADAR_TDC_ELEVATION_AT_RANGE_UPPER"},{ { "text_using_parameter", 0, 0 }, })
--AddText(nil,'test',RDR_FONT_INV,{ 0.25, -0.05, 0 },'RightCenter',DEFAULT_FONT_SIZE_2[6],nil,nil,TDC_cursor,{ "%.4f", "%s" },{ "RADAR_TDC_ELEVATION_AT_RANGE_LOWER"},{ { "text_using_parameter", 0, 0 } })

AddText(nil,'15',MakeMaterial({ used_DXUnicodeFontData = "font_arial_17" }, { 0, 15, 0, 255 }),
{ -0.45 * RS, 0.9 * RS },'CenterBottom',DEFAULT_FONT_SIZE_2[6],nil,nil,base_simple,
{'%.0f'})

AddText(nil,'15',MakeMaterial({ used_DXUnicodeFontData = "font_arial_17" }, { 0, 15, 0, 255 }),
{ 0.45 * RS, 0.9 * RS },'CenterBottom',DEFAULT_FONT_SIZE_2[6],nil,nil,base_simple,
{'%.0f'})


AddText(nil,'30',MakeMaterial({ used_DXUnicodeFontData = "font_arial_17" }, { 0, 15, 0, 255 }),
{ -0.9 * RS, 0.9 * RS },'CenterBottom',DEFAULT_FONT_SIZE_2[6],nil,nil,base_simple,
{'%.0f'})

AddText(nil,'30',MakeMaterial({ used_DXUnicodeFontData = "font_arial_17" }, { 0, 15, 0, 255 }),
{ 0.9 * RS, 0.9 * RS },'CenterBottom',DEFAULT_FONT_SIZE_2[6],nil,nil,base_simple,
{'%.0f'})

AddSimpleLine(nil,0.005,{{0,0},{0,2*Height}},{ 0, -0.9 * RS, 0 },nil,MakeMaterial(nil, { 236, 255, 250, 255 }),nil,nil,base_simple,
{ "SCAN_BEAM_AZIMUTH", "RADAR_MODE"},
{
	{ "rotate_using_parameter", 0, 1 },
	{"parameter_in_range",1,0.9,2.9},
	--{"change_color_when_parameter_equal_to_number", 0, 1, 1.0,1.0,0.0}
})