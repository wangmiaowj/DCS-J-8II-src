dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local gettext = require("i_18n")
_ = gettext.translate

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE
use_pointer_name			   = true

cursor_mode = 
{
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA = 1,
    CUMODE_CAMERA = 2
}

clickable_mode_initial_status = cursor_mode.CUMODE_CLICKABLE
use_pointer_name = true
anim_speed_default = 16

function default_button(hint_, device_, command_, command2_,arg_, sound_, arg_val_, arg_lim_)
    local arg_val_ = arg_val_ or 1
    local arg_lim_ = arg_lim_ or {0, 1}

    return {
        class = {class_type.BTN},
        hint = hint_,
        device = device_,
        action = {command_},
        stop_action = {command2_},
        arg = {arg_},
        arg_value = {arg_val_},
        arg_lim = {arg_lim_},
        use_release_message = {true},
        sound = sound_ and {{sound_}, {sound_}} or nil
    }
end

-- not in use
function default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_)
    local arg_val_ = arg_val_ or 1
    local arg_lim_ = arg_lim_ or {0, 1}
    return {
        class = {class_type.TUMB},
        hint = hint_,
        device = device_,
        action = {command_},
        arg = {arg_},
        arg_value = {arg_val_},
        arg_lim = {arg_lim_},
        updatable = true,
        use_OBB = true
    }
end

function default_2_position_tumb(hint_, device_, command_, arg_, sound_, animation_speed_)
    local animation_speed_ = animation_speed_ or anim_speed_default
    return {
        class           = {class_type.TUMB, class_type.TUMB},
        hint            = hint_,
        device          = device_,
        action          = {command_, command_},
        arg             = {arg_, arg_},
        arg_value       = {1, -1},
        arg_lim         = {{0, 1}, {0, 1}},
        updatable       = true,
        use_OBB         = true,
        animated        = {true, true},
        animation_speed = {animation_speed_, animation_speed_},
        sound           = sound_ and {{sound_, sound_}} or nil
    }
end

function default_multi_position_tumb(hint_, device_, command1_, command2_, arg_, sound_, animation_speed_)
    local animation_speed_ = animation_speed_ or anim_speed_default
    return {
        class           = {class_type.TUMB, class_type.TUMB},
        hint            = hint_,
        device          = device_,
        action          = {command1_, command2_},
        arg             = {arg_, arg_},
        arg_value       = {1, -1},
        arg_lim         = {{0, 1}, {0, 1}},
        updatable       = true,
        use_OBB         = true,
        animated        = {true, true},
        animation_speed = {animation_speed_, animation_speed_},
        sound           = sound_ and {{sound_, sound_}} or nil
    }
end

function default_3_position_tumb(hint_, device_, command_, arg_, cycled_, inversed_, sound_, animation_speed_)
    local animation_speed_ = animation_speed_ or anim_speed_default
    local cycled = false

    local val = 1
    if inversed_ then
        val = -1
    end

    if cycled_ ~= nil then
        cycled = cycled_
    end

    return {
        class           = {class_type.TUMB, class_type.TUMB},
        hint            = hint_,
        device          = device_,
        action          = {command_, command_},
        arg             = {arg_, arg_},
        arg_value       = {val, -val},
        arg_lim         = {{-1, 1}, {-1, 1}},
        updatable       = true,
        use_OBB         = true,
        cycle           = cycled,
        animated        = {true, true},
        animation_speed = {animation_speed_, animation_speed_},
        sound           = sound_ and {{sound_, sound_}} or nil
    }
end

function springloaded_3_pos_tumb(hint_, device_, command_, command2_, command3_, command4_, arg_, inversed_, sound_, animation_speed_)
    local animation_speed_ = animation_speed_ or anim_speed_default
    local val = 1
    if inversed_ then
        val = -1
    end

    return {
        class               = {class_type.BTN, class_type.BTN},
        hint                = hint_,
        device              = device_,
        action              = {command_, command3_},
        stop_action         = {command2_, command4_},
        arg                 = {arg_, arg_},
        arg_value           = {val, -val},
        arg_lim             = {{-1, 1}, {-1, 1}},
        updatable           = true,
        use_OBB             = true,
        use_release_message = true,
        animated            = {true, true},
        animation_speed     = {animation_speed_, animation_speed_},
        sound               = sound_ and {{sound_, sound_}} or nil
    }
end

-- rotary axis with no end stops. suitable for continuously rotating knobs
function default_axis(hint_, device_, command_, arg_, default_, gain_, updatable_, relative_)
    local default = default_ or 1
    local gain = gain_ or 0.1
    local updatable = updatable_ or false
    local relative = relative_ or false

    return {
        class       = {class_type.LEV},
        hint        = hint_,
        device      = device_,
        action      = {command_},
        arg         = {arg_},
        arg_value   = {default},
        arg_lim     = {{0, 1}},
        updatable   = updatable,
        use_OBB     = true,
        gain        = {gain},
        relative    = {relative}
    }
