dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local stick_pitch_pos = get_param_handle("BASE_SENSOR_STICK_PITCH_POS")
local stick_roll_pos = get_param_handle("BASE_SENSOR_STICK_ROLL_POS")
local rudder_pos = get_param_handle("BASE_SENSOR_RUDDER_POS")

sensor_data = get_base_data()

local switch_count = 0
local function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end
local display = _switch_counter()
local roll_pos = _switch_counter()
local pitch_pos = _switch_counter() 
local rud_pos = _switch_counter()--rudder_position
local lt_pos = _switch_counter() --left_throttle_positon
local rt_pos = _switch_counter() --right_throttle_position
local lt_whl_brake_pos = _switch_counter() --left_wheel_brake_position
local rt_whl_brake_pos = _switch_counter() --right_wheel_brake_position

local target_status ={
    {display,0,get_param_handle("ROD_BRT")},
    {roll_pos,0,get_param_handle("ROD_STICK_ROLL_POS")},
    {pitch_pos,0,get_param_handle("ROD_STICK_PITCH_POS")},
    {rud_pos,0,get_param_handle("ROD_RUD_POS")},
    {lt_pos,0,get_param_handle("ROD_LT_POS")},
    {rt_pos,0,get_param_handle("ROD_RT_POS")},
    {lt_whl_brake_pos,0,get_param_handle("ROD_LEFT_WHEEL_BRAKE_POS")},
    {rt_whl_brake_pos,0,get_param_handle("ROD_RIGHT_WHEEL_BRAKE_POS")},
}

local current_status = {
	{display, SWITCH_OFF, SWITCH_OFF},
	{roll_pos, SWITCH_OFF, SWITCH_OFF},
	{pitch_pos, SWITCH_OFF, SWITCH_OFF},
    {rud_pos, SWITCH_OFF, SWITCH_OFF},
    {lt_pos, SWITCH_OFF, SWITCH_OFF},
    {rt_pos, SWITCH_OFF, SWITCH_OFF},
    {lt_whl_brake_pos, SWITCH_OFF, SWITCH_OFF},
    {rt_whl_brake_pos, SWITCH_OFF, SWITCH_OFF},
}

local function update_element_status()
    for k,v in pairs(target_status) do
        current_status[k][2]=v[2]
        v[3]:set(current_status[k][2])
    end
end

update_time_step = 0.02
make_default_activity(update_time_step)
local dev = GetSelf()

dev:listen_command(851)

function post_initialize()

end

function SetCommand(command, value)
    if command == 851 then
        target_status[display][2]=1 - target_status[display][2]
    end
end

function update()
    if stick_roll_pos:get() < 0 then
        target_status[pitch_pos][2]=stick_roll_pos:get()/100*2
    else
        target_status[pitch_pos][2]=stick_roll_pos:get()/100
    end
    target_status[roll_pos][2]=stick_pitch_pos:get()/100
    target_status[rud_pos][2]=rudder_pos:get()/100
    target_status[lt_pos][2]=sensor_data.getThrottleLeftPosition()
    target_status[rt_pos][2]=sensor_data.getThrottleRightPosition()
    update_element_status()
end