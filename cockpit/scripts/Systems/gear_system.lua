dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path .. "debug_util.lua")
dofile(LockOn_Options.script_path .. "devices.lua")

local gear_system = GetSelf()

local update_time_step = 0.02 --50 refreshes per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--local iCommandPlaneGear
local gear_switch = 68 --Define landing gear buttons
local gear_up = 430
local gear_down = 431

local nose_gear_status = 1 --Landing gear status 0 retracted, 1 lowered
local l_main_gear_status = 1
local r_main_gear_status = 1

local nose_gear_broken = 0 --Landing gear condition 0 normal, 1 malfunction
local l_main_gear_broken = 0
local r_main_gear_broken = 0

local gear_level_init = 0 --The landing gear handle is not set by default

local gear_level = get_param_handle("LDG_Handle")

-- set indicator
local ngear_pos_ind = get_param_handle("F_WHEEL_IND")
local mlgear_pos_ind = get_param_handle("L_WHEEL_IND")
local mrgear_pos_ind = get_param_handle("R_WHEEL_IND")

local gear_state_share = get_param_handle("GEAR_SHARE")

gear_system:listen_command(gear_switch)
gear_system:listen_command(gear_up)
gear_system:listen_command(gear_down)

local n_gear_status
local l_gear_status
local r_gear_status

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" then
        nose_gear_status = 1 --Landing gear status 0 retracted, 1 lowered
        l_main_gear_status = 1
        r_main_gear_status = 1
    elseif birth == "AIR_HOT" then
        nose_gear_status = 0 --Landing gear status 0 retracted, 1 lowered
        l_main_gear_status = 0
        r_main_gear_status = 0
    elseif birth == "GROUND_COLD" then
        nose_gear_status = 1 --Landing gear status 0 retracted, 1 lowered
        l_main_gear_status = 1
        r_main_gear_status = 1
    end

    n_gear_status = nose_gear_status
    l_gear_status = l_main_gear_status
    r_gear_status = r_main_gear_status

    if (gear_level_init == 0) then
        --gear_system:performClickableAction(click_cmd.GearLevel, 1, false)
    end

    set_aircraft_draw_argument_value(0, nose_gear_status)
    set_aircraft_draw_argument_value(3, r_main_gear_status)
    set_aircraft_draw_argument_value(5, l_main_gear_status)
    gear_level_pos = nose_gear_status
end

local move_ability = 1;
function SetCommand(command, value)
    if (command == gear_switch) then
        local isOnGround = get_aircraft_draw_argument_value(1) > 0 or get_aircraft_draw_argument_value(4) > 0 or get_aircraft_draw_argument_value(6) > 0
        if not isOnGround then
            nose_gear_status = 1 - nose_gear_status
            l_main_gear_status = 1 - l_main_gear_status
            r_main_gear_status = 1 - r_main_gear_status
        end
        if (nose_gear_status == 1) then
            dprintf("Gear Down")
        else
            dprintf("Gear Up")
        end
    elseif (command == gear_down) then
        nose_gear_status = 1
        l_main_gear_status = 1
        r_main_gear_status = 1
    elseif (command == gear_up) then
        nose_gear_status = 0
        l_main_gear_status = 0
        r_main_gear_status = 0
    end
end

local moving_starts = 0
local c = 0
function update()
    local gear_handle_click_ref = get_clickable_element_reference("PNT_083")

    --takes 7 seconds to full extended
    -- set globle time count
    local time_increse_step = 0.02 / 7
    if (sensor_data.getWOW_LeftMainLandingGear() > 0.001 or sensor_data.getWOW_NoseLandingGear() > 0.001 or sensor_data.getWOW_RightMainLandingGear() > 0.001) then
        move_ability = 0
        --dprintf("L:"..sensor_data.getWOW_LeftMainLandingGear());
        --dprintf("R:"..sensor_data.getWOW_RightMainLandingGear());
    else
        move_ability = 1
    end
    --dprintf("N:"..sensor_data.getWOW_NoseLandingGear());
    if (nose_gear_status == 0 and n_gear_status > 0) then
        -- in increments of time_increse_step (50x per second)
        n_gear_status = n_gear_status - time_increse_step * move_ability
        if moving_starts == 0 and move_ability == 1 then
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_GEAR, 1)
            moving_starts = 1
        end
    elseif (nose_gear_status == 1 and n_gear_status < 1) then
        -- in increments of time_increse_step (50x per second)
        n_gear_status = n_gear_status + time_increse_step
        if moving_starts == 0 and move_ability == 1 then
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_GEAR, 1)
            moving_starts = 1
        end
    else
        moving_starts = 0
    end

    if (nose_gear_status == 0 and n_gear_status <= 0) then
        n_gear_status = 0
    elseif (nose_gear_status == 1 and n_gear_status >= 1) then
        n_gear_status = 1
    end

    if (l_main_gear_status == 0 and l_gear_status > 0) then
        l_gear_status = l_gear_status - time_increse_step * move_ability
    elseif (l_main_gear_status == 1 and l_gear_status < 1) then
        l_gear_status = l_gear_status + time_increse_step
    end
    if (l_main_gear_status == 0 and l_gear_status <= 0) then
        l_gear_status = 0
    elseif (l_main_gear_status == 1 and l_gear_status >= 1) then
        l_gear_status = 1
    end

    if (r_main_gear_status == 0 and r_gear_status > 0) then
        -- lower canopy in increments of time_increse_step (50x per second)
        r_gear_status = r_gear_status - time_increse_step * move_ability 
    elseif (r_main_gear_status == 1 and r_gear_status < 1) then
        -- lower canopy in increments of time_increse_step (50x per second)
        r_gear_status = r_gear_status + time_increse_step
    end

    if (r_main_gear_status == 0 and r_gear_status <= 0) then
        r_gear_status = 0
    elseif (l_main_gear_status == 1 and r_gear_status >= 1) then
        r_gear_status = 1
    end

    -- level step slower
    if (nose_gear_status == 0 and gear_level_pos > 0) then
        -- lower canopy in increments of time_increse_step (50x per second)
        gear_level_pos = gear_level_pos - 0.1
    elseif (nose_gear_status == 1 and gear_level_pos < 1) then
        -- lower canopy in increments of time_increse_step (50x per second)
        gear_level_pos = gear_level_pos + 0.1
    end

    if (gear_level_pos < 0) then
        gear_level_pos = 0
    elseif (gear_level_pos > 1) then
        gear_level_pos = 1
    end

    -- the gear indication system  wont work without the dc power
    if get_elec_dc_status() or get_elec_ac_status() then
        ngear_pos_ind:set(n_gear_status)
        mlgear_pos_ind:set(l_gear_status)
        mrgear_pos_ind:set(r_gear_status)
    else
        ngear_pos_ind:set(-1)
        mlgear_pos_ind:set(-1)
        mrgear_pos_ind:set(-1)
    end
    gear_level:set(gear_level_pos)
    gear_handle_click_ref:update()
    gear_state_share:set(nose_gear_status)
    set_aircraft_draw_argument_value(0, n_gear_status)
    set_aircraft_draw_argument_value(3, r_gear_status)
    set_aircraft_draw_argument_value(5, l_gear_status)
    c= c + update_time_step
    if c >1 then
        --print_message_to_user(n_gear_status)
        --print_message_to_user(gear_level_pos)
        c = 0
    end
end

need_to_be_closed = false