end

function default_axis_limited(hint_, device_, command_, arg_, default_, gain_, updatable_, relative_, arg_lim_)
    local default = default_ or 0
    local updatable = updatable_ or false
    local relative = relative_ or false

    local gain = gain_ or 0.1
    return {
        class       = {class_type.LEV},
        hint        = hint_,
        device      = device_,
        action      = {command_},
        arg         = {arg_},
        arg_value   = {default},
        arg_lim     = {arg_lim_},
        updatable   = updatable,
        use_OBB     = false,
        gain        = {gain},
        relative    = {relative},
        cycle       = false
    }
end

function default_movable_axis(hint_, device_, command_, arg_, default_, gain_, updatable_, relative_)
    local default = default_ or 1
    local gain = gain_ or 0.1
    local updatable = updatable_ or false
    local relative = relative_ or false

    return {
        class = {class_type.MOVABLE_LEV},
        hint = hint_,
        device = device_,
        action = {command_},
        arg = {arg_},
        arg_value = {default},
        arg_lim = {{0, 1}},
        updatable = updatable,
        use_OBB = true,
        gain = {gain},
        relative = {relative}
    }
end

-- not in use. this multiple position switch is cyclable.
function multiposition_switch(hint_, device_, command_, arg_, count_, delta_, inversed_, min_, sound_, animation_speed_)
    local animation_speed_ = animation_speed_ or anim_speed_default

    local min_ = min_ or 0
    local delta_ = delta_ or 0.5

    local inversed = 1
    if inversed_ then
        inversed = -1
    end

    return {
        class           = {class_type.TUMB, class_type.TUMB},
        hint            = hint_,
        device          = device_,
        action          = {command_, command_},
        arg             = {arg_, arg_},
        arg_value       = {-delta_ * inversed, delta_ * inversed},
        arg_lim         = {
                            {min_, min_ + delta_ * (count_ - 1)},
                            {min_, min_ + delta_ * (count_ - 1)}
                        },
        updatable       = true,
        use_OBB         = true,
        animated        = {true, true},
        animation_speed = {animation_speed_, animation_speed_},
        sound           = sound_ and {{sound_, sound_}} or nil
    }
end

function multiposition_switch_limited(hint_, device_, command_, arg_, count_, delta_, inversed_, min_, sound_, animation_speed_)
    local animation_speed_ = animation_speed_ or anim_speed_default

    local min_ = min_ or 0
    local delta_ = delta_ or 0.5

    local inversed = 1
    if inversed_ then
        inversed = -1
    end

    return {
        class           = {class_type.TUMB, class_type.TUMB},
        hint            = hint_,
        device          = device_,
        action          = {command_, command_},
        arg             = {arg_, arg_},
        arg_value       = {-delta_ * inversed, delta_ * inversed},
        arg_lim         = {
                            {min_, min_ + delta_ * (count_ - 1)},
                            {min_, min_ + delta_ * (count_ - 1)}
                        },
        updatable       = true,
        use_OBB         = true,
        cycle           = false,
        animated        = {true, true},
        animation_speed = {animation_speed_, animation_speed_},
        sound           = sound_ and {{sound_, sound_}} or nil
    }
end

-- rotary axis with push button
function default_button_axis(hint_, device_, command_1, command_2, arg_1, arg_2, limit_1, limit_2)
    local limit_1_ = limit_1 or 1.0
    local limit_2_ = limit_2 or 1.0
    return {
        class               = {class_type.BTN, class_type.LEV},
        hint                = hint_,
        device              = device_,
        action              = {command_1, command_2},
        stop_action         = {command_1, 0},
        arg                 = {arg_1, arg_2},
        arg_value           = {1, 0.5},
        arg_lim             = {{0, limit_1_}, {0, limit_2_}},
        animated            = {false, true},
        animation_speed     = {0, 0.4},
        gain                = {1.0, 0.1},
        relative            = {false, false},
        updatable           = true,
        use_OBB             = true,
        use_release_message = {true, false}
    }
end

-- NOT IN USE
function default_animated_lever(hint_, device_, command_, arg_, animation_speed_, arg_lim_)
    local animation_speed_ = animation_speed_ or anim_speed_default
    local arg_lim__ = arg_lim_ or {0.0, 1.0}
    return {
        class           = {class_type.TUMB, class_type.TUMB},
        hint            = hint_,
        device          = device_,
        action          = {command_, command_},
        arg             = {arg_, arg_},
        arg_value       = {1, 0},
        arg_lim         = {arg_lim__, arg_lim__},
        updatable       = true,
        gain            = {0.1, 0.1},
        animated        = {true, true},
        animation_speed = {animation_speed_, 0},
        cycle           = true
    }
end

