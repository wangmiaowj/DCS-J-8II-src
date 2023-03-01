dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type       = indicator_types.COMMON----------------------
init_pageID     = 1
purposes 	   = {100,render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.SCREENSPACE_OUTSIDE_COCKPIT}
--subset ids
BASE    = 1
INDICATION = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."DBG/base_page.lua",
[INDICATION]    = LockOn_Options.script_path.."DBG/indication_page.lua",
}
pages = 
{
	{
	 BASE,
	 INDICATION
	 },
}


local w = LockOn_Options.screen.width*0.3
local h = w
local x = 0
local y = 0
dedicated_viewport 		  = {x,y,w,h}
dedicated_viewport_arcade = {x,y,w,h}
