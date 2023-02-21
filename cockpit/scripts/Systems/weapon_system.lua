local WeaponSystem = GetSelf()
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
--dofile(LockOn_Options.script_path.."Systems/stores_config.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")
-- load wstype database to identify the weapon
dofile(LockOn_Options.common_script_path .. "../../../Database/wsTypes.lua")

local update_time_step = 0.02 --每秒50次刷新
make_default_activity(update_time_step)

local cannonAmmo = 200
local unlimit_weapon = false

local A2A_dg = {
    "{R-13M}", "{R-13M1}", "{R-3S}", "{R-60}", "{R-60M}", "{R-60M 2L}", "{R-60M 2R}", "{R-60 2L}", "{R-60 2R}", "{R-55}",
    "DIS_PL-5EII", "DIS_PL-8A",
}
local A2A_r = {
    "{R-3R}", "{Aspide_MK1}", "DIS_PL-12", "{AIM-7F}","{LSWM_AA}"
}

local iCommandPlaneFire = 84
local iCommandPlaneFireOff = 85

local gun_piper_available = get_param_handle('WS_GUN_PIPER_AVAILABLE')
local gun_piper_az = get_param_handle('WS_GUN_PIPER_AZIMUTH')
local gun_piper_el = get_param_handle('WS_GUN_PIPER_ELEVATION')
local gun_piper_span = get_param_handle('WS_GUN_PIPER_SPAN')

local rocket_piper_available = get_param_handle('WS_ROCKET_PIPER_AVAILABLE')
local rocket_piper_az = get_param_handle('WS_ROCKET_PIPER_AZIMUTH')
local rocket_piper_el = get_param_handle('WS_ROCKET_PIPER_ELEVATION')

local target_range = get_param_handle('WS_TARGET_RANGE')
local target_span = get_param_handle('WS_TARGET_SPAN')

local dlz_min = get_param_handle('WS_DLZ_MIN')
local dlz_authorized = get_param_handle('WS_DLZ_AUTHORIZED')
local dlz_max = get_param_handle('WS_DLZ_MAX')

local gun_ccip_dis_enable = get_param_handle('GUN_CCIP_DIS_ENABLE')
local gun_ccip_x = get_param_handle('GUN_CCIP_X')
local gun_ccip_y = get_param_handle('GUN_CCIP_Y')

local rocket_ccip_dis_enable = get_param_handle('ROCKET_CCIP_DIS_ENABLE')
local rocket_ccip_x = get_param_handle('ROCKET_CCIP_X')
local rocket_ccip_y = get_param_handle('ROCKET_CCIP_Y')

local bomb_ccip_dis_enable = get_param_handle('BOMB_CCIP_DIS_ENABLE')
local bomb_ccip_x = get_param_handle('BOMB_CCIP_X')
local bomb_ccip_y = get_param_handle('BOMB_CCIP_Y')

-- 获取红外弹目标锁定状态
local ir_missile_lock_param = get_param_handle("WS_IR_MISSILE_LOCK")-- 是否锁定
local ir_missile_az_param = get_param_handle("WS_IR_MISSILE_TARGET_AZIMUTH")-- 锁定的目标的高程
local ir_missile_el_param = get_param_handle("WS_IR_MISSILE_TARGET_ELEVATION")-- 锁定的目标的方向

--红外弹引导头相关
local ir_missile_des_az_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH")-- 红外弹引导头高程
local ir_missile_des_el_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION")-- 红外弹引导头方向

local params_count = get_param_handle('WS_PARAMS_COUNT')

local weaponPwrSwitch = get_param_handle('PNT_1011')

local target_round_dis = get_param_handle('TARGET_ROUND_DIS_ENABLE')
local target_round_x = get_param_handle('TARGET_ROUND_X')
local target_round_y = get_param_handle('TARGET_ROUND_Y')
local hud_dis=get_param_handle("HUD_DIS_ENABLE")
local gun_grid = get_param_handle('GUN_GRID')
local ecmHandle = get_param_handle('ECM')

local dbg_param = { 
    get_param_handle("WeaponSystemDebug_INV"), 
    get_param_handle("WeaponSystemDebug_QTY"),
    get_param_handle("WeaponSystemDebug_MULT"),
    get_param_handle("WeaponSystemDebug_BOMB_COUNT"),
    get_param_handle("WeaponSystemDebug_BOMB_LAUNCH_TIME"),
}

WeaponSystem:listen_command(Keys.WeaponLaunchOn)
WeaponSystem:listen_command(Keys.WeaponLaunchOff)
WeaponSystem:listen_command(Keys.WeaponMasterSwitch)
WeaponSystem:listen_command(Keys.Pylon1SelUP)
WeaponSystem:listen_command(Keys.Pylon1SelDOWN)
WeaponSystem:listen_command(Keys.Pylon2SelUP)
WeaponSystem:listen_command(Keys.Pylon2SelDOWN)
WeaponSystem:listen_command(Keys.Pylon3SelUP)
WeaponSystem:listen_command(Keys.Pylon3SelDOWN)
WeaponSystem:listen_command(Keys.Pylon4SelUP)
WeaponSystem:listen_command(Keys.Pylon4SelDOWN)
WeaponSystem:listen_command(Keys.Pylon5SelUP)
WeaponSystem:listen_command(Keys.Pylon5SelDOWN)
WeaponSystem:listen_command(Keys.Pylon6SelUP)
WeaponSystem:listen_command(Keys.Pylon6SelDOWN)
WeaponSystem:listen_command(Keys.Pylon7SelUP)
WeaponSystem:listen_command(Keys.Pylon7SelDOWN)
WeaponSystem:listen_command(Keys.QuantityTumbWheel10_UP)
WeaponSystem:listen_command(Keys.QuantityTumbWheel10_DN)
WeaponSystem:listen_command(Keys.QuantityTumbWheel_UP)
WeaponSystem:listen_command(Keys.QuantityTumbWheel_DN)
WeaponSystem:listen_command(Keys.IntervalTumbWheel100_UP)
WeaponSystem:listen_command(Keys.IntervalTumbWheel100_DN)
WeaponSystem:listen_command(Keys.IntervalTumbWheel10_UP)
WeaponSystem:listen_command(Keys.IntervalTumbWheel10_DN)
WeaponSystem:listen_command(Keys.IntervalTumbWheel_UP)
WeaponSystem:listen_command(Keys.IntervalTumbWheel_DN)
WeaponSystem:listen_command(Keys.MultTumbWheel10_UP)
WeaponSystem:listen_command(Keys.MultTumbWheel10_DN)
WeaponSystem:listen_command(Keys.MultTumbWheel_UP)
WeaponSystem:listen_command(Keys.MultTumbWheel_DN)
WeaponSystem:listen_command(Keys.HK_R_Up)
WeaponSystem:listen_command(Keys.HK_R_Down)
WeaponSystem:listen_command(Keys.ToGun)
WeaponSystem:listen_command(Keys.ToAAMIr)
WeaponSystem:listen_command(Keys.ToAAMRdr)
WeaponSystem:listen_command(Keys.PlaneDropSnarOnce)
WeaponSystem:listen_command(Keys.PlaneDropFlareOnce)
WeaponSystem:listen_command(Keys.PlaneDropChaffOnce)