function default_button_tumb(hint_, device_, command1_, command2_, arg_)
    return {
        class               = {class_type.BTN, class_type.TUMB},
        hint                = hint_,
        device              = device_,
        action              = {command1_, command2_},
        stop_action         = {command2_, command1_},
        arg                 = {arg_, arg_},
        arg_value           = {-1, 1},
        arg_lim             = {{-1, 0}, {0, 1}},
        updatable           = true,
        use_OBB             = true,
        use_release_message = {true, false}
    }
end

function default_button_2(hint_, device_, command1_, command2_, arg_)
    return {
        class               = {class_type.BTN, class_type.BTN},
        hint                = hint_,
        device              = device_,
        action              = {command1_, command2_},
        stop_action         = {command2_, command1_},
        arg                 = {arg_, arg_},
        arg_value           = {-1, 1},
        arg_lim             = {{-1, 0}, {0, 1}},
        updatable           = true,
        use_OBB             = true,
        use_release_message = {true, true}
    }
end

elements = {}

--SWITCHOFF elements["POINTER"] = default_2_position_tumb(LOCALIZE("Test Command"),devices.TEST, device_commands.Button_1,444) -- 44 arg number


--elements["PNT_003"] = default_2_position_tumb("Landing Gear Handle", devices.GEAR_SYSTEM, click_cmd.GearLevel, 3)
elements["PNT_083"] = default_2_position_tumb(_("Landing Gear Handle"), devices.GEAR_SYSTEM, click_cmd.GearLevel, 83, 4)

-- Power Systems
-- elements["PNT_107"] = default_2_position_tumb("Battry Swith", devices.ELECTRIC_SYSTEM, Keys.BatteryPower, 107)
-- elements["PNT_108"] = default_multi_position_tumb("Left Generator Switch", devices.ELECTRIC_SYSTEM, Keys.PowerGeneratorLeftUP, Keys.PowerGeneratorLeftDOWN, -1)
-- elements["PNT_111"] = default_multi_position_tumb("Right Generator Switch", devices.ELECTRIC_SYSTEM, Keys.PowerGeneratorRightUP, Keys.PowerGeneratorRightDOWN, -1)


-- Engine system
elements["PNT_109"] = default_multi_position_tumb("Left Speed Drive Switch",  devices.ENGINE, Keys.LeftSpeedDriveUP, Keys.LeftSpeedDriveDOWN, 109)
elements["PNT_110"] = default_multi_position_tumb("Right Speed Drive Switch",  devices.ENGINE, Keys.RightSpeedDriveUP, Keys.RightSpeedDriveDOWN, 110)

elements["PNT_112"] = default_2_position_tumb("Left Fuel Master",  devices.ENGINE, Keys.FuelMasterLeft, 112)
elements["PNT_113"] = default_2_position_tumb("Right Fuel Master", devices.ENGINE, Keys.FuelMasterRight, 113)

elements["PNT_114"] = default_2_position_tumb("NWW Switch", devices.ENGINE, Keys.NWWSwitch, 114)
elements["PNT_115"] = default_2_position_tumb("CSD/S Switch", devices.ENGINE, Keys.CSDSwitch, 115)
elements["PNT_116"] = default_2_position_tumb("AirCondition Switch", devices.ENGINE, Keys.AirCondSwitch, 116)
elements["PNT_117"] = default_2_position_tumb("Bleed System Cover", devices.ENGINE, Keys.BleedHoldCover, 117)

elements["PNT_150"] = default_button("Left Engine Crank",  devices.ENGINE, Keys.LeftEngineCrank, Keys.LeftEngineCrankUP, 150)
elements["PNT_151"] = default_button("Right Engine Crank", devices.ENGINE, Keys.RightEngineCrank, Keys.RightEngineCrankUP, 151)

elements["PNT_LTHRO"] = default_2_position_tumb("Left ENGINE IDLE",  devices.ENGINE, Keys.LeftEngineIDLEPOS, 41)
elements["PNT_RTHRO"] = default_2_position_tumb("Right Engine IDLE",  devices.ENGINE, Keys.RightEngineIDLEPOS, 42)

-- 
elements["PNT_279"] = default_multi_position_tumb("Flap handle", devices.FLAP_SYSTEM, Keys.FlapUp, Keys.FlapDown, 43, 5.0)

elements["PARKING_BREAK"] = default_2_position_tumb("Parking Break", devices.BREAK_SYSTEM, Keys.ParkingBrakes, 50)

elements["PNT_118"] = default_button("Boost Pump Test", devices.FUEL_SYSTEM, Keys.BoostPumpTestUP, Keys.BoostPumpTestDOWN, 118)

elements["PNT_405"] = default_button("Left Engine Motor Starter", devices.HUD_DCMS, Keys.L_STARTER_PRESS, Keys.L_STARTER_RELEASE, 405, SOUND_DEFAULT_2_WAY_SWITCH )
elements["PNT_407"] = default_button("Right Engine Motor Starter", devices.HUD_DCMS, Keys.R_STARTER_PRESS, Keys.R_STARTER_RELEASE, 407, SOUND_DEFAULT_2_WAY_SWITCH )

