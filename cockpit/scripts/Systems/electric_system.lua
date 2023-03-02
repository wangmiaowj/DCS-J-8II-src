dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path .. "sounds_def.lua")
-- snd_device:performClickableAction(command,value,false)


local electric_system = GetSelf()

local update_time_step = 0.02 --每秒50次调用update()函数
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local power_load = get_param_handle("PWR_LOAD")
power_load:set( -0.01) --默认电源负载0.01

electric_system:listen_command(Keys.InverterLeft)
electric_system:listen_command(Keys.InverterRight)
electric_system:listen_command(Keys.BatteryPower)
electric_system:listen_command(Keys.ElecPowerDCGenL)
electric_system:listen_command(Keys.ElecPowerDCGenR)
electric_system:listen_command(Keys.ADIPwr)
electric_system:listen_command(Keys.HSIPwr)
electric_system:listen_command(Keys.RadioAltPwr)
electric_system:listen_command(Keys.OilPressIndPwr)
electric_system:listen_command(Keys.EmergConverter)
electric_system:listen_command(Keys.WeaponPwr)
electric_system:listen_command(Keys.HUDPwr)
electric_system:listen_command(Keys.RWRPwr)
electric_system:listen_command(Keys.EjectPwr1)
electric_system:listen_command(Keys.EjectPwr2)
electric_system:listen_command(Keys.EjectPwr3)
electric_system:listen_command(Keys.UnknownSwitch1)
electric_system:listen_command(Keys.UnknownSwitch2)
electric_system:listen_command(Keys.CameraGunPwrSwitch)
electric_system:listen_command(Keys.MissileWarmingSwitch)
electric_system:listen_command(Keys.MissileFilamentSwitch)
electric_system:listen_command(Keys.MissileLaunchSwitch)
electric_system:listen_command(Keys.pylon1Pwr)
electric_system:listen_command(Keys.pylon2Pwr)
electric_system:listen_command(Keys.pylon3Pwr)
electric_system:listen_command(Keys.pylon4Pwr)
electric_system:listen_command(Keys.pylon5Pwr)
electric_system:listen_command(Keys.pylon6Pwr)
electric_system:listen_command(Keys.pylon7Pwr)
electric_system:listen_command(Keys.blackBoxPwr)
electric_system:listen_command(Keys.rspPwr)
electric_system:listen_command(Keys.apkPwr)
electric_system:listen_command(Keys.batteryHeating)
electric_system:listen_command(Keys.lidSow_Hide)

electric_system:listen_event('GroundPowerOn')
electric_system:listen_event('GroundPowerOff')

local acBus1 = get_param_handle("avSimpleElectricSystem::get_AC_Bus_1_voltage")
local acBus2 = get_param_handle("avSimpleElectricSystem::get_AC_Bus_2_voltage")
local dcBus1 = get_param_handle("avSimpleElectricSystem::get_DC_Bus_1_voltage")
local dcBus2 = get_param_handle("avSimpleElectricSystem::get_DC_Bus_2_voltage")

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local switch_count = 0
local function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local main_power_switch        = _switch_counter() --蓄电池
local left_real_gen_switch     = _switch_counter() --左发电机
local right_real_gen_switch    = _switch_counter() --右发电机
local battery_capacity         = _switch_counter() --电池容量

local pylon1_pwr               = _switch_counter() --1号挂架电源
local pylon2_pwr               = _switch_counter() --2号挂架电源
local pylon3_pwr               = _switch_counter() --3号挂架电源
local pylon4_pwr               = _switch_counter() --4号挂架电源
local pylon5_pwr               = _switch_counter() --5号挂架电源
local pylon6_pwr               = _switch_counter() --6号挂架电源
local pylon7_pwr               = _switch_counter() --7号挂架电源
local blackBox_pwr             = _switch_counter() --黑匣子电源
local rsp_pwr                  = _switch_counter() --应答机电源
local apk_pwr                  = _switch_counter() --APK电源
local battery_heating          = _switch_counter() --电瓶加温
local lid                      = _switch_counter() --右侧面板盖子

local display_target_status    = {
    { main_power_switch,        SWITCH_OFF, get_param_handle("PNT_1001"),         "PNT_1001" },
    { left_real_gen_switch,     SWITCH_OFF, get_param_handle("PNT_1002"),         "PNT_1002" },
    { right_real_gen_switch,    SWITCH_OFF, get_param_handle("PNT_1003"),         "PNT_1003" },
    { battery_capacity,         1000,       get_param_handle("BATTERY_CAPACITY"), nil },
    { pylon1_pwr,               SWITCH_OFF, get_param_handle("PNT_1081"),         "PNT_1081" },
    { pylon2_pwr,               SWITCH_OFF, get_param_handle("PNT_1082"),         "PNT_1082" },
    { pylon3_pwr,               SWITCH_OFF, get_param_handle("PNT_1083"),         "PNT_1083" },
    { pylon4_pwr,               SWITCH_OFF, get_param_handle("PNT_1084"),         "PNT_1084" },
    { pylon5_pwr,               SWITCH_OFF, get_param_handle("PNT_1085"),         "PNT_1085" },
    { pylon6_pwr,               SWITCH_OFF, get_param_handle("PNT_1086"),         "PNT_1086" },
    { pylon7_pwr,               SWITCH_OFF, get_param_handle("PNT_1087"),         "PNT_1087" },
    { blackBox_pwr,             SWITCH_OFF, get_param_handle("PNT_1088"),         "PNT_1088" },
    { rsp_pwr,                  SWITCH_OFF, get_param_handle("PNT_1089"),         "PNT_1089" },
    { apk_pwr,                  SWITCH_OFF, get_param_handle("PNT_1090"),         "PNT_1090" },
    { battery_heating,          SWITCH_OFF, get_param_handle("PNT_1091"),         "PNT_1091" },
    { lid,                      SWITCH_ON,  get_param_handle("PNT_1099"),         "PNT_1099" },
}

