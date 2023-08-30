dofile(LockOn_Options.script_path.."command_defs.lua")
--dofile(LockOn_Options.script_path.."sound_params.lua")
local update_rate = 1/60
make_default_activity(update_rate)
local dev = GetSelf()
local sensor_data = get_base_data()


MAX_MENU = 8
--Head args
--39 = left right
--99 = up down
local menu_index = {}
local menu_title = {
	[1] = {
		title="武器配置",
		subMenu={
			[1]={
				title=""
			}
		}
	}
}


local headLeftRight = get_param_handle("HEAD_LR")
local headUpDown = get_param_handle("HEAD_UD")
local cursorVisibility = get_param_handle("CURSOR_SHOW")

local menuStatus = 0
local submenu = {}

submenu[0] = 0
submenu[1] = 0

dev:listen_command(1000040)



function post_initialize()
	cursorVisibility:set(0)


	local maxDistance = 0.33


	get_param_handle("MENU_1_X"):set(0)
	get_param_handle("MENU_1_Y"):set(maxDistance)

	get_param_handle("MENU_2_X"):set(maxDistance)
	get_param_handle("MENU_2_Y"):set(maxDistance)

	get_param_handle("MENU_3_X"):set(maxDistance)
	get_param_handle("MENU_3_Y"):set(0)

	get_param_handle("MENU_4_X"):set(maxDistance)
	get_param_handle("MENU_4_Y"):set(-maxDistance)

	get_param_handle("MENU_5_X"):set(0)
	get_param_handle("MENU_5_Y"):set(-maxDistance)

	get_param_handle("MENU_6_X"):set(-maxDistance)
	get_param_handle("MENU_6_Y"):set(-maxDistance)

	get_param_handle("MENU_7_X"):set(-maxDistance)
	get_param_handle("MENU_7_Y"):set(0)

	get_param_handle("MENU_8_X"):set(-maxDistance)
	get_param_handle("MENU_8_Y"):set(maxDistance)




	local birth = LockOn_Options.init_conditions.birth_place
	if birth == "GROUND_HOT" or birth == "AIR_HOT" then

	elseif birth=="GROUND_COLD" then

	end
end





function SetCommand(command,value)

	if command == 1000040 then --menu pressed

		if menuStatus == 0 then --menu not shown

			menuStatus = 1 -- show menu
			--resetLoopingAudio()

		elseif menuStatus == 1 then --menu shown

			local onSubMenu = false
			for i=1,MAX_MENU do
	
				if hitBoxMenu(headLeftRight:get(),headUpDown:get(), i) == true then --check that we are on a submenu
					onSubMenu = true	--we are on a submenu
					if submenu[0] == 0 then
						submenu[0] = i -- submenu ID
					else
						submenu[1] = i -- submenu ID
					end
					
				end
			end

			if onSubMenu == false then --we are not on a submenu
				menuStatus = 0 -- hide menu
				submenu[0] = 0
				submenu[1] = 0
			end

			
		end

	end

end


function update()	
	
	if get_aircraft_draw_argument_value(472) >= 0 and get_aircraft_draw_argument_value(472) < 0.5 then -- someone is in the backseat

		headLeftRight:set(get_aircraft_draw_argument_value(39))
		headUpDown:set(get_aircraft_draw_argument_value(99))
	
		updateMenu(menuStatus)
		doAction(submenu)


	else
		
		cursorVisibility:set(0)
		for i=1,MAX_MENU do
			menuShow = get_param_handle("MENU_"..tostring(i).."_SHOW")
			menuShow:set(0)
		end
	end
end


