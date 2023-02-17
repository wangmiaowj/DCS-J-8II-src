dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."debug_util.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local Canopy = 71  --定义舱盖按键
local PlaneEject = Keys.Eject

local CANOPY_COMMAND = 1   --舱盖状态 0 关闭, 1 开启
local CANOPY_ANI_INSIDE = get_param_handle("CPT_COVER")
local Eject_pwr1 = get_param_handle("PNT_1014")
local Eject_pwr2 = get_param_handle("PNT_1015")
local Eject_pwr3 = get_param_handle("PNT_1016")
local canopy_handle = get_param_handle('CANOPY')

local CanoStatus = 0
local EjectStatus = 0

local canopy_system = GetSelf()

canopy_system:listen_command(Canopy)
canopy_system:listen_command(PlaneEject)--弹射按键
local function InitCanopySounds()
	OpenSndCpt = sndhost:create_sound("Aircrafts/A-10/Cockpit/CanopyCloseCpt")
	CloseSndCpt = sndhost:create_sound("Aircrafts/A-10/Cockpit/CanopyOpenCpt")
    EndSndCpt = sndhost:create_sound("Aircrafts/A-10/Cockpit/CanopyEndCpt")
end
function post_initialize()
    sndhost = create_sound_host("COCKPIT_BACK", "3D", -1, 0, 0)
    InitCanopySounds()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
        CANOPY_COMMAND = 0
		CanoStatus = 0
    elseif birth=="AIR_HOT" then
        CANOPY_COMMAND = 0
		CanoStatus = 0
    elseif birth=="GROUND_COLD" then
        CANOPY_COMMAND = 1
		CanoStatus = 0.9
    end
	--set_aircraft_draw_argument_value(38,CanoStatus)
end

local PlaneEjectCount = 0
local PlaneEjectTrigTime = 2
function SetCommand(command,value)
	if (command == Canopy) then
        CANOPY_COMMAND = 1 - CANOPY_COMMAND
        if (CANOPY_COMMAND == 1) then
            OpenSndCpt:play_continue()
            CloseSndCpt:stop()
        else
            OpenSndCpt:stop()
            CloseSndCpt:play_continue()
        end
	elseif command == PlaneEject and get_elec_ac_status() then
		PlaneEjectCount = PlaneEjectCount + 1
	end
end

function update()		
	if (CANOPY_COMMAND == 0 and CanoStatus > 0 and EjectStatus == 0) then
		--close
		CanoStatus = CanoStatus - 0.004
		if CanoStatus < 0 then
			CloseSndCpt:stop()
            EndSndCpt:play_once()-- body
			CanoStatus = 0
		end
	elseif (CANOPY_COMMAND == 1 and CanoStatus < 0.9 and EjectStatus == 0) then
        -- open
		CanoStatus = CanoStatus + 0.004
        if CanoStatus > 0.9 then
			CanoStatus = 0.9
            OpenSndCpt:stop()
            EndSndCpt:play_once()-- body
        end
	else
		OpenSndCpt:stop()
		CloseSndCpt:stop()
    end
	--跳伞
	if PlaneEjectCount > 0 and get_elec_ac_status() then
		PlaneEjectTrigTime = PlaneEjectTrigTime - update_time_step
		if(PlaneEjectTrigTime > 0 and PlaneEjectCount > 2 and Eject_pwr1:get() >= 1 and Eject_pwr2:get() >= 1 and Eject_pwr3:get() >= 1) then
			--弹射倒计时结束前弹射键按了3次以上就执行跳伞
			print_message_to_user("跳伞")
			CanoStatus = 1
			EjectStatus = 1
			PlaneEjectTrigTime = 0
			PlaneEjectCount = 0
		elseif PlaneEjectTrigTime <= 0 then
			--未达到条件，放弃跳伞
			PlaneEjectTrigTime = 2
			PlaneEjectCount = 0
		end
    end
    set_aircraft_draw_argument_value(38,CanoStatus)
	if get_elec_dc_status() then
		canopy_handle:set(CanoStatus)
	else
		canopy_handle:set(0)
	end
    CANOPY_ANI_INSIDE:set(CanoStatus)
	if EjectStatus == 1 then
		for i=0,2,1 do
			dispatch_action(nil,Keys.PlaneEject,1)
		end
	end
end

need_to_be_closed = false