local snd_count = 0
local function _snd_counter()
    snd_count = snd_count + 1
    return snd_count
end

local avionics_AC_snd = _snd_counter()
local sndhost = create_sound_host("COCKPIT", "3D", 0, 0, 0)
local snd_list = {
    { avionics_AC_snd, sndhost:create_sound("Aircrafts/Cockpits/Avionics_AC_400Hz") },
}

local function update_elec_state() --更新电力总线状态
    if display_target_status[main_power_switch][3]:get() > 0.5 and display_target_status[battery_capacity][3]:get() > 0 and (electric_system:get_DC_Bus_1_voltage() <= 0 or electric_system:get_DC_Bus_2_voltage() <= 0) then
        electric_system:DC_Battery_on(true)
    elseif display_target_status[main_power_switch][3]:get() < 0.5 and (electric_system:get_DC_Bus_1_voltage() >0 or electric_system:get_DC_Bus_2_voltage() >0) then
        electric_system:DC_Battery_on(false)
    end
    if display_target_status[left_real_gen_switch][3]:get() >0.5 then
        electric_system:AC_Generator_1_on(true)
    else
        electric_system:AC_Generator_1_on(false)
    end
    if display_target_status[right_real_gen_switch][3]:get() >0.5 then
        electric_system:AC_Generator_2_on(true)
    else
        electric_system:AC_Generator_2_on(false)
    end
    if (electric_system:get_AC_Bus_1_voltage() > 0) then
        -- 主发电机状态正常（双备份）
        acBus1:set(1)
    else
        acBus1:set(0)
    end
    if electric_system:get_AC_Bus_2_voltage() > 0 then
        acBus2:set(1)
    else
        acBus2:set(0)
    end
    if electric_system:get_DC_Bus_1_voltage() > 0 then
        dcBus1:set(1)
    else
        dcBus1:set(0)
    end
    if electric_system:get_DC_Bus_2_voltage() > 0 then
        dcBus2:set(1)
    else
        dcBus2:set(0)
    end
end

function post_initialize() --默认初始化函数
    --local dev = GetSelf()
    -- initial the elec system pointer for the radio
    str_ptr = string.sub(tostring(electric_system.link), 10)
    local set_elec_pointer = get_param_handle("ELEC_POINTER")
    set_elec_pointer:set(str_ptr)
    -- end of block
end

function SetCommand(command, value)
    -- 最基础的航电功能监听
end

function update_snd()
    if get_elec_ac_status() and not snd_list[avionics_AC_snd][2]:is_playing() then
        snd_list[avionics_AC_snd][2]:play_continue()
    elseif not get_elec_ac_status() then
        snd_list[avionics_AC_snd][2]:stop()
    end
end

local function update_click_view()
    if display_target_status[lid][2] == SWITCH_ON then
        for i = pylon1_pwr, battery_heating, 1 do
            local temp = get_clickable_element_reference(display_target_status[i][4])
            if temp ~= nil then
                temp:hide(true)
            end
        end
    else
        for i = pylon1_pwr, battery_heating do
            local temp = get_clickable_element_reference(display_target_status[i][4])
            if temp ~= nil then
                temp:hide(false)
            end
        end
    end
end

function update() --刷新状态
    update_elec_state()
    update_snd()
    update_click_view()
end

function CockpitEvent(event, val)
    if event == "GroundPowerOn" then
        dispatch_action(nil,Keys.gndPwrOn,SWITCH_ON)
        print_message_to_user('地面电源已开启')
    elseif event == "GroundPowerOff" then
        dispatch_action(nil,Keys.gndPwrOff,SWITCH_ON)
        print_message_to_user('地面电源已关闭')
    end
end
--[[
From DLL exports inspection, these are the methods support by avSimpleElectricSystem:
AC_Generator_1_on   <- pass true or false to this to enable or disable
AC_Generator_2_on   <- pass true or false to this to enable or disable
DC_Battery_on       <- pass true or false to this to enable or disable
get_AC_Bus_1_voltage  <- returns 115 if enabled (and left engine running), otherwise 0
get_AC_Bus_2_voltage  <- returns 115 if enabled (and right engine running), otherwise 0
get_DC_Bus_1_voltage  <- returns 28 if either AC bus has 115V, otherwise 0
get_DC_Bus_2_voltage  <- returns 28 if battery enabled, otherwise 0


potentially relevant standard base input commands:
iCommandPowerOnOff	315   -- the command dispatched by rshift-L in FC modules

iCommandGroundPowerDC	704
iCommandGroundPowerDC_Cover	705
iCommandPowerBattery1	706
iCommandPowerBattery1_Cover	707
iCommandPowerBattery2	708
iCommandPowerBattery2_Cover	709
iCommandGroundPowerAC	710
iCommandPowerGeneratorLeft	711
iCommandPowerGeneratorRight	712
iCommandElectricalPowerInverter	713

iCommandAPUGeneratorPower	1071
iCommandBatteryPower	1073
iCommandElectricalPowerInverterSTBY	1074
iCommandElectricalPowerInverterOFF	1075
iCommandElectricalPowerInverterTEST	1076
--]]
need_to_be_closed = false
