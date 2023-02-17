
dofile(LockOn_Options.script_path .. "Helmet/indicator/definitions.lua")


local FK_Simp = CreateElement "ceSimple"
FK_Simp.name = create_guid_string()
FK_Simp.init_pos = {0,0}
Add(FK_Simp)

local fk_dis_text             = CreateElement "ceStringPoly" --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
fk_dis_text.material          = "unicode_cn"    --FONT_             --材质类型（注意上面创建的字体材质）
fk_dis_text.init_pos          = {0 , 0 , 0}         -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
fk_dis_text.alignment         = "CenterCenter"       --对齐方式设置：Left/Right/Center; Top/Down/Center
fk_dis_text.stringdefs        = {0.1,0.1, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
fk_dis_text.element_params    = {"FK_DISPLAY"}
fk_dis_text.controllers       = {{"parameter_in_range",0,603,605}}
fk_dis_text.collimated        = true
fk_dis_text.use_mipfilter     = true
fk_dis_text.additive_alpha    = true
fk_dis_text.isvisible		 = true
fk_dis_text.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
fk_dis_text.level			 = FK_DEFAULT_LEVEL
fk_dis_text.value				= "创作不易\n倒卖司马"
fk_dis_text.parent_element    = FK_Simp.name  --父节点名字 --可以绑定不在同一层的父节点
Add(fk_dis_text)