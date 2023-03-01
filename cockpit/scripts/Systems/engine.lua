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

local l_fan_v = 0
local r_fan_v = 0

local gauge_count = 0

local function _gauge_counter()
    gauge_count = gauge_count + 1
    return gauge_count
end

local left_eng_rpm = _gauge_counter()
local right_eng_rpm = _gauge_counter()

local Gauge_display_state = { -- last parameter define if it is unneed from 9 to zero
	{left_eng_rpm, 0, 0, get_param_handle("L_RPM"), 3, 0.04},
	{right_eng_rpm, 0, 0, get_param_handle("R_RPM"), 3, 0.04},
}

function update_eng_rpm()
	local l_eng_rpm = sensor_data.getEngineLeftRPM()
	local r_eng_rpm = sensor_data.getEngineRightRPM()
	
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


function post_initialize() --默认初始化函数
	
    local birth = LockOn_Options.init_conditions.birth_place
end

function SetCommand(command,value)
    
end

function update() --刷新状态
	update_eng_rpm()
	update_Gauge_Display()
end

need_to_be_closed = false 