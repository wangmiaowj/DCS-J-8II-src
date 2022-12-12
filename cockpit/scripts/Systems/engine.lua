dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."sounds_def.lua")
dofile(LockOn_Options.script_path.."devices.lua")
-- snd_device:performClickableAction(command,value,false)
 

local engine_system = GetSelf()
local dev = engine_system

local update_time_step = 0.02 --每秒50次调用update()函数
make_default_activity(update_time_step)

local sensor_data = get_base_data()

dev:listen_command(Keys.DropTankInd)
dev:listen_command(Keys.windshieldAntiIce)
dev:listen_command(Keys.pump3)
dev:listen_command(Keys.pump4)
dev:listen_command(Keys.groupSwitch01Up)
dev:listen_command(Keys.groupSwitch01Down)
dev:listen_command(Keys.Starter)
dev:listen_command(Keys.oilPump)
dev:listen_command(Keys.startUnit)
dev:listen_command(Keys.genOilPress)
dev:listen_command(Keys.afterBurn)
dev:listen_command(Keys.groupSwitch02Up)
dev:listen_command(Keys.groupSwitch02Down)
dev:listen_command(Keys.LeftEngineStart)
dev:listen_command(Keys.LeftEngineStop)
dev:listen_command(Keys.RightEngineStart)
dev:listen_command(Keys.RightEngineStop)

sndhost = create_sound_host("COCKPIT", "3D", 0, 0, 0)
aircraftSndhost = create_sound_host("WORLD", "3D", 0, 0, 0)

local l_fan_v = 0
local r_fan_v = 0

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

local switchGroup1 = get_param_handle("PNT_1145")
local switchGroup2 = get_param_handle("PNT_1151")
local right_throttle = get_param_handle("R_THROTTLE")
local left_throttle = get_param_handle("L_THROTTLE")

local left_eng_running = 0
local right_eng_running = 0
local motor_running = 0
local motor_working = 0

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local drop_tank_ind_switch = _switch_counter()--副油箱指示灯开关
local windshield_anti_ice_switch = _switch_counter()--风挡除冰开关
local pump_4_switch = _switch_counter()--油泵4开关
local pump_3_switch = _switch_counter()--油泵3开关
local oil_pump_switch = _switch_counter()--燃油泵开关
local start_unit_switch = _switch_counter()--启动单元开关
local gen_oil_press_switch = _switch_counter()--发电机油压开关
local afterburn_switch = _switch_counter()--加力燃烧室开关
local right_throttle_Idle = _switch_counter()
local left_throttle_Idle = _switch_counter()
local starter = _switch_counter()

target_status = {
    {drop_tank_ind_switch , SWITCH_OFF, get_param_handle("PNT_1141"), "PNT_1141"},
	{windshield_anti_ice_switch , SWITCH_OFF, get_param_handle("PNT_1142"), "PNT_1142"},
	{pump_4_switch , SWITCH_OFF, get_param_handle("PNT_1143"), "PNT_1143"},
	{pump_3_switch , SWITCH_OFF, get_param_handle("PNT_1144"), "PNT_1144"},
	{oil_pump_switch , SWITCH_OFF, get_param_handle("PNT_1147"), "PNT_1147"},
	{start_unit_switch , SWITCH_OFF, get_param_handle("PNT_1148"), "PNT_1148"},
	{gen_oil_press_switch , SWITCH_OFF, get_param_handle("PNT_1149"), "PNT_1149"},
	{afterburn_switch , SWITCH_OFF, get_param_handle("PNT_1150"), "PNT_1150"},
	{right_throttle_Idle , SWITCH_OFF, get_param_handle("R_ENG_IDLE"), "R_ENG_IDLE"},
	{left_throttle_Idle , SWITCH_OFF, get_param_handle("L_ENG_IDLE"), "L_ENG_IDLE"},
	{starter , SWITCH_OFF, get_param_handle("PNT_1146"), "PNT_1146"},
}

current_status = {
    {drop_tank_ind_switch , SWITCH_OFF, SWITCH_OFF},
	{windshield_anti_ice_switch , SWITCH_OFF, SWITCH_OFF},
	{pump_4_switch , SWITCH_OFF, SWITCH_OFF},
	{pump_3_switch , SWITCH_OFF, SWITCH_OFF},
	{oil_pump_switch , SWITCH_OFF, SWITCH_OFF},
	{start_unit_switch , SWITCH_OFF, SWITCH_OFF},
	{gen_oil_press_switch , SWITCH_OFF, SWITCH_OFF},
	{afterburn_switch , SWITCH_OFF, SWITCH_OFF},
	{right_throttle_Idle , SWITCH_OFF, SWITCH_OFF},
	{left_throttle_Idle , SWITCH_OFF, SWITCH_OFF},
	{starter , SWITCH_OFF, SWITCH_OFF},
}

