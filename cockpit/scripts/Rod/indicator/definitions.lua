dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

ROD_DEFAULT_LEVEL = 4
ROD_DEFAULT_NOCLIP_LEVEL  = ROD_DEFAULT_LEVEL - 1
ROD_SCALE = 1--1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= ROD_DEFAULT_LEVEL
    Add(object)
end

----------------------------------------------------------------------------------------

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