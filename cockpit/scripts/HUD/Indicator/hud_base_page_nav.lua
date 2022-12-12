dofile(LockOn_Options.script_path.."HUD/Indicator/hud_def.lua")

SHOW_MASKS = false

-- 这个操作可以将新建的裁剪块对齐到三个标记
local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect()

-- 这个是最上面的总仪表裁剪层
HUD_base_clip 			 	    = CreateElement "ceMeshPoly" --这是裁剪层
HUD_base_clip.name 			    = "BASE_FLAT_IND_clip"
HUD_base_clip.primitivetype   	= "triangles"
HUD_base_clip.vertices 		    = { {1, aspect * 0.8}, { 1,-aspect}, { -1,-aspect}, {-1,aspect * 0.8}, } --四个边角
HUD_base_clip.indices 		    = {0,1,2,0,2,3,}
HUD_base_clip.init_pos		    = {0, 0, 0}
HUD_base_clip.init_rot		    = {0, 0, 0}
HUD_base_clip.material		    = "DBG_GREY"
HUD_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
HUD_base_clip.level			    = HUD_BASE_DEFAULT_NOCLIP_LEVEL
HUD_base_clip.isdraw		    = true
HUD_base_clip.change_opacity    = false
HUD_base_clip.element_params    = {"HUD_DIS_ENABLE"}              -- 初始化主显示控制
HUD_base_clip.controllers       = {{"opacity_using_parameter",0}}
HUD_base_clip.isvisible		    = SHOW_MASKS
Add(HUD_base_clip)

-- 主显示位置裁剪层
Base_Indication_clip 			            = CreateElement "ceMeshPoly" --这是创建一个平面
Base_Indication_clip.name 			        = "hud_base_clip"
Base_Indication_clip.vertices 		        = { {2, 2 * aspect}, { 2, -2 * aspect}, { -2,-2 * aspect}, {-2, 2 * aspect},} --四个边角
Base_Indication_clip.indices 		        = {0,1,2,0,3,2}
Base_Indication_clip.init_pos		        = {0 , default_hud_y_offset - 0.1 , default_hud_z_offset}
Base_Indication_clip.init_rot		        = {0, 0, default_hud_rot_offset}
Base_Indication_clip.material		        = "DBG_GREEN"
Base_Indication_clip.h_clip_relation        = h_clip_relations.INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
Base_Indication_clip.level			        = HUD_BASE_DEFAULT_LEVEL - 1
Base_Indication_clip.isdraw		            = true
Base_Indication_clip.change_opacity         = false
Base_Indication_clip.element_params         = {"HUD_DIS_ENABLE"}              -- 初始化主显示控制
Base_Indication_clip.controllers            = {{"opacity_using_parameter",0}}
Base_Indication_clip.isvisible		        = SHOW_MASKS
Add(Base_Indication_clip)

-- target_box 			            = CreateElement "ceMeshPoly" --这是创建一个平面
-- target_box.name 			        = create_guid_string()
-- target_box.vertices 		        = {{0,1},{1,0},{0,-1},{-1,0},{0,0}}--{{0,0.1},{0.1,0},{0.09,0},{0,0.09},{0,-0.1},{0,-0.09},{-0.1,0},{-0.09,0}}
-- target_box.indices 		        = {0,1,4,2,1,4,2,3,4,2,4,0}--{0,1,2,2,3,0,1,4,5,5,4,1,4,6,7,7,6,4,6,0,2,2,0,6}
-- target_box.init_pos		        = {0, 0, default_hud_z_offset}
-- target_box.init_rot		        = {0, 0, default_hud_rot_offset}
-- target_box.material		        = MakeMaterial(nil,{0, 255, 0, 255})
-- target_box.h_clip_relation       = h_clip_relations.COMPARE--COMPARE --REWRITE_LEVEL
-- target_box.level			        = HUD_DEFAULT_LEVEL
-- target_box.change_opacity        = false
-- target_box.parent_element       = "hud_base_clip"
-- Add(target_box)

-- 加载警告标记
dofile(LockOn_Options.script_path.."HUD/Indicator/hud_warning_sign.lua")
-- 加载导航标记
dofile(LockOn_Options.script_path.."HUD/Indicator/hud_nav_page.lua")