gauge_count = 0
function _gauge_counter()
    gauge_count = gauge_count + 1
    return gauge_count
end

local motor_rpm = _gauge_counter()
local left_eng_rpm = _gauge_counter()
local right_eng_rpm = _gauge_counter()

Gauge_display_state = { -- last parameter define if it is unneed from 9 to zero
    {motor_rpm, 0, 0, get_param_handle("MOTOR_RPM"), 3, 0.2},
	{left_eng_rpm, 0, 0, get_param_handle("L_RPM"), 3, 0.04},
	{right_eng_rpm, 0, 0, get_param_handle("R_RPM"), 3, 0.04},
}

snd_count = 0
function _snd_counter()
    snd_count = snd_count + 1
    return snd_count
end

local motor_snd_start = _snd_counter()
local motor_snd_end = _snd_counter()

snd_state = {}

snd_3p_state = {}

function update_switch_status()
    local switch_moving_step = 0.15
    for k,v in pairs(target_status) do
        if k == right_throttle_Idle or k == left_throttle_Idle then
			switch_moving_step = 0.04
		else
			switch_moving_step = 0.15
		end
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

function update_motor_rpm()
	local motorRPM = 0
	if get_elec_ac_status() then
		local cheaks = {starter,pump_3_switch,pump_4_switch,oil_pump_switch,start_unit_switch,gen_oil_press_switch}
		local is_run = true
		for k,v in pairs(cheaks) do
			if current_status[cheaks[k]][2] == SWITCH_OFF then
				is_run = false
				break
			end
		end
		motorRPM = Gauge_display_state[motor_rpm][2]
		if is_run then
			motor_running = 1
			if motorRPM + 0.2 > 100 then
				motorRPM = 100
			else
				motorRPM = motorRPM+0.2
			end
		else
			motor_running = 0
			if motorRPM - 0.2 < 0 then
				motorRPM = 0
			else
				motorRPM = motorRPM - 0.2
			end
		end
	end
	
	if motor_running == 1 and not snd_state[motor_snd_start][2]:is_playing() then
		snd_state[motor_snd_start][2]:play_continue()
		snd_3p_state[motor_snd_start][2]:play_continue()
	elseif motor_running == 0 and snd_state[motor_snd_start][2]:is_playing() and not snd_state[motor_snd_end][2]:is_playing() then
		snd_state[motor_snd_start][2]:stop()
		snd_3p_state[motor_snd_start][2]:stop()
		snd_state[motor_snd_end][2]:play_continue()
		snd_3p_state[motor_snd_end][2]:play_continue()
	elseif motor_running == 0 and not snd_state[motor_snd_start][2]:is_playing() and snd_state[motor_snd_end][2]:is_playing() and snd_state[motor_snd_end][3] >= snd_state[motor_snd_end][4] then
		snd_state[motor_snd_end][2]:stop()
		snd_3p_state[motor_snd_end][2]:stop()
	end
	for k,v in pairs(snd_state) do
		local snd_pos = 0
		if snd_state[k][2]:is_playing() then
			snd_pos = snd_state[k][3]
			snd_pos = snd_pos + update_time_step
		end
		snd_state[k][3] = snd_pos
	end
	Gauge_display_state[motor_rpm][2] = motorRPM
end

