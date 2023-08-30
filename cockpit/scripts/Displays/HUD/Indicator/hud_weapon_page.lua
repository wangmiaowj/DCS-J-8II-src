local x_scale = 1.35
local y_scale = 1.43
target_box 			            = CreateElement "ceMeshPoly" --这是创建一个平面
target_box.name 			        = create_guid_string()
target_box.vertices 		        = {{0,0.05},{0,0.04},{0.05,0},{0.04,0},{0,-0.05},{0,-0.04},{-0.05,0},{-0.04,0}}
target_box.indices 		        = {0,1,2,2,3,1,3,2,5,5,4,2,4,5,6,6,7,5,6,7,0,0,1,7}
--target_box.vertices 		        = {{1,1},{1,-1},{-1,-1},{-1,1}}
--target_box.indices 		        = {0,1,2,2,3,0}
target_box.init_pos		        = {0, 0}
target_box.init_rot		        = {0, 0, default_hud_rot_offset}
target_box.element_params           = {"TARGET_BOX_DIS_ENABLE","TARGET_BOX_Y","TARGET_BOX_X"} --, "D_GUNSIGHT_VISIBLE"
target_box.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1,y_scale},{"move_left_right_using_parameter",2,x_scale}}
target_box.material		        = MakeMaterial(nil,{0, 255, 0, 255})
target_box.h_clip_relation       = h_clip_relations.COMPARE--COMPARE --REWRITE_LEVEL
target_box.level			        = HUD_BASE_DEFAULT_LEVEL
target_box.change_opacity        = false
target_box.parent_element       = "hud_base_clip"
Add(target_box)

local line_shape           = CreateElement "ceSimpleLineObject"
line_shape.name            = create_guid_string()
line_shape.width           = 0.004
line_shape.vertices        = {{0,0},{1,0}}
line_shape.init_pos        = { 0, 0 }
line_shape.init_rot        = { 0, 0 }
line_shape.tex_params      = {{0, 0.5}, {1, 0.5}, {1 / (1024 * 100 / 275), 1}}
line_shape.isdraw		   = true
line_shape.material        = MakeMaterial(nil,{0, 255, 0, 255})
line_shape.additive_alpha  = false
line_shape.collimated      = false
line_shape.use_mipfilter   = true
line_shape.parent_element  = "hud_base_clip"
line_shape.h_clip_relation = h_clip_relations.COMPARE
line_shape.level           = HUD_BASE_DEFAULT_LEVEL
line_shape.isdraw          = true
line_shape.element_params           = {"TARGET_BOX_DIS_ENABLE","TARGET_BOX_X","TARGET_BOX_Y","TARGET_BOX_X_2","TARGET_BOX_Y_2"} --, "D_GUNSIGHT_VISIBLE"
line_shape.controllers              = {{"opacity_using_parameter",0},{"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},{"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}}
Add(line_shape)

