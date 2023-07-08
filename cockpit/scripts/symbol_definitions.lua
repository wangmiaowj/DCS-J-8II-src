dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "symbology_defs.lua")
SetScale(FOV)
DEFAULT_LEVEL = 1
DEFAULT_NOCLIP_LEVEL = DEFAULT_LEVEL - 1
Aspect = GetAspect()
Width = 1
Height = Width * Aspect

function AddPageControll(element_params,controllers,element_param_name,pageValue)
	if element_params and type(element_params)=='table' and #element_params>0 then
		element_params[#element_params+1] = element_param_name
		controllers[#controllers+1] = {"parameter_in_range",#element_params - 1,pageValue-0.1,pageValue+0.1}
	else
		element_params = {element_param_name}
		controllers = {{"parameter_in_range",0,pageValue-0.1,pageValue+0.1}}
	end
	return {element_params,controllers}
end

function AddLightnessControll(element_params,controllers,element_param_name)
	if element_params and type(element_params)=='table' and #element_params>0 then
		element_params[#element_params+1] = element_param_name
		controllers[#controllers+1] = {"opacity_using_parameter",#element_params - 1}
	else
		element_params = {element_param_name}
		controllers = {{"opacity_using_parameter",0}}
	end
	return {element_params,controllers}
end

function AddSimple(pos,rot,parent_element)
	local simple    = CreateElement "ceSimple"
	simple.name     = create_guid_string()
	simple.init_pos = pos or { 0, 0 }
	simple.init_rot = rot or { 0, 0 }
	if parent_element then
		if type(parent_element) == 'userdata' and parent_element.name then
			simple.parent_element = parent_element.name
		elseif type(parent_element) == 'string' then
			simple.parent_element = parent_element
		end
	end
	Add(simple)
	return simple
end

function AddText(name, val, material, pos, alignment, stringdefs, formats, element_params, controllers, _h_clip_relation,
				 level, parent)
	if material == nil then
		material = "font_kneeboard"
	end
	if pos == nil then
		pos = { 0, 0 }
	end
	if alignment == nil then
		alignment = "CenterCenter"
	end
	if stringdefs == nil then
		stringdefs = { 0.008, 0.008, 0, 0 }
	end
	if _h_clip_relation == nil then
		_h_clip_relation = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
	end
	if level == nil then
		level = DEFAULT_LEVEL
	end
	local text      = CreateElement "ceStringPoly"   --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
	text.name       = name or create_guid_string()
	text.material   = material                       --FONT_             --材质类型（注意上面创建的字体材质）
	text.init_pos   = pos                            -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
	text.alignment  = alignment                      --对齐方式设置：Left/Right/Center; Top/Down/Center
	text.stringdefs = stringdefs                     --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
	if val then
		text.value = val
	end
	if formats then
		text.formats = formats   -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
	end
	local element_ctrl
	if PAGE_NAME and Pages then
		element_ctrl=AddPageControll(element_params,controllers,(Page_prefix or '') .. 'MFCD_PAGE',Pages[PAGE_NAME])
	end
	if element_ctrl then
		element_ctrl = AddLightnessControll(element_ctrl[1],element_ctrl[2],IndicatorName)
	else
		element_ctrl = AddLightnessControll(element_params,controllers,IndicatorName)
	end
	text.element_params = element_ctrl[1]
	text.controllers = element_ctrl[2]
	-- if element_ctrl then
	-- 	text.element_params = element_ctrl[1]
	-- 	text.controllers = element_ctrl[2]
	-- elseif element_params and controllers then
	-- 	text.element_params = element_params
	-- 	text.controllers = controllers
	-- end
	if parent then
		if type(parent) == 'userdata' and parent.name then
			text.parent_element = parent.name
		elseif type(parent) == 'string' then
			text.parent_element = parent
		end
	end
	text.use_mipfilter   = true
	text.isvisible       = true
	text.h_clip_relation = _h_clip_relation
	text.level           = level
	Add(text)
	return text
end

function AddText_NotPageCtrl(name, val, material, pos, alignment, stringdefs, formats, element_params, controllers, _h_clip_relation,
				 level, parent)
	if material == nil then
		material = "font_kneeboard"
	end
	if pos == nil then
		pos = { 0, 0 }
	end
	if alignment == nil then
		alignment = "CenterCenter"
	end
	if stringdefs == nil then
		stringdefs = { 0.008, 0.008, 0, 0 }
	end
	if _h_clip_relation == nil then
		_h_clip_relation = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
	end
	if level == nil then
		level = DEFAULT_LEVEL
	end
	local text      = CreateElement "ceStringPoly"   --创建一个字符输出元素 "ceTexPoly"表示创建一个贴图模型
	text.name       = name or create_guid_string()
	text.material   = material                       --FONT_             --材质类型（注意上面创建的字体材质）
	text.init_pos   = pos                            -- 这是设置对齐点的坐标【这是当前模型的最大限制(在边角对齐时不要超出)】
	text.alignment  = alignment                      --对齐方式设置：Left/Right/Center; Top/Down/Center
	text.stringdefs = stringdefs                     --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} 第一个值控制宽度，第二个值控制高度
	if val then
		text.value = val
	end
	if formats then
		text.formats = formats   -- 这里设置输出，类似于C的printf模型 %开头的是输出类型，后面的%s是输入类型
	end
	local element_ctrl = AddLightnessControll(element_params,controllers,IndicatorName)
	text.element_params = element_ctrl[1]
	text.controllers = element_ctrl[2]
	-- if element_params then
	-- 	text.element_params = element_params
	-- end
	-- if controllers then
	-- 	text.controllers = controllers
	-- end
	if parent then
		if type(parent) == 'userdata' and parent.name then
			text.parent_element = parent.name
		elseif type(parent) == 'string' then
			text.parent_element = parent
		end
	end
	text.use_mipfilter   = true
	text.isvisible       = true
	text.h_clip_relation = _h_clip_relation
	text.level           = level
	Add(text)
	return text
end

function AddCircle(name,radius_outer, radius_inner, arc, sides,pos,rot,material,h_clip_relation,level,parent,element_param_name,controllers)
	local circle = {}
	set_circle(circle,radius_outer, radius_inner, arc, sides)
	return AddMeshPoly(name,circle.vertices,circle.indices,pos,rot,material,h_clip_relation,level,parent,element_param_name,controllers)
end

function AddBoxBorder(name,width,height,thick,pos,rot,material,level,h_clip_relation,parent,element_param_name,controllers)
	thick            = thick or 0.01
	width = width or Width
	height = height or Height
	local vertices        = {
		{ -width,       height }, { width, height }, { width, -height }, { -width, -height },
		{ -width + thick, height - thick }, { width - thick, height - thick }, { width - thick, -height + thick },
		{ -width + thick, -height + thick },
	}
	local indices         = {
		0, 1, 5, 5, 4, 0, --up
		1, 2, 6, 6, 5, 1, --right
		2, 3, 7, 7, 6, 2, --down
		3, 0, 4, 4, 7, 3 --left
	}
	return AddMeshPoly(name,vertices,indices,pos,rot,material,h_clip_relation,level,parent,element_param_name,controllers)
end

function AddBox(name,width,height,pos,rot,material,level,h_clip_relation,parent,element_param_name,controllers)
	width = width or Width
	height = height or Height
	local vertices        = {
		{ -width,       height }, { width, height }, { width, -height }, { -width, -height },
	}
	local indices         = {
		0,1,2,2,3,0
	}
	return AddMeshPoly(name,vertices,indices,pos,rot,material,h_clip_relation,level,parent,element_param_name,controllers)
end

function AddCrossHair(name,width,height,pos,rot,material,h_clip_relation,level,parent_name)
	width = width or Width
	height = height or Height
	local vertices        = { { 0, height }, { 0, -height }, { -width, 0 }, { width, 0 }, }
	local indices         = { 0, 1, 2, 3 }
	return AddMultiLine(name,vertices,indices,pos,rot,material,nil,h_clip_relation,level,parent_name,nil,nil)
end

function AddMultiLine(name,vertices,indices,pos,rot,material,alignment,h_clip_relation,level,parent,element_params,controllers)
	local line_shape           = CreateElement "ceSMultiLine"
	line_shape.name            = name or create_guid_string()
	line_shape.vertices        = vertices
	line_shape.indices         = indices
	line_shape.init_pos        = pos or {0,0}
	line_shape.init_rot        = rot or {0,0}
	line_shape.material        = material or ''
	line_shape.h_clip_relation = h_clip_relation or h_clip_relations.COMPARE
	line_shape.level           = level or DEFAULT_LEVEL
	line_shape.isdraw          = true
	line_shape.alignment       = alignment or "CenterCenter"
	line_shape.collimated	   = false
	line_shape.use_mipfilter   = true
	line_shape.additive_alpha  = false
	local element_ctrl
	if PAGE_NAME and Pages then
		element_ctrl=AddPageControll(element_params,controllers,(Page_prefix or '') .. 'MFCD_PAGE',Pages[PAGE_NAME])
	end
	if element_ctrl then
		element_ctrl = AddLightnessControll(element_ctrl[1],element_ctrl[2],IndicatorName)
	else
		element_ctrl = AddLightnessControll(element_params,controllers,IndicatorName)
	end
	line_shape.element_params = element_ctrl[1]
	line_shape.controllers = element_ctrl[2]
	-- if element_ctrl then
	-- 	line_shape.element_params = element_ctrl[1]
	-- 	line_shape.controllers = element_ctrl[2]
	-- elseif element_params and controllers then
	-- 	line_shape.element_params = element_params
	-- 	line_shape.controllers = controllers
	-- end
	if parent then
		if type(parent) == 'userdata' and parent.name then
			line_shape.parent_element = parent.name
		elseif type(parent) == 'string' then
			line_shape.parent_element = parent
		end
	end
	Add(line_shape)
	return line_shape
end

function AddMeshPoly(name,vertices,indices,pos,rot,material,h_clip_relation,level,parent,element_params,controllers)
	local meshPoly           = CreateElement "ceMeshPoly"
	meshPoly.name            = name or create_guid_string()
	meshPoly.primitivetype   = "triangles"
	meshPoly.vertices        = vertices
	meshPoly.indices         = indices
	meshPoly.init_pos        = pos or {0,0}
	meshPoly.init_rot        = rot or {0,0}
	meshPoly.material        = material or ''
	meshPoly.h_clip_relation = h_clip_relation or h_clip_relations.COMPARE
	meshPoly.level           = level or DEFAULT_LEVEL
	meshPoly.isdraw          = true
	meshPoly.change_opacity  = false
	if parent then
		if type(parent) == 'userdata' and parent.name then
			meshPoly.parent_element = parent.name
		elseif type(parent) == 'string' then
			meshPoly.parent_element = parent
		end
	end
	local element_ctrl
	if PAGE_NAME and Pages then
		element_ctrl=AddPageControll(element_params,controllers,(Page_prefix or '') .. 'MFCD_PAGE',Pages[PAGE_NAME])
	end
	if element_ctrl then
		element_ctrl = AddLightnessControll(element_ctrl[1],element_ctrl[2],IndicatorName)
	else
		element_ctrl = AddLightnessControll(element_params,controllers,IndicatorName)
	end
	meshPoly.element_params = element_ctrl[1]
	meshPoly.controllers = element_ctrl[2]
	-- if element_ctrl then
	-- 	meshPoly.element_params = element_ctrl[1]
	-- 	meshPoly.controllers = element_ctrl[2]
	-- elseif element_params and controllers then
	-- 	meshPoly.element_params = element_params
	-- 	meshPoly.controllers = controllers
	-- end
	meshPoly.isvisible       = true
	Add(meshPoly)
	return meshPoly
end