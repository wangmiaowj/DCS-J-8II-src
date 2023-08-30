dofile(LockOn_Options.script_path .. "Displays/testScreen/Indicator/definitions.lua")

local x_size = 1 * 1 --MFD_SIZE-- * MFD_SCALE
local y_size = 1 * 1 --MFD_SIZE --* MFD_SCALE
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

local black_background         = CreateElement "ceTexPoly"
black_background.primitivetype = "triangles"
black_background.name          = "black_background"
black_background.init_pos      = { 0, 0, 0 }
black_background.material      = MakeMaterial(nil, { 255, 0, 0, 255 })

black_background.vertices        = vert
black_background.indices         = indi
black_background.h_clip_relation = h_clip_relations.COMPARE
black_background.level           = 0 --MDF_FOV_LEVEL
black_background.controllers     = {
	{ "scale_to_fov", 0,0.1 },
}
black_background.element_params  = { "RDR_FOV", }
Add(black_background)