local c = 0

----rest are for pylon drop tank checking and will send to parameters

local LAUNCH_MODE = 0 -- 未选择:0; 红外弹: 1; 中距弹: 2; 机炮: 3; 火箭弹: 4; 炸弹: 5; 6: A2G弹; 7:拉烟弹
local INTERVAL_SET = 0
local QUANTITY_SET = 0
local MULT_SET = 0
local MANUAL_RELEASE_SIGNAL = 0
local FIREHOLD = 0
local isFire = 0

local SELECTED_LIST = {
    -- {is_launch, pylon launch number, select_light}
    { 0, 0, get_param_handle("PNT_1266") },
    { 0, 0, get_param_handle("PNT_1267") },
    { 0, 0, get_param_handle("PNT_2267") },
    { 0, 0, get_param_handle("PNT_1268") },
    { 0, 0, get_param_handle("PNT_2269") },
    { 0, 0, get_param_handle("PNT_1269") },
    { 0, 0, get_param_handle("PNT_1270") },
}

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1


local switch_count = 0
local function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local master_arm_switch = _switch_counter()
local pylon1_select_switch = _switch_counter()
local pylon2_select_switch = _switch_counter()
local pylon3_select_switch = _switch_counter()
local pylon4_select_switch = _switch_counter()
local pylon5_select_switch = _switch_counter()
local pylon6_select_switch = _switch_counter()
local pylon7_select_switch = _switch_counter()

local attack_interval_A = _switch_counter()
local attack_interval_B = _switch_counter()
local attack_interval_C = _switch_counter()
local attack_quantity_B = _switch_counter()
local attack_quantity_C = _switch_counter()
local attack_multi_A = _switch_counter()
local attack_multi_B = _switch_counter()

local attack_gcb_mode = _switch_counter()
local attack_delay_mode = _switch_counter()
local attack_labtgt_mode = _switch_counter()
local attack_labip_mode = _switch_counter()
local attack_rocket_mode = _switch_counter()
local attack_hiloft_mode = _switch_counter()
local attack_straight_mode = _switch_counter()
local attack_general_mode = _switch_counter()

local missile_control_switch = _switch_counter()
local missile_cooling_switch = _switch_counter()

local guns_mode_switch = _switch_counter()
local weapon_mode = _switch_counter()

local target_status = {
    { master_arm_switch, SWITCH_OFF, get_param_handle("PNT_1203"), "PNT_1203" },
    { pylon1_select_switch, SWITCH_OFF, get_param_handle("PNT_1261"), "PNT_1261" },
    { pylon2_select_switch, SWITCH_OFF, get_param_handle("PNT_1262"), "PNT_1262" },
    { pylon3_select_switch, SWITCH_OFF, get_param_handle("PNT_2263"), "PNT_2263" },
    { pylon4_select_switch, SWITCH_OFF, get_param_handle("PNT_1263"), "PNT_1263" },
    { pylon5_select_switch, SWITCH_OFF, get_param_handle("PNT_2264"), "PNT_2264" },
    { pylon6_select_switch, SWITCH_OFF, get_param_handle("PNT_1264"), "PNT_1264" },
    { pylon7_select_switch, SWITCH_OFF, get_param_handle("PNT_1265"), "PNT_1265" },
    { attack_interval_A, SWITCH_OFF, get_param_handle("PNT_1298"), "PNT_1298" },
    { attack_interval_B, SWITCH_OFF, get_param_handle("PNT_1299"), "PNT_1299" },
    { attack_interval_C, SWITCH_OFF, get_param_handle("PNT_1300"), "PNT_1300" },
    { attack_quantity_B, SWITCH_OFF, get_param_handle("PNT_1294"), "PNT_1294" },
    { attack_quantity_C, SWITCH_OFF, get_param_handle("PNT_1295"), "PNT_1295" },
    { attack_multi_A, SWITCH_OFF, get_param_handle("PNT_1296"), "PNT_1296" },
    { attack_multi_B, SWITCH_OFF, get_param_handle("PNT_1297"), "PNT_1297" },
    { attack_gcb_mode, SWITCH_OFF, get_param_handle("PTN_539"), "PTN_539" },
    { attack_delay_mode, SWITCH_OFF, get_param_handle("PTN_540"), "PTN_540" },
    { attack_labtgt_mode, SWITCH_OFF, get_param_handle("PTN_541"), "PTN_541" },
    { attack_labip_mode, SWITCH_OFF, get_param_handle("PTN_542"), "PTN_542" },
    { attack_rocket_mode, SWITCH_OFF, get_param_handle("PTN_543"), "PTN_543" },
    { attack_hiloft_mode, SWITCH_OFF, get_param_handle("PTN_544"), "PTN_544" },
    { attack_straight_mode, SWITCH_OFF, get_param_handle("PTN_545"), "PTN_545" },
    { attack_general_mode, SWITCH_OFF, get_param_handle("PTN_546"), "PTN_546" },
    { missile_control_switch, SWITCH_OFF, get_param_handle("PTN_558"), "PTN_558" },
    { missile_cooling_switch, SWITCH_OFF, get_param_handle("PTN_559"), "PTN_559" },
    { guns_mode_switch, SWITCH_OFF, get_param_handle("PTN_549"), "PTN_549" },
    { weapon_mode, SWITCH_OFF, get_param_handle("PNT_1204"), "PNT_1204" }
}

local current_status = {
    { master_arm_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon1_select_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon2_select_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon3_select_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon4_select_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon5_select_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon6_select_switch, SWITCH_OFF, SWITCH_OFF },
    { pylon7_select_switch, SWITCH_OFF, SWITCH_OFF },
    { attack_interval_A, SWITCH_OFF, },
    { attack_interval_B, SWITCH_OFF, },
    { attack_interval_C, SWITCH_OFF, },
    { attack_quantity_B, SWITCH_OFF, },
    { attack_quantity_C, SWITCH_OFF, },
    { attack_multi_A, SWITCH_OFF, },
    { attack_multi_B, SWITCH_OFF, },
    { attack_gcb_mode, SWITCH_OFF, },
    { attack_delay_mode, SWITCH_OFF, },
    { attack_labtgt_mode, SWITCH_OFF, },
    { attack_labip_mode, SWITCH_OFF, },
    { attack_rocket_mode, SWITCH_OFF, },
    { attack_hiloft_mode, SWITCH_OFF, },
    { attack_straight_mode, SWITCH_OFF, },
    { attack_general_mode, SWITCH_OFF, },
    { missile_control_switch, SWITCH_OFF, },
    { missile_cooling_switch, SWITCH_OFF, },
    { guns_mode_switch, SWITCH_OFF, },
    { weapon_mode, SWITCH_OFF, },
}

local num_count = 0
local function _num_counter()
    num_count = num_count + 1
    return num_count
end

