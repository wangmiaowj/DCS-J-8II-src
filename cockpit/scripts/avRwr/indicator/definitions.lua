dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

RWR_DEFAULT_LEVEL = 4
RWR_DEFAULT_NOCLIP_LEVEL  = RWR_DEFAULT_LEVEL - 1
RWR_SCALE = 1--1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= RWR_DEFAULT_LEVEL
    Add(object)
end



--{"change_color_when_parameter_equal_to_number", 1, 0.7, 0/255,128/255,0/255},
--{"change_color_when_parameter_equal_to_number", 1, 0.7, 0/255,255/255,0/255},
----Colors--------------------------------
	BG_BLACK_COLOR		= {30, 30, 30, 255}
	TEXT_GREEN_COLOR 	= {0, 255, 50, 255}
	TEXT_BLACK_COLOR 	= BG_BLACK_COLOR--{2, 2, 2, 255}
------------------------------------------


MATERIAL_BLACK   	= MakeMaterial(nil,{25,25,25,255})
RADAR_BG_BLACK		= MakeMaterial(nil,BG_BLACK_COLOR)--{20,20,20,255})			
RADAR_SOLID_BLACK   	= MakeMaterial(nil,{0,0,0,255,255})

MFCD_GREEN			= MakeMaterial(nil,{0, 255, 5, 255})
MFCD_GREEN_SOFT		= MakeMaterial(nil,{25, 255, 25, 128})


-------FONTS------------------------------------------------------------------------------

HUD_FONT 	= MakeFont({used_DXUnicodeFontData = "font_arial_17"},TEXT_GREEN_COLOR)		--5 "font_arial_17"  is good 
HUD_FONT_INV= MakeFont({used_DXUnicodeFontData = "font_arial_17"},TEXT_BLACK_COLOR)

FONT_SCALE = 1 

local font_size 					= 0.008						* FONT_SCALE
local default_char_height  			= font_size or 0.004		* FONT_SCALE
local default_char_width   			= 0.3 * default_char_height	* FONT_SCALE
local default_char_vert_spaceing 	= -0.001							--must be adjustet manualy to scale (scale 0.8   	-0.001

txt_box_stringdefs 	= 	{default_char_height		, default_char_width		,0, default_char_vert_spaceing} 
txt_head_stringdefs = 	{default_char_height * 1.3 	, default_char_width * 1.3	,0, -0.0025} 

txt_wpt_stringdefs 	= 	{default_char_height * 1.2 	, default_char_width * 1.2	,0, default_char_vert_spaceing} 

txt_stringdefs 	= 	{default_char_height * 1		, default_char_width * 1		,0, default_char_vert_spaceing} 
txt_s_stringdefs= 	{default_char_height * 1 * 0.5	, default_char_width * 1 * 0.5	,0, default_char_vert_spaceing} 
txt_m_stringdefs= 	{default_char_height * 1 * 0.75	, default_char_width * 1 * 0.75	,0, default_char_vert_spaceing} 
txt_1_stringdefs= 	{default_char_height * 1		, default_char_width * 1		,-0.00051, default_char_vert_spaceing}
-----------------------------------------------------------------------------------------

default_eadi_x = 2000
default_eadi_y = 2000

function create_EADI_circle_index(total_dots)
    local return_group = {}
    -- we can calculate for every three
    for i = 1, (total_dots - 1), 1 do
        return_group[i*3 - 2] = 0;
        return_group[i*3 - 1] = i;
        return_group[i*3] = i + 1;
    end
    return return_group
end

function create_EADI_circle_pos(total_dots, center_X, center_y, radius)
    local return_group = {}
    local temp_deg = 0
    local temp_x = 0
    local temp_y = 0
    for i = 1, total_dots, 1 do
        temp_x = math.sin(math.rad(temp_deg)) * radius + center_X
        temp_y = math.cos(math.rad(temp_deg)) * radius + center_y
        return_group[i] = {temp_x/ default_eadi_x, temp_y/ default_eadi_y}
        temp_deg = temp_deg + 360 / total_dots
    end
    return return_group
end

YELLOW_CONTACT = {"change_color_when_parameter_equal_to_number", 5, 1.0, 1, 1, 0, 1}
RED_CONTACT = {"change_color_when_parameter_equal_to_number", 5, 2.0, 1, 0, 0, 1}
GREEN_CONTACT = {"change_color_when_parameter_equal_to_number", 5, 3.0, 0, 1, 0, 1}
RWR_MAGENTA = MakeMaterial(nil, {255, 25, 255, 255})
RWR_FONT = MakeFont({
    used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"
}, {255, 0, 255, 255})