target_range             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
target_range.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
target_range.init_pos          = {-0.1 , 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
target_range.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
target_range.stringdefs        = {0.008,0.008, 0, 0}   --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
target_range.formats           = {"%.2fKM","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
target_range.element_params    = {"TARGET_RANGE","TARGET_BOX_DIS_ENABLE"}
target_range.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
target_range.collimated        = true
target_range.use_mipfilter     = true
target_range.additive_alpha    = true
target_range.isvisible		 = true
target_range.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
target_range.level			 = HUD_BASE_DEFAULT_LEVEL
target_range.parent_element    = target_box.name  --父节点名字 --可以绑定不在同一层的父节点
Add(target_range)

target_alt             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
target_alt.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
target_alt.init_pos          = {0.1 , 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
target_alt.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
target_alt.stringdefs        = {0.008,0.008, 0, 0}   --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
target_alt.formats           = {"%.0fM","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
target_alt.element_params    = {"TARGET_ALT","TARGET_BOX_DIS_ENABLE"}
target_alt.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
target_alt.collimated        = true
target_alt.use_mipfilter     = true
target_alt.additive_alpha    = true
target_alt.isvisible		 = true
target_alt.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
target_alt.level			 = HUD_BASE_DEFAULT_LEVEL
target_alt.parent_element    = target_box.name  --父节点名字 --可以绑定不在同一层的父节点
--Add(target_alt)


-- target_round 				            = CreateElement "ceTexPoly"
-- target_round.vertices                 = hud_vert_gen(6000,6000)-- {{-106,125},{106,125},{106,-143},{-106,-143}}
-- target_round.indices                  = {0,1,2,2,3,0}
-- target_round.tex_coords               = tex_coord_gen(638,1456,276,276,2000,2000)
-- target_round.material                 = basic_HUD_material
-- target_round.name 			        = create_guid_string()
-- target_round.init_pos                 = {0, 0, 200}
-- target_round.init_rot		            = {0, 0, default_hud_rot_offset}
-- target_round.collimated	            = true
-- target_round.element_params           = {"TARGET_ROUND_DIS_ENABLE","TARGET_ROUND_Y","TARGET_ROUND_X"} --, "D_GUNSIGHT_VISIBLE"
-- target_round.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1},{"move_left_right_using_parameter",2}}
-- target_round.use_mipfilter            = true
-- target_round.additive_alpha           = true
-- target_round.h_clip_relation          = h_clip_relations.COMPARE
-- target_round.level                    = HUD_BASE_DEFAULT_LEVEL
-- target_round.parent_element	        = "hud_base_clip"
-- Add(target_round)

local target_round = CreateElement "ceMeshPoly"
target_round.name = create_guid_string()
set_circle(target_round, 0.07, 0.06, 360,64)
target_round.init_pos                 = {0, 0}
target_round.init_rot		            = {0, 0, default_hud_rot_offset}
target_round.material        = "HUD_DAY_COLOR"
target_round.parent_element  = "hud_base_clip"
target_round.element_params           = {"TARGET_ROUND_DIS_ENABLE","TARGET_ROUND_Y","TARGET_ROUND_X"} --, "D_GUNSIGHT_VISIBLE"
target_round.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",1,y_scale},{"move_left_right_using_parameter",2,x_scale}}
target_round.h_clip_relation = h_clip_relations.COMPARE
target_round.level           = HUD_BASE_DEFAULT_LEVEL
target_round.isdraw          = true
target_round.collimated      = true
target_round.isvisible       = true
Add(target_round)

-- 机炮格子
local gun_grid_sign 				            = CreateElement "ceTexPoly"
gun_grid_sign.vertices                 = hud_vert_gen(2400,2400)-- {{-106,125},{106,125},{106,-143},{-106,-143}}
gun_grid_sign.indices                  = {0,1,2,2,3,0}
gun_grid_sign.tex_coords               = tex_coord_gen(0,0,1024,1024,1024,1024)
gun_grid_sign.material                 = MakeMaterial("./Bazar/Textures/AvionicsCommon/asp17grid.dds", HUD_DAY_COLOR)
gun_grid_sign.name 			        = create_guid_string()
gun_grid_sign.init_pos                 = {0, -0.3, default_hud_z_offset}
gun_grid_sign.init_rot		            = {0, 0, default_hud_rot_offset}
gun_grid_sign.collimated	            = true
gun_grid_sign.element_params           = {"GUN_GRID"} --, "D_GUNSIGHT_VISIBLE"
gun_grid_sign.controllers              = {{"parameter_in_range",0,0.9,1.1}}
gun_grid_sign.use_mipfilter            = true
gun_grid_sign.additive_alpha           = true
gun_grid_sign.h_clip_relation          = h_clip_relations.COMPARE
gun_grid_sign.level                    = HUD_BASE_DEFAULT_LEVEL
gun_grid_sign.parent_element	        = "hud_base_clip"
Add(gun_grid_sign)

local gun_ccip = CreateElement "ceMeshPoly"
gun_ccip.name = create_guid_string()
set_circle(gun_ccip, 0.07, 0.06, 360,64)
gun_ccip.init_pos                 = {0, 0}
gun_ccip.init_rot		            = {0, 0, default_hud_rot_offset}
gun_ccip.material        = "HUD_DAY_COLOR"
gun_ccip.parent_element  = "hud_base_clip"
gun_ccip.element_params           = {"GUN_CCIP_DIS_ENABLE","GUN_CCIP_Y","GUN_CCIP_X"} --, "D_GUNSIGHT_VISIBLE"
gun_ccip.controllers              = {{"parameter_in_range",0,0.5,1.1},{"move_up_down_using_parameter",1,y_scale},{"move_left_right_using_parameter",2,x_scale}}
gun_ccip.h_clip_relation = h_clip_relations.COMPARE
gun_ccip.level           = HUD_BASE_DEFAULT_LEVEL
gun_ccip.isdraw          = true
gun_ccip.collimated      = true
gun_ccip.isvisible       = true
Add(gun_ccip)

line_shape           = CreateElement "ceSimpleLineObject"
line_shape.name            = create_guid_string()
line_shape.width           = 0.004
line_shape.vertices        = {{0,0},{1,0}}
line_shape.init_pos        = { 0, 0 }
line_shape.init_rot        = { 0, 0 }
line_shape.tex_params      = {{0, 0.5}, {1, 0.5}, {1 / (1024 * 100 / 275), 1}}
line_shape.isdraw		   = true
line_shape.material        = 'HUD_DAY_COLOR'
line_shape.additive_alpha  = false
line_shape.collimated      = false
line_shape.use_mipfilter   = true
line_shape.parent_element  = "hud_base_clip"
line_shape.h_clip_relation = h_clip_relations.COMPARE
line_shape.level           = HUD_BASE_DEFAULT_LEVEL
line_shape.isdraw          = true
line_shape.element_params           = {"GUN_CCIP_DIS_ENABLE","GUN_CCIP_X","GUN_CCIP_Y","GUN_CCIP_X_2","GUN_CCIP_Y_2"} --, "D_GUNSIGHT_VISIBLE"
line_shape.controllers              = {{"parameter_in_range",0,0.5,1.1},{"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},{"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}}
Add(line_shape)

local rocket_ccip = CreateElement "ceMeshPoly"
rocket_ccip.name = create_guid_string()
set_circle(rocket_ccip, 0.07, 0.06, 360,64)
rocket_ccip.init_pos                 = {0, 0}
rocket_ccip.init_rot		            = {0, 0, default_hud_rot_offset}
rocket_ccip.material        = "HUD_DAY_COLOR"
rocket_ccip.parent_element  = "hud_base_clip"
rocket_ccip.element_params           = {"ROCKET_CCIP_DIS_ENABLE","ROCKET_CCIP_Y","ROCKET_CCIP_X"} --, "D_GUNSIGHT_VISIBLE"
rocket_ccip.controllers              = {{"parameter_in_range",0,0.5,1.1},{"move_up_down_using_parameter",1,y_scale},{"move_left_right_using_parameter",2,x_scale}}
rocket_ccip.h_clip_relation = h_clip_relations.COMPARE
rocket_ccip.level           = HUD_BASE_DEFAULT_LEVEL
rocket_ccip.isdraw          = true
rocket_ccip.collimated      = true
rocket_ccip.isvisible       = true
Add(rocket_ccip)

line_shape           = CreateElement "ceSimpleLineObject"
line_shape.name            = create_guid_string()
line_shape.width           = 0.004
line_shape.vertices        = {{0,0},{1,0}}
line_shape.init_pos        = { 0, 0 }
line_shape.init_rot        = { 0, 0 }
line_shape.tex_params      = {{0, 0.5}, {1, 0.5}, {1 / (1024 * 100 / 275), 1}}
line_shape.isdraw		   = true
line_shape.material        = 'HUD_DAY_COLOR'
line_shape.additive_alpha  = false
line_shape.collimated      = false
line_shape.use_mipfilter   = true
line_shape.parent_element  = "hud_base_clip"
line_shape.h_clip_relation = h_clip_relations.COMPARE
line_shape.level           = HUD_BASE_DEFAULT_LEVEL
line_shape.isdraw          = true
line_shape.element_params           = {"ROCKET_CCIP_DIS_ENABLE","ROCKET_CCIP_X","ROCKET_CCIP_Y","ROCKET_CCIP_X_2","ROCKET_CCIP_Y_2"} --, "D_GUNSIGHT_VISIBLE"
line_shape.controllers              = {{"parameter_in_range",0,0.5,1.1},{"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},{"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}}
Add(line_shape)

local bomb_ccip = CreateElement "ceMeshPoly"
bomb_ccip.name = create_guid_string()
set_circle(bomb_ccip, 0.07, 0.06, 360,64)
bomb_ccip.init_pos                 = {0, 0}
bomb_ccip.init_rot		            = {0, 0, default_hud_rot_offset}
bomb_ccip.material        = "HUD_DAY_COLOR"
bomb_ccip.parent_element  = "hud_base_clip"
bomb_ccip.element_params           = {"BOMB_CCIP_DIS_ENABLE","BOMB_CCIP_Y","BOMB_CCIP_X"} --, "D_GUNSIGHT_VISIBLE"
bomb_ccip.controllers              = {{"parameter_in_range",0,0.5,1.1},{"move_up_down_using_parameter",1,y_scale},{"move_left_right_using_parameter",2,x_scale}}
bomb_ccip.h_clip_relation = h_clip_relations.COMPARE
bomb_ccip.level           = HUD_BASE_DEFAULT_LEVEL
bomb_ccip.isdraw          = true
bomb_ccip.collimated      = true
bomb_ccip.isvisible       = true
Add(bomb_ccip)

local weapon_name             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
weapon_name.material          = "unicode_cn_hud"    --FONT_             --材质类型（注意上面创建的字体材质）
weapon_name.init_pos          = {0 , -0.5}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
weapon_name.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
weapon_name.stringdefs        = {0.008,0.008, 0, 0}   --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
weapon_name.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
weapon_name.element_params    = {"WEAPON_NAME","WEAPON_NAME_DIS"}
weapon_name.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
weapon_name.collimated        = true
weapon_name.use_mipfilter     = true
weapon_name.additive_alpha    = true
weapon_name.isvisible		 = true
weapon_name.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
weapon_name.level			 = HUD_BASE_DEFAULT_LEVEL
weapon_name.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(weapon_name)