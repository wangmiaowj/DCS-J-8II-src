-- 基础导航指示内容放在这
-- basic_HUD_material

-- 425 145； 75 1900 1260

local multiplier_of_text = 2

-- ADI指针旋转虚拟体
local HUD_ADI_rot                   = CreateElement "ceSimple"
HUD_ADI_rot.name                    = "HUD_ADI_rot"
HUD_ADI_rot.init_pos                = {0, 0, 0}
HUD_ADI_rot.element_params          = {"HUD_ADI_ROT","HUD_ADI_MOVX"}
HUD_ADI_rot.controllers             = {{"rotate_using_parameter",0,1},{"move_left_right_using_parameter",1,0.1},}
HUD_ADI_rot.collimated	            = true
HUD_ADI_rot.use_mipfilter           = true
HUD_ADI_rot.additive_alpha          = true
HUD_ADI_rot.h_clip_relation         = h_clip_relations.COMPARE
HUD_ADI_rot.level                   = HUD_BASE_DEFAULT_LEVEL
HUD_ADI_rot.parent_element	        = "hud_base_clip"
HUD_ADI_rot.isvisible               = false
Add(HUD_ADI_rot)

-- ADI指针移动虚拟体
local HUD_ADI_mov                   = CreateElement "ceSimple"
HUD_ADI_mov.name                    = "HUD_ADI_mov"
HUD_ADI_mov.init_pos                = {0, 0, 0}
HUD_ADI_mov.element_params          = {"HUD_ADI_MOVY","HUD_ADI_MOVX_2","ADI_LINE_GROUP",}
HUD_ADI_mov.controllers             = {{"move_up_down_using_parameter",0,0.9},{"move_left_right_using_parameter",1,0.1},{"opacity_using_parameter",2},}
HUD_ADI_mov.collimated	            = true
HUD_ADI_mov.use_mipfilter           = true
HUD_ADI_mov.additive_alpha          = true
HUD_ADI_mov.h_clip_relation         = h_clip_relations.COMPARE
HUD_ADI_mov.level                   = HUD_BASE_DEFAULT_LEVEL
HUD_ADI_mov.parent_element	        = "HUD_ADI_rot"
HUD_ADI_mov.isvisible               = false
Add(HUD_ADI_mov)

-- 航行矢量指示
local flight_dire_ind 				     = CreateElement "ceTexPoly"
flight_dire_ind.vertices                 = hud_vert_gen(415,280)
flight_dire_ind.indices                  = {0,1,2,2,3,0}
flight_dire_ind.tex_coords               = tex_coord_gen(385,680,415,280,2000,2000)
flight_dire_ind.material                 = basic_HUD_material
flight_dire_ind.name 			         = create_guid_string()
flight_dire_ind.init_pos                 = {0, 0, 0}
flight_dire_ind.init_rot		         = {0, 0, -default_hud_rot_offset}
flight_dire_ind.collimated	             = true
flight_dire_ind.element_params           = {"ADI_LINE_GROUP","HUD_FD_X","HUD_FD_Y"}
flight_dire_ind.controllers              = {{"opacity_using_parameter",0},{"move_left_right_using_parameter",1,1},{"move_up_down_using_parameter",2,1},}
flight_dire_ind.use_mipfilter            = true
flight_dire_ind.additive_alpha           = true
flight_dire_ind.h_clip_relation          = h_clip_relations.COMPARE
flight_dire_ind.level                    = HUD_BASE_DEFAULT_LEVEL
flight_dire_ind.parent_element	         = "hud_base_clip"
Add(flight_dire_ind)

