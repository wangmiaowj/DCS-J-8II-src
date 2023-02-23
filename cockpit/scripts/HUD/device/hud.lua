-- hud显示控制机
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local dev 	    = GetSelf()

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local hudBrt_value =0 --hud亮度旋钮的值
local count = 0

dev:listen_command(Keys.HK_L_Down)
dev:listen_command(Keys.HK_L_Up)

local hud_limit = {
    x= math.rad(6),
    y = math.rad(6)
}

local function limit_xy(x, y, limit_x, limit_y, limit_x_down, limit_y_down) 
    limit_x_down = limit_x_down or -limit_x
    limit_y_down = limit_y_down or -limit_y

    local limited_x = false
    local limited_y = false

    if (x > limit_x) and (y <= limit_y / limit_x * x) and (y >= limit_y_down / limit_x * x) then 
        y = y * limit_x / x
        x = limit_x
        limited_x = true
    end
    
    if (x < limit_x_down)  and (y <= limit_y / limit_x_down * x) and (y >= limit_y_down / limit_x_down * x) then 
        y = y * limit_x_down / x
        x = limit_x_down 
        limited_x = true
    end

    if (y > limit_y) and (x < limit_x / limit_y * y) and (x > limit_x_down / limit_y * y) then 
        x = x * limit_y / y
        y = limit_y
        limited_y = true
    end
    
    if (y < limit_y_down) and (x < limit_x / limit_y_down * y) and (x > limit_x_down / limit_y_down * y) then 
        x = x * limit_y_down / y
        y = limit_y_down 
        limited_y = true
    end
    
    local limited = (limited_x or limited_y) and 1 or 0
    return x, y, limited, limited_x, limited_y
end

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
local hud_hdg_move = get_param_handle('HUD_HDG_MOV')
local hud_detail_data_dis = get_param_handle('HUD_DETAIL_DATA_DIS')
local hud_ralt_data_dis = get_param_handle('HUD_RALT_DATA_DIS')

local hud_pwr = get_param_handle("PNT_1012")--亮度模式DayNight句柄

local sensor_data = get_base_data()
local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6 
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_INCH = 3.2808

local maxG_record = 1

local switch_count = 0
local function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local HK_L_Axis = _switch_counter()

local target_status = {
	{HK_L_Axis,0.1,get_param_handle('PNT_1202'),'PNT_1202'}
}

local current_status = {
	{HK_L_Axis,0.1,0}
}

local bitTime = 0

local function bitProgram()
	bitTime = math.floor((bitTime + update_time_step)*100 + 0.5) / 100
	
	if bitTime == 17 then
		--右襟翼放下
		print_message_to_user('右襟翼放下')
	elseif bitTime == 19 then
		--右襟翼收起
		print_message_to_user('右襟翼收起')
	elseif bitTime == 21 then
		--左襟翼放下
		print_message_to_user('左襟翼放下')
	elseif bitTime == 23 then
		--左襟翼收起
		print_message_to_user('左襟翼收起')
	elseif bitTime == 25 then
		--右副翼向下偏转
		print_message_to_user('右副翼向下偏转')
	elseif bitTime == 27 then
		--右副翼复位
		print_message_to_user('右副翼复位')
	elseif bitTime == 29 then
		--右副翼向上偏转
		print_message_to_user('右副翼向上偏转')
	elseif bitTime == 31 then
		--右副翼复位
		print_message_to_user('右副翼复位')
	elseif bitTime == 33 then
		--左副翼向下偏转
		print_message_to_user('左副翼向下偏转')
	elseif bitTime == 35 then
		--左副翼复位
		print_message_to_user('左副翼复位')
	elseif bitTime == 37 then
		--左副翼向上偏转
		print_message_to_user('左副翼向上偏转')
	elseif bitTime == 39 then
		--左副翼复位
		print_message_to_user('左副翼复位')
	elseif bitTime == 41 then
		--右平尾翼向下偏转
		print_message_to_user('右平尾翼向下偏转')
	elseif bitTime == 43 then
		--右平尾复位
		print_message_to_user('右平尾复位')
	elseif bitTime == 45 then
		--右平尾翼向上偏转
		print_message_to_user('右平尾翼向上偏转')
	elseif bitTime == 47 then
		--右平尾复位
		print_message_to_user('右平尾复位')
	elseif bitTime == 49 then
		--左平尾翼向下偏转
		print_message_to_user('左平尾翼向下偏转')
	elseif bitTime == 51 then
		--左平尾复位
		print_message_to_user('左平尾复位')
	elseif bitTime == 53 then
		--左平尾翼向上偏转
		print_message_to_user('左平尾翼向上偏转')
	elseif bitTime == 55 then
		--左平尾复位
		print_message_to_user('左平尾复位')
	elseif bitTime == 57 then
		--垂尾向右偏转
		print_message_to_user('垂尾向右偏转')
	elseif bitTime == 59 then
		--垂尾复位
		print_message_to_user('垂尾复位')
	elseif bitTime == 61 then
		--垂尾向左偏转
		print_message_to_user('垂尾向左偏转')
	elseif bitTime == 63 then
		--垂尾复位
		print_message_to_user('垂尾复位')
	elseif bitTime == 65 then
		--扰流板打开
		print_message_to_user('扰流板打开')
	elseif bitTime == 67 then
		--扰流板关闭
		print_message_to_user('扰流板关闭')
	elseif bitTime == 69 then
		--襟翼、副翼、平尾、垂尾全部活动4秒
		print_message_to_user('襟翼、副翼、平尾、垂尾全部活动4秒')
	end