elements["PNT_557"] = default_button("UHF Radio TAKE Press", devices.UHF_RADIO, Keys.UHF_TAKE_Button_Press, Keys.UHF_TAKE_Button_Release, 557)

multi_tumb_click_list = {
    -- Engine Control
    {"PNT_418", "Left Low Pressure Fuel Pump", devices.HUD_DCMS, 418, SOUND_DEFAULT_2_WAY_SWITCH , Keys.L_LP_PUMP},
    {"PNT_420", "Right Low Pressure Fuel Pump", devices.HUD_DCMS, 420, SOUND_DEFAULT_2_WAY_SWITCH , Keys.R_LP_PUMP},
    {"PNT_406", "Left Main Fuel Pump", devices.HUD_DCMS, 406, SOUND_DEFAULT_2_WAY_SWITCH , Keys.L_HP_PUMP},
    {"PNT_408", "Right Main Fuel Pump", devices.HUD_DCMS, 408, SOUND_DEFAULT_2_WAY_SWITCH , Keys.R_HP_PUMP},
    {"PNT_604", "Left Throttle Idle", devices.HUD_DCMS, 604, nil, Keys.L_THROTTLE_IDLE},
    {"PNT_605", "Right Throttle Idle", devices.HUD_DCMS, 605, nil, Keys.R_THROTTLE_IDLE},

    {"PNT_1197", "Taxi/Landing Light", devices.LIGHT_SYSTEM, 1197, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LightTaxiUP, Keys.LightTaxiDOWN},
    {"PNT_1112", "Anti-Collision Light", devices.LIGHT_SYSTEM, 1112, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LightStrobeUP, Keys.LightStrobeDOWN},
    {"PNT_1110", "Navigation Light", devices.LIGHT_SYSTEM, 1110, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LightNaviWingUP,Keys.LightNaviWingDOWN},
    
    {"PNT_125", "Taxi/Probe Light", devices.LIGHT_SYSTEM, 125, nil, Keys.LightTaxi},
    {"PNT_1111", "Tail Navigation Light", devices.LIGHT_SYSTEM, 1111, nil, Keys.LightNaviTailUP, Keys.LightNaviTailDOWN},
    {"PNT_130", "Formation Light", devices.LIGHT_SYSTEM, 130, nil, Keys.LightFormationUP, Keys.LightFormationDOWN},
    --{"PNT_1061", "Flood Light", devices.LIGHT_SYSTEM, 1061, nil, Keys.LightFloodUP, Keys.LightFloodDOWN},

    -- Electric Power Switches
    {"PNT_1001", "Main Power Switch", devices.ELECTRIC_SYSTEM, 1001, SOUND_DEFAULT_2_WAY_SWITCH , Keys.BatteryPower},
    {"PNT_1002", "Left PowerGenerator Switch", devices.ELECTRIC_SYSTEM, 1002, SOUND_DEFAULT_2_WAY_SWITCH , Keys.ElecPowerDCGenL},
	{"PNT_1003", "Right PowerGenerator Switch", devices.ELECTRIC_SYSTEM, 1003, SOUND_DEFAULT_2_WAY_SWITCH , Keys.ElecPowerDCGenR},
	{"PNT_1004", "Left Inverter Switch", devices.ELECTRIC_SYSTEM, 1004, SOUND_DEFAULT_2_WAY_SWITCH , Keys.InverterLeft},
	{"PNT_1005", "Right Inverter Switch", devices.ELECTRIC_SYSTEM, 1005, SOUND_DEFAULT_2_WAY_SWITCH , Keys.InverterRight},
	{"PNT_1006", "ADI Power Switch", devices.ELECTRIC_SYSTEM, 1006, SOUND_DEFAULT_2_WAY_SWITCH , Keys.ADIPwr},
	{"PNT_1007", "HSI Power Switch", devices.ELECTRIC_SYSTEM, 1007, SOUND_DEFAULT_2_WAY_SWITCH , Keys.HSIPwr},
	{"PNT_1008", "Radio Altitude Power Switch", devices.ELECTRIC_SYSTEM, 1008, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RadioAltPwr},
	{"PNT_1009", "Oil Pressure Gauge Power Switch", devices.ELECTRIC_SYSTEM, 1009, SOUND_DEFAULT_2_WAY_SWITCH , Keys.OilPressIndPwr},
	{"PNT_1010", "Emergency Converter Switch", devices.ELECTRIC_SYSTEM, 1010, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EmergConverter},
	{"PNT_1011", "Weapon Power Switch", devices.ELECTRIC_SYSTEM, 1011, SOUND_DEFAULT_2_WAY_SWITCH , Keys.WeaponPwr},
	{"PNT_1012", "HUD Power Switch", devices.ELECTRIC_SYSTEM, 1012, SOUND_DEFAULT_2_WAY_SWITCH , Keys.HUDPwr},
	{"PNT_1013", "RWR Power Switch", devices.ELECTRIC_SYSTEM, 1013, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RWRPwr},
	{"PNT_1014", "Eject Power 1", devices.ELECTRIC_SYSTEM, 1014, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EjectPwr1},
	{"PNT_1015", "Eject Power 2", devices.ELECTRIC_SYSTEM, 1015, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EjectPwr2},
	{"PNT_1016", "Eject Power 3", devices.ELECTRIC_SYSTEM, 1016, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EjectPwr3},
	{"PNT_1017", "Unknown Switch 1", devices.ELECTRIC_SYSTEM, 1017, SOUND_DEFAULT_2_WAY_SWITCH , Keys.UnknownSwitch1},
	{"PNT_1018", "Unknown Switch 2", devices.ELECTRIC_SYSTEM, 1018, SOUND_DEFAULT_2_WAY_SWITCH , Keys.UnknownSwitch2},
	{"PNT_1019", "Camera Gun Power Switch", devices.ELECTRIC_SYSTEM, 1019, SOUND_DEFAULT_2_WAY_SWITCH , Keys.CameraGunPwrSwitch},
	{"PNT_1020", "Missile Warming Switch", devices.ELECTRIC_SYSTEM, 1020, SOUND_DEFAULT_2_WAY_SWITCH , Keys.MissileWarmingSwitch},
	{"PNT_1021", "Missile Filament Switch", devices.ELECTRIC_SYSTEM, 1021, SOUND_DEFAULT_2_WAY_SWITCH , Keys.MissileFilamentSwitch},
	{"PNT_1022", "Missile Launch Switch", devices.ELECTRIC_SYSTEM, 1022, SOUND_DEFAULT_2_WAY_SWITCH , Keys.MissileLaunchSwitch},
	
	-- Left Wall Panel 01
    {"PNT_1141", "Drop Tanks Ind Switch", devices.ENGINE, 1141, SOUND_DEFAULT_2_WAY_SWITCH , Keys.DropTankInd},
	{"PNT_1142", "Windshield Anti Ice Switch", devices.ENGINE, 1142, SOUND_DEFAULT_2_WAY_SWITCH , Keys.windshieldAntiIce},
	{"PNT_1143", "Pump 4 Switch", devices.ENGINE, 1143, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pump4},
	{"PNT_1144", "Pump 3 Switch", devices.ENGINE, 1144, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pump3},
	--{"PNT_1145", "", devices.ENGINE, 1145, SOUND_DEFAULT_2_WAY_SWITCH , Keys.groupSwitch01},
	{"PNT_1146", "Motor Starter", devices.ENGINE, 1146, SOUND_DEFAULT_2_WAY_SWITCH , Keys.Starter},
	{"PNT_1147", "Oil Pump Switch", devices.ENGINE, 1147, SOUND_DEFAULT_2_WAY_SWITCH , Keys.oilPump},
	{"PNT_1148", "Start Unit", devices.ENGINE, 1148, SOUND_DEFAULT_2_WAY_SWITCH , Keys.startUnit},
	{"PNT_1149", "Generator Oil Pressure", devices.ENGINE, 1149, SOUND_DEFAULT_2_WAY_SWITCH , Keys.genOilPress},
	{"PNT_1150", "After Burn Switch", devices.ENGINE, 1150, SOUND_DEFAULT_2_WAY_SWITCH , Keys.afterBurn},
	{"PNT_1151", "", devices.ENGINE, 1151, SOUND_DEFAULT_2_WAY_SWITCH , Keys.groupSwitch02},
	{"R_ENG_IDLE", "Right Engine Start/Stop", devices.ENGINE, 102, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RightEngineStart, Keys.RightEngineStop},
	{"L_ENG_IDLE", "Left Engine Start/Stop", devices.ENGINE, 103, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LeftEngineStart, Keys.LeftEngineStop},

    
    {"PNT_414", "A/G mode", devices.WEAPON_SYSTEM, 414, SOUND_DEFAULT_2_WAY_SWITCH , Keys.WeaponAirGroundChange},

	--火控台
	
	{"PNT_1202", "Flight Mode", nil, 1202, SOUND_DEFAULT_2_WAY_SWITCH, Keys.HK_L_Up,Keys.HK_L_Down},
	{"PNT_1203", "Master Arm", devices.WEAPON_SYSTEM, 1203, SOUND_DEFAULT_2_WAY_SWITCH , Keys.WeaponMasterSwitch},
	{"PNT_1204", "Weapon Type", devices.WEAPON_SYSTEM, 1204, SOUND_DEFAULT_2_WAY_SWITCH, Keys.HK_R_Up,Keys.HK_R_Down},
	{"PNT_1261", "Pylon 1 Select", devices.WEAPON_SYSTEM, 1261, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon1SelUP,Keys.Pylon1SelDOWN},
	{"PNT_1262", "Pylon 2 Select", devices.WEAPON_SYSTEM, 1262, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon2SelUP,Keys.Pylon2SelDOWN},
	{"PNT_1263", "Pylon 3 Select", devices.WEAPON_SYSTEM, 1263, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon3SelUP,Keys.Pylon3SelDOWN},
	{"PNT_1264", "Pylon 4 Select", devices.WEAPON_SYSTEM, 1264, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon4SelUP,Keys.Pylon4SelDOWN},
	{"PNT_1265", "Pylon 5 Select", devices.WEAPON_SYSTEM, 1265, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon5SelUP,Keys.Pylon5SelDOWN},
	
    --RWR
	{"PNT_1196", "RWR Power", devices.RWR, 1311, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RwrOnOffSwitch},
    
    -- RADAR Panel
	{"PNT_1215", "Radar OFF/STBY/ON", devices.RADAR_RAW, 1215, SOUND_DEFAULT_2_WAY_SWITCH, Keys.RadarModeUp,Keys.RadarModeDown},
    {"PNT_1216", "Radar Max Range", devices.RADAR_RAW, 1216, SOUND_DEFAULT_2_WAY_SWITCH, Keys.RadarMaxRange},

    -- GNS430
    {"PNT_513", "VLOC/COM Focus Change", devices.HUD_DCMS, 513, nil, Keys.Freq_Knob_Push},
    {"PNT_514", "COM frequency Flip-flop", devices.HUD_DCMS, 514, nil, Keys.COM_Freq_Swap},
    {"PNT_515", "VLOC frequency Flip-flop", devices.HUD_DCMS, 515, nil, Keys.VLOC_Freq_Swap},
    {"PNT_516", "Change CDI", devices.HUD_DCMS, 516, nil, Keys.Nav_CDI},
    {"PNT_517", "OBS", devices.HUD_DCMS, 517, nil, Keys.Nav_OBS},
    {"PNT_518", "Message", devices.HUD_DCMS, 518, nil, Keys.Nav_MSG},
    {"PNT_519", "Flight Plan", devices.HUD_DCMS, 519, nil, Keys.Nav_FPL},
    {"PNT_520", "Process", devices.HUD_DCMS, 520, nil, Keys.Nav_PROC},
    {"PNT_521", "Range decrease", devices.HUD_DCMS, 521, nil, Keys.Nav_Map_range_decrease},
    {"PNT_522", "Range increase", devices.HUD_DCMS, 522, nil, Keys.Nav_Map_range_increse},
    {"PNT_523", "Direct To", devices.HUD_DCMS, 523, nil, Keys.Nav_Direct_to},
    {"PNT_524", "Menu", devices.HUD_DCMS, 524, nil, Keys.Nav_Menu},
    {"PNT_525", "Clear", devices.HUD_DCMS, 525, nil, Keys.Nav_Clear},
    {"PNT_526", "Enter", devices.HUD_DCMS, 526, nil, Keys.Nav_Ent},
    {"PNT_529", "Select Input", devices.HUD_DCMS, 529, nil, Keys.Nav_Right_Knob_Push},

    -- R&S GB6500
    -- {"PNT_554", "UHF Volume Change", devices.UHF_RADIO, 554, Keys.UHF_Vol_Up, Keys.UHF_Vol_Down},
    {"PNT_1046", "UHF SQL ON/OFF, Acknology", devices.UHF_RADIO, 1046, SOUND_DEFAULT_2_WAY_SWITCH , Keys.UHF_Vol_Up, Keys.UHF_Vol_Down},
    {"PNT_1049", "UHF Mode Selection", devices.UHF_RADIO, 1049, nil, Keys.UHF_Mode_Left, Keys.UHF_Mode_Right},
    -- keyboard
    {"PNT_1032", "UHF Key 1 (TONE)", devices.UHF_RADIO, 1032, nil, Keys.UHF_Key_1},
    {"PNT_1033", "UHF Key 2 (-)", devices.UHF_RADIO, 1033, nil, Keys.UHF_Key_2},
    {"PNT_1034", "UHF Key 3 (+)", devices.UHF_RADIO, 1034, nil, Keys.UHF_Key_3},
    {"PNT_1035", "UHF Key 4 (H)", devices.UHF_RADIO, 1035, nil, Keys.UHF_Key_4},
    {"PNT_1036", "UHF Key 5 (A)", devices.UHF_RADIO, 1036, nil, Keys.UHF_Key_5},
    {"PNT_1037", "UHF Key 6 (M)", devices.UHF_RADIO, 1037, nil, Keys.UHF_Key_6},
    {"PNT_1038", "UHF Key 7 (P)", devices.UHF_RADIO, 1038, nil, Keys.UHF_Key_7},
    {"PNT_1039", "UHF Key 8 (C)", devices.UHF_RADIO, 1039, nil, Keys.UHF_Key_8},
    {"PNT_1040", "UHF Key 9 (T)", devices.UHF_RADIO, 1040, nil, Keys.UHF_Key_9},
    {"PNT_1052", "UHF Key < (Manual)", devices.UHF_RADIO, nil, 1052, Keys.UHF_Key_MAN},
    {"PNT_1030", "UHF Key 0 (Preset)", devices.UHF_RADIO, nil, 1030, Keys.UHF_Key_0},
    {"PNT_1051", "UHF Key > (Enter)", devices.UHF_RADIO, nil, 1051, Keys.UHF_Key_ENT},

    {"PNT_601", "Canopy Handle", devices.CANOPY, 601, nil, 71}, -- iCommandPlaneCanopy
}

