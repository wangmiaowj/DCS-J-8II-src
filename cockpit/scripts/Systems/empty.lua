dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."debug_util.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local rpm = get_param_handle('ED_FM_ENGINE_1_RPM')
local rpm = get_param_handle('ED_FM_ENGINE_1_RELATED_RPM')
local dev = GetSelf()


function post_initialize()
    
end

function SetCommand(command,value)
	
end

function update()
	
end

need_to_be_closed = false