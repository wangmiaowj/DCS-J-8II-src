dofile(LockOn_Options.script_path .. "Displays/HUD/Indicator/hud_def.lua")

SHOW_MASKS = false

-- 这个操作可以将新建的裁剪块对齐到三个标记
local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect()

-- 这个是最上面的总仪表裁剪层
HUD_base_clip 			 	    = CreateElement "ceMeshPoly" --这是裁剪层
HUD_base_clip.name 			    = "hud_base_data_clip"
HUD_base_clip.primitivetype   	= "triangles"
HUD_base_clip.vertices 		    = { {1, aspect * 0.8}, { 1,-aspect}, { -1,-aspect}, {-1,aspect * 0.8}, } --四个边角
HUD_base_clip.indices 		    = {0,1,2,0,2,3,}
HUD_base_clip.init_pos		    = {0, 0, 0}
HUD_base_clip.init_rot		    = {0, 0, 0}
HUD_base_clip.material		    = "DBG_GREY"
HUD_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
HUD_base_clip.level			    = HUD_DEFAULT_NOCLIP_LEVEL
HUD_base_clip.isdraw		    = true
HUD_base_clip.collimated		= false
HUD_base_clip.change_opacity    = false
HUD_base_clip.element_params    = {"HUD_BRT"}              -- 初始化主显示控制
HUD_base_clip.controllers       = {{"opacity_using_parameter",0}}
HUD_base_clip.isvisible		    = SHOW_MASKS
Add(HUD_base_clip)

-- 速度移动条裁剪层
speed_move_clip 			            = CreateElement "ceMeshPoly" --这是创建一个平面
speed_move_clip.name 			        = "speed_move_clip"
speed_move_clip.vertices 		        = hud_duo_vert_gen(680, 2600, 232)
speed_move_clip.indices 		        = {0,1,2,0,3,2,4,5,6,5,6,7}
speed_move_clip.init_pos		        = { - 1 , default_hud_y_offset - 0.1 , default_hud_z_offset}
speed_move_clip.init_rot		        = {0, 0, default_hud_rot_offset}
speed_move_clip.material		        = "DBG_GREEN"
speed_move_clip.h_clip_relation         = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
speed_move_clip.level			        = HUD_DEFAULT_LEVEL - 1
speed_move_clip.change_opacity          = false
speed_move_clip.collimated 		        = true
speed_move_clip.element_params          = {"HUD_BRT","HUD_DETAIL_DATA_DIS"}
speed_move_clip.controllers             = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.5,1.1}}
speed_move_clip.isvisible		        = SHOW_MASKS
--speed_move_clip.parent_element	       = "hud_base_data_clip"
Add(speed_move_clip)

-- 高度移动条裁剪层
altitude_move_clip 			                = CreateElement "ceMeshPoly" --这是创建一个平面
altitude_move_clip.name 			        = "altitude_move_clip"
altitude_move_clip.vertices 		        = hud_duo_vert_gen(680, 2600, 232)
altitude_move_clip.indices 		            = {0,1,2,0,3,2,4,5,6,5,6,7}
altitude_move_clip.init_pos		            = { 1 , default_hud_y_offset - 0.1 , default_hud_z_offset}
altitude_move_clip.init_rot		            = {0, 0, default_hud_rot_offset}
altitude_move_clip.material		            = "DBG_GREEN"
altitude_move_clip.h_clip_relation          = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
altitude_move_clip.level			        = HUD_DEFAULT_LEVEL - 1
altitude_move_clip.change_opacity           = false
altitude_move_clip.collimated 		        = true
altitude_move_clip.element_params          = {"HUD_BRT","HUD_DETAIL_DATA_DIS"}
altitude_move_clip.controllers             = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.5,1.1}}
altitude_move_clip.isvisible		        = SHOW_MASKS
Add(altitude_move_clip)

-- 航向移动条裁剪层
heading_move_clip 			            = CreateElement "ceMeshPoly" --这是创建一个平面
heading_move_clip.name 			        = "heading_move_clip"
heading_move_clip.vertices 		        = hud_vert_gen(3200, 300) --四个边角
heading_move_clip.indices 		        = {0,1,2,0,3,2}
heading_move_clip.init_pos		        = {0 , default_hud_y_offset + 1750 / 2000 , default_hud_z_offset}
heading_move_clip.init_rot		        = {0, 0, default_hud_rot_offset}
heading_move_clip.material		        = "DBG_GREEN"
heading_move_clip.h_clip_relation       = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
heading_move_clip.level			        = HUD_DEFAULT_LEVEL - 1
heading_move_clip.change_opacity        = false
heading_move_clip.collimated            = true
heading_move_clip.element_params        = {"HUD_BRT"}              -- 初始化主显示控制
heading_move_clip.controllers           = {{"opacity_using_parameter",0}}
heading_move_clip.isvisible		        = SHOW_MASKS
Add(heading_move_clip)


-- 加载浮动标记
dofile(LockOn_Options.script_path .. "Displays/HUD/Indicator/hud_base_data.lua")
dofile(LockOn_Options.script_path .. "Displays/HUD/Indicator/hud_base_page_nav.lua")