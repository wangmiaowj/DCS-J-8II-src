dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."sounds_def.lua")
-- snd_device:performClickableAction(command,value,false)
 

local electric_system = GetSelf()
local dev = electric_system

local update_time_step = 0.02 --每秒50次调用update()函数
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local genLeftStatus = 0
local genRightStatus = 0
local batteryStatus = 0

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

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local main_power_switch = _switch_counter()--蓄电池
local left_real_gen_switch = _switch_counter()--左发电机
local right_real_gen_switch = _switch_counter()--右发电机
local left_inverter_switch = _switch_counter()--逆变器左
local right_inverter_switch = _switch_counter()--逆变器右
local battery_capacity = _switch_counter()--电池容量
local adi_pwr  = _switch_counter()--姿态仪供电
local hsi_pwr = _switch_counter()--罗盘供电
local radio_alt_pwr = _switch_counter()--无线电高度表供电
local oil_hyd_pwr = _switch_counter()--滑油压力表供电
local converter_emerg_converse = _switch_counter()--变流机应急转换
local weapon_pwr = _switch_counter()--武器供电
local hud_pwr = _switch_counter()--HUD供电
local rwr_pwr = _switch_counter()--RWR供电
local eject_pwr1 = _switch_counter()--弹射逃生系统供电1
local eject_pwr2 = _switch_counter()--弹射逃生系统供电2
local eject_pwr3 = _switch_counter()--弹射逃生系统供电3
local unknow1 = _switch_counter()
local unknow2 = _switch_counter()
local camera_gun = _switch_counter()--照相枪供电
local msl_warming = _switch_counter()--导弹加温供电
local msl_filament = _switch_counter()--导弹灯丝
local msl_launch = _switch_counter()--导弹发射

target_status = {
    {main_power_switch , SWITCH_OFF, get_param_handle("PNT_1001"), "PNT_1001"},
	{left_real_gen_switch , SWITCH_OFF, get_param_handle("PNT_1002"), "PNT_1002"},
    {right_real_gen_switch , SWITCH_OFF, get_param_handle("PNT_1003"), "PNT_1003"},
	{left_inverter_switch , SWITCH_OFF, get_param_handle("PNT_1004"), "PNT_1004"},
    {right_inverter_switch , SWITCH_OFF, get_param_handle("PNT_1005"), "PNT_1005"},
	{battery_capacity, 1000, get_param_handle("BATTERY_CAPACITY"), nil},
	{adi_pwr, SWITCH_OFF, get_param_handle("PNT_1006"), "PNT_1006"},
	{hsi_pwr, SWITCH_OFF, get_param_handle("PNT_1007"), "PNT_1007"},
	{radio_alt_pwr, SWITCH_OFF, get_param_handle("PNT_1008"), "PNT_1008"},
	{oil_hyd_pwr, SWITCH_OFF, get_param_handle("PNT_1009"), "PNT_1009"},
	{converter_emerg_converse, SWITCH_OFF, get_param_handle("PNT_1010"), "PNT_1010"},
	{weapon_pwr, SWITCH_OFF, get_param_handle("PNT_1011"), "PNT_1011"},
	{hud_pwr, SWITCH_OFF, get_param_handle("PNT_1012"), "PNT_1012"},
	{rwr_pwr, SWITCH_OFF, get_param_handle("PNT_1013"), "PNT_1013"},
	{eject_pwr1, SWITCH_OFF, get_param_handle("PNT_1014"), "PNT_1014"},
	{eject_pwr2, SWITCH_OFF, get_param_handle("PNT_1015"), "PNT_1015"},
	{eject_pwr3, SWITCH_OFF, get_param_handle("PNT_1016"), "PNT_1016"},
	{unknow1, SWITCH_OFF, get_param_handle("PNT_1017"), "PNT_1017"},
	{unknow2, SWITCH_OFF, get_param_handle("PNT_1018"), "PNT_1018"},
	{camera_gun, SWITCH_OFF, get_param_handle("PNT_1019"), "PNT_1019"},
	{msl_warming, SWITCH_OFF, get_param_handle("PNT_1020"), "PNT_1020"},
	{msl_filament, SWITCH_OFF, get_param_handle("PNT_1021"), "PNT_1021"},
	{msl_launch, SWITCH_OFF, get_param_handle("PNT_1022"), "PNT_1022"},
}