for k,v in pairs(multi_tumb_click_list) do
    if multi_tumb_click_list[k][7] == nil then
        elements[multi_tumb_click_list[k][1]] = default_2_position_tumb( multi_tumb_click_list[k][2],multi_tumb_click_list[k][3],multi_tumb_click_list[k][6],multi_tumb_click_list[k][4], multi_tumb_click_list[k][5])
        elements[multi_tumb_click_list[k][1]].sound	= {{multi_tumb_click_list[k][5], multi_tumb_click_list[k][5]}}
    else
        elements[multi_tumb_click_list[k][1]] = default_multi_position_tumb( multi_tumb_click_list[k][2],multi_tumb_click_list[k][3],multi_tumb_click_list[k][6],multi_tumb_click_list[k][7],multi_tumb_click_list[k][4],multi_tumb_click_list[k][5])
        elements[multi_tumb_click_list[k][1]].sound	= {{multi_tumb_click_list[k][5], multi_tumb_click_list[k][5]}}
    end
end

elements["PNT_1145"] = default_button("", devices.ENGINE, Keys.groupSwitch01Down, Keys.groupSwitch01Up, 1145, SOUND_DEFAULT_2_WAY_SWITCH)
elements["PNT_1151"] = default_button("", devices.ENGINE, Keys.groupSwitch02Down, Keys.groupSwitch02Up, 1151, SOUND_DEFAULT_2_WAY_SWITCH)

