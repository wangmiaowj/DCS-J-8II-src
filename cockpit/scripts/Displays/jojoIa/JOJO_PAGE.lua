dofile(LockOn_Options.script_path .. "Displays/jojoIa/jojo_def.lua")
dofile(LockOn_Options.script_path .. "Systems/electric_system_api.lua")

local positionX           = -2.56
local positionY           = -1
local positionZ           = 0

MAX_MENU                  = 8

AddBox('GPS_C_BASE',Width,0.8*Height,{ positionX, positionY, positionZ },nil,MakeMaterial(nil, { 3, 3, 12, 128 }),PAGE_LEVEL_BASE,REWRITE_LEVEL,nil,{ "CURSOR_SHOW" },{ { "parameter_compare_with_number", 0, 2 } })

local cursor           = CreateElement "ceTexPoly"
cursor.vertices        = jojo_vert_gen(550, 550)              --Size X,Y
cursor.indices         = { 0, 1, 2, 0, 2, 3 }
cursor.tex_coords      = tex_coord_gen(450, 819, 80, 67, 2048, 2048) -- start X , start Y , cut X, cut Y, resolution X, resolution Y 2048/2048
cursor.material        = jojo_PAGE_INDICATOR
cursor.name            = "jojo_cursor"
cursor.init_pos        = { positionX, positionY, positionZ }
cursor.init_rot        = { 0, 0, 0 }
cursor.collimated      = true
cursor.use_mipfilter   = true
cursor.additive_alpha  = false
cursor.isvisible       = true
cursor.h_clip_relation = h_clip_relations.REWRITE_LEVEL
cursor.level           = PAGE_LEVEL_BASE + 1
cursor.element_params  = { "CURSOR_SHOW", "HEAD_LR", "HEAD_UD" }
cursor.controllers     = { { "parameter_compare_with_number", 0, 2 }, { "move_left_right_using_parameter", 1, 1 },
  { "move_up_down_using_parameter", 2, 1 } }
Add(cursor)

AddSimpleLine('Cursorline',nil,jojo_vert_gen(1, 1),{ positionX, positionY, positionZ },nil,'DBG_WHITE',REWRITE_LEVEL,PAGE_LEVEL_BASE+1,nil,
  { "CURSOR_SHOW", "HEAD_LR", "HEAD_UD" },
  {
    { "parameter_compare_with_number", 0, 2 },
    { "line_object_set_point_using_parameters", 0, 1, 2, 1, 1 }
  }
)

for i = 1, MAX_MENU do
  AddText(nil,nil,'unicode_cn_white',{ positionX, positionY, positionZ },nil,{ 0.05, 0.05, 0, 0 },REWRITE_LEVEL,PAGE_LEVEL_BASE+1,nil,
  {'%s'},
  {
    string.format( "MENU_%.0f_TXT",i ),
    string.format( "MENU_%.0f_SHOW",i ),
    string.format( "MENU_%.0f_X",i ),
    string.format( "MENU_%.0f_Y",i ),
    "CURSOR_SHOW",
    string.format( "CURSOR_TOP_%.0f",i )
  },
  {
    { "text_using_parameter", 0 },
    { "parameter_compare_with_number", 4, 2 },
    { "move_left_right_using_parameter", 2, 1 },
    { "move_up_down_using_parameter", 3, 1 },
    { "parameter_compare_with_number", 4, 2 },
    { "change_color_when_parameter_equal_to_number", 5, 1, 1, 0, 0 },
    { "change_color_when_parameter_equal_to_number", 5, 0, 1, 1, 1 }
  }
)
end



--known parameter
-- {"change_color_when_parameter_equal_to_number", param_nr, number, red, green, blue}
-- {"text_using_parameter", param_nr, format_nr}
-- {"move_left_right_using_parameter", param_nr, gain}
-- {"move_up_down_using_parameter", param_nr, gain}
-- {"opacity_using_parameter", param_nr}
-- {"rotate_using_parameter", param_nr, gain}
-- {"compare_parameters", param1_nr, param2_nr} -- if param1 == param2 then visible
-- {"parameter_in_range", param_nr, greaterthanvalue, lessthanvalue} -- if greaterthanvalue < param < lessthanvalue then visible
-- {"parameter_compare_with_number", param_nr, number} -- if param == number then visible
-- {"draw_argument_in_range", arg_nr, greaterthanvalue, lessthanvalue} -- if greaterthanvalue < arg < lessthanvalue then visible
-- {"line_object_set_point_using_parameters", point_nr, param_x, param_y, gain_x, gain_y} -- applies to ceSimpleLineObject at least


--known but not finished
-- {"change_texture_state_using_parameter",???} -- exists but crashed DCS when used with one argument.
-- {"change_color_using_parameter", ???} -- exists but crashed DCS when used with one to five arguments.
-- {"fov_control", ???}
-- {"increase_render_target_counter", ???}
