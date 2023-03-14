local LightSystem = GetSelf()
dofile(LockOn_Options.script_path .. "debug_util.lua")

--初始化加载要用lua文件
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "sounds_def.lua")
-- dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)

--设置循环次数
local update_rate = 0.01 -- 50次每秒
make_default_activity(update_rate)

--初始化DCS读取API
local sensor_data = get_base_data()

------Here Strat the general Switch Control

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local switch_count = 0
local function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local strobe_light_switch = _switch_counter()
local taxi_light_switch = _switch_counter()
local wing_navi_switch = _switch_counter()
local formation_switch = _switch_counter()
local flood_light_switch = _switch_counter()
local instrument_light_switch = _switch_counter()
local console_light_switch = _switch_counter()

local gear_state_share = get_param_handle("GEAR_SHARE")

local cpt_lighting = get_param_handle("CPT_LIGHTING")
local target_status = {
    { strobe_light_switch, SWITCH_OFF, get_param_handle("PNT_1112"), "PNT_1112" },
    { taxi_light_switch, 0.5, get_param_handle("PNT_1197"), "PNT_1197" },
    { wing_navi_switch, SWITCH_TEST, get_param_handle("PNT_1110"), "PNT_1110" },
    { formation_switch, SWITCH_OFF, get_param_handle("PTN_130"), "PTN_130" },
    { flood_light_switch, SWITCH_OFF, get_param_handle("PNT_1061"), "PNT_1061" },
    { instrument_light_switch, SWITCH_OFF, get_param_handle("PNT_1062"), "PNT_1062" },
    { console_light_switch, SWITCH_OFF, get_param_handle("PTN_131"), "PTN_131" },
}

local current_status = {
    { strobe_light_switch, SWITCH_OFF, SWITCH_OFF },
    { taxi_light_switch, SWITCH_OFF, SWITCH_OFF },
    { wing_navi_switch, SWITCH_TEST, SWITCH_TEST },
    { formation_switch, SWITCH_OFF, SWITCH_OFF },
    { flood_light_switch, SWITCH_OFF, SWITCH_OFF },
    { instrument_light_switch, SWITCH_OFF, SWITCH_OFF },
    { console_light_switch, SWITCH_OFF, SWITCH_OFF },
}

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    local current_time_in_second = get_absolute_model_time()
    local current_hour = current_time_in_second / 3600
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        target_status = {
            { strobe_light_switch, SWITCH_ON, get_param_handle("PNT_1112"), "PNT_1112" },
            { taxi_light_switch, 0.5, get_param_handle("PNT_1197"), "PNT_1197" },
            { wing_navi_switch, SWITCH_ON, get_param_handle("PNT_1110"), "PNT_1110" },
            { formation_switch, SWITCH_OFF, get_param_handle("PTN_130"), "PTN_130" },
            { flood_light_switch, SWITCH_OFF, get_param_handle("PNT_1061"), "PNT_1061" },
            { instrument_light_switch, SWITCH_ON, get_param_handle("PNT_1062"), "PNT_1062" },
            { console_light_switch, 0.3, get_param_handle("PTN_131"), "PTN_131" },
        }
        if !(current_hour > 8 and current_hour < 18) then
            target_status[flood_light_switch][2] = SWITCH_ON
            target_status[console_light_switch][2] = SWITCH_ON
        end
    end
end

LightSystem:listen_command(Keys.LightStrobeUP)
LightSystem:listen_command(Keys.LightStrobeDOWN)
LightSystem:listen_command(Keys.LightTaxiUP)
LightSystem:listen_command(Keys.LightTaxiDOWN)
LightSystem:listen_command(Keys.LightNaviWingUP)
LightSystem:listen_command(Keys.LightNaviWingDOWN)
LightSystem:listen_command(Keys.LightNaviTailUP)
LightSystem:listen_command(Keys.LightNaviTailDOWN)
LightSystem:listen_command(Keys.LightFormationUP)
LightSystem:listen_command(Keys.LightFormationDOWN)
LightSystem:listen_command(Keys.LightFlood)
LightSystem:listen_command(Keys.LightInstruBRT)
LightSystem:listen_command(Keys.LightConsoleBRT)
LightSystem:listen_command(Keys.LightApproIndexBRT)
LightSystem:listen_command(Keys.SpecialSence)
LightSystem:listen_command(Keys.PlaneHeadLightOnOff)
LightSystem:listen_command(Keys.Planelight)
LightSystem:listen_command(Keys.PlaneAntiCollisionLights)
LightSystem:listen_command(Keys.PlaneCockpitIllumination)

local special_display_status = 0;
local special_display_current = 0;