-- 速度指示框
local speed_dis_box 				    = CreateElement "ceTexPoly"
speed_dis_box.vertices                  = hud_vert_gen(670,220)
speed_dis_box.indices                   = {0,1,2,2,3,0}
speed_dis_box.tex_coords                = tex_coord_gen(395,495,425,145,2000,2000)
speed_dis_box.material                  = basic_HUD_material
speed_dis_box.name 			            = create_guid_string()
speed_dis_box.init_pos                  = {- 1 , 0 , 0}
speed_dis_box.init_rot		            = {0, 0, 0}
speed_dis_box.element_params			={"HUD_DIS_ENABLE"}
speed_dis_box.controllers				= {{"opacity_using_parameter",0}}
speed_dis_box.collimated	            = true
speed_dis_box.blend_mode 	            =  blend_mode.IBM_REGULAR
speed_dis_box.use_mipfilter             = true
speed_dis_box.additive_alpha            = true
speed_dis_box.h_clip_relation           = h_clip_relations.COMPARE
speed_dis_box.level                     = HUD_BASE_DEFAULT_LEVEL
speed_dis_box.parent_element	        = "hud_base_clip"
Add(speed_dis_box)

-- 速度显示
local speed_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
speed_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
speed_dis_text.init_pos          = {-1 + 275 / 2000 , 0 , 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
speed_dis_text.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
speed_dis_text.stringdefs        = font_size[2]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
speed_dis_text.formats           = {"%.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
speed_dis_text.element_params    = {"HUD_SPEED_DIS","HUD_DIS_ENABLE"}
speed_dis_text.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
speed_dis_text.collimated        = true
speed_dis_text.use_mipfilter     = true
speed_dis_text.additive_alpha    = true
speed_dis_text.isvisible		 = true
speed_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
speed_dis_text.level			 = HUD_BASE_DEFAULT_LEVEL
speed_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(speed_dis_text)

-- 高度指示框
local alt_dis_box 				      = CreateElement "ceTexPoly"
alt_dis_box.vertices                  = hud_vert_gen(790,220)
alt_dis_box.indices                   = {0,1,2,2,3,0}
alt_dis_box.tex_coords                = tex_coord_gen(1145,495,500,145,2000,2000)
alt_dis_box.material                  = basic_HUD_material
alt_dis_box.name 			          = create_guid_string()
alt_dis_box.element_params			  ={"HUD_DIS_ENABLE"}
alt_dis_box.controllers				  = {{"opacity_using_parameter",0}}
alt_dis_box.init_pos                  = {1, 0 , 0}
alt_dis_box.init_rot		          = {0, 0, 0}
alt_dis_box.collimated	              = true
alt_dis_box.use_mipfilter             = true
alt_dis_box.additive_alpha            = true
alt_dis_box.h_clip_relation           = h_clip_relations.COMPARE
alt_dis_box.level                     = HUD_BASE_DEFAULT_LEVEL
alt_dis_box.parent_element	          = "hud_base_clip"
Add(alt_dis_box)

-- 高度显示
local alt_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
alt_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
alt_dis_text.init_pos          = {1 - 325 / 2000 , 0  , 0}--{-370/2000, 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
alt_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
alt_dis_text.stringdefs        = font_size[2]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
alt_dis_text.formats           = {"%.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
alt_dis_text.element_params    = {"HUD_ALT_DIS","HUD_DIS_ENABLE"}
alt_dis_text.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
alt_dis_text.collimated        = true
alt_dis_text.use_mipfilter     = true
alt_dis_text.additive_alpha    = true
alt_dis_text.isvisible		   = true
alt_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
alt_dis_text.level			   = HUD_BASE_DEFAULT_LEVEL
alt_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(alt_dis_text)

-- G值显示
local G_level_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
G_level_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
G_level_dis_box.init_pos          = {-1.15, 1800/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
G_level_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
G_level_dis_box.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
G_level_dis_box.formats           = {"G %.1f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
G_level_dis_box.element_params    = {"HUD_G_DIS","HUD_DIS_ENABLE","HUD_DIS_ENABLE"}
G_level_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
G_level_dis_box.collimated        = true
G_level_dis_box.use_mipfilter     = true
G_level_dis_box.additive_alpha    = true
G_level_dis_box.isvisible		 = true
G_level_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
G_level_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
G_level_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(G_level_dis_box)

-- AOA显示
local AOA_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
AOA_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
AOA_dis_box.init_pos          = {-1.15, 1600/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
AOA_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
AOA_dis_box.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
AOA_dis_box.formats           = {"\24  %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
AOA_dis_box.element_params    = {"HUD_AOA_DIS","HUD_DIS_ENABLE"}
AOA_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
AOA_dis_box.collimated        = true
AOA_dis_box.use_mipfilter     = true
AOA_dis_box.additive_alpha    = true
AOA_dis_box.isvisible		 = true
AOA_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
AOA_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
AOA_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(AOA_dis_box)

-- 磁航向显示
local magnitude_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
magnitude_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
magnitude_dis_text.init_pos          = {0, 1950/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
magnitude_dis_text.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
magnitude_dis_text.stringdefs        = font_size[4]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
magnitude_dis_text.formats           = {"%.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
magnitude_dis_text.element_params    = {"HUD_MAGNI_DIS","HUD_DIS_ENABLE"}
magnitude_dis_text.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1}}
magnitude_dis_text.collimated        = true
magnitude_dis_text.use_mipfilter     = true
magnitude_dis_text.additive_alpha    = true
magnitude_dis_text.isvisible		 = true
magnitude_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
magnitude_dis_text.level			 = HUD_BASE_DEFAULT_LEVEL
magnitude_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(magnitude_dis_text)

-- 马赫数显示
local Mach_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
Mach_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
Mach_dis_box.init_pos          = {- 1, -1600/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
Mach_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
Mach_dis_box.stringdefs        = font_size[5]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
Mach_dis_box.formats           = {"M %.2f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
Mach_dis_box.element_params    = {"HUD_MACH_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
Mach_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
Mach_dis_box.collimated        = true
Mach_dis_box.use_mipfilter     = true
Mach_dis_box.additive_alpha    = true
Mach_dis_box.isvisible		 = true
Mach_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
Mach_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
Mach_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(Mach_dis_box)

-- 雷达高度显示
local Ralt_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
Ralt_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
Ralt_dis_box.init_pos          = {0.75, -1450/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
Ralt_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
Ralt_dis_box.stringdefs        = font_size[5]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
Ralt_dis_box.formats           = {"RA %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
Ralt_dis_box.element_params    = {"HUD_RALT_DIS","HUD_DIS_ENABLE","HUD_RALT_DATA_DIS"}
Ralt_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
Ralt_dis_box.collimated        = true
Ralt_dis_box.use_mipfilter     = true
Ralt_dis_box.additive_alpha    = true
Ralt_dis_box.isvisible		 = true
Ralt_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
Ralt_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
Ralt_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(Ralt_dis_box)

-- 左发动机N2转速显示
local LN2_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
LN2_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
LN2_dis_box.init_pos          = {-1, -1900/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
LN2_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
LN2_dis_box.stringdefs        = font_size[6]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
LN2_dis_box.formats           = {"L RPM %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
LN2_dis_box.element_params    = {"HUD_LN2_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
LN2_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
LN2_dis_box.collimated        = true
LN2_dis_box.use_mipfilter     = true
LN2_dis_box.additive_alpha    = true
LN2_dis_box.isvisible		 = true
LN2_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
LN2_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
LN2_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(LN2_dis_box)

-- 右发动机N2转速显示
local RN2_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
RN2_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
RN2_dis_box.init_pos          = {-1, -2050/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
RN2_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
RN2_dis_box.stringdefs        = font_size[6]   --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
RN2_dis_box.formats           = {"R RPM %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
RN2_dis_box.element_params    = {"HUD_RN2_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
RN2_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
RN2_dis_box.collimated        = true
RN2_dis_box.use_mipfilter     = true
RN2_dis_box.additive_alpha    = true
RN2_dis_box.isvisible		 = true
RN2_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
RN2_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
RN2_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(RN2_dis_box)

-- 全程最大过载显示
local GM_dis_box             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
GM_dis_box.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
GM_dis_box.init_pos          = {-1, -2200/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
GM_dis_box.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
GM_dis_box.stringdefs        = font_size[6]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
GM_dis_box.formats           = {"GM %.0f","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
GM_dis_box.element_params    = {"HUD_GM_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
GM_dis_box.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
GM_dis_box.collimated        = true
GM_dis_box.use_mipfilter     = true
GM_dis_box.additive_alpha    = true
GM_dis_box.isvisible		 = true
GM_dis_box.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
GM_dis_box.level			 = HUD_BASE_DEFAULT_LEVEL
GM_dis_box.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(GM_dis_box)

-- 右下航点显示第一行
local nav_line1_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
nav_line1_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
nav_line1_dis_text.init_pos          = {0.7 , -1900/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
nav_line1_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
nav_line1_dis_text.stringdefs        = font_size[7]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
nav_line1_dis_text.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
nav_line1_dis_text.element_params    = {"HUD_NAV_DATA_1_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
nav_line1_dis_text.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
nav_line1_dis_text.collimated        = true
nav_line1_dis_text.use_mipfilter     = true
nav_line1_dis_text.additive_alpha    = true
nav_line1_dis_text.isvisible		 = true
nav_line1_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
nav_line1_dis_text.level			 = HUD_BASE_DEFAULT_LEVEL
nav_line1_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(nav_line1_dis_text)

--右下航点显示第二行
local nav_line2_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
nav_line2_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
nav_line2_dis_text.init_pos          = {0.7, -2050/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
nav_line2_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
nav_line2_dis_text.stringdefs        = font_size[7]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
nav_line2_dis_text.formats           = {"%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
nav_line2_dis_text.element_params    = {"HUD_NAV_DATA_2_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
nav_line2_dis_text.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
nav_line2_dis_text.collimated        = true
nav_line2_dis_text.use_mipfilter     = true
nav_line2_dis_text.additive_alpha    = true
nav_line2_dis_text.isvisible		 = true
nav_line2_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
nav_line2_dis_text.level			 = HUD_BASE_DEFAULT_LEVEL
nav_line2_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(nav_line2_dis_text)

-- 右下航点显示第三行
local nav_line3_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
nav_line3_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
nav_line3_dis_text.init_pos          = {0.7, -2200/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
nav_line3_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
nav_line3_dis_text.stringdefs        = font_size[7]   --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
nav_line3_dis_text.formats           = {"MODE:%s","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
nav_line3_dis_text.element_params    = {"HUD_NAV_DATA_3_DIS","HUD_DIS_ENABLE","HUD_DETAIL_DATA_DIS"}
nav_line3_dis_text.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.5,1.1}}
nav_line3_dis_text.collimated        = true
nav_line3_dis_text.use_mipfilter     = true
nav_line3_dis_text.additive_alpha    = true
nav_line3_dis_text.isvisible		 = true
nav_line3_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
nav_line3_dis_text.level			 = HUD_BASE_DEFAULT_LEVEL
nav_line3_dis_text.parent_element    = "hud_base_clip"  --父节点名字 --可以绑定不在同一层的父节点
Add(nav_line3_dis_text)

-- 水平线(0位置)指示
local level_line 				    = CreateElement "ceTexPoly"
level_line.vertices                 = hud_vert_gen(3000,150)
level_line.indices                  = {0,1,2,2,3,0}
level_line.tex_coords               = tex_coord_gen(385,370,1280,90,2000,2000)
level_line.material                 = basic_HUD_material
level_line.name 			        = create_guid_string()
level_line.init_pos                 = {0, 0, 0}
level_line.init_rot		            = {0, 0, -default_hud_rot_offset}
level_line.collimated	            = true
level_line.element_params           = {"ADI_LINE_GROUP"}
level_line.controllers              = {{"opacity_using_parameter",0},}
level_line.use_mipfilter            = true
level_line.additive_alpha           = true
level_line.h_clip_relation          = h_clip_relations.COMPARE
level_line.level                    = HUD_BASE_DEFAULT_LEVEL
level_line.parent_element	        = "HUD_ADI_mov"
Add(level_line)

-- 
local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
left_0_line_sign.init_pos          = {0.74, 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
left_0_line_sign.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
left_0_line_sign.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
left_0_line_sign.formats           = {"0","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
left_0_line_sign.collimated        = true
left_0_line_sign.use_mipfilter     = true
left_0_line_sign.additive_alpha    = true
left_0_line_sign.isvisible		   = true
left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
left_0_line_sign.level			   = HUD_BASE_DEFAULT_LEVEL
left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
Add(left_0_line_sign)

-- 
local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
left_0_line_sign.init_pos          = {-0.73, 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
left_0_line_sign.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
left_0_line_sign.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
left_0_line_sign.formats           = {"0","%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
left_0_line_sign.collimated        = true
left_0_line_sign.use_mipfilter     = true
left_0_line_sign.additive_alpha    = true
left_0_line_sign.isvisible		   = true
left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
left_0_line_sign.level			   = HUD_BASE_DEFAULT_LEVEL
left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
Add(left_0_line_sign)

local i 
local sign_number
local vertical_distance

-- 循环生成ADI上半水平线
for i = 1,18 do
    sign_number = i * 5
    vertical_distance = i * 0.8
    -- 水平线指示
    local level_line 				    = CreateElement "ceTexPoly"
    level_line.vertices                 = hud_vert_gen(1800,200)
    level_line.indices                  = {0,1,2,2,3,0}
    level_line.tex_coords               = tex_coord_gen(560,120,935,65,2000,2000)
    level_line.material                 = basic_HUD_material
    level_line.name 			        = create_guid_string()
    level_line.init_pos                 = {0, vertical_distance, 0}
    level_line.init_rot		            = {0, 0, -default_hud_rot_offset}
    level_line.collimated	            = true
    level_line.element_params           = {"ADI_LINE_GROUP"}
    level_line.controllers              = {{"opacity_using_parameter",0},}
    level_line.use_mipfilter            = true
    level_line.additive_alpha           = true
    level_line.h_clip_relation          = h_clip_relations.COMPARE
    level_line.level                    = HUD_BASE_DEFAULT_LEVEL
    level_line.parent_element	        = "HUD_ADI_mov"
    Add(level_line)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_BASE_DEFAULT_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {-0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_BASE_DEFAULT_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)
end

-- 循环生成ADI下半水平线
for i = 1,18 do
    sign_number = - i * 5
    vertical_distance = - i * 0.8
    -- 水平线指示
    local level_line 				    = CreateElement "ceTexPoly"
    level_line.vertices                 = hud_vert_gen(1800,200)
    level_line.indices                  = {0,1,2,2,3,0}
    level_line.tex_coords               = tex_coord_gen(560,245,935,65,2000,2000)
    level_line.material                 = basic_HUD_material
    level_line.name 			        = create_guid_string()
    level_line.init_pos                 = {0, vertical_distance, 0}
    level_line.init_rot		            = {0, 0, -default_hud_rot_offset}
    level_line.collimated	            = true
    level_line.element_params           = {"ADI_LINE_GROUP"}
    level_line.controllers              = {{"opacity_using_parameter",0},}
    level_line.use_mipfilter            = true
    level_line.additive_alpha           = true
    level_line.h_clip_relation          = h_clip_relations.COMPARE
    level_line.level                    = HUD_BASE_DEFAULT_LEVEL
    level_line.parent_element	        = "HUD_ADI_mov"
    Add(level_line)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_BASE_DEFAULT_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)

    -- 
    local left_0_line_sign             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    left_0_line_sign.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    left_0_line_sign.init_pos          = {-0.5, vertical_distance}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    left_0_line_sign.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    left_0_line_sign.stringdefs        = font_size[3]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    left_0_line_sign.formats           = {tostring(sign_number),"%s"} -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    left_0_line_sign.element_params    = {"ADI_LINE_GROUP","ADI_LINE_GROUP"}
    left_0_line_sign.controllers       = {{"text_using_parameter",0},{"opacity_using_parameter",1},}
    left_0_line_sign.collimated        = true
    left_0_line_sign.use_mipfilter     = true
    left_0_line_sign.additive_alpha    = true
    left_0_line_sign.isvisible		   = true
    left_0_line_sign.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    left_0_line_sign.level			   = HUD_BASE_DEFAULT_LEVEL
    left_0_line_sign.parent_element    = "HUD_ADI_mov"  --父节点名字 --可以绑定不在同一层的父节点
    Add(left_0_line_sign)
end