local pylon1_ammos_10 = _num_counter()
local pylon1_ammos_1 = _num_counter()
local pylon2_ammos_10 = _num_counter()
local pylon2_ammos_1 = _num_counter()
local pylon3_ammos_10 = _num_counter()
local pylon3_ammos_1 = _num_counter()
local pylon4_ammos_10 = _num_counter()
local pylon4_ammos_1 = _num_counter()
local pylon5_ammos_10 = _num_counter()
local pylon5_ammos_1 = _num_counter()
local pylon6_ammos_10 = _num_counter()
local pylon6_ammos_1 = _num_counter()
local pylon7_ammos_10 = _num_counter()
local pylon7_ammos_1 = _num_counter()
local gun_ammo_100 = _num_counter()
local gun_ammo_10 = _num_counter()
local gun_ammo_1 = _num_counter()
local atk_qty_ammos_10 = _num_counter()
local atk_qty_ammos_1 = _num_counter()
local atk_mult_ammos_10 = _num_counter()
local atk_mult_ammos_1 = _num_counter()
local atk_int_ammos_100 = _num_counter()
local atk_int_ammos_10 = _num_counter()
local atk_int_ammos_1 = _num_counter()

local num_target = {
    { pylon1_ammos_10, 0, get_param_handle('PNT_1271') },
    { pylon1_ammos_1, 0, get_param_handle('PNT_1272') },
    { pylon2_ammos_10, 0, get_param_handle('PNT_1273') },
    { pylon2_ammos_1, 0, get_param_handle('PNT_1274') },
    { pylon3_ammos_10, 0, get_param_handle('PNT_2273') },
    { pylon3_ammos_1, 0, get_param_handle('PNT_2274') },
    { pylon4_ammos_10, 0, get_param_handle('PNT_1275') },
    { pylon4_ammos_1, 0, get_param_handle('PNT_1276') },
    { pylon5_ammos_10, 0, get_param_handle('PNT_2277') },
    { pylon5_ammos_1, 0, get_param_handle('PNT_2278') },
    { pylon6_ammos_10, 0, get_param_handle('PNT_1277') },
    { pylon6_ammos_1, 0, get_param_handle('PNT_1278') },
    { pylon7_ammos_10, 0, get_param_handle('PNT_1279') },
    { pylon7_ammos_1, 0, get_param_handle('PNT_1280') },
    { gun_ammo_100, 0, get_param_handle('PNT_1281') },
    { gun_ammo_10, 0, get_param_handle('PNT_1282') },
    { gun_ammo_1, 0, get_param_handle('PNT_1283') },
    { atk_qty_ammos_10, 0, get_param_handle('PNT_1284') },
    { atk_qty_ammos_1, 0, get_param_handle('PNT_1285') },
    { atk_mult_ammos_10, 0, get_param_handle('PNT_1286') },
    { atk_mult_ammos_1, 0, get_param_handle('PNT_1287') },
    { atk_int_ammos_100, 0, get_param_handle('PNT_1288') },
    { atk_int_ammos_10, 0, get_param_handle('PNT_1289') },
    { atk_int_ammos_1, 0, get_param_handle('PNT_1290') },
}

local num_current = {
    { pylon1_ammos_10, 0, 99 },
    { pylon1_ammos_1, 0, 99 },
    { pylon2_ammos_10, 0, 99 },
    { pylon2_ammos_1, 0, 99 },
    { pylon3_ammos_10, 0, 99 },
    { pylon3_ammos_1, 0, 99 },
    { pylon4_ammos_10, 0, 99 },
    { pylon4_ammos_1, 0, 99 },
    { pylon5_ammos_10, 0, 99 },
    { pylon5_ammos_1, 0, 99 },
    { pylon6_ammos_10, 0, 99 },
    { pylon6_ammos_1, 0, 99 },
    { pylon7_ammos_10, 0, 99 },
    { pylon7_ammos_1, 0, 99 },
    { gun_ammo_100, 0, 999 },
    { gun_ammo_10, 0, 999 },
    { gun_ammo_1, 0, 999 },
    { atk_qty_ammos_10, 0, 99 },
    { atk_qty_ammos_1, 0, 99 },
    { atk_mult_ammos_10, 0, 99 },
    { atk_mult_ammos_1, 0, 99 },
    { atk_int_ammos_100, 0, 999 },
    { atk_int_ammos_10, 0, 999 },
    { atk_int_ammos_1, 0, 999 },
}

local snd_count = 0
local function _snd_counter()
    snd_count = snd_count + 1
    return snd_count
end

local sidewinder_high = _snd_counter()
local sidewinder_low = _snd_counter()
local sidewinder_quiet = _snd_counter()
local msl_launch_in = _snd_counter()
local drop_weapon = _snd_counter()
local flare_snd = _snd_counter()
local chaff_snd = _snd_counter()

local snd_list = {}

local function initSnd()
    local sndHeadPhonehost = create_sound_host("COCKPIT_SIDEWINDER", "HEADPHONES", 0, 0, 0)
    local sndhost = create_sound_host("COCKPIT", "3D", 0, 0, 0)
    snd_list[sidewinder_high] = { sidewinder_high, sndHeadPhonehost:create_sound("Aircrafts/Cockpits/SidewinderHigh") }
    snd_list[sidewinder_high][2]:update(1,1,1)
    snd_list[sidewinder_low] = { sidewinder_low, sndHeadPhonehost:create_sound("Aircrafts/Cockpits/SidewinderLow") }
    snd_list[sidewinder_low][2]:update(1,1,1)
    snd_list[sidewinder_quiet] = { sidewinder_quiet, sndHeadPhonehost:create_sound("Aircrafts/Cockpits/SidewinderLowQuiet") }
    snd_list[sidewinder_quiet][2]:update(1,1,1)
    snd_list[msl_launch_in] = { msl_launch_in, sndhost:create_sound("Weapons/MissileShootIn") }
    snd_list[drop_weapon] = { drop_weapon, sndhost:create_sound("Aircrafts/DropWeaponIn") }
    snd_list[flare_snd] = { flare_snd, sndhost:create_sound("Aircrafts/Cockpits/FlareIn") }
    snd_list[chaff_snd] = { chaff_snd, sndhost:create_sound("Weapons/Snare") }
end

local function ammo_count_cal()
    for i = 0, 6, 1 do
        local pylon_num = i
        local pylon_info = WeaponSystem:get_station_info(pylon_num)
        local num_x10 = 0
        local num_x1 = 0
        if pylon_info ~= nil then
            local ammo_count = pylon_info.count
            num_x10 = math.floor(ammo_count / 10) / 10
            num_x1 = math.floor(ammo_count % 10) / 10
        end
        num_target[2 * i + 1][2] = num_x10
        num_target[2 * i + 2][2] = num_x1
    end
end

local function calGunAmmo()
    if get_elec_ac_status() and weaponPwrSwitch:get() == SWITCH_ON and LAUNCH_MODE == 3 and isFire == 1 and FIREHOLD >=0.04 and math.floor((FIREHOLD*100)%4) == 0 and not unlimit_weapon then
        cannonAmmo = cannonAmmo -1
    end
    num_target[gun_ammo_100][2] = math.floor(cannonAmmo/100) * 0.1
    num_target[gun_ammo_10][2] = math.floor(cannonAmmo %100/10)*0.1
    num_target[gun_ammo_1][2] = math.floor(cannonAmmo % 10) * 0.1