elements["PNT_1294"] = default_button_2("Release Quantity x10",devices.WEAPON_SYSTEM,Keys.QuantityTumbWheel10_UP,Keys.QuantityTumbWheel10_DN,1294)
elements["PNT_1295"] = default_button_2("Release Quantity x1",devices.WEAPON_SYSTEM,Keys.QuantityTumbWheel_UP,Keys.QuantityTumbWheel_DN,1295)
elements["PNT_1297"] = default_button_2("Release Multitude x10",devices.WEAPON_SYSTEM,Keys.MultTumbWheel10_UP,Keys.MultTumbWheel10_DN,1297)
elements["PNT_1296"] = default_button_2("Release Multitude x1",devices.WEAPON_SYSTEM,Keys.MultTumbWheel_UP,Keys.MultTumbWheel_DN,1296)
elements["PNT_1298"] = default_button_2("Release Interval x100",devices.WEAPON_SYSTEM,Keys.IntervalTumbWheel100_UP,Keys.IntervalTumbWheel100_DN,1298)
elements["PNT_1299"] = default_button_2("Release Interval x10",devices.WEAPON_SYSTEM,Keys.IntervalTumbWheel10_UP,Keys.IntervalTumbWheel10_DN,1299)
elements["PNT_1300"] = default_button_2("Release Interval x1",devices.WEAPON_SYSTEM,Keys.IntervalTumbWheel_UP,Keys.IntervalTumbWheel_DN,1300)

