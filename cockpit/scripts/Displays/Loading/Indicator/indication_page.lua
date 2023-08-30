
dofile(LockOn_Options.script_path .. "Displays/Loading/indicator/definitions.lua")

local base_simple = AddSimple()

ChinaLoading_video = {}
local video_width = Width
local video_height = Width/(1280/720)
for i = 1, 4615, 1 do
    local img = string.format( "CHN_LOADING_%04.0f",i )
	local end_time = i*(1/30)
	local start_time = end_time-1/30
	AddTex(nil,video_width,video_height,nil,nil,img,nil,nil,base_simple.name,
		{'CHN_LOADING_TIME'},
		{{'parameter_in_range',0,start_time,end_time}}
	)
end