end

local function update_num_anim()
    for k, v in pairs(num_target) do
        num_current[k][2] = num_target[k][2]
        num_target[k][3]:set(num_current[k][2])
    end
end

local PYLON_INFO_LIST = {}

local pylon_is_tank = {
    get_param_handle("pylon_rout"),
    get_param_handle("pylon_rin"),
    get_param_handle("pylon_ctr"),
    get_param_handle("pylon_lin"),
    get_param_handle("pylon_lout"),
}

local function check_externel_tank_status()
    local pylonSelection
    for pylonSelection = 0, 6, 1 do
        local station = WeaponSystem:get_station_info(pylonSelection)
        if (station.CLSID == "{5f5a94ef-a4d7-464e-8d80-b40e6cd6c264}") then
            pylon_is_tank[pylonSelection + 1]:set(1)
        end
    end
end

local function update_display_light()
    for k, v in pairs(SELECTED_LIST) do
        SELECTED_LIST[k][3]:set(SELECTED_LIST[k][1])
    end
end

----end of transfer pylon tank status

local function update_Pylon_list()
    local pylonSelection
    for pylonSelection = 0, 6, 1 do
        local station_data = WeaponSystem:get_station_info(pylonSelection)
        PYLON_INFO_LIST[pylonSelection + 1] = { station_data.weapon.level2, station_data.weapon.level3,
            station_data.count }
    end
end

--[[
local tablePrinted = {}
local file = io.open("e:\\00_00_00_海外组_学习\\挂架.txt", "w")
assert(file)
function printTableItem(k, v, level)
    for i = 1, level do
        file:write("\t")
    end
    file:write(tostring(k) .. " = " .. tostring(v) .. "\r\n")
    if type(v) == "table" then
        if not tablePrinted[v] then
            tablePrinted[v] = true
            for k, v in pairs(v) do
                printTableItem(k, v, level + 1)
            end
        end
    end
end

--]]
function post_initialize()
    update_Pylon_list()
    check_externel_tank_status()
    initSnd()
    unlimit_weapon = LockOn_Options.flight.unlimited_weapons
    --printTableItem("LockOn_Options",LockOn_Options,0)
end

function getPylonInfo()

end

local function drop_flare()
    WeaponSystem:drop_flare(2)
    snd_list[flare_snd][2]:play_once()
end

local function drop_chaff()
    WeaponSystem:drop_chaff(1)
    snd_list[chaff_snd][2]:play_once()
end

