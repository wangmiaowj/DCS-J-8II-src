dofile(LockOn_Options.script_path .. "avRadar/Indicator/definitions.lua")

--local MARK_MATERIAL   = MakeMaterial(nil,{255,120,0,255})
RS = RADAR_SCALE

ud_scale      = 0.00001 * 0.1 * RS --0.00001
lr_scale      = 0.095 * 0.1 * 2 * RS --0.2		--0.085
life_time     = 1 --1
life_time_low = 0


-------------------------------------------------------------


local function make_inner_ring(material, radius, width, name, init_pos, init_rot, element_params, controllers)
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
	if element_params then
		inner_ring.element_params = element_params
	end
	if controllers then
		inner_ring.controllers = controllers
	end
	inner_ring.h_clip_relation = h_clip_relations.COMPARE
	inner_ring.level           = RADAR_DEFAULT_LEVEL
	inner_ring.isdraw          = true
	inner_ring.collimated      = false
	inner_ring.isvisible       = true
	Add(inner_ring)
end

for i = 1, 4 do
	make_inner_ring(MFCD_GREEN_SOFT, i * 0.45 * RS, 0.005, nil, { 0, -0.9 * RS, 0 }, nil, { "RADAR_LIGHTNESS" },
		{ { "opacity_using_parameter", 0 } })
end

local x_size = 0.01 * 2
local y_size = 0.01 * 2

--	for ia = 1,999 do
for ia = 1, 900 do

	if ia < 10 then
		i = "_0" .. ia .. "_"
	else
		i = "_" .. ia .. "_"
	end

	local radar_contact           = CreateElement "ceMeshPoly"
	radar_contact.name            = "radar_contact" .. i .. "name"
	radar_contact.primitivetype   = "triangles" --"lines"--
	radar_contact.vertices        = {
		{ -x_size, -y_size },
		{ -x_size, y_size },
		{ x_size, y_size },
		{ x_size, -y_size },
	}
	radar_contact.indices         = { 0, 1, 2, 0, 2, 3 } --{0, 1, 2, 0, 2, 3}
	radar_contact.init_pos        = { 0, -0.90 * RS, 0 }
	radar_contact.material        = MakeMaterial(nil, { 0, 15, 0, 255 })
	radar_contact.isdraw          = true
	radar_contact.isvisible       = true
	radar_contact.h_clip_relation = h_clip_relations.COMPARE
	radar_contact.level           = RADAR_DEFAULT_LEVEL
	radar_contact.collimated      = true
	radar_contact.controllers     = {
		--{"move_up_down_using_parameter"		,0,1.0},
		{ "move_left_right_using_parameter", 1, lr_scale },
		{ "move_up_down_using_parameter", 2, ud_scale },
		{ "parameter_in_range", 2, 30, 120000 },
		{ "parameter_in_range", 3, life_time_low, life_time },
		{ "change_color_when_parameter_equal_to_number", 4, 1, 1.0, 1.0, 0.0 },
		{ "parameter_in_range", 5, -1,100}
	}
	radar_contact.element_params  = {
		"RADAR_CONTACT" .. i .. "ELEVATION",
		"RADAR_CONTACT" .. i .. "AZIMUTH",
		"RADAR_CONTACT" .. i .. "RANGE",
		"RADAR_CONTACT" .. i .. "TIME",
		"RADAR_CONTACT" .. i .. "FRIENDLY",
		"RADAR_CONTACT" .. i .. "RCS",
		"RADAR_CONTACT" .. i .. "LGT"
	}
	Add(radar_contact)

end
--------------------------------------------------------------------------


local x_size = 0.006
local y_size = 0.05


local radar_cursor           = CreateElement "ceMeshPoly"
radar_cursor.name            = "radar_cursor"
radar_cursor.primitivetype   = "triangles"
radar_cursor.vertices        = {
	{ -x_size - 0.04, -y_size },
	{ -x_size - 0.04, y_size },
	{ x_size - 0.04, y_size },
	{ x_size - 0.04, -y_size },

	{ -x_size + 0.04, -y_size },
	{ -x_size + 0.04, y_size },
	{ x_size + 0.04, y_size },
	{ x_size + 0.04, -y_size },
}
radar_cursor.indices         = { 0, 1, 2, 0, 2, 3, 4, 5, 6, 4, 6, 7 } --{0, 1, 2, 0, 2, 3}
radar_cursor.init_pos        = { 0, -0.90 * RS, 0 }
radar_cursor.material        = MakeMaterial(nil, { 0, 15, 0, 255 }) --MFCD_GREEN
radar_cursor.isdraw          = true
radar_cursor.isvisible       = true
radar_cursor.h_clip_relation = h_clip_relations.COMPARE
radar_cursor.level           = RADAR_DEFAULT_LEVEL
radar_cursor.collimated      = true
radar_cursor.controllers     = {
	{ "move_up_down_using_parameter", 0, ud_scale },
	{ "move_left_right_using_parameter", 1, lr_scale },
	{ "parameter_in_range", 2, -0.1, 2.1 },
	{ "opacity_using_parameter", 3, },
}
radar_cursor.element_params  = {
	"RADAR_TDC_RANGE",
	"RADAR_TDC_AZIMUTH",
	"RADAR_MODE",
	"RADAR_LIGHTNESS"
}
Add(radar_cursor)