function updateMenu(menu)
	
	local menuText
	local menuShow

	if menu == 0 then --menu hidden
		cursorVisibility:set(0)

		for i=1,MAX_MENU do
			menuShow = get_param_handle("MENU_"..tostring(i).."_SHOW")
			menuShow:set(0)
		end


	elseif menu == 1 then -- menu level 1
		if submenu[0] == 0 then -- no submenu

			cursorVisibility:set(2)
			for i=1,MAX_MENU do
				menuText = get_param_handle("MENU_"..tostring(i).."_TXT")
				menuShow = get_param_handle("MENU_"..tostring(i).."_SHOW")
				menuShow:set(2)

				menuText:set("菜单"..tostring(i)..'示例')

				

				if hitBoxMenu(headLeftRight:get(),headUpDown:get(), i) == true then
					get_param_handle("CURSOR_TOP_"..tostring(i)):set(1)
				else
					get_param_handle("CURSOR_TOP_"..tostring(i)):set(0)
				end
			end
		else -- in submenu

			if submenu[0] == 1 then -- clicked on menu 1

				for i=1,MAX_MENU do
					menuText = get_param_handle("MENU_"..tostring(i).."_TXT")
					menuShow = get_param_handle("MENU_"..tostring(i).."_SHOW")
					menuShow:set(2)
	
					menuText:set("子菜单"..tostring(submenu[0]).." \n "..tostring(i).."\n示例")

					if hitBoxMenu(headLeftRight:get(),headUpDown:get(), i) == true then
						get_param_handle("CURSOR_TOP_"..tostring(i)):set(1)
					else
						get_param_handle("CURSOR_TOP_"..tostring(i)):set(0)
					end
				end

			else --clicked on any other menu
				print_message_to_user("欢迎使用菜单: "..tostring(submenu[0].." | "..tostring(submenu[1])))
			end			

		end
	end

end

function hitBoxMenu(x,y, menuId) -- return true if cursor on a submenu

	maxDistance = 0.33
	local m1x = 0
	local m1y = maxDistance

	local m2x = maxDistance
	local m2y = maxDistance

	local m3x = maxDistance
	local m3y = 0

	local m4x = maxDistance
	local m4y = -maxDistance

	local m5x = 0
	local m5y = -maxDistance

	local m6x = -maxDistance
	local m6y = -maxDistance

	local m7x = -maxDistance
	local m7y = 0

	local m8x = -maxDistance
	local m8y = maxDistance

	local OnX = false
	local onY = false

	local tolerence = 0.05


	if menuId == 1 then


		if x - m1x <= tolerence and x - m1x >= -tolerence then
			OnX = true
		else
			OnX = false
		end

		if y - m1y <= tolerence and y - m1y >= -tolerence then
			OnY = true
		else
			OnY = false
		end

	 elseif menuId == 2 then

	 	if x - m2x <= tolerence and x - m2x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m2y <= tolerence and y - m2y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	 elseif menuId == 3 then

	 	if x - m3x <= tolerence and x - m3x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m3y <= tolerence and y - m3y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	 elseif menuId == 4 then
		
	 	if x - m4x <= tolerence and x - m4x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m4y <= tolerence and y - m4y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	 elseif menuId == 5 then
				
	 	if x - m5x <= tolerence and x - m5x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m5y <= tolerence and y - m5y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	 elseif menuId == 6 then
				
	 	if x - m6x <= tolerence and x - m6x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m6y <= tolerence and y - m6y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	 elseif menuId == 7 then
				
	 	if x - m7x <= tolerence and x - m7x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m7y <= tolerence and y - m7y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	 elseif menuId == 8 then
				
	 	if x - m8x <= tolerence and x - m8x >= -tolerence then
	 		OnX = true
	 	else
	 		OnX = false
	 	end

	 	if y - m8y <= tolerence and y - m8y >= -tolerence then
	 		OnY = true
	 	else
	 		OnY = false
	 	end

	end


	
	if OnX and OnY then
		return true
	else
		return false
	end
	
end


function doAction(menu)

	
	if submenu[0] == 1 then --menu 1

		if submenu[1] == 1 then --sub 1
			--do stuff
		end

		if submenu[1] == 2 then 

		end

		if submenu[1] == 3 then 
		
		end

		if submenu[1] == 4 then
			

		end

		if submenu[1] == 5 then 
			
		end

		if submenu[1] == 6 then

		end

		if submenu[1] == 7 then 
			

		end

		if submenu[1] == 8 then 

		end


	elseif submenu[0] == 2 then -- menu 2


	end

end