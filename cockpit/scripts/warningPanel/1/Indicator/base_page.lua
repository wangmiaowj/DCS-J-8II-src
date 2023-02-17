dofile(LockOn_Options.script_path.."warningPanel/def.lua")
local aspect       = GetAspect()

local warning_panel_4_base          = CreateElement "ceSimple"
warning_panel_4_base.name     = create_guid_string()
warning_panel_4_base.init_pos = { 0, 0, 0 }
Add(warning_panel_4_base)

local glass1 			 	 = CreateElement "ceMeshPoly"
glass1.name 			 = create_guid_string()
glass1.primitivetype = "triangles"
glass1.vertices 	   = { {1, aspect * 1}, { 1,-aspect}, { -1,-aspect}, {-1,aspect * 1}, }
glass1.indices 		 = {0,1,2,0,2,3,}
glass1.init_pos		 =  {0, 0} 
glass1.init_rot		 = {0, 0} 
glass1.material		 = MakeMaterial(nil,{255,0,0,20})--red
glass1.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass1.level			 = WARNING_PANEL_DEFAULT_NOCLIP_LEVEL
glass1.parent_element = warning_panel_4_base.name
glass1.isdraw		 = true
glass1.change_opacity = false
glass1.isvisible		 = false
Add(glass1)

local backGround 			 	 = CreateElement "ceMeshPoly"
backGround.name 			 = create_guid_string()
backGround.primitivetype = "triangles"
backGround.vertices 	   =  { {1, aspect * 0.9}, { 1,-aspect*0.9}, { -1,-aspect*0.9}, {-1,aspect * 0.9}, }
backGround.indices 		 = {0,1,2,0,2,3,}
backGround.init_pos		 =  {0, 0}
backGround.init_rot		 = {0, 0}
backGround.material		 = MakeMaterial(nil,{0, 255, 0, 45})--green
--backGround.element_params   = {"HUD_DIS_ENABLE"} 
--backGround.controllers 	   = {{"opacity_using_parameter",0}}
backGround.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
backGround.level			 = WARNING_PANEL_DEFAULT_NOCLIP_LEVEL
backGround.isdraw		 = true
backGround.change_opacity = false
backGround.parent_element = warning_panel_4_base.name
backGround.isvisible		 = false
Add(backGround)