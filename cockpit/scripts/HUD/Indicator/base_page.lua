dofile(LockOn_Options.script_path.."HUD/Indicator/hud_def.lua")
local aspect       = GetAspect()

local glass1 			 	 = CreateElement "ceMeshPoly"
glass1.name 			 = "glass1"
glass1.primitivetype = "triangles"
glass1.vertices 	   = { {1, aspect * 0.8}, { 1,-aspect}, { -1,-aspect}, {-1,aspect * 0.8}, }
glass1.indices 		 = {0,1,2,0,2,3,}
glass1.init_pos		 =  {0, 0} 
glass1.init_rot		 = {0, 0} 
glass1.material		 = MakeMaterial(nil,{255,0,0,20})--red
glass1.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass1.level			 = HUD_DEFAULT_NOCLIP_LEVEL
glass1.isdraw		 = true
glass1.change_opacity = false
glass1.isvisible		 = false
Add(glass1)

local FOV 			 	 = CreateElement "ceMeshPoly"
FOV.name 			 = "FOV"
FOV.primitivetype = "triangles"
FOV.vertices 	   =  { {1, aspect * 0.8}, { 1,-aspect}, { -1,-aspect}, {-1,aspect * 0.8}, }
FOV.indices 		 = {0,1,2,0,2,3,}
FOV.init_pos		 =  {0, 0}
FOV.init_rot		 = {0, 0}
FOV.material		 = MakeMaterial(nil,{0, 255, 0, 45})--green
FOV.element_params   = {"HUD_DIS_ENABLE"} 
FOV.controllers 	   = {{"opacity_using_parameter",0}}
FOV.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
FOV.level			 = HUD_DEFAULT_NOCLIP_LEVEL
FOV.isdraw		 = true
FOV.change_opacity = false
FOV.isvisible		 = false
Add(FOV)