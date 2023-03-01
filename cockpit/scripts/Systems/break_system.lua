local Breaks = GetSelf()
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

-- ATTENTION: 空气刹车暂时不工作

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local fmt = '%.2f'

local air_brake_state=0
local air_brake_pos = 0

local air_brake_pos_ind = get_param_handle("AIRBRAKE_IND")
local flap_pos_ind = get_param_handle("FLAP_IND")

local parking_brake_handle = get_param_handle("PARKINGBREAK_HANDLE")

-- 减速伞工作情况
local drag_chute_target_state = 0 -- 0为关闭，1为打开，2为抛离
local drag_chute_pos = 0


local gear_state_share = get_param_handle("GEAR_SHARE")

local parking_brake_state = 0
local parking_brake_target = 0

local parking_brake_applied = 0

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
        
    elseif birth=="AIR_HOT" then
        
    elseif birth=="GROUND_COLD" then
        set_aircraft_draw_argument_value(23,1)
    end
end

Breaks:listen_command(72)
Breaks:listen_command(Keys.PlaneParachute)
Breaks:listen_command(145)
Breaks:listen_command(146)
-- listen to flap
Breaks:listen_command(Keys.Flap_Pos_Up)
Breaks:listen_command(Keys.Flap_Pos_Half)
Breaks:listen_command(Keys.Flap_Pos_Down)
Breaks:listen_event("WheelChocksOn")
Breaks:listen_event("WheelChocksOff")
Breaks:listen_event("Repair")
Breaks:listen_event("WeaponRearmFirstStep")

Flap_Target = 0
Flap_Current = 0

function SetCommand(command,value)
    if (command == 146) then
        if (Flap_Target > 0.1 and Flap_Target <= 0.7) then
            Flap_Target = 0
        elseif Flap_Target >= 0.8 then
            Flap_Target = 0.5
        end
    elseif (command == 145) then
        if (Flap_Target < 0.8 and Flap_Target > 0.3) then
            Flap_Target = 1
        elseif Flap_Target < 0.3 then
            Flap_Target = 0.5
        end
    elseif (command == 72) then
        -- this is warthunder like now
        if get_aircraft_draw_argument_value(0) > 0.5 then
            if Flap_Target > 0.3 then
                Flap_Target = 0
                --print_message_to_user("Flap: Retract")
            else
                if (sensor_data.getWOW_NoseLandingGear() > 0.0001) then
                    Flap_Target = 0.5
                   -- print_message_to_user("Flap: Takeoff")
                else
                    Flap_Target = 1
                    --print_message_to_user("Flap: Landing")
                end
            end
        else
            if Flap_Target > 0.3 then
                Flap_Target = 0
                --print_message_to_user("Flap: Retract")
            else
                Flap_Target = 0.5
                --print_message_to_user("Flap: Combat")
            end
        end
    elseif (command == Keys.Flap_Pos_Up) then
        Flap_Target = 0
    elseif (command == Keys.Flap_Pos_Half) then
        Flap_Target = 0.5
    elseif (command == Keys.Flap_Pos_Down) then
        Flap_Target = 1
    elseif command == Keys.PlaneParachute then
        local speed = sensor_data.getIndicatedAirSpeed()
        speed = speed * 3.6
        local is_on_ground = get_aircraft_draw_argument_value(1) > 0 or get_aircraft_draw_argument_value(4) > 0 or get_aircraft_draw_argument_value(6) > 0
        if is_on_ground then
            print_message_to_user('1')
            print_message_to_user(speed)
            print_message_to_user(drag_chute_target_state)
            print_message_to_user(drag_chute_pos)
        else

        end
        if is_on_ground and speed>60 and speed <400 and drag_chute_target_state==0 then
            drag_chute_target_state = 1
        elseif drag_chute_target_state == 1 and drag_chute_pos >0.9 then
            drag_chute_target_state = 2--丢弃伞
        end
    end
end

function update_chute()
    drag_chute_pos = get_aircraft_draw_argument_value(35)
    if drag_chute_target_state == 1 and drag_chute_pos < 0.5 then
        drag_chute_pos = drag_chute_pos + update_time_step*0.5 --拉伞
    elseif drag_chute_target_state == 1 and drag_chute_pos >= 0.5 and drag_chute_pos < 1 then
        drag_chute_pos = 1 --放伞
    elseif drag_chute_target_state == 2 and drag_chute_pos >= 0.98 then
        drag_chute_pos = 0.1 --丢伞
    elseif drag_chute_pos >= 0.08 and drag_chute_pos < 0.12 and drag_chute_target_state == 0 then
        drag_chute_pos = 0 --重新装填伞
    end
    set_aircraft_draw_argument_value(35,drag_chute_pos)
end

function update()
    update_chute()
    if (air_brake_pos < air_brake_state) then
		air_brake_pos = air_brake_pos + 0.02
    elseif (air_brake_pos > air_brake_state) then
        air_brake_pos = air_brake_pos - 0.02
    end
	--print_message_to_user("BREAKPOS")
	--print_message_to_user(air_brake_pos)
	--print_message_to_user("BREAKTAR")
    --print_message_to_user(air_brake_state)
    if (parking_brake_state < parking_brake_target) and (parking_brake_target == 1) then
        parking_brake_state = parking_brake_state + 0.1
    elseif (parking_brake_state > parking_brake_target) and (parking_brake_target == 0) then
        parking_brake_state = parking_brake_state - 0.1
    end

    parking_brake_handle:set(parking_brake_state)
    --print_message_to_user(parking_brake_state)
    local flap_moving_step = 0.02 / 5
    -- update flap status
    if math.abs(Flap_Target - Flap_Current) < flap_moving_step then
        Flap_Current = Flap_Target
    else
        if Flap_Target < Flap_Current then
            Flap_Current = Flap_Current - flap_moving_step
        elseif Flap_Current < Flap_Target then
            Flap_Current = Flap_Current + flap_moving_step
        end
    end
    set_aircraft_draw_argument_value(9,Flap_Current)
    set_aircraft_draw_argument_value(10,Flap_Current)
    set_aircraft_draw_argument_value(13,Flap_Current)
    set_aircraft_draw_argument_value(14,Flap_Current)
    if get_elec_ac_status() or get_elec_dc_status() then
		flap_pos_ind:set(Flap_Current)
		air_brake_pos_ind:set(air_brake_pos)
	else
		flap_pos_ind:set(0)
		air_brake_pos_ind:set(0)
	end
end
function CockpitEvent(event, val)
    if event == "WheelChocksOn" then
        set_aircraft_draw_argument_value(23,1)
        print_message_to_user('轮档放置')
    elseif event == "WheelChocksOff" then
        print_message_to_user('轮档移除')
        set_aircraft_draw_argument_value(23,0)
    elseif event == "Repair" then
        drag_chute_target_state = 0
    elseif event == "WeaponRearmFirstStep" then
        drag_chute_target_state = 0
    end
end
--不关闭该lua
need_to_be_closed = false