function SetCommand(command, value)
    if (command == Keys.WeaponLaunchOn) then
        MANUAL_RELEASE_SIGNAL = 1
    elseif (command == Keys.WeaponLaunchOff) then
        MANUAL_RELEASE_SIGNAL = 0
        FIREHOLD = 0
        isFire = 0
        dispatch_action(nil, iCommandPlaneFireOff, 1)
    elseif (command == Keys.WeaponMasterSwitch) then
        target_status[master_arm_switch][2] = 1 - target_status[master_arm_switch][2]
    elseif (command == Keys.Pylon1SelUP) then
        target_status[pylon1_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon1SelDOWN) then
        target_status[pylon1_select_switch][2] = SWITCH_OFF
        --2
    elseif (command == Keys.Pylon2SelUP) then
        target_status[pylon2_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon2SelDOWN) then
        target_status[pylon2_select_switch][2] = SWITCH_OFF
        -- 3
    elseif (command == Keys.Pylon3SelUP) then
        target_status[pylon3_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon3SelDOWN) then
        target_status[pylon3_select_switch][2] = SWITCH_OFF
        -- 4
    elseif (command == Keys.Pylon4SelUP) then
        target_status[pylon4_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon4SelDOWN) then
        target_status[pylon4_select_switch][2] = SWITCH_OFF
        -- 5
    elseif (command == Keys.Pylon5SelUP) then
        target_status[pylon5_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon5SelDOWN) then
        target_status[pylon5_select_switch][2] = SWITCH_OFF
        -- 6
    elseif (command == Keys.Pylon6SelUP) then
        target_status[pylon6_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon6SelDOWN) then
        target_status[pylon6_select_switch][2] = SWITCH_OFF
        -- 7
    elseif (command == Keys.Pylon7SelUP) then
        target_status[pylon7_select_switch][2] = SWITCH_ON
    elseif (command == Keys.Pylon7SelDOWN) then
        target_status[pylon7_select_switch][2] = SWITCH_OFF
        -- tumb wheel
    elseif command == Keys.IntervalTumbWheel100_UP then
        if target_status[attack_interval_A][2] < 1 then
            if target_status[attack_interval_A][2] + 1 >= 1 then
                target_status[attack_interval_A][2] = 1
                if num_target[atk_int_ammos_100][2] + 0.1 > 0.9 then
                    num_target[atk_int_ammos_100][2] = 0
                else
                    num_target[atk_int_ammos_100][2] = num_target[atk_int_ammos_100][2] + 0.1
                end
            else
                target_status[attack_interval_A][2] = target_status[attack_interval_A][2] + 1
            end
        end
    elseif command == Keys.IntervalTumbWheel100_DN then
        if target_status[attack_interval_A][2] > -1 then
            if target_status[attack_interval_A][2] - 1 <= -1 then
                target_status[attack_interval_A][2] = -1
                if num_target[atk_int_ammos_100][2] - 0.1 < 0 then
                    num_target[atk_int_ammos_100][2] = 0.9
                else
                    num_target[atk_int_ammos_100][2] = num_target[atk_int_ammos_100][2] - 0.1
                end
            else
                target_status[attack_interval_A][2] = target_status[attack_interval_A][2] - 1
            end
        end
    elseif command == Keys.IntervalTumbWheel10_UP then
        if target_status[attack_interval_B][2] < 1 then
            if target_status[attack_interval_B][2] + 1 >= 1 then
                if num_target[atk_int_ammos_10][2] + 0.1 > 0.9 then
                    num_target[atk_int_ammos_10][2] = 0
                else
                    num_target[atk_int_ammos_10][2] = num_target[atk_int_ammos_10][2] + 0.1
                end
                target_status[attack_interval_B][2] = 1
            else
                target_status[attack_interval_B][2] = target_status[attack_interval_B][2] + 1
            end
        end
    elseif command == Keys.IntervalTumbWheel10_DN then
        if target_status[attack_interval_B][2] > -1 then
            if target_status[attack_interval_B][2] - 1 <= -1 then
                target_status[attack_interval_B][2] = -1
                if num_target[atk_int_ammos_10][2] - 0.1 < 0 then
                    num_target[atk_int_ammos_10][2] = 0.9
                else
                    num_target[atk_int_ammos_10][2] = num_target[atk_int_ammos_10][2] - 0.1
                end
            else
                target_status[attack_interval_B][2] = target_status[attack_interval_B][2] - 1
            end
        end
    elseif command == Keys.IntervalTumbWheel_UP then
        if target_status[attack_interval_C][2] < 1 then
            if target_status[attack_interval_C][2] + 1 >= 1 then
                if num_target[atk_int_ammos_1][2] + 0.1 > 0.9 then
                    num_target[atk_int_ammos_1][2] = 0
                else
                    num_target[atk_int_ammos_1][2] = num_target[atk_int_ammos_1][2] + 0.1
                end
                target_status[attack_interval_C][2] = 1
            else
                target_status[attack_interval_C][2] = target_status[attack_interval_C][2] + 1
            end
        end
    elseif command == Keys.IntervalTumbWheel_DN then
        if target_status[attack_interval_C][2] > -1 then
            if target_status[attack_interval_C][2] - 1 <= -1 then
                if num_target[atk_int_ammos_1][2] - 0.1 < 0 then
                    num_target[atk_int_ammos_1][2] = 0.9
                else
                    num_target[atk_int_ammos_1][2] = num_target[atk_int_ammos_1][2] - 0.1
                end
                target_status[attack_interval_C][2] = -1
            else
                target_status[attack_interval_C][2] = target_status[attack_interval_C][2] - 1
            end
        end
    elseif command == Keys.QuantityTumbWheel10_UP then
        if target_status[attack_quantity_B][2] < 1 then
            if target_status[attack_quantity_B][2] + 1 >= 1 then
                target_status[attack_quantity_B][2] = 1
                if num_target[atk_qty_ammos_10][2] + 0.1 > 0.9 then
                    num_target[atk_qty_ammos_10][2] = 0
                else
                    num_target[atk_qty_ammos_10][2] = num_target[atk_qty_ammos_10][2] + 0.1
                end
            else
                target_status[attack_quantity_B][2] = target_status[attack_quantity_B][2] + 1
            end
        end
    elseif command == Keys.QuantityTumbWheel10_DN then
        if target_status[attack_quantity_B][2] > -1 then
            if target_status[attack_quantity_B][2] - 1 <= -1 then
                target_status[attack_quantity_B][2] = -1
                if num_target[atk_qty_ammos_10][2] - 0.1 < 0 then
                    num_target[atk_qty_ammos_10][2] = 0.9
                else
                    num_target[atk_qty_ammos_10][2] = num_target[atk_qty_ammos_10][2] - 0.1
                end
            else
                target_status[attack_quantity_B][2] = target_status[attack_quantity_B][2] - 1
            end
        end
    elseif command == Keys.QuantityTumbWheel_UP then
        if target_status[attack_quantity_C][2] < 1 then
            if target_status[attack_quantity_C][2] + 1 >= 1 then
                target_status[attack_quantity_C][2] = 1
                if num_target[atk_qty_ammos_1][2] + 0.1 > 0.9 then
                    num_target[atk_qty_ammos_1][2] = 0
                else
                    num_target[atk_qty_ammos_1][2] = num_target[atk_qty_ammos_1][2] + 0.1
                end
            else
                target_status[attack_quantity_C][2] = target_status[attack_quantity_C][2] + 1
            end
        end
    elseif command == Keys.QuantityTumbWheel_DN then
        if target_status[attack_quantity_C][2] > -1 then
            if target_status[attack_quantity_C][2] - 1 <= -1 then
                target_status[attack_quantity_C][2] = -1
                if num_target[atk_qty_ammos_1][2] - 0.1 < 0 then
                    num_target[atk_qty_ammos_1][2] = 0.9
                else
                    num_target[atk_qty_ammos_1][2] = num_target[atk_qty_ammos_1][2] - 0.1
                end
            else
                target_status[attack_quantity_C][2] = target_status[attack_quantity_C][2] - 1
            end
        end
    elseif command == Keys.MultTumbWheel10_UP then
        if target_status[attack_multi_A][2] < 1 then
            if target_status[attack_multi_A][2] + 1 >= 1 then
                target_status[attack_multi_A][2] = 1
                if num_target[atk_mult_ammos_10][2] + 0.1 > 0.9 then
                    num_target[atk_mult_ammos_10][2] = 0
                else
                    num_target[atk_mult_ammos_10][2] = num_target[atk_mult_ammos_10][2] + 0.1
                end
            else
                target_status[attack_multi_A][2] = target_status[attack_multi_A][2] + 1
            end
        end
    elseif command == Keys.MultTumbWheel10_DN then
        if target_status[attack_multi_A][2] > -1 then
            if target_status[attack_multi_A][2] - 1 <= -1 then
                target_status[attack_multi_A][2] = -1
                if num_target[atk_mult_ammos_10][2] - 0.1 < 0 then
                    num_target[atk_mult_ammos_10][2] = 0.9
                else
                    num_target[atk_mult_ammos_10][2] = num_target[atk_mult_ammos_10][2] - 0.1
                end
            else
                target_status[attack_multi_A][2] = target_status[attack_multi_A][2] - 1
            end
        end
    elseif command == Keys.MultTumbWheel_UP then
        --print_message_to_user(command..":"..value..":"..target_status[attack_multi_B][2])
        if target_status[attack_multi_B][2] < 1 then
            if target_status[attack_multi_B][2] + 1 >= 1 then
                target_status[attack_multi_B][2] = 1
                if num_target[atk_mult_ammos_1][2] + 0.1 > 0.9 then
                    num_target[atk_mult_ammos_1][2] = 0
                else
                    num_target[atk_mult_ammos_1][2] = num_target[atk_mult_ammos_1][2] + 0.1
                end
            else
                target_status[attack_multi_B][2] = target_status[attack_multi_B][2] + 1
            end
        end
    elseif command == Keys.MultTumbWheel_DN then
        if target_status[attack_multi_B][2] > -1 then
            if target_status[attack_multi_B][2] - 1 <= -1 then
                target_status[attack_multi_B][2] = -1
                if num_target[atk_mult_ammos_1][2] - 0.1 < 0 then
                    num_target[atk_mult_ammos_1][2] = 0.9
                else
                    num_target[atk_mult_ammos_1][2] = num_target[atk_mult_ammos_1][2] - 0.1
                end
            else
                target_status[attack_multi_B][2] = target_status[attack_multi_B][2] - 1
            end
        end
    elseif command == Keys.MissileControl then
        target_status[missile_control_switch][2] = 1 - target_status[missile_control_switch][2]
    elseif command == Keys.MissileCoolingUP then
        if target_status[missile_cooling_switch][2] < 0.5 then
            target_status[missile_cooling_switch][2] = target_status[missile_cooling_switch][2] + 1
        end
    elseif command == Keys.MissileCoolingDOWN then
        if target_status[missile_cooling_switch][2] > -0.5 then
            target_status[missile_cooling_switch][2] = target_status[missile_cooling_switch][2] - 1
        end
    elseif command == Keys.GunsModeSwitchUP then
        if target_status[guns_mode_switch][2] < 0.5 then
            target_status[guns_mode_switch][2] = target_status[guns_mode_switch][2] + 1
        end
    elseif command == Keys.GunsModeSwitchDOWN then
        if target_status[guns_mode_switch][2] > -0.5 then
            target_status[guns_mode_switch][2] = target_status[guns_mode_switch][2] - 1
        end
    elseif command == Keys.HK_R_Up then
        if target_status[weapon_mode][2] < 1 then
            if target_status[weapon_mode][2] + 0.14 > 0.97 then
                target_status[weapon_mode][2] = 1
            else
                target_status[weapon_mode][2] = target_status[weapon_mode][2] + 0.14
            end
            LAUNCH_MODE = LAUNCH_MODE + 1
        end
    elseif command == Keys.HK_R_Down then
        if target_status[weapon_mode][2] > 0 then
            if target_status[weapon_mode][2] - 0.14 < 0.03 then
                target_status[weapon_mode][2] = 0
            else
                target_status[weapon_mode][2] = target_status[weapon_mode][2] - 0.14
            end
            LAUNCH_MODE = LAUNCH_MODE - 1
        end
    elseif command == Keys.ToGun then
        target_status[weapon_mode][2] = 0.14 * 3
        LAUNCH_MODE = 3
    elseif command == Keys.ToAAMRdr then
        target_status[weapon_mode][2] = 0.14 * 2
        LAUNCH_MODE = 2
    elseif command == Keys.ToAAMIr then
        target_status[weapon_mode][2] = 0.14 * 1
        LAUNCH_MODE = 1
    elseif command == Keys.PlaneDropSnarOnce then
        --扔一个箔条和一对热焰弹
        if target_status[master_arm_switch][2] == SWITCH_ON then
            drop_chaff()
            drop_flare()
        end
    elseif command == Keys.PlaneDropFlareOnce then
        --扔一个箔条和一对热焰弹
        if target_status[master_arm_switch][2] == SWITCH_ON then
            drop_flare()
        end
    elseif command == Keys.PlaneDropChaffOnce then
        --扔一个箔条和一对热焰弹
        if target_status[master_arm_switch][2] == SWITCH_ON then
            drop_chaff()
        end
    end

    if target_status[master_arm_switch][2] == SWITCH_OFF then
        --reset all warning
        RESELECT_LIGHT_STATUS = 0
        COMPLETE_LIGHT_STATUS = 0
        local SELECTED_LIST = {
            -- {is_launch, pylon launch number, select_light}
            { 0, 0, get_param_handle("PNT_1266") },
            { 0, 0, get_param_handle("PNT_1267") },
            { 0, 0, get_param_handle("PNT_2267") },
            { 0, 0, get_param_handle("PNT_1268") },
            { 0, 0, get_param_handle("PNT_2269") },
            { 0, 0, get_param_handle("PNT_1269") },
            { 0, 0, get_param_handle("PNT_1270") },
        }
    end
    -- update missile in use selection
    MISSILE_IN_USE = -1
