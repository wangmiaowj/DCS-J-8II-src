-- hud显示控制机
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev 	    = GetSelf()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local hudBrt_value =0 --hud亮度旋钮的值
local count = 0

local hud_warning = get_param_handle("WARNING_FLASH")
local hud_danger = get_param_handle("DANGER_FLASH")
local hud_denied = get_param_handle("WARNING_FLASH")
local hud_enable = get_param_handle("HUD_DIS_ENABLE")
local hud_adi_level_enable = get_param_handle("ADI_LINE_GROUP")
local hud_adi_rot = get_param_handle("HUD_ADI_ROT")
local hud_adi_pitch = get_param_handle("HUD_ADI_MOVY")
local hud_FD_x = get_param_handle("HUD_FD_X")
local hud_FD_y = get_param_handle("HUD_FD_Y")
local hud_speed_dis = get_param_handle("HUD_SPEED_DIS")
local hud_alt_dis = get_param_handle("HUD_ALT_DIS")
local hud_ralt_dis = get_param_handle("HUD_RALT_DIS")
local hud_g_dis = get_param_handle("HUD_G_DIS")
local hud_aoa_dis = get_param_handle("HUD_AOA_DIS")
local hud_mach_dis = get_param_handle("HUD_MACH_DIS")
local hud_ln2_dis = get_param_handle("HUD_LN2_DIS")
local hud_rn2_dis = get_param_handle("HUD_RN2_DIS")
local hud_maxg_dis = get_param_handle("HUD_GM_DIS")
local hud_magni_dis = get_param_handle("HUD_MAGNI_DIS")
local hud_nav_data_1 = get_param_handle("HUD_NAV_DATA_1_DIS")
local hud_nav_data_2 = get_param_handle("HUD_NAV_DATA_2_DIS")
local hud_nav_data_3 = get_param_handle("HUD_NAV_DATA_3_DIS")
local hud_speed_bar_group = get_param_handle("HUD_SPEED_BAR_GROUP")
local hud_alt_bar_group = get_param_handle("HUD_ALT_BAR_GROUP")
local hud_hdg_bar_group = get_param_handle("HUD_HDG_BAR_GROUP")

local hud_pwr = get_param_handle("PNT_1012")--亮度模式DayNight句柄

local sensor_data = get_base_data()
local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6 
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_INCH = 3.2808

local maxG_record = 1

function post_initialize()
    hud_FD_x:set(0)
    hud_FD_y:set(0)
    hud_adi_level_enable:set(1)
    hud_enable:set(1)
    hud_maxg_dis:set(1)
	local birth = LockOn_Options.init_conditions.birth_place
	if birth=="GROUND_HOT" or birth=="AIR_HOT" then
		hudBrt_value = 1
		count = 8
    elseif birth=="GROUND_COLD" then
		hudBrt_value = 0
		count = 0
    end
end

function SetCommand(command,value)
	
end


function update()
    hud_adi_rot:set(sensor_data.getRoll())
    hud_adi_pitch:set(-sensor_data.getPitch())
    hud_speed_dis:set(sensor_data.getIndicatedAirSpeed()*ias_conversion_to_kmh)
    hud_alt_dis:set(sensor_data.getBarometricAltitude())
    hud_aoa_dis:set(sensor_data.getAngleOfAttack() * RAD_TO_DEGREE)
    hud_g_dis:set(sensor_data.getVerticalAcceleration())
    local temp_G = sensor_data.getVerticalAcceleration()
    hud_ralt_dis:set(sensor_data.getRadarAltitude)
    if (temp_G > maxG_record) then
        maxG_record = temp_G
        hud_maxg_dis:set(maxG_record)
    end
    hud_mach_dis:set(sensor_data.getMachNumber())
    hud_magni_dis:set(sensor_data.getMagneticHeading())
    hud_ln2_dis:set(sensor_data.getEngineLeftRPM())
    hud_rn2_dis:set(sensor_data.getEngineRightRPM())
    -- getMagneticHeading

    hud_nav_data_1:set("NAV UNSET")
    hud_nav_data_2:set("ETE: 00:00")
	
	if hud_pwr:get() == 1 and get_elec_ac_status() then
		count = count + update_time_step
		if hudBrt_value < 1 then
			hudBrt_value = hudBrt_value + update_time_step
		end
		if  count > 3 then
			local temp_brt = hud_adi_level_enable:get()
			temp_brt = temp_brt + update_time_step
			if temp_brt > hudBrt_value then
			 temp_brt = hudBrt_value
			end
			hud_adi_level_enable:set(temp_brt)
		end
		if  count > 4 then
			local temp_brt = hud_enable:get()
			temp_brt = temp_brt + update_time_step
			if temp_brt > hudBrt_value then
			 temp_brt = hudBrt_value
			end
			hud_enable:set(temp_brt)
		end
		if  count > 5 then
			local temp_brt = hud_maxg_dis:get()
			temp_brt = temp_brt + update_time_step
			if temp_brt > hudBrt_value then
			 temp_brt = hudBrt_value
			end
			hud_maxg_dis:set(temp_brt)
		end
		if  count > 6 then
			local temp_brt = hud_speed_bar_group:get()
			temp_brt = temp_brt + update_time_step
			if temp_brt > hudBrt_value then
			 temp_brt = hudBrt_value
			end
			hud_speed_bar_group:set(temp_brt)
		end
		if  count > 7 then
			local temp_brt = hud_alt_bar_group:get()
			temp_brt = temp_brt + update_time_step
			if temp_brt > hudBrt_value then
			 temp_brt = hudBrt_value
			end
			hud_alt_bar_group:set(temp_brt)
		end
		if  count > 8 then
			local temp_brt = hud_hdg_bar_group:get()
			temp_brt = temp_brt + update_time_step
			if temp_brt > hudBrt_value then
			 temp_brt = hudBrt_value
			end
			hud_hdg_bar_group:set(temp_brt)
		end
	else
		count = 0
		if hudBrt_value > 0 then
			hudBrt_value = hudBrt_value - update_time_step
		end
		hud_adi_level_enable:set(hudBrt_value)
		hud_enable:set(hudBrt_value)
		hud_maxg_dis:set(hudBrt_value)
		hud_speed_bar_group:set(hudBrt_value)
		hud_alt_bar_group:set(hudBrt_value)
		hud_hdg_bar_group:set(hudBrt_value)
	end
end