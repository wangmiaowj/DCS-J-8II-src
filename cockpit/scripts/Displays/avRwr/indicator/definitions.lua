dofile(LockOn_Options.script_path.."Displays/common_definitions.lua")


YELLOW_CONTACT = {"change_color_when_parameter_equal_to_number", 5, 1.0, 1, 1, 0, 1}
RED_CONTACT = {"change_color_when_parameter_equal_to_number", 5, 2.0, 1, 0, 0, 1}
GREEN_CONTACT = {"change_color_when_parameter_equal_to_number", 5, 3.0, 0, 1, 0, 1}
RWR_MAGENTA = MakeMaterial(nil, {255, 25, 255, 255})
RWR_FONT = MakeFont({
    used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"
}, {255, 0, 255, 255})