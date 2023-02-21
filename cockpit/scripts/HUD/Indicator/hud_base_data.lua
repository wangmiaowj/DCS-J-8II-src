-- 基础导航指示内容放在这
-- basic_HUD_material

local default_scale = 1.5

-- 速度条移动虚拟体
local HUD_speed_bar_ctrl                   = CreateElement "ceSimple"
HUD_speed_bar_ctrl.name                    = "HUD_speed_bar_ctrl"
HUD_speed_bar_ctrl.init_pos                = {0, 0, 0}
HUD_speed_bar_ctrl.element_params          = {"HUD_SPEED_DIS"} -- {"HUD_SPEED_BAR_Y"}
HUD_speed_bar_ctrl.controllers             = {{"move_up_down_using_parameter",0,-0.00083871},}
HUD_speed_bar_ctrl.collimated	           = true
HUD_speed_bar_ctrl.use_mipfilter           = true
HUD_speed_bar_ctrl.additive_alpha          = true
HUD_speed_bar_ctrl.h_clip_relation         = h_clip_relations.COMPARE
HUD_speed_bar_ctrl.level                   = HUD_DEFAULT_LEVEL
HUD_speed_bar_ctrl.parent_element	       = "speed_move_clip"
HUD_speed_bar_ctrl.isvisible               = false
Add(HUD_speed_bar_ctrl)

local default_speed_bar_length = 3250
local count_i

for count_i = 1,12 do
    -- 速度指示条
    local HUD_speed_bar 				   = CreateElement "ceTexPoly"
    HUD_speed_bar.vertices                 = hud_vert_gen(default_scale * 150,default_speed_bar_length)
    HUD_speed_bar.indices                  = {0,1,2,2,3,0}
    HUD_speed_bar.tex_coords               = mirror_tex_coord_gen(0,10,75,1260,2000,2000)
    HUD_speed_bar.material                 = basic_HUD_material
    HUD_speed_bar.name 			           = create_guid_string()
    HUD_speed_bar.init_pos                 = {91/2000, (default_speed_bar_length / 2 + default_speed_bar_length * (count_i - 1)) / 2000, 0}
    HUD_speed_bar.init_rot		           = {0, 0, 0}
    HUD_speed_bar.collimated	           = true
    HUD_speed_bar.element_params           = {"HUD_SPEED_BAR_GROUP","HUD_DETAIL_DATA_DIS"}
    HUD_speed_bar.controllers              = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.5,1.1}}
    HUD_speed_bar.use_mipfilter            = true
    HUD_speed_bar.additive_alpha           = true
    HUD_speed_bar.h_clip_relation          = h_clip_relations.COMPARE
    HUD_speed_bar.level                    = HUD_DEFAULT_LEVEL
    HUD_speed_bar.parent_element	       = "HUD_speed_bar_ctrl"
    Add(HUD_speed_bar)
end

for count_i = 0,60 do
    -- 速度条刻度显示
    local speed_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    speed_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    speed_dis_text.init_pos          = {- 38/2000, count_i * 812.5 / 2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    speed_dis_text.alignment         = "RightCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    speed_dis_text.stringdefs        = font_size[1]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    speed_dis_text.value           = tostring(count_i * 5)
    speed_dis_text.element_params    = {"HUD_SPEED_BAR_GROUP","HUD_DETAIL_DATA_DIS"}
    speed_dis_text.controllers       = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.5,1.1}}
    speed_dis_text.collimated        = true
    speed_dis_text.use_mipfilter     = true
    speed_dis_text.additive_alpha    = true
    speed_dis_text.isvisible		 = true
    speed_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    speed_dis_text.level			 = HUD_DEFAULT_LEVEL
    speed_dis_text.parent_element    = "HUD_speed_bar_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
    Add(speed_dis_text)
end

-- 高度条移动虚拟体
local HUD_altitude_bar_ctrl                   = CreateElement "ceSimple"
HUD_altitude_bar_ctrl.name                    = "HUD_altitude_bar_ctrl"
HUD_altitude_bar_ctrl.init_pos                = {0, 0, 0}
HUD_altitude_bar_ctrl.element_params          = {"HUD_ALT_DIS"} -- {"HUD_SPEED_BAR_Y"}
HUD_altitude_bar_ctrl.controllers             = {{"move_up_down_using_parameter",0,-0.000083871},}
HUD_altitude_bar_ctrl.collimated	           = true
HUD_altitude_bar_ctrl.use_mipfilter           = true
HUD_altitude_bar_ctrl.additive_alpha          = true
HUD_altitude_bar_ctrl.h_clip_relation         = h_clip_relations.COMPARE
HUD_altitude_bar_ctrl.level                   = HUD_DEFAULT_LEVEL
HUD_altitude_bar_ctrl.parent_element	       = "altitude_move_clip"
HUD_altitude_bar_ctrl.isvisible               = false
Add(HUD_altitude_bar_ctrl)

local default_speed_bar_length = 3250
local count_i

