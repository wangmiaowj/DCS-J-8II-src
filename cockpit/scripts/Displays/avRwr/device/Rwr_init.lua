dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
-- dofile(LockOn_Options.script_path .. "utils.lua")
dofile(LockOn_Options.script_path .. "Displays/avRwr/indicator/symbols.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")
local gettext = require("i_18n")
_ = gettext.translate

dofile [[Scripts\socket.lua]]
local gettime = socket.gettime

local firstRun = false

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local switch_count = 0
local function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end
local rwrPower = _switch_counter()
local rwrLoudness = _switch_counter()
local rwrBrt = _switch_counter()

local target_status ={
    {rwrPower,SWITCH_OFF,get_param_handle("PNT_1196"),"PNT_1196"},
    {rwrLoudness,SWITCH_OFF,get_param_handle("PNT_1312"),"PNT_1312"},
    {rwrBrt,SWITCH_OFF,get_param_handle("PNT_1311"),"PNT_1311"},
}

local current_status = {
	{rwrPower, SWITCH_OFF, SWITCH_OFF},
	{rwrLoudness, SWITCH_OFF, SWITCH_OFF},
	{rwrBrt, SWITCH_OFF, SWITCH_OFF},
}

local function update_switch_status()
    local switch_moving_step = 0.15
    for k,v in pairs(target_status) do
		if math.abs(target_status[k][2] - current_status[k][2]) < switch_moving_step then
			current_status[k][2] = target_status[k][2]
		elseif target_status[k][2] > current_status[k][2] then
			current_status[k][2] = current_status[k][2] + switch_moving_step
		elseif target_status[k][2] < current_status[k][2] then
			current_status[k][2] = current_status[k][2] - switch_moving_step
		end
        target_status[k][3]:set(current_status[k][2])
		if target_status[k][4] ~= nil then
			local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
			temp_switch_ref:update()
		end
        -- print_message_to_user(k)
    end
end

local rwrDisplay = get_param_handle("RWR_BRT")
local rwrOverlay = get_param_handle("RWR_Overlay")
local RWR_dubug_01 = get_param_handle("rwrSystem_symb")
-- rwr_brightness = get_param_handle(Nav_Radar_brightness_parameter)

update_time_step = 0.05
make_default_activity(update_time_step)
new_contact_time = 7.5
local rwrSystem = GetSelf()

electric_system = GetDevice(devices.ELECTRIC_SYSTEM)

MaxThreats = 20
EmitterLiveTime = 7.0
EmitterSoundTime = 0.5
LaunchSoundDelay = 15.0

DefaultType = 100

RWR_detection_coeff = 0.85
DEFAULT_TYPE_ = { DefaultType, DefaultType, DefaultType, DefaultType }

