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
function default_button_4(hint_, device_, command1_, command2_,command3_, command4_, arg_)
    return {
        class               = {class_type.BTN, class_type.BTN,class_type.BTN, class_type.BTN},
        hint                = hint_,
        device              = device_,
        action              = {command1_, command3_},
        stop_action         = {command2_, command4_},
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


--elements["PNT_003"] = default_2_position_tumb(_("Landing Gear Handle"), devices.GEAR_SYSTEM, click_cmd.GearLevel, 3)
 elements["PNT_083"] = default_2_position_tumb(_("Landing Gear Handle"), devices.GEAR_SYSTEM, Keys.PlaneGear, 83, 4)

-- Power Systems
-- elements["PNT_107"] = default_2_position_tumb(_("Battry Swith"), devices.ELECTRIC_SYSTEM, Keys.BatteryPower, 107)
-- elements["PNT_108"] = default_multi_position_tumb(_("Left Generator Switch"), devices.ELECTRIC_SYSTEM, Keys.PowerGeneratorLeftUP, Keys.PowerGeneratorLeftDOWN, -1)
-- elements["PNT_111"] = default_multi_position_tumb(_("Right Generator Switch"), devices.ELECTRIC_SYSTEM, Keys.PowerGeneratorRightUP, Keys.PowerGeneratorRightDOWN, -1)


-- Engine system
-- elements["PNT_109"] = default_multi_position_tumb(_("Left Speed Drive Switch"), devices.ENGINE, Keys.LeftSpeedDriveUP, Keys.LeftSpeedDriveDOWN, 109)
-- elements["PNT_110"] = default_multi_position_tumb(_("Right Speed Drive Switch"), devices.ENGINE, Keys.RightSpeedDriveUP, Keys.RightSpeedDriveDOWN, 110)

-- elements["PNT_112"] = default_2_position_tumb(_("Left Fuel Master"), devices.ENGINE, Keys.FuelMasterLeft, 112)
-- elements["PNT_113"] = default_2_position_tumb(_("Right Fuel Master"), devices.ENGINE, Keys.FuelMasterRight, 113)

-- elements["PNT_114"] = default_2_position_tumb(_("NWW Switch"), devices.ENGINE, Keys.NWWSwitch, 114)
-- elements["PNT_115"] = default_2_position_tumb(_("CSD/S Switch"), devices.ENGINE, Keys.CSDSwitch, 115)
-- elements["PNT_116"] = default_2_position_tumb(_("AirCondition Switch"), devices.ENGINE, Keys.AirCondSwitch, 116)
-- elements["PNT_117"] = default_2_position_tumb(_("Bleed System Cover"), devices.ENGINE, Keys.BleedHoldCover, 117)

-- elements["PNT_150"] = default_button(_("Left Engine Crank"), devices.ENGINE, Keys.LeftEngineCrank, Keys.LeftEngineCrankUP, 150)
-- elements["PNT_151"] = default_button(_("Right Engine Crank"), devices.ENGINE, Keys.RightEngineCrank, Keys.RightEngineCrankUP, 151)

-- elements["PNT_LTHRO"] = default_2_position_tumb(_("Left ENGINE IDLE"), devices.ENGINE, Keys.LeftEngineIDLEPOS, 41)
-- elements["PNT_RTHRO"] = default_2_position_tumb(_("Right Engine IDLE"), devices.ENGINE, Keys.RightEngineIDLEPOS, 42)

-- 
-- elements["PNT_279"] = default_multi_position_tumb(_("Flap handle"), devices.FLAP_SYSTEM, Keys.FlapUp, Keys.FlapDown, 43, 5.0)

-- elements["PARKING_BREAK"] = default_2_position_tumb(_("Parking Break"), devices.BREAK_SYSTEM, Keys.ParkingBrakes, 50)

-- elements["PNT_118"] = default_button(_("Boost Pump Test"), devices.FUEL_SYSTEM, Keys.BoostPumpTestUP, Keys.BoostPumpTestDOWN, 118)

-- elements["PNT_405"] = default_button(_("Left Engine Motor Starter"), devices.HUD_DCMS, Keys.L_STARTER_PRESS, Keys.L_STARTER_RELEASE, 405, SOUND_DEFAULT_2_WAY_SWITCH )
-- elements["PNT_407"] = default_button(_("Right Engine Motor Starter"), devices.HUD_DCMS, Keys.R_STARTER_PRESS, Keys.R_STARTER_RELEASE, 407, SOUND_DEFAULT_2_WAY_SWITCH )

-- elements["PNT_557"] = default_button(_("UHF Radio TAKE Press"), devices.UHF_RADIO, Keys.UHF_TAKE_Button_Press, Keys.UHF_TAKE_Button_Release, 557)

multi_tumb_click_list = {
    -- Engine Control
    -- {"PNT_418", _("Left Low Pressure Fuel Pump"), devices.HUD_DCMS, 418, SOUND_DEFAULT_2_WAY_SWITCH , Keys.L_LP_PUMP},
    -- {"PNT_420", _("Right Low Pressure Fuel Pump"), devices.HUD_DCMS, 420, SOUND_DEFAULT_2_WAY_SWITCH , Keys.R_LP_PUMP},
    -- {"PNT_406", _("Left Main Fuel Pump"), devices.HUD_DCMS, 406, SOUND_DEFAULT_2_WAY_SWITCH , Keys.L_HP_PUMP},
    -- {"PNT_408", _("Right Main Fuel Pump"), devices.HUD_DCMS, 408, SOUND_DEFAULT_2_WAY_SWITCH , Keys.R_HP_PUMP},
    -- {"PNT_604", _("Left Throttle Idle"), devices.HUD_DCMS, 604, nil, Keys.L_THROTTLE_IDLE},
    -- {"PNT_605", _("Right Throttle Idle"), devices.HUD_DCMS, 605, nil, Keys.R_THROTTLE_IDLE},

    {"PNT_1197", _("Taxi/Landing Light"), devices.LIGHT_SYSTEM, 1197, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LightTaxiUP, Keys.LightTaxiDOWN},
    {"PNT_1112", _("Anti-Collision Light"), devices.LIGHT_SYSTEM, 1112, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LightStrobeUP, Keys.LightStrobeDOWN},
    {"PNT_1110", _("Navigation Light"), devices.LIGHT_SYSTEM, 1110, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LightNaviWingUP,Keys.LightNaviWingDOWN},
    
    --{"PNT_125", _("Taxi/Probe Light"), devices.LIGHT_SYSTEM, 125, nil, Keys.LightTaxi},
    {"PNT_1111", _("Tail Navigation Light"), devices.LIGHT_SYSTEM, 1111, nil, Keys.LightNaviTailUP, Keys.LightNaviTailDOWN},
    --{"PNT_130", _("Formation Light"), devices.LIGHT_SYSTEM, 130, nil, Keys.LightFormationUP, Keys.LightFormationDOWN},
    --{"PNT_1061", _("Flood Light"), devices.LIGHT_SYSTEM, 1061, nil, Keys.LightFloodUP, Keys.LightFloodDOWN},

    -- Electric Power Switches
    {"PNT_1001", _("Main Power Switch"), devices.ELECTRIC_SYSTEM, 1001, SOUND_DEFAULT_2_WAY_SWITCH , Keys.BatteryPower},
    {"PNT_1002", _("Left PowerGenerator Switch"), devices.ELECTRIC_SYSTEM, 1002, SOUND_DEFAULT_2_WAY_SWITCH , Keys.ElecPowerDCGenL},
	{"PNT_1003", _("Right PowerGenerator Switch"), devices.ELECTRIC_SYSTEM, 1003, SOUND_DEFAULT_2_WAY_SWITCH , Keys.ElecPowerDCGenR},
	{"PNT_1004", _("Left Inverter Switch"), devices.ELECTRIC_SYSTEM, 1004, SOUND_DEFAULT_2_WAY_SWITCH , Keys.InverterLeft},
	{"PNT_1005", _("Right Inverter Switch"), devices.ELECTRIC_SYSTEM, 1005, SOUND_DEFAULT_2_WAY_SWITCH , Keys.InverterRight},
	{"PNT_1006", _("ADI Power Switch"), devices.ELECTRIC_SYSTEM, 1006, SOUND_DEFAULT_2_WAY_SWITCH , Keys.ADIPwr},
	{"PNT_1007", _("HSI Power Switch"), devices.ELECTRIC_SYSTEM, 1007, SOUND_DEFAULT_2_WAY_SWITCH , Keys.HSIPwr},
	{"PNT_1008", _("Radio Altitude Power Switch"), devices.ELECTRIC_SYSTEM, 1008, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RadioAltPwr},
	{"PNT_1009", _("Oil Pressure Gauge Power Switch"), devices.ELECTRIC_SYSTEM, 1009, SOUND_DEFAULT_2_WAY_SWITCH , Keys.OilPressIndPwr},
	{"PNT_1010", _("Emergency Converter Switch"), devices.ELECTRIC_SYSTEM, 1010, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EmergConverter},
	{"PNT_1011", _("Weapon Power Switch"), devices.ELECTRIC_SYSTEM, 1011, SOUND_DEFAULT_2_WAY_SWITCH , Keys.WeaponPwr},
	{"PNT_1012", _("HUD Power Switch"), devices.ELECTRIC_SYSTEM, 1012, SOUND_DEFAULT_2_WAY_SWITCH , Keys.HUDPwr},
	{"PNT_1013", _("RWR Power Switch"), devices.ELECTRIC_SYSTEM, 1013, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RWRPwr},
	{"PNT_1014", _("Eject Power 1"), devices.ELECTRIC_SYSTEM, 1014, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EjectPwr1},
	{"PNT_1015", _("Eject Power 2"), devices.ELECTRIC_SYSTEM, 1015, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EjectPwr2},
	{"PNT_1016", _("Eject Power 3"), devices.ELECTRIC_SYSTEM, 1016, SOUND_DEFAULT_2_WAY_SWITCH , Keys.EjectPwr3},
	{"PNT_1017", _("Unknown Switch 1"), devices.ELECTRIC_SYSTEM, 1017, SOUND_DEFAULT_2_WAY_SWITCH , Keys.UnknownSwitch1},
	{"PNT_1018", _("Unknown Switch 2"), devices.ELECTRIC_SYSTEM, 1018, SOUND_DEFAULT_2_WAY_SWITCH , Keys.UnknownSwitch2},
	{"PNT_1019", _("Camera Gun Power Switch"), devices.ELECTRIC_SYSTEM, 1019, SOUND_DEFAULT_2_WAY_SWITCH , Keys.CameraGunPwrSwitch},
	{"PNT_1020", _("Missile Warming Switch"), devices.ELECTRIC_SYSTEM, 1020, SOUND_DEFAULT_2_WAY_SWITCH , Keys.MissileWarmingSwitch},
	{"PNT_1021", _("Missile Filament Switch"), devices.ELECTRIC_SYSTEM, 1021, SOUND_DEFAULT_2_WAY_SWITCH , Keys.MissileFilamentSwitch},
	{"PNT_1022", _("Missile Launch Switch"), devices.ELECTRIC_SYSTEM, 1022, SOUND_DEFAULT_2_WAY_SWITCH , Keys.MissileLaunchSwitch},
    {"PNT_1081", _("Pylon1 Power Switch"), devices.ELECTRIC_SYSTEM, 1081, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon1Pwr},
    {"PNT_1082", _("Pylon2 Power Switch"), devices.ELECTRIC_SYSTEM, 1082, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon2Pwr},
    {"PNT_1083", _("Pylon3 Power Switch"), devices.ELECTRIC_SYSTEM, 1083, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon3Pwr},
    {"PNT_1084", _("Pylon4 Power Switch"), devices.ELECTRIC_SYSTEM, 1084, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon4Pwr},
    {"PNT_1085", _("Pylon5 Power Switch"), devices.ELECTRIC_SYSTEM, 1085, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon5Pwr},
    {"PNT_1086", _("Pylon6 Power Switch"), devices.ELECTRIC_SYSTEM, 1086, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon6Pwr},
    {"PNT_1087", _("Pylon7 Power Switch"), devices.ELECTRIC_SYSTEM, 1087, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pylon7Pwr},
    {"PNT_1088", _("Black Box Power Switch"), devices.ELECTRIC_SYSTEM, 1088, SOUND_DEFAULT_2_WAY_SWITCH , Keys.blackBoxPwr},
    {"PNT_1089", _("Responder Power Switch"), devices.ELECTRIC_SYSTEM, 1089, SOUND_DEFAULT_2_WAY_SWITCH , Keys.rspPwr},
    {"PNT_1090", _("Apk Power Switch"), devices.ELECTRIC_SYSTEM, 1090, SOUND_DEFAULT_2_WAY_SWITCH , Keys.apkPwr},
    {"PNT_1091", _("Battery Heating Switch"), devices.ELECTRIC_SYSTEM, 1091, SOUND_DEFAULT_2_WAY_SWITCH , Keys.batteryHeating},
    {"PNT_1099", _("Open/Close Cover"), devices.ELECTRIC_SYSTEM, 1099, SOUND_DEFAULT_2_WAY_SWITCH , Keys.lidSow_Hide},
	
	-- Left Wall Panel 01
    {"PNT_1141", _("Drop Tanks Ind Switch"), devices.ENGINE, 1141, SOUND_DEFAULT_2_WAY_SWITCH , Keys.DropTankInd},
	{"PNT_1142", _("Windshield Anti Ice Switch"), devices.ENGINE, 1142, SOUND_DEFAULT_2_WAY_SWITCH , Keys.windshieldAntiIce},
	{"PNT_1143", _("Pump 4 Switch"), devices.ENGINE, 1143, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pump4},
	{"PNT_1144", _("Pump 3 Switch"), devices.ENGINE, 1144, SOUND_DEFAULT_2_WAY_SWITCH , Keys.pump3},
	--{"PNT_1145", _(""), devices.ENGINE, 1145, SOUND_DEFAULT_2_WAY_SWITCH , Keys.groupSwitch01},
	{"PNT_1146", _("Motor Starter"), devices.ENGINE, 1146, SOUND_DEFAULT_2_WAY_SWITCH , Keys.Starter},
	{"PNT_1147", _("Oil Pump Switch"), devices.ENGINE, 1147, SOUND_DEFAULT_2_WAY_SWITCH , Keys.oilPump},
	{"PNT_1148", _("Start Unit"), devices.ENGINE, 1148, SOUND_DEFAULT_2_WAY_SWITCH , Keys.startUnit},
	{"PNT_1149", _("Generator Oil Pressure"), devices.ENGINE, 1149, SOUND_DEFAULT_2_WAY_SWITCH , Keys.genOilPress},
	{"PNT_1150", _("After Burn Switch"), devices.ENGINE, 1150, SOUND_DEFAULT_2_WAY_SWITCH , Keys.afterBurn},
	--{"PNT_1151", _(""), devices.ENGINE, 1151, SOUND_DEFAULT_2_WAY_SWITCH , Keys.groupSwitch02},
	{"R_ENG_IDLE", _("Right Engine Start/Stop"), devices.ENGINE, 102, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RightEngineStart, Keys.RightEngineStop},
	{"L_ENG_IDLE", _("Left Engine Start/Stop"), devices.ENGINE, 103, SOUND_DEFAULT_2_WAY_SWITCH , Keys.LeftEngineStart, Keys.LeftEngineStop},

    
    -- {"PNT_414", _("A/G mode"), devices.WEAPON_SYSTEM, 414, SOUND_DEFAULT_2_WAY_SWITCH , Keys.WeaponAirGroundChange},

	--火控台
	
	{"PNT_1202", _("Flight Mode"), nil, 1202, SOUND_DEFAULT_2_WAY_SWITCH, Keys.HK_L_Up,Keys.HK_L_Down},
	{"PNT_1203", _("Master Arm"), devices.WEAPON_SYSTEM, 1203, SOUND_DEFAULT_2_WAY_SWITCH , Keys.WeaponMasterSwitch},
	{"PNT_1204", _("Weapon Type"), devices.WEAPON_SYSTEM, 1204, SOUND_DEFAULT_2_WAY_SWITCH, Keys.HK_R_Up,Keys.HK_R_Down},
	{"PNT_1261", _("Pylon 1 Select"), devices.WEAPON_SYSTEM, 1261, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon1SelUP,Keys.Pylon1SelDOWN},
	{"PNT_1262", _("Pylon 2 Select"), devices.WEAPON_SYSTEM, 1262, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon2SelUP,Keys.Pylon2SelDOWN},
    {"PNT_2263", _("Pylon 3 Select"), devices.WEAPON_SYSTEM, 2263, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon3SelUP,Keys.Pylon3SelDOWN},
	{"PNT_1263", _("Pylon 4 Select"), devices.WEAPON_SYSTEM, 1263, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon4SelUP,Keys.Pylon4SelDOWN},
    {"PNT_2264", _("Pylon 5 Select"), devices.WEAPON_SYSTEM, 2264, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon5SelUP,Keys.Pylon5SelDOWN},
	{"PNT_1264", _("Pylon 6 Select"), devices.WEAPON_SYSTEM, 1264, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon6SelUP,Keys.Pylon6SelDOWN},
	{"PNT_1265", _("Pylon 7 Select"), devices.WEAPON_SYSTEM, 1265, SOUND_DEFAULT_2_WAY_SWITCH, Keys.Pylon7SelUP,Keys.Pylon7SelDOWN},
	
    --RWR
	{"PNT_1196", _("RWR Power"), devices.RWR, 1196, SOUND_DEFAULT_2_WAY_SWITCH , Keys.RwrOnOffSwitch},
    
    -- RADAR Panel
	{"PNT_1215", _("Radar OFF/STBY/ON"), devices.RADAR_RAW, 1215, SOUND_DEFAULT_2_WAY_SWITCH, Keys.RadarModeUp,Keys.RadarModeDown},
    {"PNT_1216", _("Radar Max Range"), devices.RADAR_RAW, 1216, SOUND_DEFAULT_2_WAY_SWITCH, Keys.RadarMaxRange},

    -- GNS430
    -- {"PNT_513", _("VLOC/COM Focus Change"), devices.HUD_DCMS, 513, nil, Keys.Freq_Knob_Push},
    -- {"PNT_514", _("COM frequency Flip-flop"), devices.HUD_DCMS, 514, nil, Keys.COM_Freq_Swap},
    -- {"PNT_515", _("VLOC frequency Flip-flop"), devices.HUD_DCMS, 515, nil, Keys.VLOC_Freq_Swap},
    -- {"PNT_516", _("Change CDI"), devices.HUD_DCMS, 516, nil, Keys.Nav_CDI},
    -- {"PNT_517", _("OBS"), devices.HUD_DCMS, 517, nil, Keys.Nav_OBS},
    -- {"PNT_518", _("Message"), devices.HUD_DCMS, 518, nil, Keys.Nav_MSG},
    -- {"PNT_519", _("Flight Plan"), devices.HUD_DCMS, 519, nil, Keys.Nav_FPL},
    -- {"PNT_520", _("Process"), devices.HUD_DCMS, 520, nil, Keys.Nav_PROC},
    -- {"PNT_521", _("Range decrease"), devices.HUD_DCMS, 521, nil, Keys.Nav_Map_range_decrease},
    -- {"PNT_522", _("Range increase"), devices.HUD_DCMS, 522, nil, Keys.Nav_Map_range_increse},
    -- {"PNT_523", _("Direct To"), devices.HUD_DCMS, 523, nil, Keys.Nav_Direct_to},
    -- {"PNT_524", _("Menu"), devices.HUD_DCMS, 524, nil, Keys.Nav_Menu},
    -- {"PNT_525", _("Clear"), devices.HUD_DCMS, 525, nil, Keys.Nav_Clear},
    -- {"PNT_526", _("Enter"), devices.HUD_DCMS, 526, nil, Keys.Nav_Ent},
    -- {"PNT_529", _("Select Input"), devices.HUD_DCMS, 529, nil, Keys.Nav_Right_Knob_Push},

    -- R&S GB6500
    -- {"PNT_554", _("UHF Volume Change"), devices.UHF_RADIO, 554, Keys.UHF_Vol_Up, Keys.UHF_Vol_Down},
    {"PNT_1046", _("UHF SQL ON/OFF, Acknology"), devices.UHF_RADIO, 1046, SOUND_DEFAULT_2_WAY_SWITCH , Keys.UHF_Vol_Up, Keys.UHF_Vol_Down},
    {"PNT_1049", _("UHF Mode Selection"), devices.UHF_RADIO, 1049, nil, Keys.UHF_Mode_Left, Keys.UHF_Mode_Right},
    -- keyboard
    {"PNT_1032", _("UHF Key 1 (TONE)"), devices.UHF_RADIO, 1032, nil, Keys.UHF_Key_1},
    {"PNT_1033", _("UHF Key 2 (-)"), devices.UHF_RADIO, 1033, nil, Keys.UHF_Key_2},
    {"PNT_1034", _("UHF Key 3 (+)"), devices.UHF_RADIO, 1034, nil, Keys.UHF_Key_3},
    {"PNT_1035", _("UHF Key 4 (H)"), devices.UHF_RADIO, 1035, nil, Keys.UHF_Key_4},
    {"PNT_1036", _("UHF Key 5 (A)"), devices.UHF_RADIO, 1036, nil, Keys.UHF_Key_5},
    {"PNT_1037", _("UHF Key 6 (M)"), devices.UHF_RADIO, 1037, nil, Keys.UHF_Key_6},
    {"PNT_1038", _("UHF Key 7 (P)"), devices.UHF_RADIO, 1038, nil, Keys.UHF_Key_7},
    {"PNT_1039", _("UHF Key 8 (C)"), devices.UHF_RADIO, 1039, nil, Keys.UHF_Key_8},
    {"PNT_1040", _("UHF Key 9 (T)"), devices.UHF_RADIO, 1040, nil, Keys.UHF_Key_9},
    {"PNT_1052", _("UHF Key < (Manual)"), devices.UHF_RADIO, nil, 1052, Keys.UHF_Key_MAN},
    {"PNT_1031", _("UHF Key 0 (Preset)"), devices.UHF_RADIO, nil, 1031, Keys.UHF_Key_0},
    {"PNT_1051", _("UHF Key > (Enter)"), devices.UHF_RADIO, nil, 1051, Keys.UHF_Key_ENT},

    -- {"PNT_601", _("Canopy Handle"), devices.CANOPY, 601, nil, 71}, -- iCommandPlaneCanopy
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

elements["PNT_1145"] = default_button(_(""), devices.ENGINE, Keys.groupSwitch01Up, Keys.groupSwitch01Down, 1145, SOUND_DEFAULT_2_WAY_SWITCH)
elements["PNT_1151"] = default_button(_(""), devices.ENGINE, Keys.groupSwitch02Up, Keys.groupSwitch02Down, 1151, SOUND_DEFAULT_2_WAY_SWITCH)

elements["PNT_1124"] = default_button_4(_("Engine Start Selector"), devices.ENGINE,Keys.L_STARTER_PRESS,Keys.L_STARTER_RELEASE,Keys.R_STARTER_PRESS,Keys.R_STARTER_RELEASE,1124)
elements["PNT_1294"] = default_button_2(_("Release Quantity x10"), devices.WEAPON_SYSTEM,Keys.QuantityTumbWheel10_UP,Keys.QuantityTumbWheel10_DN,1294)
elements["PNT_1295"] = default_button_2(_("Release Quantity x1"), devices.WEAPON_SYSTEM,Keys.QuantityTumbWheel_UP,Keys.QuantityTumbWheel_DN,1295)
elements["PNT_1297"] = default_button_2(_("Release Multitude x10"), devices.WEAPON_SYSTEM,Keys.MultTumbWheel10_UP,Keys.MultTumbWheel10_DN,1297)
elements["PNT_1296"] = default_button_2(_("Release Multitude x1"), devices.WEAPON_SYSTEM,Keys.MultTumbWheel_UP,Keys.MultTumbWheel_DN,1296)
elements["PNT_1298"] = default_button_2(_("Release Interval x100"), devices.WEAPON_SYSTEM,Keys.IntervalTumbWheel100_UP,Keys.IntervalTumbWheel100_DN,1298)
elements["PNT_1299"] = default_button_2(_("Release Interval x10"), devices.WEAPON_SYSTEM,Keys.IntervalTumbWheel10_UP,Keys.IntervalTumbWheel10_DN,1299)
elements["PNT_1300"] = default_button_2(_("Release Interval x1"), devices.WEAPON_SYSTEM,Keys.IntervalTumbWheel_UP,Keys.IntervalTumbWheel_DN,1300)

--UHF Keys

--Radar panel
elements["PNT_1211"] = default_axis(_("Radar Range"), devices.RADAR_RAW, Keys.RadarRangeAxis, 1211, 0, 0.1,true,true)
elements["PNT_1212"] = default_axis(_("A Lightness"), devices.RADAR_RAW, Keys.RadarLightA, 1212, 0, 0.1,true,true)
elements["PNT_1213"] = default_axis(_("Radar Lightness"), devices.RADAR_RAW, Keys.RadarLightnessAxis, 1213, 0, 0.1,true,true)
elements["PNT_1214"] = default_axis(_("B Lightness"), devices.RADAR_RAW, Keys.RadarLightB, 1214, 0, 0.1,true,true)
--elements["PNT_1215"] = default_3_position_tumb('Radar OFF/STBY/ON',devices.RADAR_RAW,Keys.RadarMode, 1215,false,false,SOUND_DEFAULT_2_WAY_SWITCH,0.1)

elements["PNT_1061"] = default_axis(_("Flood Light"), devices.LIGHT_SYSTEM, Keys.LightFlood, 1061, 0, 0.1,true,true)
elements["PNT_1062"] = default_axis(_("instrument light"), devices.LIGHT_SYSTEM, Keys.LightInstruBRT, 1062, 0, 0.1,true,true)
-- elements["PNT_132"] = default_axis(_("Instrument Light"), devices.LIGHT_SYSTEM, Keys.LightInstruBRT, 1132, 0, 0.1)
-- elements["PNT_131"] = default_axis(_("Console Light"), devices.LIGHT_SYSTEM, Keys.LightConsoleBRT, 1133, 0, 0.1)
-- elements["PNT_134"] = default_axis(_("Approach Index Light"), devices.LIGHT_SYSTEM, Keys.LightApproIndexBRT, 1134, 0, 0.1)

-- elements["PNT_211"] = default_axis(_("Auto Temperature Control"), devices.ECS_SYSTEM, Keys.AircondTemp, 1134, 0, 0.1)
-- elements["PNT_213"] = default_axis(_("Defog Airflow"), devices.ECS_SYSTEM, Keys.AircondDefog, 1134, 0, 0.1)
-- UHF
-- elements["PNT_178"] = default_axis(_("UHF Mode Selection"), devices.RADIO_SYSTEM, Keys.UHFMode, 1134, 0, 0.1)
-- elements["PNT_183"] = default_axis(_("UHF Volume"), devices.RADIO_SYSTEM, Keys.UHFVolume, 1134, 0, 0.1)
-- TACAN
-- elements["PNT_184"] = default_axis(_("TACAN Mode Selection"), devices.RADIO_SYSTEM, Keys.TACANMode, 1134, 0, 0.1)
-- elements["PNT_185"] = default_axis(_("TACAN Channel x10"), devices.RADIO_SYSTEM, Keys.TACANChanA, 1134, 0, 0.1)
-- elements["PNT_186"] = default_axis(_("TACAN Channel x1"), devices.RADIO_SYSTEM, Keys.TACANChanB, 1134, 0, 0.1)

-- EHSI SANDEL SN3500
-- elements["PNT_534"] = default_axis(_("Course Selection Knob"), devices.HUD_DCMS, Keys.Nav_Course_Sel, 1134, 0, 0.1)
-- elements["PNT_541"] = default_axis(_("Heading Selection Knob"), devices.HUD_DCMS, Keys.Nav_Heading_Sel, 1134, 0, 0.1)

-- GNS430 Unit
-- elements["PNT_509"] = default_axis(_("Vol/PWR Knob"), devices.HUD_DCMS, Keys.Nav_Vol_PWR, 1134, 0, 0.1)
-- elements["PNT_510"] = default_axis(_("Vol Knob"), devices.HUD_DCMS, Keys.Nav_Vol, 1134, 0, 0.1)
-- elements["PNT_511"] = default_axis(_("Freqency MHz Knob"), devices.HUD_DCMS, Keys.Freq_Num, 1134, 0, 0.1)
-- elements["PNT_512"] = default_axis(_("Freqency kHz Knob"), devices.HUD_DCMS, Keys.Freq_Degi, 1134, 0, 0.1)
-- elements["PNT_527"] = default_axis(_("Right Large Knob"), devices.HUD_DCMS, Keys.Nav_Right_Knob_L, 1134, 0, 0.1)
-- elements["PNT_528"] = default_axis(_("Right Small Knob"), devices.HUD_DCMS, Keys.Nav_Right_Knob_S, 1134, 0, 0.1)

--RWR
elements["PNT_1311"] = default_axis(_("RWR Lightness"), devices.RWR, Keys.RwrLightness, 1311, 0, 0.1,true,true)
elements["PNT_1312"] = default_axis(_("RWR Volume"), devices.RWR, Keys.RwrVolume, 1312, 0, 0.1,true,true)

-- UHF R&S GB6500
-- elements["PNT_554"] = default_axis(_("UHF Volume"), devices.UHF_RADIO, Keys.UHF_Vol, 1134, 0, 0.1)

-- Baro
-- elements["ALT_down"] = default_axis(_("Baro Setting"), devices.HUD_DCMS, Keys.EALT_BARO, 1134, 0, 0.1)

-- elements["PNT_179"] = springloaded_3_pos_tumb(_("UHF tens of Mega hertz"), devices.RADIO_SYSTEM, Keys.UHFFreqAUP, Keys.UHFFreqASTOP, Keys.UHFFreqADOWN, Keys.UHFFreqASTOP, 1134)
-- elements["PNT_180"] = springloaded_3_pos_tumb(_("UHF Mega hertz"), devices.RADIO_SYSTEM, Keys.UHFFreqBUP, Keys.UHFFreqBSTOP, Keys.UHFFreqBDOWN, Keys.UHFFreqBSTOP, 1134)
-- elements["PNT_181"] = springloaded_3_pos_tumb(_("UHF hundreds and tens of Kilo hertz"), devices.RADIO_SYSTEM, Keys.UHFFreqCUP, Keys.UHFFreqCSTOP, Keys.UHFFreqCDOWN, Keys.UHFFreqCSTOP, 1134)


--for i,o in pairs(elements) do
--	if  o.class[1] == class_type.TUMB or 
--	   (o.class[2]  and o.class[2] == class_type.TUMB) or
--	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
--	   o.updatable = true
--	   o.use_OBB   = true
--	end
--end