for count_i = 1,24 do
    -- 高度指示条
    local HUD_altitude_bar 				   = CreateElement "ceTexPoly"
    HUD_altitude_bar.vertices                 = hud_vert_gen(default_scale * 150,default_speed_bar_length)
    HUD_altitude_bar.indices                  = {0,1,2,2,3,0}
    HUD_altitude_bar.tex_coords               = tex_coord_gen(0,10,75,1260,2000,2000)
    HUD_altitude_bar.material                 = basic_HUD_material
    HUD_altitude_bar.name 			           = create_guid_string()
    HUD_altitude_bar.init_pos                 = {-91/2000, (default_speed_bar_length / 2 + default_speed_bar_length * (count_i - 1)) / 2000, 0}
    HUD_altitude_bar.init_rot		           = {0, 0, 0}
    HUD_altitude_bar.collimated	           = true
    HUD_altitude_bar.element_params           = {"HUD_ALT_BAR_GROUP","HUD_DETAIL_DATA_DIS"}
    HUD_altitude_bar.controllers              = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.5,1.1}}
    HUD_altitude_bar.use_mipfilter            = true
    HUD_altitude_bar.additive_alpha           = true
    HUD_altitude_bar.h_clip_relation          = h_clip_relations.COMPARE
    HUD_altitude_bar.level                    = HUD_DEFAULT_LEVEL
    HUD_altitude_bar.parent_element	       = "HUD_altitude_bar_ctrl"
    Add(HUD_altitude_bar)
end

for count_i = 0,120 do
    -- 高度条刻度显示
    local altitude_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    altitude_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    altitude_dis_text.init_pos          = { 38/2000, count_i * 812.5 / 2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    altitude_dis_text.alignment         = "LeftCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    altitude_dis_text.stringdefs        = font_size[1]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    altitude_dis_text.value           = tostring(count_i * 5)
    altitude_dis_text.element_params    = {"HUD_ALT_BAR_GROUP","HUD_DETAIL_DATA_DIS"}
    altitude_dis_text.controllers       = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.5,1.1}}
    altitude_dis_text.collimated        = true
    altitude_dis_text.use_mipfilter     = true
    altitude_dis_text.additive_alpha    = true
    altitude_dis_text.isvisible		 = true
    altitude_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    altitude_dis_text.level			 = HUD_DEFAULT_LEVEL
    altitude_dis_text.parent_element    = "HUD_altitude_bar_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
    Add(altitude_dis_text)
end

local default_heading_bar_length = 8500

-- 航向条移动虚拟体
local HUD_heading_bar_ctrl                   = CreateElement "ceSimple"
HUD_heading_bar_ctrl.name                    = "HUD_heading_bar_ctrl"
HUD_heading_bar_ctrl.init_pos                = {0, 0, 0}
HUD_heading_bar_ctrl.element_params          = {"HUD_HDG_MOV"} -- {"HUD_SPEED_BAR_Y"}
HUD_heading_bar_ctrl.controllers             = {{"move_left_right_using_parameter",0,1},}
HUD_heading_bar_ctrl.collimated	             = true
HUD_heading_bar_ctrl.use_mipfilter           = true
HUD_heading_bar_ctrl.additive_alpha          = true
HUD_heading_bar_ctrl.h_clip_relation         = h_clip_relations.COMPARE
HUD_heading_bar_ctrl.level                   = HUD_DEFAULT_LEVEL
HUD_heading_bar_ctrl.parent_element	         = "heading_move_clip"
HUD_heading_bar_ctrl.isvisible               = false
Add(HUD_heading_bar_ctrl)

-- 0， 1930
for count_i = 1,11 do
    -- 航向指示条
    local HUD_heading_bar 				     = CreateElement "ceTexPoly"
    HUD_heading_bar.vertices                 = hud_vert_gen(default_heading_bar_length, default_scale * 150)
    HUD_heading_bar.indices                  = {0,1,2,2,3,0}
    HUD_heading_bar.tex_coords               = tex_coord_gen(0,1930,1260,70,2000,2000)
    HUD_heading_bar.material                 = basic_HUD_material
    HUD_heading_bar.name 			         = create_guid_string()
    HUD_heading_bar.init_pos                 = {(default_heading_bar_length * (count_i - 6)) / 2000, -75 / 2000 , 0}
    HUD_heading_bar.init_rot		         = {0, 0, 0}
    HUD_heading_bar.collimated	             = true
    HUD_heading_bar.element_params           = {"HUD_HDG_BAR_GROUP",}
    HUD_heading_bar.controllers              = {{"opacity_using_parameter",0},}
    HUD_heading_bar.use_mipfilter            = true
    HUD_heading_bar.additive_alpha           = true
    HUD_heading_bar.h_clip_relation          = h_clip_relations.COMPARE
    HUD_heading_bar.level                    = HUD_DEFAULT_LEVEL
    HUD_heading_bar.parent_element	         = "HUD_heading_bar_ctrl"
    Add(HUD_heading_bar)
end

local heading_temp

for count_i = -22,22 do
    if  count_i < 0 then
        heading_temp = 36 + count_i
    elseif count_i >= 0 then
        heading_temp = count_i
    end
    -- 航向条刻度显示
    local heading_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    heading_dis_text.material          = "hud_font_base"    --FONT_             --材质类型（注意上面创建的字体材质）
    heading_dis_text.init_pos          = { count_i * default_heading_bar_length / 4 / 2000 , 20/2000}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    heading_dis_text.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
    heading_dis_text.stringdefs        = font_size[1]    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    heading_dis_text.value           = tostring(heading_temp)
    heading_dis_text.element_params    = {"HUD_HDG_BAR_GROUP"}
    heading_dis_text.controllers       = {{"opacity_using_parameter",0},}
    heading_dis_text.collimated        = true
    heading_dis_text.use_mipfilter     = true
    heading_dis_text.additive_alpha    = true
    heading_dis_text.isvisible		   = true
    heading_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    heading_dis_text.level			   = HUD_DEFAULT_LEVEL
    heading_dis_text.parent_element    = "HUD_heading_bar_ctrl"  --父节点名字 --可以绑定不在同一层的父节点
    Add(heading_dis_text)
end