end

local function update_switch_status()
    local switch_moving_step = 0.05
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

local function update_flight_mode()
	local hk_l_val = math.floor(target_status[HK_L_Axis][2] * 10 + 0.5) / 10
	if hk_l_val == 0.0 then
		bitProgram()
	elseif hk_l_val ~= 0.0 then
		bitTime = 0
	end
	if hk_l_val == 0.1 then
		--惯导校准
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.2 then
		--导航
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.3 then
		--边飞行边校准
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.4 then
		--低航
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(1)
	elseif hk_l_val == 0.5 then
		--导航
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.6 then
		--起飞
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.7 then
		--巡航
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.8 then
		--对空
		hud_detail_data_dis:set(0)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 0.9 then
		--对地
		hud_detail_data_dis:set(0)
		hud_ralt_data_dis:set(0)
	elseif hk_l_val == 1.0 then
		--降落
		hud_detail_data_dis:set(1)
		hud_ralt_data_dis:set(1)
	end
end

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
	if command == Keys.HK_L_Down then
		if current_status[HK_L_Axis][2] >= 0.1 then
			target_status[HK_L_Axis][2] = target_status[HK_L_Axis][2] - 0.1
		else
			target_status[HK_L_Axis][2] = 0
		end
	elseif command == Keys.HK_L_Up then
		if current_status[HK_L_Axis][2] <= 0.9 then
			target_status[HK_L_Axis][2] = target_status[HK_L_Axis][2] + 0.1
		else
			target_status[HK_L_Axis][2] = 1
		end
	end
end

function calFPM()
	local v_x, v_y, v_z = sensor_data:getSelfVelocity()
	local v = math.sqrt( v_x * v_x + v_y * v_y + v_z * v_z)
	local v_hdg = math.atan2(v_z, v_x)
	local v_pitch = 0

    if v ~= 0 then
        v_pitch = math.asin(v_y / v)
    end
	local p_pitch, p_roll, p_hdg
    p_pitch = sensor_data.getPitch()
	p_roll = sensor_data:getRoll()
    p_hdg = 2*math.pi - sensor_data:getHeading()
	local dif_hdg = (v_hdg - p_hdg) % (2*math.pi)
	if dif_hdg > math.pi then
		dif_hdg = dif_hdg - 2 * math.pi
	end
	local fpm_x = (dif_hdg) * math.cos(p_roll) - (-p_pitch + v_pitch) * math.sin(p_roll)
    local fpm_y = (-p_pitch + v_pitch) * math.cos(p_roll) + (dif_hdg) * math.sin(p_roll)
	local fpm_cross = 0
	fpm_x,fpm_y,fpm_cross = limit_xy(fpm_x,fpm_y,hud_limit.x,hud_limit.y*1.3)
	hud_FD_x:set(fpm_x)
	hud_FD_y:set(fpm_y)
end

local c = 0
function update()
	update_switch_status()
	update_flight_mode()
	calFPM()
	local heading = sensor_data.getHeading()*RAD_TO_DEGREE
	if heading > 160 then
		hud_hdg_move:set(-(360-heading) * 0.008)
	else
		hud_hdg_move:set(heading * 0.008)
	end
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