--UHF Keys

--Radar panel
elements["PNT_1211"] = default_axis("Radar Range", devices.RADAR_RAW, Keys.RadarRangeAxis, 1211, 0, 0.1,true,true)
elements["PNT_1212"] = default_axis("A Lightness", devices.RADAR_RAW, Keys.RadarLightA, 1212, 0, 0.1,true,true)
elements["PNT_1213"] = default_axis("Radar Lightness", devices.RADAR_RAW, Keys.RadarLightnessAxis, 1213, 0, 0.1,true,true)
elements["PNT_1214"] = default_axis("B Lightness", devices.RADAR_RAW, Keys.RadarLightB, 1214, 0, 0.1,true,true)
--elements["PNT_1215"] = default_3_position_tumb('Radar OFF/STBY/ON',devices.RADAR_RAW,Keys.RadarMode, 1215,false,false,SOUND_DEFAULT_2_WAY_SWITCH,0.1)

elements["PNT_1061"] = default_axis("Flood Light", devices.LIGHT_SYSTEM, Keys.LightFlood, 1061, 0, 0.1,true,true)
elements["PNT_132"] = default_axis("Instrument Light", devices.LIGHT_SYSTEM, Keys.LightInstruBRT, 1132, 0, 0.1)
elements["PNT_131"] = default_axis("Console Light", devices.LIGHT_SYSTEM, Keys.LightConsoleBRT, 1133, 0, 0.1)
elements["PNT_134"] = default_axis("Approach Index Light", devices.LIGHT_SYSTEM, Keys.LightApproIndexBRT, 1134, 0, 0.1)