function update_eng_rpm()
	local l_eng_rpm = 0
	local r_eng_rpm = 0
	local motorRPM = 0
	if get_elec_ac_status() then
		l_eng_rpm = sensor_data.getEngineLeftRPM()
		r_eng_rpm = sensor_data.getEngineRightRPM()
		motorRPM = Gauge_display_state[motor_rpm][4]:get()
		if current_status[left_throttle_Idle][2] == 1 and motorRPM >95 and left_eng_running == 0 and motor_working ==0 then
			left_eng_running = 1
			motor_working = 1
			dispatch_action(nil,Keys.PlaneLeftEngineStart)
		elseif (current_status[left_throttle_Idle][2] == 0 and left_eng_running == 1) or (motor_running == 0 and l_eng_rpm < 30 and left_eng_running == 1) then
			left_eng_running = 0
			dispatch_action(nil,Keys.PlaneLeftEngineStop)
		end
		if current_status[right_throttle_Idle][2] == 1 and motorRPM >95 and right_eng_running == 0 and motor_working == 0 then
			right_eng_running = 1
			motor_working = 1
			dispatch_action(nil,Keys.PlaneRightEngineStart)
		elseif (current_status[right_throttle_Idle][2] == 0 and right_eng_running == 1) or (motor_running == 0 and r_eng_rpm < 30 and right_eng_running == 1) then
			right_eng_running = 0
			dispatch_action(nil,Keys.PlaneRightEngineStop)
		end
	end
	if motor_working == 1 and ((l_eng_rpm > 45 and r_eng_rpm == 0) or (r_eng_rpm > 45 and l_eng_rpm == 0) or (r_eng_rpm > 45 and l_eng_rpm > 45)) then
		motor_working = 0
	end
	l_fan_v = l_eng_rpm/500
	r_fan_v = r_eng_rpm/500
	local r_v=get_aircraft_draw_argument_value(324)+r_fan_v
	if r_v > 1 then
		r_v = r_v-1
	end
	local l_v=get_aircraft_draw_argument_value(325)+l_fan_v
	if l_v > 1 then
		l_v = l_v-1
	end
	set_aircraft_draw_argument_value(324,r_v)
	set_aircraft_draw_argument_value(325,l_v)
	Gauge_display_state[left_eng_rpm][2] = l_eng_rpm
	Gauge_display_state[right_eng_rpm][2] = r_eng_rpm
	
end

function update_Gauge_Display()
    for k_G,v_G in pairs(Gauge_display_state) do
        if math.abs(Gauge_display_state[k_G][2] - Gauge_display_state[k_G][3]) < Gauge_display_state[k_G][6] then
            Gauge_display_state[k_G][3] = Gauge_display_state[k_G][2]
        elseif Gauge_display_state[k_G][5] == 1 then
            if Gauge_display_state[k_G][2] < Gauge_display_state[k_G][3] then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - Gauge_display_state[k_G][6]
            elseif Gauge_display_state[k_G][2] > Gauge_display_state[k_G][3] then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + Gauge_display_state[k_G][6]
            end
        elseif Gauge_display_state[k_G][5] == 2 then
            if Gauge_display_state[k_G][3] > 0.85 and Gauge_display_state[k_G][2] < - 0.85 then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + Gauge_display_state[k_G][6]
                if Gauge_display_state[k_G][3] > 1 then
                    Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - 2
                end
            elseif Gauge_display_state[k_G][3] < -0.85 and Gauge_display_state[k_G][2] > 0.85 then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - Gauge_display_state[k_G][6]
                if Gauge_display_state[k_G][3] < 0 then
                    Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + 2
                end
            else
                if Gauge_display_state[k_G][2] < Gauge_display_state[k_G][3] then
                    Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - Gauge_display_state[k_G][6]
                elseif Gauge_display_state[k_G][2] > Gauge_display_state[k_G][3] then
                    Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + Gauge_display_state[k_G][6]
                end
            end
        elseif Gauge_display_state[k_G][3] > 0.85 and Gauge_display_state[k_G][2] < 0.15 then
            Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + Gauge_display_state[k_G][6]
            if Gauge_display_state[k_G][3] > 1 then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - 1
            end
        elseif Gauge_display_state[k_G][3] < 0.15 and Gauge_display_state[k_G][2] > 0.85 then
            Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - Gauge_display_state[k_G][6]
            if Gauge_display_state[k_G][3] < 0 then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + 1
            end
		elseif Gauge_display_state[k_G][5] == 3 then
            Gauge_display_state[k_G][3] = Gauge_display_state[k_G][2]--直接绘制
        else
            if Gauge_display_state[k_G][2] < Gauge_display_state[k_G][3] then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] - Gauge_display_state[k_G][6]
            elseif Gauge_display_state[k_G][2] > Gauge_display_state[k_G][3] then
                Gauge_display_state[k_G][3] = Gauge_display_state[k_G][3] + Gauge_display_state[k_G][6]
            end
        end
        Gauge_display_state[k_G][4]:set(Gauge_display_state[k_G][3])
    end
end