local line_shape           = CreateElement "ceSimpleLineObject"
line_shape.name            = create_guid_string()
line_shape.width           = 0.008
line_shape.vertices        = {{0,0},{0,0}}
line_shape.init_pos        = { 0, -0.90 * RS}
line_shape.init_rot        = { 0, 0 }
line_shape.tex_params      = {{0, 0.5}, {1, 0.5}, {1 / (1024 * 100 / 275), 1}}
line_shape.isdraw		   = true
line_shape.material        = MakeMaterial(nil,{0, 0, 0, 255})
line_shape.additive_alpha  = false
line_shape.collimated      = false
line_shape.use_mipfilter   = true
--line_shape.parent_element  = "hud_base_clip"
line_shape.h_clip_relation = h_clip_relations.COMPARE
line_shape.level           = RADAR_DEFAULT_LEVEL
line_shape.isdraw          = true
line_shape.element_params           = {"RADAR_MODE","RADAR_TDC_AZIMUTH","RADAR_TDC_RANGE","RADAR_TDC_AZIMUTH_2","RADAR_TDC_RANGE_2"} --, "D_GUNSIGHT_VISIBLE"
line_shape.controllers              = {
	{"parameter_in_range",0,-0.1,2.1},
	{"line_object_set_point_using_parameters",0,1,2,lr_scale,ud_scale},
	{"line_object_set_point_using_parameters",1,3,4,lr_scale,ud_scale}
}
Add(line_shape)


x_size = 0.03
y_size = 0.03


local radar_STT           = CreateElement "ceMeshPoly"
radar_STT.name            = "radar_STT"
radar_STT.primitivetype   = "triangles" --"lines"--
radar_STT.vertices        = {
	{ -x_size, -y_size },
	{ -x_size, y_size },
	{ x_size, y_size },
	{ x_size, -y_size },
}
radar_STT.indices         = { 0, 1, 2, 0, 2, 3 } --{0, 1, 2, 0, 2, 3}
radar_STT.init_pos        = { 0, -0.90 * RS, 0 }
radar_STT.material        = MakeMaterial(nil, { 0, 15, 0, 255 }) --MFCD_GREEN--MakeMaterial(nil,{10,10,255,150})
radar_STT.isdraw          = true
radar_STT.isvisible       = true
radar_STT.h_clip_relation = h_clip_relations.COMPARE
radar_STT.level           = RADAR_DEFAULT_LEVEL
radar_STT.collimated      = true
radar_STT.controllers     = {
	{ "move_up_down_using_parameter", 0, ud_scale },
	{ "move_left_right_using_parameter", 1, lr_scale },
	--{"move_up_down_using_parameter"		,3,1.0},
	{ "parameter_in_range", 3, 2.9, 3.1 },
	{ "opacity_using_parameter", 4, },
}
radar_STT.element_params  = {
	"RADAR_STT_RANGE",
	"RADAR_STT_AZIMUTH",
	"RADAR_STT_ELEVATION",
	"RADAR_MODE",
	"RADAR_LIGHTNESS",
}
Add(radar_STT)

x_size                           = 0.004
y_size                           = 0.09
local radar_STT_backview         = CreateElement "ceMeshPoly"
radar_STT_backview.name          = "radar_STT_backview"
radar_STT_backview.primitivetype = "triangles" --"lines"--
radar_STT_backview.vertices      = {
	{ -x_size, -y_size },
	{ -x_size, y_size },
	{ x_size, y_size },
	{ x_size, -y_size },

	{ -y_size, -x_size },
	{ -y_size, x_size },
	{ y_size, x_size },
	{ y_size, -x_size },

}
radar_STT_backview.indices       = { 0, 1, 2, 0, 2, 3, 4, 5, 6, 4, 6, 7 } --{0, 1, 2, 0, 2, 3}
radar_STT_backview.init_pos      = { 0, 0.0, 0 }
radar_STT_backview.material      = MakeMaterial(nil, { 0, 15, 0, 255 }) --MFCD_GREEN--MakeMaterial(nil,{10,10,255,150})
radar_STT_backview.isdraw        = true
radar_STT_backview.isvisible     = true