current_status = {
    {main_power_switch , SWITCH_OFF, SWITCH_OFF},
	{left_real_gen_switch , SWITCH_OFF, SWITCH_OFF},
    {right_real_gen_switch , SWITCH_OFF, SWITCH_OFF},
	{left_inverter_switch , SWITCH_OFF, SWITCH_OFF},
    {right_inverter_switch , SWITCH_OFF, SWITCH_OFF},
	{battery_capacity, 1000, 1000},
	{adi_pwr, SWITCH_OFF, SWITCH_OFF},
	{hsi_pwr, SWITCH_OFF, SWITCH_OFF},
	{radio_alt_pwr, SWITCH_OFF, SWITCH_OFF},
	{oil_hyd_pwr, SWITCH_OFF, SWITCH_OFF},
	{converter_emerg_converse, SWITCH_OFF, SWITCH_OFF},
	{weapon_pwr, SWITCH_OFF, SWITCH_OFF},
	{hud_pwr, SWITCH_OFF, SWITCH_OFF},
	{rwr_pwr, SWITCH_OFF, SWITCH_OFF},
	{eject_pwr1, SWITCH_OFF, SWITCH_OFF},
	{eject_pwr2, SWITCH_OFF, SWITCH_OFF},
	{eject_pwr3, SWITCH_OFF, SWITCH_OFF},
	{unknow1, SWITCH_OFF, SWITCH_OFF},
	{unknow2, SWITCH_OFF, SWITCH_OFF},
	{camera_gun, SWITCH_OFF, SWITCH_OFF},
	{msl_warming, SWITCH_OFF, SWITCH_OFF},
	{msl_filament, SWITCH_OFF, SWITCH_OFF},
	{msl_launch, SWITCH_OFF, SWITCH_OFF},
}
local snd_count = 0
local function _snd_counter()
    snd_count = snd_count + 1
    return snd_count
end

local avionics_AC_snd = _snd_counter()
local sndhost = create_sound_host("COCKPIT", "3D", 0, 0, 0)
local snd_list = {
    {avionics_AC_snd,sndhost:create_sound("Aircrafts/Cockpits/Avionics_AC_400Hz")},
}

function update_switch_status()
    local switch_moving_step = 0.15
    for k,v in pairs(target_status) do
        if target_status[k][1] ~= battery_capacity then
			if math.abs(target_status[k][2] - current_status[k][2]) < switch_moving_step then
				current_status[k][2] = target_status[k][2]
			elseif target_status[k][2] > current_status[k][2] then
				current_status[k][2] = current_status[k][2] + switch_moving_step
			elseif target_status[k][2] < current_status[k][2] then
				current_status[k][2] = current_status[k][2] - switch_moving_step
			end
		elseif target_status[k][1] == battery_capacity then
			current_status[k][2] = elec_battery_status:get()
		end
        target_status[k][3]:set(current_status[k][2])
		if target_status[k][4] ~= nil then
			local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
			temp_switch_ref:update()
		end
        -- print_message_to_user(k)
    end
end

local inverter_statue = -1

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
            elec_dc_status:set(1)
        else
            elec_dc_status:set(1)
        end
    else
        elec_dc_status:set(0)
    end

    if (electric_system:get_DC_Bus_1_voltage() > 0 or electric_system:get_DC_Bus_2_voltage() > 0) and (target_status[left_inverter_switch][2] == 1 or target_status[right_inverter_switch][2] == 1) then
        elec_ac_status:set(1)
    else
        elec_ac_status:set(0)
    end

    if (elec_dc_status:get() == 1 and elec_charging_status:get() == 0) then    
        if (elec_ac_status:get() == 1) then
            elec_battery_status:set(elec_battery_status:get()-0.02)
        else
            elec_battery_status:set(elec_battery_status:get()-0.01)
        end
    elseif (elec_charging_status:get() == 1) then
        elec_battery_status:set(elec_battery_status:get()+0.05)
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
    str_ptr = string.sub(tostring(electric_system.link),10)
    local set_elec_pointer = get_param_handle("ELEC_POINTER")
    set_elec_pointer:set(str_ptr)
    -- end of block
    elec_battery_status:set(1000)
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
        electric_system:AC_Generator_1_on(true)
        electric_system:AC_Generator_2_on(true)
        electric_system:DC_Battery_on(true)
        for k,v in pairs(target_status) do
			target_status[k][2] = SWITCH_ON
			current_status[k][2] = SWITCH_ON
		end
		target_status[unknow1][2] = SWITCH_OFF
		target_status[unknow2][2] = SWITCH_OFF
		current_status[unknow1][2] = SWITCH_OFF
		current_status[unknow2][2] = SWITCH_OFF
    elseif birth=="GROUND_COLD" then
        electric_system:AC_Generator_1_on(false) 
        electric_system:AC_Generator_2_on(false)
        electric_system:DC_Battery_on(false)
        for k,v in pairs(target_status) do
			target_status[k][2] = SWITCH_OFF
			current_status[k][2] = SWITCH_OFF
		end
    end
    update_switch_status()
    update_elec_state()
