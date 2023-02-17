dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."debug_util.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local gettext = require("i_18n")
_ = gettext.translate

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local cheat = GetSelf()
cheat:listen_command(Keys.autoStart)
cheat:listen_command(Keys.autoStop)

local sensor_data = get_base_data()

local time = 0
local status = false --false未启动,true已启动
local action = 0 --0中立，1启动，-1关机

local motorRPM_handle = get_param_handle('MOTOR_RPM')
function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        status = true
    elseif birth=="GROUND_COLD" then
        status = false
    end
end

function SetCommand(command,value)
    if command == Keys.autoStart then
        action = 1
        print_message_to_user('start of autostart',3)
    elseif command == Keys.autoStart then
        action = -1
    end
end

local function interactive(elementName,cmd,device,val)
    local text = ''
    if action == 1 then
        text = '开启'
        dispatch_action(device,cmd,val)
    elseif action == -1 then
        text = '关闭'
        dispatch_action(device,cmd,0)
    end
    print_message_to_user(elementName..'-'..text)
end

local function get_cockpit_arg_val(arg)
    return get_cockpit_draw_argument_value(arg)
end

local function autoStart()
    local motorRPM = motorRPM_handle:get()
    if get_cockpit_arg_val(1001) == 0 then
        interactive(_("Main Power Switch"),Keys.BatteryPower,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1002) == 0 then
        interactive(_("Left PowerGenerator Switch"),Keys.ElecPowerDCGenL,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1003) == 0 then
        interactive(_("Right PowerGenerator Switch"),Keys.ElecPowerDCGenR,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1004) == 0 then
        interactive(_('Left Inverter Switch'),Keys.InverterLeft,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1005) == 0 then
        interactive(_('Right Inverter Switch'),Keys.InverterRight,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1099) == 1 and sensor_data.getEngineLeftRPM() < 55 and sensor_data.getEngineRightRPM() < 55 then
        interactive(_('Open/Close Cover'),Keys.lidSow_Hide,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1088) == 0 then
        interactive(_('Black Box Power Switch'),Keys.blackBoxPwr,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1089) == 0 then
        interactive(_('Responder Power Switch'),Keys.rspPwr,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1090) == 0 then
        interactive(_('APK'),Keys.apkPwr,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1091) == 0 then
        interactive(_('Battery Heating Switch'),Keys.batteryHeating,devices.ELECTRIC_SYSTEM,1)
    elseif get_cockpit_arg_val(1141) == 0 then
        interactive(_('Drop Tanks Ind Switch'),Keys.DropTankInd,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1142) == 0 then
        interactive(_('Windshield Anti Ice Switch'),Keys.windshieldAntiIce,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1143) == 0 then
        interactive(_('Pump 4 Switch'),Keys.pump4,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1144) == 0 then
        interactive(_('Pump 3 Switch'),Keys.pump3,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1147) == 0 then
        interactive(_('Oil Pump Switch'),Keys.oilPump,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1148) == 0 then
        interactive(_('Start Unit'),Keys.startUnit,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1149) == 0 then
        interactive(_('Generator Oil Pressure'),Keys.genOilPress,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1150) == 0 then
        interactive(_('After Burn Switch'),Keys.afterBurn,devices.ENGINE,1)
    elseif get_cockpit_arg_val(1146) == 0 then
        interactive(_('Motor Starter'),Keys.Starter,devices.ENGINE,1)
        print_message_to_user('wait motor start',15)
    elseif motorRPM > 99 and sensor_data.getEngineLeftRPM() <= 0 then
        interactive(_('Left Engine Start/Stop'),Keys.LeftEngineStart,devices.ENGINE,1)
    elseif motorRPM > 99 and sensor_data.getEngineRightRPM() <= 0 and sensor_data.getEngineLeftRPM() > 55 then
        interactive(_('Right Engine Start/Stop'),Keys.RightEngineStart,devices.ENGINE,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1006) == 0 then
        interactive(_('ADI Power Switch'),Keys.ADIPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1007) == 0 then
        interactive(_('HSI Power Switch'),Keys.HSIPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1008) == 0 then
        interactive(_('Radio Altitude Power Switch'),Keys.RadioAltPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1009) == 0 then
        interactive(_('Oil Pressure Gauge Power Switch'),Keys.OilPressIndPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1011) == 0 then
        interactive(_('Weapon Power Switch'),Keys.WeaponPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1012) == 0 then
        interactive(_('HUD Power Switch'),Keys.HUDPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1013) == 0 then
        interactive(_('RWR Power Switch'),Keys.RWRPwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1014) == 0 then
        interactive(_('Eject Power 1'),Keys.EjectPwr1,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1015) == 0 then
        interactive(_('Eject Power 2'),Keys.EjectPwr2,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1016) == 0 then
        interactive(_('Eject Power 3'),Keys.EjectPwr3,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1020) == 0 then
        interactive(_('Missile Warming Switch'),Keys.MissileWarmingSwitch,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1021) == 0 then
        interactive(_('Missile Filament Switch'),Keys.MissileFilamentSwitch,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1022) == 0 then
        interactive(_('Missile Launch Switch'),Keys.MissileLaunchSwitch,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1081) == 0 then
        interactive(_('Pylon1 Power Switch'),Keys.pylon1Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1082) == 0 then
        interactive(_('Pylon2 Power Switch'),Keys.pylon2Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1083) == 0 then
        interactive(_('Pylon3 Power Switch'),Keys.pylon3Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1084) == 0 then
        interactive(_('Pylon4 Power Switch'),Keys.pylon4Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1085) == 0 then
        interactive(_('Pylon5 Power Switch'),Keys.pylon5Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1086) == 0 then
        interactive(_('Pylon6 Power Switch'),Keys.pylon6Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1087) == 0 then
        interactive(_('Pylon7 Power Switch'),Keys.pylon7Pwr,devices.ELECTRIC_SYSTEM,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1099) == 0 then
        interactive(_('Open/Close Cover'),Keys.lidSow_Hide,devices.ELECTRIC_SYSTEM,0)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1311) > 0.5 then
        interactive(_('RWR Lightness'),Keys.RwrLightness,devices.RWR,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1312) > 0.5 then
        interactive(_('RWR Volume'),Keys.RwrVolume,devices.RWR,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1196) == 0 then
        interactive(_('RWR Power'),Keys.RwrOnOffSwitch,devices.RWR,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1215) == 0 then
        interactive(_('Radar OFF/STBY/ON'),Keys.RadarModeUp,devices.RADAR_RAW,1)
    elseif (sensor_data.getEngineLeftRPM() > 40 or sensor_data.getEngineRightRPM() > 40) and get_cockpit_arg_val(1213) < 0.5 then
        interactive(_('Radar Lightness'),Keys.RadarLightnessAxis,devices.RADAR_RAW,1)
    elseif motorRPM > 99 and sensor_data.getEngineLeftRPM() > 55 and sensor_data.getEngineRightRPM() > 55 and get_cockpit_arg_val(181) > 0.899 then
        interactive(_('Canopy Open/Close'),Keys.PlaneFonar,devices.CPT,0)
    elseif motorRPM > 99 and sensor_data.getEngineLeftRPM() > 55 and sensor_data.getEngineRightRPM() > 55 and get_cockpit_arg_val(181) == 0 then
        interactive(_('Motor Starter'),Keys.Starter,devices.ENGINE,0)
        print_message_to_user('end of autostart',3)
        action = 0
    end
end

local function autoStop()
    
end

function update()
    time = time + update_time_step
    if time > 0.6 then
        if action == 1 then
            autoStart()
        elseif action == -1 then
            autoStop()
        end
        time = 0
    end
end