radar_STT_backview.h_clip_relation = h_clip_relations.COMPARE
radar_STT_backview.level           = RADAR_DEFAULT_LEVEL
radar_STT_backview.collimated      = true
radar_STT_backview.controllers     = {
	{ "move_up_down_using_parameter", 2, lr_scale },
	{ "move_left_right_using_parameter", 1, lr_scale },
	{ "parameter_in_range", 3, 2.9, 3.1 },
	{ "opacity_using_parameter", 4, },
}
radar_STT_backview.element_params  = {
	"RADAR_STT_RANGE",
	"RADAR_STT_AZIMUTH",
	"RADAR_STT_ELEVATION",
	"RADAR_MODE",
	"RADAR_LIGHTNESS"
}
Add(radar_STT_backview)

x_size                        = 0.004
y_size                        = 0.08
local radar_STT_iff           = CreateElement "ceMeshPoly"
radar_STT_iff.name            = "radar_STT_iff"
radar_STT_iff.primitivetype   = "triangles" --"lines"--
radar_STT_iff.vertices        = {
	{ -x_size, -y_size },
	{ -x_size, y_size },
	{ x_size, y_size },
	{ x_size, -y_size },
}
radar_STT_iff.indices         = { 0, 1, 2, 0, 2, 3 } --{0, 1, 2, 0, 2, 3}
radar_STT_iff.init_pos        = { 0, 0, 0 }
radar_STT_iff.material        = MakeMaterial(nil, { 0, 15, 0, 255 }) --MFCD_GREEN--MakeMaterial(nil,{10,10,255,150})
radar_STT_iff.isdraw          = true
radar_STT_iff.isvisible       = true
radar_STT_iff.h_clip_relation = h_clip_relations.COMPARE
radar_STT_iff.level           = RADAR_DEFAULT_LEVEL
radar_STT_iff.collimated      = true
radar_STT_iff.parent_element  = "radar_STT"
radar_STT_iff.controllers     = {
	{ "parameter_in_range", 0, 0.9, 1.1 },
	{ "change_color_when_parameter_equal_to_number", 0, 1, 1.0, 1.0, 0.0 },
	{ "opacity_using_parameter", 1, },
}
radar_STT_iff.element_params  = { "RADAR_STT_FRIENDLY", "RADAR_LIGHTNESS" }
Add(radar_STT_iff)




local radar_cursor_range           = CreateElement "ceStringPoly"
radar_cursor_range.name            = "radar_cursor_range"
radar_cursor_range.material        = MakeMaterial({ used_DXUnicodeFontData = "font_arial_17" }, { 0, 15, 0, 255 }) --HUD_FONT
radar_cursor_range.init_pos        = { -0.1, 0.0, 0 }
radar_cursor_range.stringdefs      = txt_m_stringdefs
radar_cursor_range.alignment       = "RightCenter" --"LeftTop"
radar_cursor_range.value           = "test"
radar_cursor_range.formats         = { "%.0f" }
radar_cursor_range.UseBackground   = false
radar_cursor_range.element_params  = { "RADAR_TDC_RANGE", "RADAR_LIGHTNESS" }
radar_cursor_range.controllers     = { { "text_using_parameter", 0, 0 }, { "opacity_using_parameter", 1, } }
radar_cursor_range.parent_element  = "radar_cursor"
radar_cursor_range.use_mipfilter   = true
radar_cursor_range.h_clip_relation = h_clip_relations.COMPARE
radar_cursor_range.level           = RADAR_DEFAULT_LEVEL
Add(radar_cursor_range)


local radar_cursor_upper_alt          = Copy(radar_cursor_range)
radar_cursor_upper_alt.name           = "radar_cursor_upper_alt"
radar_cursor_upper_alt.init_pos       = { 0.25, 0.05, 0 } --{0.15,0.05,0}
radar_cursor_upper_alt.alignment      = "RightCenter" --"LeftTop"
radar_cursor_upper_alt.formats        = { "%.4f", "%s" }
radar_cursor_upper_alt.element_params = { "RADAR_TDC_ELEVATION_AT_RANGE_UPPER", "RADAR_LIGHTNESS" }
radar_cursor_upper_alt.controllers    = { { "text_using_parameter", 0, 0 }, { "opacity_using_parameter", 1, }, }
Add(radar_cursor_upper_alt)