end

function SetCommand(command,value)
    -- 最基础的航电功能监听
    local status = 0
    if command == Keys.InverterLeft then
        target_status[left_inverter_switch][2] = 1 - target_status[left_inverter_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.InverterRight then
        target_status[right_inverter_switch][2] = 1 - target_status[right_inverter_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
    elseif command == Keys.BatteryPower then
        target_status[main_power_switch][2] = 1 - target_status[main_power_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
        if target_status[main_power_switch][2] < 0.5 then
            electric_system:DC_Battery_on(false)
        else
            electric_system:DC_Battery_on(true)
        end
    elseif command == Keys.ElecPowerDCGenL then
        target_status[left_real_gen_switch][2] = 1 - target_status[left_real_gen_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
        if target_status[left_real_gen_switch][2] < 0.5 then
            electric_system:AC_Generator_1_on(false)
        else
            electric_system:AC_Generator_1_on(true)
        end
    elseif command == Keys.ElecPowerDCGenR then
        target_status[right_real_gen_switch][2] = 1 - target_status[right_real_gen_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
        if target_status[right_real_gen_switch][2] < 0.5 then
            electric_system:AC_Generator_2_on(false)
        else
            electric_system:AC_Generator_2_on(true)
        end
	elseif command == Keys.ADIPwr then
        target_status[adi_pwr][2] = 1 - target_status[adi_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.HSIPwr then
        target_status[hsi_pwr][2] = 1 - target_status[hsi_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.RadioAltPwr then
        target_status[radio_alt_pwr][2] = 1 - target_status[radio_alt_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.OilPressIndPwr then
        target_status[oil_hyd_pwr][2] = 1 - target_status[oil_hyd_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.EmergConverter then
        target_status[converter_emerg_converse][2] = 1 - target_status[converter_emerg_converse][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.WeaponPwr then
        target_status[weapon_pwr][2] = 1 - target_status[weapon_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.HUDPwr then
        target_status[hud_pwr][2] = 1 - target_status[hud_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.RWRPwr then
        target_status[rwr_pwr][2] = 1 - target_status[rwr_pwr][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.EjectPwr1 then
        target_status[eject_pwr1][2] = 1 - target_status[eject_pwr1][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.EjectPwr2 then
        target_status[eject_pwr2][2] = 1 - target_status[eject_pwr2][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.EjectPwr3 then
        target_status[eject_pwr3][2] = 1 - target_status[eject_pwr3][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.UnknownSwitch1 then
        target_status[unknow1][2] = 1 - target_status[unknow1][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.UnknownSwitch2 then
        target_status[unknow2][2] = 1 - target_status[unknow2][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.CameraGunPwrSwitch then
        target_status[camera_gun][2] = 1 - target_status[camera_gun][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.MissileWarmingSwitch then
        target_status[msl_warming][2] = 1 - target_status[msl_warming][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.MissileFilamentSwitch then
        target_status[msl_filament][2] = 1 - target_status[msl_filament][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_RIGHT_PANEL, cockpit_sound.basic_switch)
	elseif command == Keys.MissileLaunchSwitch then
        target_status[msl_launch][2] = 1 - target_status[msl_launch][2]
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

function update() --刷新状态
    update_switch_status()
    update_elec_state()
    update_snd()
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