elements["PNT_211"] = default_axis("Auto Temperature Control", devices.ECS_SYSTEM, Keys.AircondTemp, 1134, 0, 0.1)
elements["PNT_213"] = default_axis("Defog Airflow", devices.ECS_SYSTEM, Keys.AircondDefog, 1134, 0, 0.1)
-- UHF
elements["PNT_178"] = default_axis("UHF Mode Selection", devices.RADIO_SYSTEM, Keys.UHFMode, 1134, 0, 0.1)
elements["PNT_183"] = default_axis("UHF Volume", devices.RADIO_SYSTEM, Keys.UHFVolume, 1134, 0, 0.1)
-- TACAN
elements["PNT_184"] = default_axis("TACAN Mode Selection", devices.RADIO_SYSTEM, Keys.TACANMode, 1134, 0, 0.1)
elements["PNT_185"] = default_axis("TACAN Channel x10", devices.RADIO_SYSTEM, Keys.TACANChanA, 1134, 0, 0.1)
elements["PNT_186"] = default_axis("TACAN Channel x1", devices.RADIO_SYSTEM, Keys.TACANChanB, 1134, 0, 0.1)

-- EHSI SANDEL SN3500
elements["PNT_534"] = default_axis("Course Selection Knob", devices.HUD_DCMS, Keys.Nav_Course_Sel, 1134, 0, 0.1)
elements["PNT_541"] = default_axis("Heading Selection Knob", devices.HUD_DCMS, Keys.Nav_Heading_Sel, 1134, 0, 0.1)

-- GNS430 Unit
elements["PNT_509"] = default_axis("Vol/PWR Knob", devices.HUD_DCMS, Keys.Nav_Vol_PWR, 1134, 0, 0.1)
elements["PNT_510"] = default_axis("Vol Knob", devices.HUD_DCMS, Keys.Nav_Vol, 1134, 0, 0.1)
elements["PNT_511"] = default_axis("Freqency MHz Knob", devices.HUD_DCMS, Keys.Freq_Num, 1134, 0, 0.1)
elements["PNT_512"] = default_axis("Freqency kHz Knob", devices.HUD_DCMS, Keys.Freq_Degi, 1134, 0, 0.1)
elements["PNT_527"] = default_axis("Right Large Knob", devices.HUD_DCMS, Keys.Nav_Right_Knob_L, 1134, 0, 0.1)
elements["PNT_528"] = default_axis("Right Small Knob", devices.HUD_DCMS, Keys.Nav_Right_Knob_S, 1134, 0, 0.1)

--RWR
elements["PNT_1311"] = default_axis("RWR Lightness", devices.RWR, Keys.RwrLightness, 1311, 0, 0.1)
elements["PNT_1312"] = default_axis("ICS undef knob", devices.RWR, Keys.ICS_UNDEF_KNOB_ROT, 1312, 0, 0.1)

-- UHF R&S GB6500
elements["PNT_554"] = default_axis("UHF Volume", devices.UHF_RADIO, Keys.UHF_Vol, 1134, 0, 0.1)

-- Baro
elements["ALT_down"] = default_axis("Baro Setting", devices.HUD_DCMS, Keys.EALT_BARO, 1134, 0, 0.1)

elements["PNT_179"] = springloaded_3_pos_tumb("UHF tens of Mega hertz", devices.RADIO_SYSTEM, Keys.UHFFreqAUP, Keys.UHFFreqASTOP, Keys.UHFFreqADOWN, Keys.UHFFreqASTOP, 1134)
elements["PNT_180"] = springloaded_3_pos_tumb("UHF Mega hertz", devices.RADIO_SYSTEM, Keys.UHFFreqBUP, Keys.UHFFreqBSTOP, Keys.UHFFreqBDOWN, Keys.UHFFreqBSTOP, 1134)
elements["PNT_181"] = springloaded_3_pos_tumb("UHF hundreds and tens of Kilo hertz", devices.RADIO_SYSTEM, Keys.UHFFreqCUP, Keys.UHFFreqCSTOP, Keys.UHFFreqCDOWN, Keys.UHFFreqCSTOP, 1134)


--for i,o in pairs(elements) do
--	if  o.class[1] == class_type.TUMB or 
--	   (o.class[2]  and o.class[2] == class_type.TUMB) or
--	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
--	   o.updatable = true
--	   o.use_OBB   = true
--	end
--end