end

function update_switch_status()
    local switch_moving_step = 0.25
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
        -- print_message_to_user(k)
    end
end

function get_tumb_wheel_set()
    INTERVAL_SET = num_target[atk_int_ammos_100][2] * 1000 + num_target[atk_int_ammos_10][2] * 100 +
        num_target[atk_int_ammos_1][2] * 10
    if INTERVAL_SET < update_time_step * 100 then
        INTERVAL_SET = update_time_step * 100
        num_target[atk_int_ammos_100][2] = math.floor(update_time_step) * 0.1
        num_target[atk_int_ammos_10][2] = math.floor(update_time_step * 10 % 10) * 0.1
        num_target[atk_int_ammos_1][2] = update_time_step * 100 % 10 * 0.1
    end
    QUANTITY_SET = num_target[atk_qty_ammos_10][2] * 100 + num_target[atk_qty_ammos_1][2] * 10
    if QUANTITY_SET <= 0 then
        QUANTITY_SET = 1
        num_target[atk_qty_ammos_10][2] = math.floor(QUANTITY_SET * 0.1) * 0.1
        num_target[atk_qty_ammos_1][2] = math.floor(QUANTITY_SET % 10) * 0.1
    end

    MULT_SET = num_target[atk_mult_ammos_10][2] * 100 + num_target[atk_mult_ammos_1][2] * 10
    if MULT_SET <= 0 then
        MULT_SET = 1
        num_target[atk_mult_ammos_10][2] = math.floor(MULT_SET * 0.1) * 0.1
        num_target[atk_mult_ammos_1][2] = math.floor(MULT_SET % 10) * 0.1
    end
    dbg_param[1]:set(INTERVAL_SET)
    dbg_param[2]:set(QUANTITY_SET)
    dbg_param[3]:set(MULT_SET)
end

USING_PYLON_DATA = { -1, nil, 0 }
BOMB_COUNT = 0
function update_launch_selection()
    if not get_elec_ac_status() then
        return
    end
    if MANUAL_RELEASE_SIGNAL == 1 then
        FIREHOLD = FIREHOLD + update_time_step
    end
    if current_status[master_arm_switch][2] == SWITCH_ON and LAUNCH_MODE > 0 then
        if LAUNCH_MODE == 3 then
            if isFire == 0 and FIREHOLD > update_time_step then
                dispatch_action(nil, iCommandPlaneFire, 1)
                isFire = 1
            end
        elseif USING_PYLON_DATA[1] ~= -1 then
            if LAUNCH_MODE < 3 and FIREHOLD > 1 and isFire == 0 then
                --A2A导弹
                for k, v in pairs(PYLON_INFO_LIST) do
                    if v[3] > 0 and SELECTED_LIST[k][1] == 1 then
                        if USING_PYLON_DATA[1] == 2 or USING_PYLON_DATA[1] == 4 then
                            snd_list[msl_launch_in][2]:play_once()
                        end
                        WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
                        isFire = 1
                        break
                    end
                end
            elseif LAUNCH_MODE == 4 and FIREHOLD > update_time_step then
                --火箭弹
                --射击操作已移交到rocket_launch()
            elseif LAUNCH_MODE == 5 and isFire == 0 and FIREHOLD > update_time_step then
                BOMB_COUNT = QUANTITY_SET
                isFire = 1
                --炸弹操作已移交到bomb_launch()
            elseif LAUNCH_MODE == 6 and FIREHOLD > 1 and isFire == 0 then
                for k, v in pairs(PYLON_INFO_LIST) do
                    if v[3] > 0 and SELECTED_LIST[k][1] == 1 then
                        WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
                        isFire = 1
                        break
                    end
                end
            elseif LAUNCH_MODE == 7 and isFire == 0 and FIREHOLD > update_time_step then
                for k, v in pairs(PYLON_INFO_LIST) do
                    if v[3] > 0 and SELECTED_LIST[k][1] == 1 then
                        WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
                        isFire = 1
                    end
                end
            end
        end
        
    elseif LAUNCH_MODE == 0 and MANUAL_RELEASE_SIGNAL == 1 and current_status[master_arm_switch][2] == SWITCH_ON then
        for i = 2, 8, 1 do
            if target_status[i][2] == SWITCH_ON then
                --丢弃挂载
                snd_list[drop_weapon][2]:play_once()
                WeaponSystem:emergency_jettison(i - 2)
                target_status[i][2] = SWITCH_OFF
            end
        end
    end
