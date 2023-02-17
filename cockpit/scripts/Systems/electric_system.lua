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

local dis_play_current_status  = {
    --  {switch_index,switch_status,unknow,pwr_load,needAc}
    --  {开关索引,开关状态,未知变量,功耗,是否需要交流电}
    { main_power_switch,        SWITCH_OFF, SWITCH_OFF, 0,      false },
    { left_real_gen_switch,     SWITCH_OFF, SWITCH_OFF, 0.005,  false },
    { right_real_gen_switch,    SWITCH_OFF, SWITCH_OFF, 0.005,  false },
    { left_inverter_switch,     SWITCH_OFF, SWITCH_OFF, 0,      false },
    { right_inverter_switch,    SWITCH_OFF, SWITCH_OFF, 0,      false },
    { battery_capacity,         1000,       1000,       0,      false },
    { adi_pwr,                  SWITCH_OFF, SWITCH_OFF, 0.005,  false },
    { hsi_pwr,                  SWITCH_OFF, SWITCH_OFF, 0.005,  false },
    { radio_alt_pwr,            SWITCH_OFF, SWITCH_OFF, 0.005,  false },
    { oil_hyd_pwr,              SWITCH_OFF, SWITCH_OFF, 0.005,  false },
    { converter_emerg_converse, SWITCH_OFF, SWITCH_OFF, 0.2,    false },
    { weapon_pwr,               SWITCH_OFF, SWITCH_OFF, 0.04,   true },
    { hud_pwr,                  SWITCH_OFF, SWITCH_OFF, 0.075,  true },
    { rwr_pwr,                  SWITCH_OFF, SWITCH_OFF, 0.05,   true },
    { eject_pwr1,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { eject_pwr2,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { eject_pwr3,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { unknow1,                  SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { unknow2,                  SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { camera_gun,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { msl_warming,              SWITCH_OFF, SWITCH_OFF, 0.025,  true },
    { msl_filament,             SWITCH_OFF, SWITCH_OFF, 0.0025, true },
    { msl_launch,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon1_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon2_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon3_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon4_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon5_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon6_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { pylon7_pwr,               SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { blackBox_pwr,             SWITCH_OFF, SWITCH_OFF, 0.04,   true },
    { rsp_pwr,                  SWITCH_OFF, SWITCH_OFF, 0.025,  true },
    { apk_pwr,                  SWITCH_OFF, SWITCH_OFF, 0.01,   true },
    { battery_heating,          SWITCH_OFF, SWITCH_OFF, 0.05,   true },
    { lid,                      SWITCH_ON,  SWITCH_ON,  0,      false },
}

local warning_panel_4_count    = 0
local function warning_panel_counter()
    warning_panel_4_count = warning_panel_4_count + 1
    return warning_panel_4_count
end

local l_gen = warning_panel_counter()
local r_gen = warning_panel_counter()
local l_inv = warning_panel_counter()
local r_inv = warning_panel_counter()
local batt = warning_panel_counter()
local dc_ok = warning_panel_counter()
local ac_ok = warning_panel_counter()
local gen_inter = warning_panel_counter()
local eject_system = warning_panel_counter()
local batt_color = warning_panel_counter()

local warning_panel_status = {
    { l_gen,         SWITCH_OFF, get_param_handle('L_GEN') },
    { r_gen,         SWITCH_OFF, get_param_handle('R_GEN') },
    { l_inv,         SWITCH_OFF, get_param_handle('L_INV') },
    { r_inv,         SWITCH_OFF, get_param_handle('R_INV') },
    { batt,          SWITCH_OFF, get_param_handle('BATT') },
    { dc_ok,         SWITCH_OFF, get_param_handle('DC') },
    { ac_ok,         SWITCH_OFF, get_param_handle('AC') },
    { gen_inter,     SWITCH_OFF, get_param_handle('GEN_INTER') },
    { eject_system,  SWITCH_OFF, get_param_handle('EJECT_SYSTEM') },
    { batt_color,    SWITCH_OFF, get_param_handle('BATT_COLOR') }
}

local function drawingWarningPanel()
    for k, v in pairs(warning_panel_status) do
        v[3]:set(v[2])
    end
end

local function updateWarningPanel()
    warning_panel_status[dc_ok][2] = SWITCH_ON
    if dis_play_current_status[battery_capacity][2] < 300 then
        warning_panel_status[batt_color][2] = 0
    elseif dis_play_current_status[battery_capacity][2] < 500 then
        warning_panel_status[batt_color][2] = 1
    elseif dis_play_current_status[battery_capacity][2] <= 1000 then
        warning_panel_status[batt_color][2] = 2
    end
    if not get_elec_ac_status() or dis_play_current_status[battery_capacity][2] < 1000 then
        warning_panel_status[batt][2] = SWITCH_ON
    else
        warning_panel_status[batt][2] = SWITCH_OFF
    end
    if elec_charging_status:get() == 0 or dis_play_current_status[left_real_gen_switch][2] == SWITCH_OFF or sensor_data.getEngineLeftRPM() < 50 then
        warning_panel_status[l_gen][2] = SWITCH_ON
    else
        warning_panel_status[l_gen][2] = SWITCH_OFF
    end
    if elec_charging_status:get() == 0 or dis_play_current_status[right_real_gen_switch][2] == SWITCH_OFF or sensor_data.getEngineRightRPM() < 50 then
        warning_panel_status[r_gen][2] = SWITCH_ON
    else
        warning_panel_status[r_gen][2] = SWITCH_OFF
    end
    if dis_play_current_status[left_inverter_switch][2] == SWITCH_OFF then
        warning_panel_status[l_inv][2] = SWITCH_ON
    else
        warning_panel_status[l_inv][2] = SWITCH_OFF
    end
    if dis_play_current_status[right_inverter_switch][2] == SWITCH_OFF then
        warning_panel_status[r_inv][2] = SWITCH_ON
    else
        warning_panel_status[r_inv][2] = SWITCH_OFF
    end
    if get_elec_ac_status() then
        warning_panel_status[ac_ok][2] = SWITCH_ON
    else
        warning_panel_status[ac_ok][2] = SWITCH_OFF
    end
    if not get_elec_ac_status() or dis_play_current_status[eject_pwr1][2] == SWITCH_OFF or dis_play_current_status[eject_pwr2][2] == SWITCH_OFF or dis_play_current_status[eject_pwr3][2] == SWITCH_OFF then
        warning_panel_status[eject_system][2] = SWITCH_ON
    else
        warning_panel_status[eject_system][2] = SWITCH_OFF
    end
end

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

function update_switch_status()
    local switch_moving_step = 0.15
    for k, v in pairs(display_target_status) do
        if display_target_status[k][1] ~= battery_capacity then
            if math.abs(display_target_status[k][2] - dis_play_current_status[k][2]) < switch_moving_step then
                dis_play_current_status[k][2] = display_target_status[k][2]
            elseif display_target_status[k][2] > dis_play_current_status[k][2] then
                dis_play_current_status[k][2] = dis_play_current_status[k][2] + switch_moving_step
            elseif display_target_status[k][2] < dis_play_current_status[k][2] then
                dis_play_current_status[k][2] = dis_play_current_status[k][2] - switch_moving_step
            end
        elseif display_target_status[k][1] == battery_capacity then
            dis_play_current_status[k][2] = elec_battery_status:get()
        end
        display_target_status[k][3]:set(dis_play_current_status[k][2])
        if display_target_status[k][4] ~= nil then
            local temp_switch_ref = get_clickable_element_reference(display_target_status[k][4])
            temp_switch_ref:update()
        end
        -- print_message_to_user(k)
    end
end

local inverter_statue = -1

local function handlePwrLoad()
    local pwrLoad = 0
    if elec_charging_status:get() == 1 then
        pwrLoad = 0.05
    elseif get_elec_dc_status() then
        for k, v in pairs(dis_play_current_status) do
            if v[5] then
                if get_elec_ac_status() then
                    if v[2] == SWITCH_ON then
                        pwrLoad = pwrLoad - v[4] --增加负载
                    end
                end
            else
                if v[2] == SWITCH_ON then
                    pwrLoad = pwrLoad - v[4] --增加负载
                end
            end
        end
    end
    power_load:set(pwrLoad)
end

function update_elec_state() --更新电力总线状态
    if (electric_system:get_AC_Bus_1_voltage() > 0 or electric_system:get_AC_Bus_2_voltage() > 0) then
        -- 主发电机状态正常（双备份）
        elec_charging_status:set(1)
    else
        elec_charging_status:set(0)
    end

    if electric_system:get_DC_Bus_1_voltage() > 0 or electric_system:get_DC_Bus_2_voltage() > 0 then
        if elec_battery_status:get() == 0 then
            -- elec_dc_status:set(0)
            -- problem here, when bus has power, dc electric should be on
            elec_dc_status:set(0)
        else
            elec_dc_status:set(1)
        end
    else
        elec_dc_status:set(0)
    end

    if get_elec_dc_status() and
        (display_target_status[left_inverter_switch][2] == 1 or display_target_status[right_inverter_switch][2] == 1) then
        elec_ac_status:set(1)
    else
        elec_ac_status:set(0)
    end
    local pwrLoad = power_load:get()
    if (get_elec_dc_status() and elec_charging_status:get() == 0) then
        elec_battery_status:set(elec_battery_status:get() + pwrLoad)
    elseif (elec_charging_status:get() == 1) then
        pwrLoad = 0.05
        power_load:set(0.05)
        elec_battery_status:set(elec_battery_status:get() + pwrLoad)
    end
    if elec_battery_status:get() < 0 then
        elec_battery_status:set(0)
    elseif elec_battery_status:get() > 1000 then
        elec_battery_status:set(1000)
    end

    if (inverter_statue == -1 or inverter_statue ~= elec_dc_status:get()) then
        inverter_statue = elec_dc_status:get()
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_ELECTRIC, inverter_statue)
    end
end

function post_initialize() --默认初始化函数
    --local dev = GetSelf()
    -- initial the elec system pointer for the radio
    str_ptr = string.sub(tostring(electric_system.link), 10)
    local set_elec_pointer = get_param_handle("ELEC_POINTER")
    set_elec_pointer:set(str_ptr)
    -- end of block
    elec_battery_status:set(1000)
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
        electric_system:AC_Generator_1_on(true)
        electric_system:AC_Generator_2_on(true)
        electric_system:DC_Battery_on(true)
        for k, v in pairs(display_target_status) do
            display_target_status[k][2] = SWITCH_ON
        end
        display_target_status[converter_emerg_converse][2] = SWITCH_OFF
        display_target_status[unknow1][2] = SWITCH_OFF
        display_target_status[unknow2][2] = SWITCH_OFF
    elseif birth == "GROUND_COLD" then
        electric_system:AC_Generator_1_on(false)
        electric_system:AC_Generator_2_on(false)
        electric_system:DC_Battery_on(false)
    end
    display_target_status[lid][2] = SWITCH_ON
    update_switch_status()
    update_elec_state()
end

function SetCommand(command, value)
    -- 最基础的航电功能监听
    local status = 0
    if command == Keys.InverterLeft then
        display_target_status[left_inverter_switch][2] = 1 - display_target_status[left_inverter_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.InverterRight then
        display_target_status[right_inverter_switch][2] = 1 - display_target_status[right_inverter_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.BatteryPower then
        display_target_status[main_power_switch][2] = 1 - display_target_status[main_power_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
        if display_target_status[main_power_switch][2] < 0.5 then
            electric_system:DC_Battery_on(false)
        else
            electric_system:DC_Battery_on(true)
        end
    elseif command == Keys.ElecPowerDCGenL then
        display_target_status[left_real_gen_switch][2] = 1 - display_target_status[left_real_gen_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
        if display_target_status[left_real_gen_switch][2] < 0.5 then
            electric_system:AC_Generator_1_on(false)
        else
            electric_system:AC_Generator_1_on(true)
        end
    elseif command == Keys.ElecPowerDCGenR then
        display_target_status[right_real_gen_switch][2] = 1 - display_target_status[right_real_gen_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
        if display_target_status[right_real_gen_switch][2] < 0.5 then
            electric_system:AC_Generator_2_on(false)
        else
            electric_system:AC_Generator_2_on(true)
        end
    elseif command == Keys.ADIPwr then
        display_target_status[adi_pwr][2] = 1 - display_target_status[adi_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.HSIPwr then
        display_target_status[hsi_pwr][2] = 1 - display_target_status[hsi_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.RadioAltPwr then
        display_target_status[radio_alt_pwr][2] = 1 - display_target_status[radio_alt_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.OilPressIndPwr then
        display_target_status[oil_hyd_pwr][2] = 1 - display_target_status[oil_hyd_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.EmergConverter then
        display_target_status[converter_emerg_converse][2] = 1 - display_target_status[converter_emerg_converse][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.WeaponPwr then
        display_target_status[weapon_pwr][2] = 1 - display_target_status[weapon_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.HUDPwr then
        display_target_status[hud_pwr][2] = 1 - display_target_status[hud_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.RWRPwr then
        display_target_status[rwr_pwr][2] = 1 - display_target_status[rwr_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.EjectPwr1 then
        display_target_status[eject_pwr1][2] = 1 - display_target_status[eject_pwr1][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.EjectPwr2 then
        display_target_status[eject_pwr2][2] = 1 - display_target_status[eject_pwr2][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.EjectPwr3 then
        display_target_status[eject_pwr3][2] = 1 - display_target_status[eject_pwr3][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.UnknownSwitch1 then
        display_target_status[unknow1][2] = 1 - display_target_status[unknow1][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.UnknownSwitch2 then
        display_target_status[unknow2][2] = 1 - display_target_status[unknow2][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.CameraGunPwrSwitch then
        display_target_status[camera_gun][2] = 1 - display_target_status[camera_gun][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.MissileWarmingSwitch then
        display_target_status[msl_warming][2] = 1 - display_target_status[msl_warming][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.MissileFilamentSwitch then
        display_target_status[msl_filament][2] = 1 - display_target_status[msl_filament][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.MissileLaunchSwitch then
        display_target_status[msl_launch][2] = 1 - display_target_status[msl_launch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon1Pwr then
        display_target_status[pylon1_pwr][2] = 1 - display_target_status[pylon1_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon2Pwr then
        display_target_status[pylon2_pwr][2] = 1 - display_target_status[pylon2_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon3Pwr then
        display_target_status[pylon3_pwr][2] = 1 - display_target_status[pylon3_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon4Pwr then
        display_target_status[pylon4_pwr][2] = 1 - display_target_status[pylon4_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon5Pwr then
        display_target_status[pylon5_pwr][2] = 1 - display_target_status[pylon5_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon6Pwr then
        display_target_status[pylon6_pwr][2] = 1 - display_target_status[pylon6_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.pylon7Pwr then
        display_target_status[pylon7_pwr][2] = 1 - display_target_status[pylon7_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.blackBoxPwr then
        display_target_status[blackBox_pwr][2] = 1 - display_target_status[blackBox_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.rspPwr then
        display_target_status[rsp_pwr][2] = 1 - display_target_status[rsp_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.apkPwr then
        display_target_status[apk_pwr][2] = 1 - display_target_status[apk_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.batteryHeating then
        display_target_status[battery_heating][2] = 1 - display_target_status[battery_heating][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.lidSow_Hide then
        display_target_status[lid][2] = 1 - display_target_status[lid][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
    end
end

function update_snd()
    if get_elec_ac_status() and not snd_list[avionics_AC_snd][2]:is_playing() then
        snd_list[avionics_AC_snd][2]:play_continue()
    elseif not get_elec_ac_status() then
        snd_list[avionics_AC_snd][2]:stop()
    end
end

local function update_click_view()
    if dis_play_current_status[lid][2] == SWITCH_ON then
        for i = pylon1_pwr, apk_pwr, 1 do
            local temp = get_clickable_element_reference(display_target_status[i][4])
            if temp ~= nil then
                temp:hide(true)
            end
        end
    else
        for i = pylon1_pwr, apk_pwr do
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
    handlePwrLoad()
    if get_elec_dc_status() or get_elec_ac_status() then
        updateWarningPanel()
    else
        for k, v in pairs(warning_panel_status) do
            v[2]=SWITCH_OFF
        end
    end
    drawingWarningPanel()
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
