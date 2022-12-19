--初始化加载要用lua文件
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."debug_util.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

--设置循环次数
local update_rate = 0.02 -- 20次每秒
make_default_activity(update_rate)

local ic_ctrl = GetSelf()

--初始化DCS读取API
local sensor_data = get_base_data()
local ias_conversion_to_kmh = 3.6

------Here Strat the general Switch Control

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local pullup = _switch_counter()

local display_target_status = {
    {pullup , SWITCH_OFF, get_param_handle("PULLUP_FLASH")},
}

local dis_play_current_status = {
    {pullup , SWITCH_OFF, SWITCH_OFF},
}
local snd_count = 0

local function _snd_count()
    snd_count = snd_count+1
    return snd_count
end

local pullup_snd = _snd_count()
local over_G_snd = _snd_count()
local gear_down_tip_snd = _snd_count()
local gear_up_tip_snd = _snd_count()
local fuel_1500 = _snd_count()
local fuel_800 = _snd_count()
local fuel_500 = _snd_count()

local snd_list = {}

function post_initialize()
    local sndhost = create_sound_host("COCKPIT_WARN", "HEADPHONES", 0, 0, 0)
    snd_list[pullup_snd] = { pullup_snd, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/PullUp") }
    snd_list[over_G_snd] = { over_G_snd, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/GOverLimit") }
    snd_list[gear_down_tip_snd] = { gear_down_tip_snd, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/GearDown") }
    snd_list[gear_up_tip_snd] = { gear_up_tip_snd, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/GearUp") }
    snd_list[fuel_1500] = { fuel_1500, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/Fuel1500") }
    snd_list[fuel_800] = { fuel_800, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/Fuel800") }
    snd_list[fuel_500] = { fuel_500, sndhost:create_sound("Aircrafts/J-8/Cockpit/Warning/Fuel500") }
end

ic_ctrl:listen_command()

function SetCommand(command, value)

end

local function update_display_status()
    for k,v in pairs(display_target_status) do
        dis_play_current_status[k][2] = v[2]
        v[3]:set(dis_play_current_status[k][2])
    end
end
local warning_system_debug = get_param_handle("WARNING_SYS_DEBUG")
local warning_system_debug2 = get_param_handle("WARNING_SYS_DEBUG2")
local pullTimeCounter = 0
local function calculate_pull_up()
    local vertices_velocity = sensor_data.getVerticalVelocity()
    local gear_up = sensor_data.getLeftMainLandingGearUp()
    if vertices_velocity < 0 and gear_up == 1 then
        local radAlt = sensor_data.getRadarAltitude()
        local touchdownTime = radAlt / math.abs( vertices_velocity )
        warning_system_debug:set(touchdownTime)
        warning_system_debug2:set(pullTimeCounter)
        if touchdownTime < 5 then
            pullTimeCounter = pullTimeCounter + update_rate
            if not snd_list[pullup_snd][2]:is_playing() then
                snd_list[pullup_snd][2]:play_continue()
            end
            if math.floor(pullTimeCounter*10 % 2) == 0 then
                display_target_status[pullup][2] = SWITCH_ON
            else
                display_target_status[pullup][2] = SWITCH_OFF
            end
        else
            pullTimeCounter = 0
            display_target_status[pullup][2] = SWITCH_OFF
            if snd_list[pullup_snd][2]:is_playing() then
                snd_list[pullup_snd][2]:stop()
            end
        end
    end
    
end
local function calculate_overG()
    local G = sensor_data.getVerticalAcceleration()
    if G > 7 then
        if not snd_list[over_G_snd][2]:is_playing() then
            snd_list[over_G_snd][2]:play_continue()
        end
    elseif G < 7 and snd_list[over_G_snd][2]:is_playing() then
        snd_list[over_G_snd][2]:stop()
    end
end
local gearUpTimeCounter = 0
local gearDnTimeCounter = 0
local function calculate_gear_tip()
    local gear_up = sensor_data.getLeftMainLandingGearUp()
    local ias = sensor_data.getIndicatedAirSpeed()*ias_conversion_to_kmh
    local radAlt = sensor_data.getRadarAltitude()
    if radAlt < 150 and gear_up == 1 and ias < 350 then
        gearDnTimeCounter = gearDnTimeCounter + update_rate
        if math.floor(gearDnTimeCounter%3) == 0 then
            snd_list[gear_down_tip_snd][2]:play_once()
        end
    elseif gear_up == 0 and snd_list[gear_down_tip_snd][2]:is_playing() then
        snd_list[gear_down_tip_snd][2]:stop()
        gearDnTimeCounter = 0
    end
    if radAlt > 300 and gear_up == 0 and ias > 500 then
        if snd_list[gear_down_tip_snd][2]:is_playing() then
            snd_list[gear_down_tip_snd][2]:stop()
        end
        gearUpTimeCounter = gearUpTimeCounter + update_rate
        if math.floor(gearUpTimeCounter%3) == 0 then
            snd_list[gear_up_tip_snd][2]:play_once()
        end
    elseif gear_up == 1 and snd_list[gear_up_tip_snd][2]:is_playing() then
        snd_list[gear_up_tip_snd][2]:stop()
        gearUpTimeCounter = 0
    end
end

local function calculate_fuel()
    local fuel_mass = sensor_data.getTotalFuelWeight()
    if fuel_mass < 1500 and not snd_list[fuel_1500][2]:is_playing() then
        snd_list[fuel_1500][2]:play_once()
    elseif fuel_mass < 800 and not snd_list[fuel_800][2]:is_playing() then
        snd_list[fuel_800][2]:play_once()
    elseif fuel_mass < 500 and not snd_list[fuel_500][2]:is_playing() then
        snd_list[fuel_500][2]:play_once()
    elseif fuel_mass > 500 and snd_list[fuel_500][2]:is_playing() then
        snd_list[fuel_500][2]:stop()
    elseif fuel_mass > 800 and snd_list[fuel_800][2]:is_playing() then
        snd_list[fuel_800][2]:stop()
    elseif fuel_mass > 1500 and snd_list[fuel_1500][2]:is_playing() then
        snd_list[fuel_1500][2]:stop()
    end
end

local function stopAllSnd()
    for k, v in pairs(snd_list) do
        if v[2]:is_playing() then
            v[2]:stop()
        end
    end
end

function update()
    update_display_status()
    if get_elec_dc_status() then
        calculate_pull_up()
        calculate_overG()
        calculate_gear_tip()
        calculate_fuel()
    else
        for key, value in pairs(display_target_status) do
            value[2]=SWITCH_OFF
        end
        pullTimeCounter = 0
        stopAllSnd()
    end
end

need_to_be_closed = false