local radar_cursor_lower_alt          = Copy(radar_cursor_range)
radar_cursor_lower_alt.name           = "radar_cursor_lower_alt"
radar_cursor_lower_alt.init_pos       = { 0.25, -0.05, 0 } --{0.15,-0.05,0}
radar_cursor_lower_alt.formats        = { "%.4f", "%s" }
radar_cursor_lower_alt.element_params = { "RADAR_TDC_ELEVATION_AT_RANGE_LOWER", "RADAR_LIGHTNESS" }
radar_cursor_lower_alt.controllers    = { { "text_using_parameter", 0, 0 }, { "opacity_using_parameter", 1, }, }
Add(radar_cursor_lower_alt)




local radar_bearing_L15           = CreateElement "ceStringPoly"
radar_bearing_L15.name            = "radar_bearing_L15"
radar_bearing_L15.material        = MakeMaterial({ used_DXUnicodeFontData = "font_arial_17" }, { 0, 15, 0, 255 }) --HUD_FONT
radar_bearing_L15.init_pos        = { -0.45 * RS, 0.9 * RS, 0 }
radar_bearing_L15.stringdefs      = txt_m_stringdefs
radar_bearing_L15.alignment       = "CenterBottom" --"LeftTop"
radar_bearing_L15.value           = "15"
radar_bearing_L15.formats         = { "%.0f" }
radar_bearing_L15.UseBackground   = false
radar_bearing_L15.use_mipfilter   = true
radar_bearing_L15.h_clip_relation = h_clip_relations.COMPARE
radar_bearing_L15.level           = RADAR_DEFAULT_LEVEL
radar_bearing_L15.controllers     = { { "opacity_using_parameter", 0, }, }
radar_bearing_L15.element_params  = { "RADAR_LIGHTNESS" }
Add(radar_bearing_L15)

local radar_bearing_R15          = Copy(radar_bearing_L15)
radar_bearing_R15.name           = "radar_bearing_R15"
radar_bearing_R15.init_pos       = { 0.45 * RS, 0.9 * RS, 0 }
radar_bearing_R15.controllers    = { { "opacity_using_parameter", 0, }, }
radar_bearing_R15.element_params = { "RADAR_LIGHTNESS" }
Add(radar_bearing_R15)

local radar_bearing_L30          = Copy(radar_bearing_L15)
radar_bearing_L30.name           = "radar_bearing_L30"
radar_bearing_L30.value          = "30"
radar_bearing_L30.init_pos       = { -0.90 * RS, 0.9 * RS, 0 }
radar_bearing_L30.controllers    = { { "opacity_using_parameter", 0, }, }
radar_bearing_L30.element_params = { "RADAR_LIGHTNESS" }
Add(radar_bearing_L30)

local radar_bearing_R30          = Copy(radar_bearing_L15)
radar_bearing_R30.name           = "radar_bearing_R30"
radar_bearing_R30.value          = "30"
radar_bearing_R30.init_pos       = { 0.90 * RS, 0.9 * RS, 0 }
radar_bearing_R30.controllers    = { { "opacity_using_parameter", 0, }, }
radar_bearing_R30.element_params = { "RADAR_LIGHTNESS" }
Add(radar_bearing_R30)



x_size = 0.01
y_size = 2


local radar_SZ_AZIMUTH           = CreateElement "ceMeshPoly"
radar_SZ_AZIMUTH.name            = "radar_SZ_AZIMUTH"
radar_SZ_AZIMUTH.primitivetype   = "triangles" --"lines"--
radar_SZ_AZIMUTH.vertices        = {
	{ -x_size, 0 },
	{ -x_size, y_size },
	{ x_size, y_size },
	{ x_size, 0 },
}
radar_SZ_AZIMUTH.indices         = { 0, 1, 2, 0, 2, 3 } --{0, 1, 2, 0, 2, 3}
radar_SZ_AZIMUTH.init_pos        = { 0, -0.9 * RS, 0 }
radar_SZ_AZIMUTH.material        = MakeMaterial(nil, { 236, 255, 250, 255 }) --MakeMaterial(nil,{10,10,255,150})
radar_SZ_AZIMUTH.isdraw          = true
radar_SZ_AZIMUTH.isvisible       = true
radar_SZ_AZIMUTH.h_clip_relation = h_clip_relations.COMPARE
radar_SZ_AZIMUTH.level           = RADAR_DEFAULT_LEVEL
radar_SZ_AZIMUTH.collimated      = true
--radar_SZ_AZIMUTH.parent_element	= "radar_STT"
radar_SZ_AZIMUTH.controllers     = {
	{ "rotate_using_parameter", 0, 1 },
	--{"parameter_in_range",0,0.9,1.1},
	--{"change_color_when_parameter_equal_to_number", 0, 1, 1.0,1.0,0.0},
	{ "opacity_using_parameter", 1 }
}
radar_SZ_AZIMUTH.element_params  = { "SCAN_BEAM_AZIMUTH", "RADAR_LIGHTNESS" }
Add(radar_SZ_AZIMUTH)