eyes = {} -- sensor locations
eyes[1] = {
    position = {
        x = 2.57,
        y = -0.7,
        z = 0.8
    }, -- {Forward/Back,U/D,L/R}
    orientation = {
        azimuth = math.rad(45),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(120)
}
eyes[2] = {
    position = {
        x = 2.57,
        y = -0.7,
        z = -0.8
    },
    orientation = {
        azimuth = math.rad(-45),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(120)
}
eyes[3] = {
    position = {
        x = -3,
        y = 0.5,
        z = 0.3
    },
    orientation = {
        azimuth = math.rad(135),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(120)
}
eyes[4] = {
    position = {
        x = -3,
        y = 0.5,
        z = -0.3
    },
    orientation = {
        azimuth = math.rad(-135),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(120)
}

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

rwr = {}
for ia = 1, 20 do
    if ia < 10 then
        i = "_0" .. ia .. "_"
    else
        i = "_" .. ia .. "_"
    end
    rwr[ia] = {
        elevation_h = get_param_handle("RWR_CONTACT" .. i .. "ELEVATION"),
        azimuth_h = get_param_handle("RWR_CONTACT" .. i .. "AZIMUTH"),
        power_h = get_param_handle("RWR_CONTACT" .. i .. "POWER"),
        unit_type_h = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE"),

        general_type_h = get_param_handle("RWR_CONTACT" .. i .. "GENERAL_TYPE"),
        priority_h = get_param_handle("RWR_CONTACT" .. i .. "PRIORITY"),
        signal_h = get_param_handle("RWR_CONTACT" .. i .. "SIGNAL"),
        time_h = get_param_handle("RWR_CONTACT" .. i .. "TIME"),
        source_h = get_param_handle("RWR_CONTACT" .. i .. "SOURCE"),

        unit_type_sym_h = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_SYM"),
        unit_type_sym_num = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_SYM_NUMERIC"),

        unit_type_is_num = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_IS_NUMERIC"),
        power_sym_h = get_param_handle("RWR_CONTACT" .. i .. "POWER_SYM"),
        color_sym_h = get_param_handle("RWR_CONTACT" .. i .. "COLOR"),
        first_seen = get_param_handle("RWR_CONTACT" .. i .. "FIRST_SEEN"),
        scan_sym = get_param_handle("RWR_CONTACT" .. i .. "SCAN_SYM"),
    }
    rwr[ia].first_seen:set(-1.0)
end


rwrSystem:listen_command(Keys.RwrOnOffSwitch)
rwrSystem:listen_command(Keys.ICS_UNDEF_KNOB_ROT)
rwrSystem:listen_command(Keys.RwrVolume)
rwrSystem:listen_command(Keys.RwrLightness)

function round(num, idp)
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function post_initialize()
    sndhost = create_sound_host("COCKPIT_RADAR_WARN", "HEADPHONES", 0, 0, 0)
    rwrLaunch = sndhost:create_sound("Aircrafts/Cockpits/RWR/Launch")--rwrLaunch = sndhost:create_sound("Cockpit/rwr_warn")
    rwrLock = sndhost:create_sound("Aircrafts/Cockpits/RWR/LockWarning")--rwrLock = sndhost:create_sound("Cockpit/rwr_lock")
    initRwr = sndhost:create_sound("Aircrafts/J-8/Cockpit/rwr/init")
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        firstRun = true
        target_status[rwrPower][2]=SWITCH_OFF
        target_status[rwrPower][2]=SWITCH_ON
        target_status[rwrLoudness][2] = 0.5
        target_status[rwrBrt][2]=SWITCH_ON
    elseif birth == "GROUND_COLD" then
        target_status[rwrPower][2]=SWITCH_OFF
        target_status[rwrBrt][2]=SWITCH_OFF
    end
end

function SetCommand(command, value)

    if command == Keys.RwrVolume then
        target_status[rwrLoudness][2]=math.min(1.0, math.max(-1.0, target_status[rwrLoudness][2] + value))
    elseif command == Keys.RwrOnOffSwitch then
        target_status[rwrPower][2]=1-target_status[rwrPower][2]
    elseif command == Keys.RwrLightness then
        if target_status[rwrBrt][2] >= 0 and target_status[rwrBrt][2] <= 1 then
			if target_status[rwrBrt][2] + value > 1 then
				target_status[rwrBrt][2] = 1
			elseif target_status[rwrBrt][2] + value < 0 then
				target_status[rwrBrt][2] = 0
			else
				target_status[rwrBrt][2] = target_status[rwrBrt][2] + value
			end
		end
    end
end
local function update_rwr_volume()
    local new_val = (target_status[rwrLoudness][2] + 1.0) / 2.0
    local volumeLock = math.pow((((round(new_val / 0.5, 2)) * 0.3)), 3)
    local volumeWarn = math.pow((((round(new_val / 0.5, 2)) * 0.4)), 3)
    rwrLock:update(nil, volumeLock, nil)
    rwrLaunch:update(nil, volumeWarn, nil)
end
local counter = 0

local rwrPwrSwitch = get_param_handle('PNT_1013')
function update()
    -- print_message_to_user(rwrOverlay:get())
    update_switch_status()
    if get_elec_ac_status() and target_status[rwrPower][2] > 0 and rwrPwrSwitch:get() == SWITCH_ON then
        update_rwr_volume()
        rwrDisplay:set(math.min(current_status[rwrBrt][2],current_status[rwrPower][2]))
    else
        rwrDisplay:set(0)
    end
    if counter > 1 then
        counter = 0
    else
        counter = counter + update_time_step
    end
    
    
    local tmp_type, tmp_signal, tmp_gen_type
    local lock = false
    local warn = false
    for i = 1, 20 do

        tmp_type = rwr[i].unit_type_h:get()

        tmp_gen_type = rwr[i].general_type_h:get()
        if tmp_type and tmp_type ~= "" then

            if tmp_type ~= 0 then
                if rwr[i].time_h:get() == -1 then
                    rwr[i].first_seen:set(-1)
                else
                    if rwr[i].first_seen:get() == -1 then
                        rwr[i].first_seen:set(gettime())
                    end
                end

                tmp_signal = rwr[i].signal_h:get()
                rwr[i].scan_sym:set(0.5)
                if tmp_signal == 2 then -- 2 Lock
                    lock = true
                    rwr[i].color_sym_h:set(1.0)
                elseif tmp_signal == 3 then -- 3 Launch
                    warn = true
                    lock = true
                    rwr[i].color_sym_h:set(2.0)
                else -- else 1 - Search
                    rwr[i].color_sym_h:set(3.0)
                end

                symb = symbols[tmp_type]
                if symb == nil then
                    symb = "UU"
                end
                if tonumber(symb) ~= nil then
                    rwr[i].unit_type_sym_num:set(symb)
                    if tmp_signal == 3 then
                        if math.floor(counter*10 % 2) == 0 then
                            rwr[i].unit_type_is_num:set(1.0)
                        else
                            rwr[i].unit_type_is_num:set(0)
                        end
                    else
                        rwr[i].unit_type_is_num:set(1.0)
                    end
                else
                    rwr[i].unit_type_sym_h:set(symb)
                    if tmp_signal == 3 then
                        if math.floor(counter*10 % 2) == 0 then
                            rwr[i].unit_type_is_num:set(0.5)
                        else
                            rwr[i].unit_type_is_num:set(0)
                        end
                    else
                        rwr[i].unit_type_is_num:set(0.5)
                    end
                end
            end
        end
        tmp = 1 - rwr[i].power_h:get() + 0.1
        rwr[i].power_sym_h:set(tmp)
    end

    if get_elec_ac_status() and current_status[rwrPower][2] == SWITCH_ON then
        if lock == false then
            if rwrLock:is_playing() then
                rwrLock:stop()
                rwrLock:update(nil, volumeLock, nil)
            end
        else

            if not rwrLock:is_playing() then
                rwrLock:play_continue()
                rwrLock:update(nil, volumeLock, nil)
            end
        end

        if warn == false then
            if rwrLaunch:is_playing() then
                rwrLaunch:stop()
            end
        else
            if not rwrLaunch:is_playing() then
                rwrLaunch:play_continue()
            end
        end
    else
        if rwrLock:is_playing() then
            rwrLock:stop()
        end
        if rwrLaunch:is_playing() then
            rwrLaunch:stop()
        end
    end
    rwrLock:update(nil, volumeLock, nil)
    rwrLaunch:update(nil, volumeWarn, nil)

    if get_elec_ac_status() and current_status[rwrPower][2] == SWITCH_ON then
        if not firstRun then
            initRwr:play_once()
            firstRun = true
        end
        rwrSystem:set_power(true)
    else
        rwrSystem:set_power(false)
    end

end