function update_throttle()
	local l_throttle_pos = 0
	local r_throttle_pos = 0
	if current_status[left_throttle_Idle][2] == 1 then
		l_throttle_pos = sensor_data.getThrottleLeftPosition()
	end
	if current_status[right_throttle_Idle][2] == 1 then
		r_throttle_pos = sensor_data.getThrottleRightPosition()
	end
	right_throttle:set(r_throttle_pos)
	left_throttle:set(l_throttle_pos)
end

local function InitEngineSounds()
	--{index, 音源, 当前刻度, 音频长度}
	snd_state[motor_snd_start] = { motor_snd_start, sndhost:create_sound("Aircrafts/ASU"), 0, 20}
	snd_state[motor_snd_end] = { motor_snd_end, sndhost:create_sound("Aircrafts/ASU_End"), 0, 15}
	
	snd_3p_state[motor_snd_start] = { motor_snd_start, aircraftSndhost:create_sound("Aircrafts/ASU")}
	snd_3p_state[motor_snd_end] = { motor_snd_end, aircraftSndhost:create_sound("Aircrafts/ASU_End")}
end

function post_initialize() --默认初始化函数
	
    InitEngineSounds()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then --"GROUND_COLD","GROUND_HOT","AIR_HOT"
        for k,v in pairs(target_status) do
			if k ~= starter then
				target_status[k][2] = SWITCH_ON
				current_status[k][2] = SWITCH_ON
			end
		end
    elseif birth=="GROUND_COLD" then
		for k,v in pairs(target_status) do
			target_status[k][2] = SWITCH_OFF
			current_status[k][2] = SWITCH_OFF
		end
    end
end

function SetCommand(command,value)
    if command == Keys.DropTankInd then
		target_status[drop_tank_ind_switch][2] = 1 - target_status[drop_tank_ind_switch][2]
	elseif command == Keys.windshieldAntiIce then
		target_status[windshield_anti_ice_switch][2] = 1 - target_status[windshield_anti_ice_switch][2]
	elseif command == Keys.pump3 then
		target_status[pump_3_switch][2] = 1 - target_status[pump_3_switch][2]
	elseif command == Keys.pump4 then
		target_status[pump_4_switch][2] = 1 - target_status[pump_4_switch][2]
	elseif command == Keys.groupSwitch01Down then
		target_status[drop_tank_ind_switch][2] = SWITCH_ON
		target_status[windshield_anti_ice_switch][2] = SWITCH_ON
		target_status[pump_3_switch][2] = SWITCH_ON
		target_status[pump_4_switch][2] = SWITCH_ON
		switchGroup1:set(SWITCH_ON)
	elseif command == Keys.groupSwitch01Up then
		switchGroup1:set(SWITCH_OFF)
	elseif command == Keys.Starter then
		target_status[starter][2] = 1 - target_status[starter][2]
	elseif command == Keys.oilPump then
		target_status[oil_pump_switch][2] = 1 - target_status[oil_pump_switch][2]
	elseif command == Keys.startUnit then
		target_status[start_unit_switch][2] = 1 - target_status[start_unit_switch][2]
	elseif command == Keys.genOilPress then
		target_status[gen_oil_press_switch][2] = 1 - target_status[gen_oil_press_switch][2]
	elseif command == Keys.afterBurn then
		target_status[afterburn_switch][2] = 1 - target_status[afterburn_switch][2]
	elseif command == Keys.groupSwitch02Down then
		target_status[oil_pump_switch][2] = SWITCH_ON
		target_status[start_unit_switch][2] = SWITCH_ON
		target_status[gen_oil_press_switch][2] = SWITCH_ON
		target_status[afterburn_switch][2] = SWITCH_ON
		switchGroup2:set(SWITCH_ON)
	elseif command == Keys.groupSwitch02Up then
		switchGroup2:set(SWITCH_OFF)
	elseif command == Keys.LeftEngineStart then
		target_status[left_throttle_Idle][2] = SWITCH_ON
	elseif command == Keys.LeftEngineStop then
		target_status[left_throttle_Idle][2] = SWITCH_OFF
	elseif command == Keys.RightEngineStart then
		target_status[right_throttle_Idle][2] = SWITCH_ON
	elseif command == Keys.RightEngineStop then
		target_status[right_throttle_Idle][2] = SWITCH_OFF
	end
end

local count = 0
function update() --刷新状态
    update_switch_status()
	update_motor_rpm()
	update_eng_rpm()
	update_throttle()
	update_Gauge_Display()
	count = count + update_time_step
	
	if count > 1 then
		
		count = 0
	end
end

need_to_be_closed = false 