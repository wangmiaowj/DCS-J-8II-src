dofile(LockOn_Options.script_path.."debug_util.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."sounds_def.lua")
dofile(LockOn_Options.script_path.."devices.lua")

range_scale 		  	= 60000.0
TDC_range_carret_size 	= 5000
render_debug_info 		= false--true


perfomance = 
{
	-- 简化计算，不能旋转
	roll_compensation_limits	= {0, 0},
	pitch_compensation_limits	= {0, 0},
	
	tracking_azimuth   			= { -math.rad(90),math.rad(90)}, -- available to use, set to 90 for better performance
	-- tracking_elevation 			= { -math.rad(80),math.rad(80)}, -- not available: only +- 30 deg limite
	
	-- 在当前设置下，扫描区间为5deg, 扫描周期为41/50 s。
	scan_volume_azimuth 	= math.rad(120), --扫描范围
	scan_volume_elevation	= math.rad(120),		
	scan_beam				= math.rad(120), --扫描扇区纵向面积
	-- scan_speed				= math.rad(10*80), -- 无效参数
	
	max_available_distance  = 20 * 60000.0,--200*60000.0,
	dead_zone 				= 200.0,
	
	ground_clutter =
	{-- spot RCS = A + B * random + C * random 
		sea		   	   = {0 ,0,0},
		land 	   	   = {0 ,0,0},		
		artificial 	   = {0 ,0,0},
		rays_density   = 0.01,
		max_distance   = 60000,
	}
	
}


------------------------------------------------------------------------------

RadarSystem 	    	= GetSelf()
DEBUG_ACTIVE 	= true
Sensor_Data_Raw = get_base_data()


update_time_step 	= 0.02		--50次每秒
RadarSystemice_timer_dt		= 0.02

make_default_activity(update_time_step) 

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local radar_range = _switch_counter()
local radar_lightness_a = _switch_counter()
local radar_lightness = _switch_counter()
local radar_lightness_b = _switch_counter()
local radar_mode = _switch_counter()
local radar_max_range = _switch_counter()

local isLock = get_param_handle("PNT_1207")
local isEnableFire = get_param_handle("PNT_1206")

local target_dis=get_param_handle("TARGET_BOX_DIS_ENABLE")
local target_range=get_param_handle("TARGET_RANGE")
local target_type = get_param_handle("TARGET_TYPE")
local target_x=get_param_handle("TARGET_BOX_X")
local target_y=get_param_handle("TARGET_BOX_Y")
local hud_dis=get_param_handle("HUD_DIS_ENABLE")

local target_status = {
	{radar_range, SWITCH_OFF, get_param_handle('PNT_1211'), 'PNT_1211'},
	{radar_lightness_a, SWITCH_OFF, get_param_handle('PNT_1212'), 'PNT_1212'},
	{radar_lightness, SWITCH_OFF, get_param_handle('PNT_1213'), 'PNT_1213'},
	{radar_lightness_b, SWITCH_OFF, get_param_handle('PNT_1214'), 'PNT_1214'},
	{radar_mode, SWITCH_OFF, get_param_handle('PNT_1215'), 'PNT_1215'},
	{radar_max_range, SWITCH_OFF, get_param_handle('PNT_1216'), 'PNT_1216'},
}

local current_status = {
	{radar_range, SWITCH_OFF, SWITCH_OFF},
	{radar_lightness_a, SWITCH_OFF, SWITCH_OFF},
	{radar_lightness, SWITCH_OFF, SWITCH_OFF},
	{radar_lightness_b, SWITCH_OFF, SWITCH_OFF},
	{radar_mode, SWITCH_OFF, SWITCH_OFF},
	{radar_max_range, SWITCH_OFF, SWITCH_OFF},
}


Radar = 	{
				mode_h 		= get_param_handle("RADAR_MODE"), -- 1:searching, 2:trying to lock, 3:STT lock
				szoe_h 		= get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				szoa_h 		= get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				
				opt_pb_stab_h 	= get_param_handle("RADAR_PITCH_BANK_STABILIZATION"),
				opt_bank_stab_h = get_param_handle("RADAR_BANK_STABILIZATION"),
				opt_pitch_stab_h= get_param_handle("RADAR_PITCH_STABILIZATION"),
				
				
				tdc_azi_h 		= get_param_handle("RADAR_TDC_AZIMUTH"),
				tdc_range_h 	= get_param_handle("RADAR_TDC_RANGE"),
				tdc_closet_h	= get_param_handle("CLOSEST_RANGE_RESPONSE"),
				
				tdc_rcsize_h	= get_param_handle("RADAR_TDC_RANGE_CARRET_SIZE"),
				tdc_acqzone_h   = get_param_handle("ACQUSITION_ZONE_VOLUME_AZIMUTH"),
				

				
				stt_azimuth_h 	= get_param_handle("RADAR_STT_AZIMUTH"),
				stt_elevation_h = get_param_handle("RADAR_STT_ELEVATION"),
				stt_range = get_param_handle("RADAR_STT_RANGE"),
				
				sz_azimuth_h 	= get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				sz_elevation_h 	= get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				
				tdc_ele_up_h 	= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_UPPER"),
				tdc_ele_down_h 	= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_LOWER"),
				
				ws_ir_slave_azimuth_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH"),
				ws_ir_slave_elevation_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION"),
				
				iff_status_h			= get_param_handle("IFF_INTERROGATOR_STATUS"),
				bit_h 					= get_param_handle("RADAR_BIT"),

				antenna_pos 	= get_param_handle("SCAN_BEAM_AZIMUTH"), --设置扫描扇区显示
				radar_lightness = get_param_handle("RADAR_LIGHTNESS"),
			}

function update_switch_status()
    local switch_moving_step = 0.15
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

function post_initialize()
	Radar.iff_status_h:set(1)
	dprintf("Radar - INIT")
		
		RadarSystem:listen_command(100)
		
		RadarSystem:listen_command(139)		--scanzone left
		RadarSystem:listen_command(140)		--scanzone right
		
		RadarSystem:listen_command(141)		--scanzone up
		RadarSystem:listen_command(142)		--scanzone down
		
		RadarSystem:listen_command(394)		--change PRF (radar puls freqency)
	
		RadarSystem:listen_command(509)		--lock start
		RadarSystem:listen_command(510)		--lock finish
		
		RadarSystem:listen_command(285)		--Change radar mode RWS/TWS 
		
		RadarSystem:listen_command(2025)
		RadarSystem:listen_command(2026)
		RadarSystem:listen_command(2031)
		RadarSystem:listen_command(2032)
		RadarSystem:listen_command(2033)
		RadarSystem:listen_command(2034)
		
		RadarSystem:listen_command(Keys.RadarRangeAxis)
		RadarSystem:listen_command(Keys.RadarLightA)
		RadarSystem:listen_command(Keys.RadarLightnessAxis)
		RadarSystem:listen_command(Keys.RadarLightB)
		RadarSystem:listen_command(Keys.RadarModeUp)
		RadarSystem:listen_command(Keys.RadarModeDown)
		RadarSystem:listen_command(Keys.RadarMaxRange)
		

		Radar.opt_pb_stab_h:set(1)
		Radar.opt_pitch_stab_h:set(1)
		Radar.opt_bank_stab_h:set(1)
		local birth = LockOn_Options.init_conditions.birth_place
		if birth=="AIR_HOT" then
			target_status[radar_lightness][2] = SWITCH_ON
			target_status[radar_mode][2] = SWITCH_ON
			target_status[radar_range][2] = SWITCH_ON
		elseif birth=="GROUND_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
			target_status[radar_lightness][2] = SWITCH_ON
			target_status[radar_mode][2] = SWITCH_OFF
			target_status[radar_range][2] = SWITCH_ON
		elseif birth=="GROUND_COLD" then
			target_status[radar_lightness][2] = SWITCH_OFF
			target_status[radar_mode][2] = SWITCH_OFF
			target_status[radar_range][2] = SWITCH_OFF
		end
		
	
end

function update_radar()
	if current_status[radar_max_range][2] == 0 then
		range_scale = 60000
	elseif current_status[radar_max_range][2] == 1 then
		range_scale = 30000
	end
	if current_status[radar_mode][2] == 0 then
		--关闭(不显示扫描线并且暂停扫描)
	elseif current_status[radar_mode][2] == 0.5 then
		--待机(显示扫描线并且暂停扫描)
	elseif current_status[radar_mode][2] == 1 then
		--工作，雷达正常工作
	end
	if get_elec_ac_status() then
		Radar.radar_lightness:set(current_status[radar_lightness][2])
	else
		Radar.radar_lightness:set(0)
	end
end

local tdc_azi_h_v = 0
local tdc_range_h_v = 0

function SetCommand(command,value)
	--dprintf(string.format("Radar SetCom: C %i   V%.8f",command,value))
---------------------------------------------------------------------
	
	if command == 141 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() + 0.003)
	elseif command == 142 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() - 0.003)
	end
	
	if command == 139 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() + 0.003)
	elseif command == 140 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() - 0.003)
	end
	
	if command == Keys.RadarRangeAxis then
		if value > 0 and target_status[radar_range][2] < 1 then
			target_status[radar_range][2] = target_status[radar_range][2] + update_time_step
		elseif value < 0 and target_status[radar_range][2] > 0 then
			target_status[radar_range][2] = target_status[radar_range][2] - update_time_step
		end
	elseif command == Keys.RadarLightA then
		if value > 0 and target_status[radar_lightness_a][2] < 1 then
			target_status[radar_lightness_a][2] = target_status[radar_lightness_a][2] + update_time_step
		elseif value < 0 and target_status[radar_lightness_a][2] > 0 then
			target_status[radar_lightness_a][2] = target_status[radar_lightness_a][2] - update_time_step
		end
	elseif command == Keys.RadarLightnessAxis then
		if value > 0 and target_status[radar_lightness][2] < 1 then
			target_status[radar_lightness][2] = target_status[radar_lightness][2] + math.abs(value)
		elseif value < 0 and target_status[radar_lightness][2] > 0 then
			target_status[radar_lightness][2] = target_status[radar_lightness][2] - math.abs(value)
		end
	elseif command == Keys.RadarLightB then
		if value > 0 and target_status[radar_lightness_b][2] < 1 then
			target_status[radar_lightness_b][2] = target_status[radar_lightness_b][2] + update_time_step
		elseif value < 0 and target_status[radar_lightness_b][2] > 0 then
			target_status[radar_lightness_b][2] = target_status[radar_lightness_b][2] - update_time_step
		end
	elseif command == Keys.RadarModeUp then
		target_status[radar_mode][2] = SWITCH_ON
	elseif command == Keys.RadarModeDown then
		target_status[radar_mode][2] = SWITCH_OFF
	elseif command == Keys.RadarMaxRange then
		target_status[radar_max_range][2] = 1 - target_status[radar_max_range][2]
	end
	
