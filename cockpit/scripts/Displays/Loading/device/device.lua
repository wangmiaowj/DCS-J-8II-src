dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local dev = GetSelf()
local time = 0
local video_time = -1

local autoStart_BGM
local stopBGM_delay = -1
local bgm_gain = 1

local CHN_LOADING_TIME = get_param_handle('CHN_LOADING_TIME')
local LOADING_DISPLAY = get_param_handle('LOADING_DISPLAY')

function post_initialize()
    local sndhost = create_sound_host("COCKPIT_AUTO_START", "HEADPHONES", 0, 0, 0)
    autoStart_BGM = sndhost:create_sound("Music/A-10C_II")
end

function SetCommand(command,value)
    
end

function update()
	time = time + update_time_step
	if time > 10 then
		if not autoStart_BGM:is_playing() then
			autoStart_BGM:play_continue()
			video_time = 0
		end
	else
		if autoStart_BGM:is_playing() then
			autoStart_BGM:stop()
			video_time = -1
		end
	end
	if autoStart_BGM:is_playing() then
        video_time = video_time + update_time_step
        if video_time > 122 then
            video_time = 0
        end
    else
        video_time = -1
        LOADING_DISPLAY:set(0)
    end
	CHN_LOADING_TIME:set(video_time)
end