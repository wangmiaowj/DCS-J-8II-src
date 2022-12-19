
dofile(LockOn_Options.script_path .. "Rod/indicator/definitions.lua")


local Rod_Simp = CreateElement "ceSimple"
Rod_Simp.name = "Rod_Simp"
Rod_Simp.init_pos = {0,0}
Add(Rod_Simp)

local function make_inner_ring(material, radius, width, name, init_pos, init_rot, element_params, controllers,parentElement)
	local inner_ring = CreateElement "ceMeshPoly"
	if name then
		inner_ring.name = name
	else
		inner_ring.name = create_guid_string()
	end
	inner_ring.primitivetype = "triangles"
	set_circle(inner_ring, radius + width, radius - width, 360, 64)
	if init_pos then
		inner_ring.init_pos = init_pos
	end
	if init_rot then
		inner_ring.init_pos = init_rot
	end
	inner_ring.material = material
	if parentElement then
		inner_ring.parent_element = parentElement
	end
	if element_params then
		inner_ring.element_params = element_params
	end
	if controllers then
		inner_ring.controllers = controllers
	end
	inner_ring.h_clip_relation = h_clip_relations.COMPARE
	inner_ring.level           = ROD_DEFAULT_LEVEL
	inner_ring.isdraw          = true
	inner_ring.collimated      = false
	inner_ring.isvisible       = true
	Add(inner_ring)
end

local function make_line(material,name,starPos,endPos,thickness,isMirror,position,rotation,element_params, controllers,parent_element)
    local line = CreateElement "ceMeshPoly"
    if name then
		line.name = name
	else
		line.name = create_guid_string()
	end
    line.primitivetype = "triangles"
    if isMirror then
        line.vertices = {{starPos,thickness},{starPos,-thickness},{endPos,-thickness},{endPos,thickness},{-starPos,thickness},{-starPos,-thickness},{-endPos,-thickness},{-endPos,thickness}}
        line.indices = {0,1,2,2,3,0,4,5,6,6,7,4}
    else
        line.vertices = {{starPos,thickness},{starPos,-thickness},{endPos,-thickness},{endPos,thickness}}
        line.indices = {0,1,2,2,3,0}
    end
    if rotation then
        line.init_rot = rotation
    end
    if position then
        line.init_pos = position
    end
    line.material = material
    if parent_element then
        line.parent_element = parent_element
    end
    if element_params then
		line.element_params = element_params
	end
	if controllers then
		line.controllers = controllers
	end
    line.h_clip_relation = h_clip_relations.COMPARE
    line.level            = ROD_DEFAULT_LEVEL
    line.isdraw          = true
	line.collimated      = false
	line.isvisible	=true
    Add(line)
end
make_line("DBG_WHITE", nil, -0.8, 0.8, 0.01, false, nil, nil, { "ROD_DISPLAY" }, { { "parameter_in_range", 0, 0.9, 1.1 } }
	, Rod_Simp.name)
make_line("DBG_WHITE", nil, -0.8, 0.8, 0.01, false, nil, { 90, 0 }, { "ROD_DISPLAY" },
	{ { "parameter_in_range", 0, 0.9, 1.1 } }, Rod_Simp.name)
	--十字架
make_inner_ring("DBG_RED", 0.05 , 0.005, nil, { 0, 0.02, 0 }, nil, { "ROD_DISPLAY","ROD_STICK_PITCH_POS","ROD_STICK_ROLL_POS" },
    { { "parameter_in_range", 0, 0.9, 1.1 }, { "move_up_down_using_parameter", 1,-0.08 },
        { "move_left_right_using_parameter", 2,0.08 } },Rod_Simp.name)
	--杆量环
make_line("DBG_WHITE", 'RudderLine', -1, 1, 0.01, false, { 0, -0.95 }, nil, { "ROD_DISPLAY" },
	{ { "parameter_in_range", 0, 0.9, 1.1 } }, Rod_Simp.name)
	--脚舵线
make_line("DBG_RED", nil, -0.05, 0.05, 0.01, false, nil, { 90, 0 }, { "ROD_DISPLAY", "ROD_RUD_POS" },
	{ { "parameter_in_range", 0, 0.9, 1.1 }, { "move_up_down_using_parameter", 1, 0.1 } }, "RudderLine")
	--脚舵位
make_line("DBG_WHITE", 'Left_Throttle', -0.9, 0.9, 0.01, false, { -0.96, 0 }, { 90, 0 }, { "ROD_DISPLAY" },
	{ { "parameter_in_range", 0, 0.9, 1.1 } }, Rod_Simp.name)
	--左发线
make_line("DBG_WHITE", 'Right_Throttle', -0.9, 0.9, 0.01, false, { -0.86, 0 }, { 90, 0 }, { "ROD_DISPLAY" },
	{ { "parameter_in_range", 0, 0.9, 1.1 } }, Rod_Simp.name)
	--右发线
make_line("DBG_RED", nil, -0.05, 0.05, 0.01, false, { -0.9, 0, 0 }, { -90, 0 }, { "ROD_DISPLAY", "ROD_LT_POS" },
	{ { "parameter_in_range", 0, 0.9, 1.1 }, { "move_up_down_using_parameter", 1, 0.18 } }, "Left_Throttle")
	--左发位
make_line("DBG_RED", nil, -0.05, 0.05, 0.01, false, { -0.9, 0, 0 }, { -90, 0 }, { "ROD_DISPLAY", "ROD_RT_POS" },
	{ { "parameter_in_range", 0, 0.9, 1.1 }, { "move_up_down_using_parameter", 1, 0.18 } }, "Right_Throttle")
	--右发位