----------------------------------------------------------------------	
--print_message_to_user(command)
	if Radar.tdc_range_h:get() > 1200000 then
		Radar.tdc_range_h:set(1200000) -- 目标指示附 距离
	elseif Radar.tdc_range_h:get() < 0 then
		Radar.tdc_range_h:set(0)
	end

	if Radar.tdc_azi_h:get() > 1 then
		Radar.tdc_azi_h:set(1) -- 目标指示符 方向
	elseif Radar.tdc_azi_h:get() < -1 then
		Radar.tdc_azi_h:set(-1)
	end
	
-------------------------------------------------
	
	if command == 2034  then
		--Radar.tdc_range_h:set(Radar.tdc_range_h:get()- value*1000)
		tdc_range_h_v = value*1000
		--print_message_to_user(value)
	end
	
	if command == 2033  then
		--Radar.tdc_azi_h:set(Radar.tdc_azi_h:get()+ value*0.1)
		tdc_azi_h_v = value*0.01
	end

-------------------------------------------------	
	
	
	
	
end

-- 雷达校准数据
local radar_scan_pos_align = 0
local radar_scan_align_target = 0
-- 自身状态数组
local self_status_array = {}
-- 雷达扫描结果数组
local radar_result_temp_array = {}
-- 雷达航迹跟踪数组
local radar_target_tracing_array = {}
-- 雷达扫描增稳模式状态
local radar_stable_status = 1

