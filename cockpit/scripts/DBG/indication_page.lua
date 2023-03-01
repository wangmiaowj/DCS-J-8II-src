
dofile(LockOn_Options.script_path .. "DBG/definitions.lua")


local dbg_Simp = CreateElement "ceSimple"
dbg_Simp.name = "dbg_Simp"
dbg_Simp.init_pos = {0,0}
Add(dbg_Simp)

local dbg_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
dbg_text.material          = "unicode_cn"    --FONT_             --材质类型（注意上面创建的字体材质）
dbg_text.init_pos          = {0 , 0 , 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
dbg_text.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
dbg_text.stringdefs        = {0.01,0.01, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
dbg_text.element_params    = {"DBG_INFO_S/H","DBG_INFO"}
dbg_text.formats           = {"%s","%s"}
dbg_text.controllers       = {{"parameter_in_range",0,0.9,1.1},{"text_using_parameter",1}}
dbg_text.collimated        = true
dbg_text.use_mipfilter     = true
dbg_text.additive_alpha    = true
dbg_text.isvisible		 = true
dbg_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
dbg_text.level			 = DBG_DEFAULT_LEVEL
dbg_text.parent_element    = dbg_Simp.name  --父节点名字 --可以绑定不在同一层的父节点
Add(dbg_text)