end
local bomb_launch_time=0
local function bomb_launch()
    if current_status[master_arm_switch][2] == SWITCH_ON and LAUNCH_MODE == 5 and isFire == 1 and FIREHOLD > update_time_step then
        if math.floor((bomb_launch_time * 100) % INTERVAL_SET) == 0 and BOMB_COUNT > 0 then
            WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
            BOMB_COUNT = BOMB_COUNT - 1
        end
        bomb_launch_time=bomb_launch_time+update_time_step
    elseif (isFire == 0 and FIREHOLD == 0) or LAUNCH_MODE ~= 5 then
        BOMB_COUNT = 0
        bomb_launch_time=0
    end
end

local function rocket_launch()
    if current_status[master_arm_switch][2] == SWITCH_ON and LAUNCH_MODE == 4 and FIREHOLD > update_time_step then
        if QUANTITY_SET == 1 then
            --单射
            if isFire == 0 then
                if MULT_SET == 1 then
                    WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
                else
                    WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
                    if SELECTED_LIST[8-USING_PYLON_DATA[1]][1] == SWITCH_ON and PYLON_INFO_LIST[8-USING_PYLON_DATA[1]][3] > 0 then
                        WeaponSystem:launch_station(8-USING_PYLON_DATA[1]-1)
                    end
                end
                isFire = 1
            end
        else
            --齐射
            if MULT_SET == 1 then
                WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
            else
                WeaponSystem:launch_station(USING_PYLON_DATA[1] - 1)
                if SELECTED_LIST[8-USING_PYLON_DATA[1]][1] == SWITCH_ON and PYLON_INFO_LIST[8-USING_PYLON_DATA[1]][3] > 0 then
                    WeaponSystem:launch_station(8-USING_PYLON_DATA[1]-1)
                end
            end
        end
    end
end

MISSILE_IN_USE = -1
AFTER_LAUNCH = 0

function isInTbl(target, tbl)
    if tbl then
        for k, v in pairs(tbl) do
            if v == target then
                return true
            end
        end
    end
    return false
end

local function resetReleaseProgram()
    num_target[atk_qty_ammos_10][2]=0
    num_target[atk_qty_ammos_1][2]=0.1
    num_target[atk_mult_ammos_10][2]=0
    num_target[atk_mult_ammos_1][2]=0.1
    num_target[atk_int_ammos_100][2]=0
    num_target[atk_int_ammos_10][2]=0
    num_target[atk_int_ammos_1][2]=0.2
end

function update_launch_mode()
    if LAUNCH_MODE == 0 or not get_elec_ac_status() then
        for k, v in pairs(SELECTED_LIST) do
            v[1]=SWITCH_OFF
        end
        return
    end
    if USING_PYLON_DATA[3] ~= LAUNCH_MODE then
        --模式切换
        USING_PYLON_DATA = { -1, nil, LAUNCH_MODE }
        --重置投放程序
        resetReleaseProgram()
    end
    if USING_PYLON_DATA[1] ~= -1 then
        USING_PYLON_DATA[2] = WeaponSystem:get_station_info(USING_PYLON_DATA[1] - 1) --刷新使用中的挂载信息
    end
    if LAUNCH_MODE == 3 then
        USING_PYLON_DATA = { -1, nil, LAUNCH_MODE }
        if gun_grid:get() < 0.9 then
            gun_grid:set(1)
        end
    else
        gun_grid:set(0)
    end
    for i = 1, 7, 1 do
        repeat
            local pylonPwrStatus = get_param_handle("PNT_108" .. i)
            if pylonPwrStatus == SWITCH_OFF then
                SELECTED_LIST[i][1] = SWITCH_OFF
                break
            end
            local pylonData = WeaponSystem:get_station_info(i - 1)
            if pylonData ~= nil and pylonData.count > 0 then
                local wsType = pylonData.weapon
                if LAUNCH_MODE == 1 and wsType.level1 == 4 and wsType.level2 == 4 and wsType.level3 == 7 and
                    isInTbl(pylonData.CLSID, A2A_dg) then
                    --A2A IR
                    --target_status[i+1][2]=SWITCH_ON
                    SELECTED_LIST[i][1] = SWITCH_ON

                    if USING_PYLON_DATA[1] == -1 or
                        (FIREHOLD == 0 and USING_PYLON_DATA[1] ~= i and USING_PYLON_DATA[2].count < pylonData.count) then
                        WeaponSystem:select_station(i - 1)

                        USING_PYLON_DATA = { i, pylonData, LAUNCH_MODE }
                    end
                elseif LAUNCH_MODE == 2 and wsType.level1 == 4 and wsType.level2 == 4 and wsType.level3 == 7 and
                    isInTbl(pylonData.CLSID, A2A_r) then
                    --target_status[i+1][2]=SWITCH_ON
                    SELECTED_LIST[i][1] = SWITCH_ON
                    if USING_PYLON_DATA[1] == -1 or
                        (FIREHOLD == 0 and USING_PYLON_DATA[1] ~= i and USING_PYLON_DATA[2].count < pylonData.count) then
                        WeaponSystem:select_station(i - 1)

                        USING_PYLON_DATA = { i, pylonData, LAUNCH_MODE }
                    end
                    --A2a_r
                elseif LAUNCH_MODE == 3 then
                    --机炮
                    --target_status[i+1][2]=SWITCH_OFF
                    SELECTED_LIST[i][1] = SWITCH_OFF
                elseif LAUNCH_MODE == 4 and wsType.level1 == 4 and wsType.level2 == 7 and wsType.level3 == 33 then
                    --火箭弹
                    --target_status[i+1][2]=SWITCH_ON
                    SELECTED_LIST[i][1] = SWITCH_ON
                    if USING_PYLON_DATA[1] == -1 or
                        (USING_PYLON_DATA[1] ~= i and USING_PYLON_DATA[2].count < pylonData.count) then
                        WeaponSystem:select_station(i - 1)
                        USING_PYLON_DATA = { i, pylonData, LAUNCH_MODE }
                    end
                elseif LAUNCH_MODE == 5 and wsType.level1 == 4 and wsType.level2 == 5 then
                    --炸弹
                    --target_status[i+1][2]=SWITCH_ON
                    SELECTED_LIST[i][1] = SWITCH_ON
                    if USING_PYLON_DATA[1] == -1 or
                        (USING_PYLON_DATA[1] ~= i and USING_PYLON_DATA[2].count < pylonData.count) then
                        WeaponSystem:select_station(i - 1)
                        USING_PYLON_DATA = { i, pylonData, LAUNCH_MODE }
                    end
                elseif LAUNCH_MODE == 6 and wsType.level1 == 4 and wsType.level2 == 4 and wsType.level3 == 8 then
                    --A2G弹
                    --target_status[i+1][2]=SWITCH_ON
                    SELECTED_LIST[i][1] = SWITCH_ON
                    if USING_PYLON_DATA[1] == -1 or
                        (FIREHOLD == 0 and USING_PYLON_DATA[1] ~= i and USING_PYLON_DATA[2].count < pylonData.count) then
                        WeaponSystem:select_station(i - 1)

                        USING_PYLON_DATA = { i, pylonData, LAUNCH_MODE }
                    end
                elseif LAUNCH_MODE == 7 and wsType.level1 == 4 and wsType.level2 == 15 and wsType.level3 == 50 then
                    SELECTED_LIST[i][1] = SWITCH_ON
                    if USING_PYLON_DATA[1] == -1 or
                        (FIREHOLD == 0 and USING_PYLON_DATA[1] ~= i and USING_PYLON_DATA[2].count < pylonData.count) then
                        WeaponSystem:select_station(i - 1)

                        USING_PYLON_DATA = { i, pylonData, LAUNCH_MODE }
                    end
                else
                    SELECTED_LIST[i][1] = SWITCH_OFF
                end
            end
        until true
    end