local hk_mode = get_param_handle("HK_MODE")

-- 设置雷达增稳状态
local function setRadarStable(stab_signal)
	if stab_signal == true then
		-- 增稳打开，用于远程扫描跟踪
		Radar.opt_pb_stab_h:set(1)
		Radar.opt_pitch_stab_h:set(1)
		Radar.opt_bank_stab_h:set(1)
		radar_stable_status = 1
	else
		-- 增稳关闭，用于近距离格斗
		Radar.opt_pb_stab_h:set(0)
		Radar.opt_pitch_stab_h:set(0)
		Radar.opt_bank_stab_h:set(0)
		radar_stable_status = 0
	end
end

-- 飞机自身状态更新函数
function self_change_update()

end

local test_param = get_param_handle("RADAR_CONTACT_01_TIME")
local param_ele
local param_azm
local param_range
local param_time
local sum_target = 0
local basic_gs_dis = get_param_handle("BASIC_GS_DIS")

-- 刷新雷达扫描数据
-- 根据目前测试为固定的每次扫描后， 有效期10s,后续消失后所有往前位移
function update_scan_result()
	sum_target = 0
	for ia = 1,900 do
		if ia  < 10 then
			i = "_0".. ia .."_"
		else
			i = "_".. ia .."_"
		end
		param_time = get_param_handle("RADAR_CONTACT"..i.."TIME")
		param_lgt = get_param_handle("RADAR_CONTACT"..i.."LGT")
		param_lgt:set(current_status[radar_lightness][2])
		if (param_time:get() < 0.82 and param_time:get() > 0) then --判断是否为当次扫描内的目标
			param_ele = get_param_handle("RADAR_CONTACT"..i.."ELEVATION")
			param_azm = get_param_handle("RADAR_CONTACT"..i.."AZIMUTH")
			param_range = get_param_handle("RADAR_CONTACT"..i.."RANGE")
			sum_target = sum_target + 1
		end
		-- 目前测试时间相同，截止为程序开始前
		if ia == 1 then
			Radar.tdc_ele_up_h:set(test_param:get()) --用来测试两个时间是否一致
		elseif ia == 800 then
			Radar.tdc_ele_down_h:set(test_param:get())
		end
	end
	basic_gs_dis:set(sum_target)