function SetCommand(command, value)
    local new_value
    if command == Keys.LightStrobeUP then
        if target_status[strobe_light_switch][2] < 0.5 then
            target_status[strobe_light_switch][2] = target_status[strobe_light_switch][2] + 1
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)
        end
    elseif command == Keys.LightStrobeDOWN then
        if target_status[strobe_light_switch][2] > -0.5 then
            target_status[strobe_light_switch][2] = target_status[strobe_light_switch][2] - 1
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)
        end
    elseif command == Keys.LightTaxiUP then
        -- print_message_to_user(target_status[taxi_light_switch][2])
        if target_status[taxi_light_switch][2] < 0.8 then
            target_status[taxi_light_switch][2] = target_status[taxi_light_switch][2] + 0.5
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)
        end
    elseif command == Keys.LightTaxiDOWN then
        if target_status[taxi_light_switch][2] > 0.3 then
            target_status[taxi_light_switch][2] = target_status[taxi_light_switch][2] - 0.5
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)
        end
        -- fit new
    elseif command == Keys.LightNaviWingUP then
        if target_status[wing_navi_switch][2] < 1 and target_status[wing_navi_switch][2] >= 0 then
            target_status[wing_navi_switch][2] = target_status[wing_navi_switch][2] + 0.5
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)
        end
    elseif command == Keys.LightNaviWingDOWN then
        if target_status[wing_navi_switch][2] > 0 then
            target_status[wing_navi_switch][2] = target_status[wing_navi_switch][2] - 0.5
            dispatch_action(devices.SOUND_SYSTEM, Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch)
        end

    elseif command == Keys.LightFormationUP then
        if target_status[formation_switch][2] < 0.5 then
            target_status[formation_switch][2] = target_status[formation_switch][2] + 1
        end
    elseif command == Keys.LightFormationDOWN then
        if target_status[formation_switch][2] > -0.5 then
            target_status[formation_switch][2] = target_status[formation_switch][2] - 1
        end
    elseif command == Keys.LightFlood then
		if target_status[flood_light_switch][2] >= 0 and target_status[flood_light_switch][2] <= 1 then
			if target_status[flood_light_switch][2] + value > 1 then
				target_status[flood_light_switch][2] = 1
			elseif target_status[flood_light_switch][2] + value < 0 then
				target_status[flood_light_switch][2] = 0
			else
				target_status[flood_light_switch][2] = target_status[flood_light_switch][2] + value
			end
		end
    elseif command == Keys.LightInstruBRT then
        if value < 0.5 then
            new_value = -0.1
        else
            new_value = 0.1
        end
        if target_status[instrument_light_switch][2] <= 1 and target_status[instrument_light_switch][2] >= 0 then
            --print_message_to_user(new_value)
            target_status[instrument_light_switch][2] = target_status[instrument_light_switch][2] + new_value
        elseif target_status[instrument_light_switch][2] < 0 then
            target_status[instrument_light_switch][2] = 0
        elseif target_status[instrument_light_switch][2] > 1 then
            target_status[instrument_light_switch][2] = 1
        end
        --print_message_to_user(value)
        --print_message_to_user(target_status[instrument_light_switch][2])
    elseif command == Keys.LightConsoleBRT then
        if value < 0.5 then
            new_value = -0.1
        else
            new_value = 0.1
        end
        if target_status[console_light_switch][2] <= 1 and target_status[console_light_switch][2] >= 0 then
            target_status[console_light_switch][2] = target_status[console_light_switch][2] + new_value
        elseif target_status[console_light_switch][2] < 0 then
            target_status[console_light_switch][2] = 0
        elseif target_status[console_light_switch][2] > 1 then
            target_status[console_light_switch][2] = 1
        end
        dprintf(value)
        dprintf(target_status[console_light_switch][2])
    elseif command == Keys.SpecialSence then
        --print_message_to_user("start")
        special_display_current = 0
        special_display_status = 1
    elseif command == Keys.PlaneHeadLightOnOff then
        --滑行灯 近/远/关
        if target_status[taxi_light_switch][2] + 1 > 1 then
            target_status[taxi_light_switch][2]=-1
        else
            target_status[taxi_light_switch][2]=target_status[taxi_light_switch][2] + 1
        end
    elseif command == Keys.PlaneLightsOnOff then
        --航行灯
        if target_status[wing_navi_switch][2] + 0.5 > 1 then
            target_status[wing_navi_switch][2] = 0
        else
            target_status[wing_navi_switch][2] = target_status[wing_navi_switch][2] + 0.5
        end
    elseif command == Keys.PlaneAntiCollisionLights then
        --防撞灯
        if target_status[strobe_light_switch][2] + 1 > 1 then
            target_status[strobe_light_switch][2] = -1
        else
            target_status[strobe_light_switch][2] = target_status[strobe_light_switch][2] + 1
        end
    elseif command == Keys.PlaneCockpitIllumination then
        --座舱灯光
        target_status[flood_light_switch][2] =1- target_status[flood_light_switch][2]
    end 
end

NAV_FLASH_COUNT = 0
STROBE_ROTATION = 0

