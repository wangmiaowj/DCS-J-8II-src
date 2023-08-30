dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
--dofile(LockOn_Options.script_path.."Systems/flight_model_api.lua")
--dofile(LockOn_Options.script_path.."Systems/environnement_api.lua")
--dofile(LockOn_Options.script_path.."sound_params.lua")


indicator_type       = indicator_types.COMMON
purposes 	   = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 4;

JOJO    	= 1

page_subsets  = {
	[JOJO]			= LockOn_Options.script_path.."Displays/jojoIa/JOJO_PAGE.lua",
}

pages = {
	{ JOJO,	},
}


init_pageID = 1


-- HUD only view diplacement
function JOJO_set_screenspace_displacement(aspect, left_center_right, zoom_value)
    local w = LockOn_Options.screen.width;
    local h = LockOn_Options.screen.height;

    if LockOn_Options.screen.oculus_rift then
        local ui_x,ui_y,ui_w,ui_h = get_UIMainView()
        w = ui_w;
        h = ui_h;
    end

    local x0 = 0
    local w0 = 0.5 * h

    local aspect     =     aspect or 1
    local zoom_value = zoom_value or 1
    local default_width  = w0

    if default_width > h then
       default_width = h
    end

    if default_width > 0.5 * w then
       default_width = 0.5 * w
    end

    default_width = default_width * math.abs(zoom_value)
    local default_height = default_width / aspect
    local default_y      = h - default_height
    local default_x      = w - default_width - x0

    if left_center_right == -1 then -- left
        default_x   = x0
    else
        if left_center_right == 0 then -- center
            default_x = default_x /2
        end
    end

    dedicated_viewport           = {default_x,default_y,default_width,default_height}
    dedicated_viewport_arcade = {default_x, 0        ,default_width,default_height}
end



update_screenspace_diplacement(SelfWidth/SelfHeight,false)

--dedicated_viewport_arcade = dedicated_viewport
