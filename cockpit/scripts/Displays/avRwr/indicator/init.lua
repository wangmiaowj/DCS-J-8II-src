dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type       = indicator_types.COMMON----------------------
init_pageID     = 1
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
--subset ids
BASE    = 1
INDICATION = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path .. "Displays/avRwr/Indicator/base_page.lua",
[INDICATION]    = LockOn_Options.script_path .. "Displays/avRwr/Indicator/indication_page.lua",
}
pages = 
{
	{
	 BASE,
	 INDICATION
	 },
}


update_screenspace_diplacement(1,true)
dedicated_viewport[1]=0
dedicated_viewport[2]=0
--固定在屏幕左上角
dedicated_viewport[3]=dedicated_viewport[3]*0.5
dedicated_viewport[4]=dedicated_viewport[4]*0.5
dedicated_viewport_arcade = dedicated_viewport
