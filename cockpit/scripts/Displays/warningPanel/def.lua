dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)--MILLYRADIANS) --这里设置了毫弧度
--A4定义了两个层级
--数值越小越靠上
WARNING_PANEL_DEFAULT_LEVEL = 6                              -- 二次裁剪显示层
WARNING_PANEL_DEFAULT_NOCLIP_LEVEL  = WARNING_PANEL_DEFAULT_LEVEL - 1 -- 一次裁剪显示层

-- 默认hud单色吧
-- 排错颜色（大雾）
OK_COLOR                 = {0,255,0,255}
-- 白天模式hud的颜色
WARNING_COLOR               = {255,255,0,255}
ERROR_COLOR = {255,0,0,255}

font_size={}
font_size[1]={1.0 * 0.010,1.0 * 0.010, 0, 0}
font_size[2]={0.9 * 0.010,0.9 * 0.010, 0, 0}
font_size[3]={0.8 * 0.010,0.8 * 0.010, 0, 0}
font_size[4]={0.7 * 0.010,0.7 * 0.010, 0, 0}
font_size[5]={0.6 * 0.010,0.6 * 0.010, 0, 0}
font_size[6]={0.5 * 0.010,0.5 * 0.010, 0, 0}
font_size[7]={0.4 * 0.010,0.4 * 0.010, 0, 0}
font_size[8]={0.3 * 0.010,0.3 * 0.010, 0, 0}
font_size[9]={0.2 * 0.010,0.2 * 0.010, 0, 0}
font_size[10]={0.1 * 0.010,0.1 * 0.010, 0, 0}

function add_warning_info(material,position,textStr,controllers,element_params,format)
    local sim    = CreateElement "ceSimple"
    sim.name     = create_guid_string()
    sim.init_pos = position
    Add(sim)

    local text           = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
    text.material        = material --FONT_             --材质类型（注意上面创建的字体材质）
    text.init_pos        = {0, 0} -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
    text.alignment       = "CenterCenter" --对齐方式设置：Left/Right/Center; Top/Down/Center
    text.stringdefs      = font_size[7] --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
    if format ~=nil then
        text.formats           = format -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
    end
    if element_params~=nil then
        text.element_params = element_params
    end
    if controllers ~= nil then
        text.controllers  = controllers
    end
    if textStr ~= nil then
        text.value           = textStr 
    end
    text.collimated      = true
    text.use_mipfilter   = true
    text.additive_alpha  = true
    text.isvisible       = true
    text.h_clip_relation = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    text.level           = WARNING_PANEL_DEFAULT_LEVEL
    text.parent_element  = sim.name --父节点名字 --可以绑定不在同一层的父节点
    Add(text)
end