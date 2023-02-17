dofile(LockOn_Options.script_path .. "avRwr/Indicator/definitions.lua")

--local TST  		 = MakeMaterial(nil,{80,17,7,200})
local TST = MakeMaterial(nil, { 220, 220, 220, 5 })

local SHOW_MASKS                    = true

local x_size = 1 * RWR_SCALE --MFD_SIZE-- * MFD_SCALE
local y_size = 1 * RWR_SCALE --MFD_SIZE --* MFD_SCALE
local corner = 0.9


local vert = { { -x_size, y_size * corner },
    { x_size, y_size * corner },
    { x_size, -y_size * corner },
    { -x_size, -y_size * corner },

    { -x_size, y_size * corner },
    { x_size, y_size * corner },
    { x_size * corner, y_size },
    { -x_size * corner, y_size },

    { -x_size, -y_size * corner },
    { x_size, -y_size * corner },
    { x_size * corner, -y_size },
    { -x_size * corner, -y_size },
}
local indi = { 0, 1, 2, 0, 2, 3,
    4, 5, 6, 4, 6, 7,
    8, 9, 10, 8, 10, 11,
} --default_box_indices





base          = CreateElement "ceSimple"
base.name     = "Rwr_base"
base.init_pos = { 0, 0, 0 }
Add(base)

---------------------------------------------------
local total_field_of_view         = CreateElement "ceMeshPoly"
total_field_of_view.name          = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

total_field_of_view.vertices = create_EADI_circle_pos(120, 0, 0, 2000)
total_field_of_view.indices  = create_EADI_circle_index(120)

total_field_of_view.material        = MakeMaterial(nil, { 255, 1, 1, 255 })
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level           = RWR_DEFAULT_NOCLIP_LEVEL --MDF_FOV_LEVEL
total_field_of_view.controllers     = {
    { "opacity_using_parameter", 0 },
}
total_field_of_view.element_params  = { "RWR_DISPLAY", }
total_field_of_view.isdraw          = true
total_field_of_view.collimated      = false
total_field_of_view.isvisible       = false --false
total_field_of_view.parent_element  = "Rwr_base"
Add(total_field_of_view)
---------------------------------

local black_background         = CreateElement "ceTexPoly"
black_background.primitivetype = "triangles"
black_background.name          = "black_background"
black_background.init_pos      = { 0, 0, 0 }
black_background.material      = MakeMaterial(nil, { 0, 16, 0, 255 })

black_background.vertices        = vert
black_background.indices         = indi
black_background.parent_element  = "Rwr_base"
black_background.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
black_background.level           = RWR_DEFAULT_NOCLIP_LEVEL --MDF_FOV_LEVEL
black_background.controllers     = {
    { "opacity_using_parameter", 0 },
}
black_background.element_params  = { "RWR_DISPLAY", }
Add(black_background)