end

function update_ir_msl_status()
    if LAUNCH_MODE == 1 and USING_PYLON_DATA[1] ~= -1 and USING_PYLON_DATA[2].count > 0 then
        if ir_missile_lock_param:get() == 1 then
            target_round_dis:set(hud_dis:get())
            if snd_list[sidewinder_quiet][2]:is_playing() then
                snd_list[sidewinder_quiet][2]:stop()
            end
            if snd_list[sidewinder_low][2]:is_playing() then
                snd_list[sidewinder_low][2]:stop()
            end
            local temp_ir_az = ir_missile_az_param:get()
            local temp_ir_el = ir_missile_el_param:get()
            target_round_x:set(math.tan(ir_missile_az_param:get())*15.5)
            target_round_y:set(math.tan(ir_missile_el_param:get())*15.5)
            ir_missile_des_az_param:set(temp_ir_az)
            ir_missile_des_el_param:set(temp_ir_el)
            if not snd_list[sidewinder_high][2]:is_playing() then
                snd_list[sidewinder_high][2]:play_continue()
            end
        else
            target_round_dis:set(0)
            target_round_x:set(0)
            target_round_y:set(0)
            ir_missile_des_az_param:set(0)
            ir_missile_des_el_param:set(0)
            if snd_list[sidewinder_high][2]:is_playing() then
                snd_list[sidewinder_high][2]:stop()
            end
            if not snd_list[sidewinder_low][2]:is_playing() then
                snd_list[sidewinder_low][2]:play_continue()
            end

        end
    else
        if snd_list[sidewinder_high][2]:is_playing() then
            snd_list[sidewinder_high][2]:stop()
        end
        if snd_list[sidewinder_quiet][2]:is_playing() then
            snd_list[sidewinder_quiet][2]:stop()
        end
        if snd_list[sidewinder_low][2]:is_playing() then
            snd_list[sidewinder_low][2]:stop()
        end
        ir_missile_des_az_param:set(0)
        ir_missile_des_el_param:set(0)
        target_round_dis:set(0)
        target_round_x:set(0)
        target_round_y:set(0)
    end
end

local function update_cannon_track()
    if LAUNCH_MODE == 3 then
        gun_ccip_dis_enable:set(1)
        gun_ccip_x:set(gun_piper_az:get())
        gun_ccip_y:set(gun_piper_el:get())
    else
        gun_ccip_dis_enable:set(0)
        gun_ccip_x:set(0)
        gun_ccip_y:set(0)
    end
end

local function update_rocket_track()
    if LAUNCH_MODE == 4 and USING_PYLON_DATA[2] ~= -1 then
        rocket_ccip_dis_enable:set(1)
        rocket_ccip_x:set(rocket_piper_az:get())
        rocket_ccip_y:set(rocket_piper_el:get())
    else
        rocket_ccip_dis_enable:set(0)
        rocket_ccip_x:set(0)
        rocket_ccip_y:set(0)
    end
end

local function update_bomb_track()
    if LAUNCH_MODE == 5 and USING_PYLON_DATA[2] ~= -1 then
        gun_ccip_dis_enable:set(1)
        gun_ccip_x:set(gun_piper_az:get())
        gun_ccip_y:set(gun_piper_el:get())
    else
        gun_ccip_dis_enable:set(0)
        gun_ccip_x:set(0)
        gun_ccip_y:set(0)
    end
end

function update()
    -- WeaponSystem:emergency_jettison(i-1)
    -- WeaponSystem:launch_station(pylonSelected - 1)
    local ECMStatus=WeaponSystem:get_ECM_status()
    if ECMStatus and (get_elec_ac_status() or get_elec_dc_status()) then
        ecmHandle:set(SWITCH_ON)
    else
        ecmHandle:set(SWITCH_OFF)
    end
    ammo_count_cal()--绘制弹药数量信息
    update_num_anim()--绘制数字轮
    update_Pylon_list()--更新挂架信息
    update_switch_status()--更新拨杆
    check_externel_tank_status()--检查副油箱
    get_tumb_wheel_set()--更新投放程序
    --calGunAmmo()
    if get_elec_ac_status() and weaponPwrSwitch:get() == SWITCH_ON then
        bomb_launch() --炸弹投放程序
        rocket_launch() --火箭弹射击程序
        update_launch_mode()--更新发射模式以及下一个该发射的挂架
        update_ir_msl_status()--更新红外弹参数 
        update_launch_selection()--更新发射状态
        update_display_light()--更新挂架选择灯
        update_rocket_track()
    end
    
    if c > 1 then
        --hud_lock_test_sign:set()
        c = 0
    end
    c = c + update_time_step
end

need_to_be_closed = false

--[[
    GetDevice(devices.WEAPON_SYSTEM) metatable:
    weapons meta["__index"] = {}
    weapons meta["__index"]["get_station_info"] = function: 00000000CCCC5780
    weapons meta["__index"]["listen_event"] = function: 00000000CCC8E000
    weapons meta["__index"]["drop_flare"] = function: 000000003C14E208
    weapons meta["__index"]["set_ECM_status"] = function: 00000000CCCC76E0
    weapons meta["__index"]["performClickableAction"] = function: 00000000CCE957B0
    weapons meta["__index"]["get_ECM_status"] = function: 00000000CCE37BC0
    weapons meta["__index"]["launch_station"] = function: 00000000CCC36A30
    weapons meta["__index"]["SetCommand"] = function: 00000000CCE52820
    weapons meta["__index"]["get_chaff_count"] = function: 00000000CCBDD650
    weapons meta["__index"]["emergency_jettison"] = function: 00000000CCC26810
    weapons meta["__index"]["set_target_range"] = function: 000000003AB0FDD0
    weapons meta["__index"]["set_target_span"] = function: 0000000027E4E970
    weapons meta["__index"]["get_flare_count"] = function: 00000000CCCC57D0
    weapons meta["__index"]["get_target_range"] = function: 00000000CCC26710
    weapons meta["__index"]["get_target_span"] = function: 00000000CCCC7410
    weapons meta["__index"]["SetDamage"] = function: 00000000CCC384B0
    weapons meta["__index"]["drop_chaff"] = function: 00000000CCE37AA0
    weapons meta["__index"]["select_station"] = function: 00000000CC5C26F0
    weapons meta["__index"]["listen_command"] = function: 0000000038088060
    weapons meta["__index"]["emergency_jettison_rack"] = function: 00000000720F15F0
]]