end

local count = 0
function updateTargetBox()
    if Radar.mode_h:get() == 3 then
		isLock:set(1)
        target_dis:set(hud_dis:get())
		target_range:set(Radar.stt_range:get()/1000)
        target_x:set(math.tan(Radar.stt_azimuth_h:get())*15.5)
        target_y:set(math.tan(Radar.stt_elevation_h:get())*15.5)
    else
		isLock:set(0)
		target_range:set(0)
        target_dis:set(0)
        target_x:set(0)
        target_y:set(0)
    end
end
function update_TDC_pos()
	Radar.tdc_azi_h:set(Radar.tdc_azi_h:get()+tdc_azi_h_v)
	Radar.tdc_range_h:set(Radar.tdc_range_h:get()+tdc_range_h_v)
end
function update()
	update_radar()
	update_switch_status()
	updateTargetBox()
	update_TDC_pos()
	local hk_mode = hk_mode:get()
	if hk_mode == 1 or hk_mode == 3 then
		setRadarStable(false)--增稳关闭
	else
		setRadarStable(true)
	end
	count = count + update_time_step
	if count > 1 then
		
		--print_message_to_user()
		count = 0
	end
	-- 显示目标识别符当前位置海拔区间
	Radar.tdc_ele_up_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() + (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	Radar.tdc_ele_down_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() - (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	
	-- 更新飞机状态
	self_change_update()

	-- 显示雷达扫描指向
	if current_status[radar_mode][2] == SWITCH_ON then
		-- 扫描周期为41/50s
		-- 判断雷达教准状态，搜索模式下教准扫描状态
		-- 每个雷达结果生存周期为10s
		if (Radar.mode_h:get() == 1) then
			if (radar_scan_pos_align < 19 and radar_scan_align_target == 0) then
				radar_scan_pos_align = radar_scan_pos_align + 1
			elseif (radar_scan_pos_align >=19 and radar_scan_align_target == 0) then
				radar_scan_align_target = 1
				update_scan_result() -- 这里说明一个周期结束，开始刷新这一轮扫描数据
			elseif (radar_scan_pos_align > -20 and radar_scan_align_target == 1) then
				radar_scan_pos_align = radar_scan_pos_align - 1
			elseif (radar_scan_pos_align <= -20 and radar_scan_align_target == 1) then
				radar_scan_align_target = 0
				update_scan_result() -- 这里说明一个周期结束，开始刷新这一轮扫描数据
			end
		-- 若进入单目标锁定或准备锁定模式则重新教准
		elseif (Radar.mode_h:get() == 2 or Radar.mode_h:get() == 3) then
			radar_scan_pos_align = 0
			radar_scan_align_target = 0
		end
		Radar.antenna_pos:set(math.rad(radar_scan_pos_align * 2.5))
	end
	
end

function release()

end

function is_tracking(ID, weapon_type)
	print_message_to_user(ID)
end

need_to_be_closed = false --不关闭该lua