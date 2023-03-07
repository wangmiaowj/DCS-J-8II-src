dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path .. "sounds_def.lua")
-- snd_device:performClickableAction(command,value,false)


local electric_system = GetSelf()

local update_time_step = 0.02 --每秒50次调用update()函数
make_default_activity(update_time_step)

local sensor_data = get_base_data()

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
local left_inverter_switch     = _switch_counter() --逆变器左
local right_inverter_switch    = _switch_counter() --逆变器右
local battery_capacity         = _switch_counter() --电池容量
local adi_pwr                  = _switch_counter() --姿态仪供电
local hsi_pwr                  = _switch_counter() --罗盘供电
local radio_alt_pwr            = _switch_counter() --无线电高度表供电
local oil_hyd_pwr              = _switch_counter() --滑油压力表供电
local converter_emerg_converse = _switch_counter() --变流机应急转换
local weapon_pwr               = _switch_counter() --武器供电
local hud_pwr                  = _switch_counter() --HUD供电
local rwr_pwr                  = _switch_counter() --RWR供电
local eject_pwr1               = _switch_counter() --弹射逃生系统供电1
local eject_pwr2               = _switch_counter() --弹射逃生系统供电2
local eject_pwr3               = _switch_counter() --弹射逃生系统供电3
local unknow1                  = _switch_counter()
local unknow2                  = _switch_counter()
local camera_gun               = _switch_counter() --照相枪供电
local msl_warming              = _switch_counter() --导弹加温供电
local msl_filament             = _switch_counter() --导弹灯丝
local msl_launch               = _switch_counter() --导弹发射

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
    { left_inverter_switch,     SWITCH_OFF, get_param_handle("PNT_1004"),         "PNT_1004" },
    { right_inverter_switch,    SWITCH_OFF, get_param_handle("PNT_1005"),         "PNT_1005" },
    { battery_capacity,         1000,       get_param_handle("BATTERY_CAPACITY"), nil },
    { adi_pwr,                  SWITCH_OFF, get_param_handle("PNT_1006"),         "PNT_1006" },
    { hsi_pwr,                  SWITCH_OFF, get_param_handle("PNT_1007"),         "PNT_1007" },
    { radio_alt_pwr,            SWITCH_OFF, get_param_handle("PNT_1008"),         "PNT_1008" },
    { oil_hyd_pwr,              SWITCH_OFF, get_param_handle("PNT_1009"),         "PNT_1009" },
    { converter_emerg_converse, SWITCH_OFF, get_param_handle("PNT_1010"),         "PNT_1010" },
    { weapon_pwr,               SWITCH_OFF, get_param_handle("PNT_1011"),         "PNT_1011" },
    { hud_pwr,                  SWITCH_OFF, get_param_handle("PNT_1012"),         "PNT_1012" },
    { rwr_pwr,                  SWITCH_OFF, get_param_handle("PNT_1013"),         "PNT_1013" },
    { eject_pwr1,               SWITCH_OFF, get_param_handle("PNT_1014"),         "PNT_1014" },
    { eject_pwr2,               SWITCH_OFF, get_param_handle("PNT_1015"),         "PNT_1015" },
    { eject_pwr3,               SWITCH_OFF, get_param_handle("PNT_1016"),         "PNT_1016" },
    { unknow1,                  SWITCH_OFF, get_param_handle("PNT_1017"),         "PNT_1017" },
    { unknow2,                  SWITCH_OFF, get_param_handle("PNT_1018"),         "PNT_1018" },
    { camera_gun,               SWITCH_OFF, get_param_handle("PNT_1019"),         "PNT_1019" },
    { msl_warming,              SWITCH_OFF, get_param_handle("PNT_1020"),         "PNT_1020" },
    { msl_filament,             SWITCH_OFF, get_param_handle("PNT_1021"),         "PNT_1021" },
    { msl_launch,               SWITCH_OFF, get_param_handle("PNT_1022"),         "PNT_1022" },
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

local function update_switch_status()
    for k, v in pairs(display_target_status) do
        display_target_status[k][2] = display_target_status[k][3]:get()
        if display_target_status[k][4] ~= nil then
            local temp_switch_ref = get_clickable_element_reference(display_target_status[k][4])
            temp_switch_ref:update()
        end
        -- print_message_to_user(k)
    end
end

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
    update_switch_status()
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