local taxi_light_base_pos = 0
function update_taxi_light_base()
    if current_status[taxi_light_switch][2] == 0.5 and taxi_light_base_pos > 0 then
        taxi_light_base_pos = taxi_light_base_pos - 0.01
    elseif (current_status[taxi_light_switch][2] == 0 or current_status[taxi_light_switch][2] == 1) and
        taxi_light_base_pos < 1 then
        taxi_light_base_pos = taxi_light_base_pos + 0.01
    end
end
function update_externel_light_status()
    if get_elec_ac_status() == true or get_elec_dc_status() then
        cpt_lighting:set(target_status[flood_light_switch][2])
        if get_elec_ac_status() then
            set_aircraft_draw_argument_value(208, taxi_light_base_pos)
            --防撞灯
            if math.abs(current_status[strobe_light_switch][2]) > 0.5 then
                STROBE_ROTATION = STROBE_ROTATION + 0.004
                if (STROBE_ROTATION > 0.5) then
                    STROBE_ROTATION = STROBE_ROTATION - 0.5
                end
                set_aircraft_draw_argument_value(194, STROBE_ROTATION)
            else
                set_aircraft_draw_argument_value(194, 0)
            end

            -- 导航灯
            if target_status[wing_navi_switch][2] > 0.25 and target_status[wing_navi_switch][2] < 0.75 then
                NAV_FLASH_COUNT = NAV_FLASH_COUNT + 0.02
                if NAV_FLASH_COUNT > 2 then
                    NAV_FLASH_COUNT = 0
                end
                if NAV_FLASH_COUNT <= 1 then
                    set_aircraft_draw_argument_value(190, NAV_FLASH_COUNT)
                    set_aircraft_draw_argument_value(191, NAV_FLASH_COUNT)
                else
                    set_aircraft_draw_argument_value(190, 2 - NAV_FLASH_COUNT)
                    set_aircraft_draw_argument_value(191, 2 - NAV_FLASH_COUNT)
                end
            elseif target_status[wing_navi_switch][2] < -0.25 then
                NAV_FLASH_COUNT = 0
                set_aircraft_draw_argument_value(190, 0)
                set_aircraft_draw_argument_value(191, 0)
            elseif target_status[wing_navi_switch][2] > -0.25 and target_status[wing_navi_switch][2] < 0.25 then
                NAV_FLASH_COUNT = 0
                set_aircraft_draw_argument_value(190, 0.5)
                set_aircraft_draw_argument_value(191, 0.5)
            elseif target_status[wing_navi_switch][2] > 0.75 then
                NAV_FLASH_COUNT = 0
                set_aircraft_draw_argument_value(190, 1)
                set_aircraft_draw_argument_value(191, 1)
            end

            -- taxi/landing lights
            update_taxi_light_base()
            if get_aircraft_draw_argument_value(0) > 0.8 then
                -- when gear is out
                if taxi_light_base_pos >= 0.95 then
                    if target_status[taxi_light_switch][2] == 0 or target_status[taxi_light_switch][2] == 1 then
                        if target_status[taxi_light_switch][2] == 0 then
                            set_aircraft_draw_argument_value(209, 0.5)
                        elseif target_status[taxi_light_switch][2] == 1 then
                            set_aircraft_draw_argument_value(209, 1)
                        end
                    else
                        set_aircraft_draw_argument_value(209, 0)
                        set_aircraft_draw_argument_value(210, 0)
                    end 
                end
            else
                -- cloase taxi/landing light
                set_aircraft_draw_argument_value(209, 0)
            end
            --flood_light_switch
        end
    else
        set_aircraft_draw_argument_value(208, 0) -- taxi light 51
        set_aircraft_draw_argument_value(209, 0) -- taxi light 51
        set_aircraft_draw_argument_value(190, 0)
        set_aircraft_draw_argument_value(191, 0)
        set_aircraft_draw_argument_value(192, 0)
        set_aircraft_draw_argument_value(193, 0)
        set_aircraft_draw_argument_value(194, 0)
    end
end

function update_switch_status()
    local switch_moving_step = 0.15
    for k, v in pairs(target_status) do
        if math.abs(target_status[k][2] - current_status[k][2]) < switch_moving_step then
            current_status[k][2] = target_status[k][2]
        elseif target_status[k][2] > current_status[k][2] then
            current_status[k][2] = current_status[k][2] + switch_moving_step
        elseif target_status[k][2] < current_status[k][2] then
            current_status[k][2] = current_status[k][2] - switch_moving_step
        end
        target_status[k][3]:set(current_status[k][2])
        local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
        if temp_switch_ref ~= nil then
            temp_switch_ref:update()
        end
    end
end

function updateSpecialAnimation()
    if special_display_status == 1 then
        if special_display_current < 1 then
            special_display_current = special_display_current + update_rate / 4
        else
            special_display_current = 0
            special_display_status = 0
        end
        set_aircraft_draw_argument_value(999, special_display_current)
        --print_message_to_user(special_display_current)
    end
end

function update()
    update_switch_status()
    update_externel_light_status()
    updateSpecialAnimation()
end

need_to_be_closed = false
