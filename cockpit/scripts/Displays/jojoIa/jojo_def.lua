dofile(LockOn_Options.script_path.."Displays/common_definitions.lua")

jojo_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/PFD/"


SetScale(FOV)


DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD  = 0.0174532925199433
RAD_TO_DEGREE  = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

jojo_ASPECT_HEIGHT = GetAspect()


jojo_DEFAULT_LEVEL = 15                            
jojo_DEFAULT_NOCLIP_LEVEL  = jojo_DEFAULT_LEVEL + 1 

--Colors
jojo_WHITE_COLOR               = {255,255,255,255}
--Materials
jojo_PAGE_INDICATOR = MakeMaterial(jojo_IND_TEX_PATH.."YOUR_INDICATOR_HERE", jojo_WHITE_COLOR)

default_jojo_x = 6000
default_jojo_y = 6000

function jojo_vert_gen(width, height)
    return {{(0 - width) / 2 / default_jojo_x , (0 + height) / 2 / default_jojo_y},
    {(0 + width) / 2 / default_jojo_x , (0 + height) / 2 / default_jojo_y},
    {(0 + width) / 2 / default_jojo_x , (0 - height) / 2 / default_jojo_y},
    {(0 - width) / 2 / default_jojo_x , (0 - height) / 2 / default_jojo_y},}
end

function jojo_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_jojo_x , (0 + total_height) / 2 / default_jojo_y},
        {(0 + width) / 2 / default_jojo_x , (0 + total_height) / 2 / default_jojo_y},
        {(0 + width) / 2 / default_jojo_x , (0 + not_include_height) / 2 / default_jojo_y},
        {(0 - width) / 2 / default_jojo_x , (0 + not_include_height) / 2 / default_jojo_y},
        {(0 + width) / 2 / default_jojo_x , (0 - not_include_height) / 2 / default_jojo_y},
        {(0 - width) / 2 / default_jojo_x , (0 - not_include_height) / 2 / default_jojo_y},
        {(0 + width) / 2 / default_jojo_x , (0 - total_height) / 2 / default_jojo_y},
        {(0 - width) / 2 / default_jojo_x , (0 - total_height) / 2 / default_jojo_y},
    }
end

function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end

function mirror_tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{(x_dis + width) / size_X , y_dis / size_Y},
			{x_dis / size_X , y_dis / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},}
end

function calculateCircle(object, radius, init_x, init_y, point_num)
	local verts = {}
    multiplier = math.rad(360.0/point_num)
    verts[1] = {init_x / default_jojo_x, init_y / default_jojo_y}
	for i = 2, point_num do
	  verts[i] = {(init_x + radius * math.cos(i * multiplier)) / default_jojo_x, (init_y + radius * math.sin(i * multiplier)) / default_jojo_y}
    end
    
    local indices = {}
	for i = 0, point_num - 3 do
	  indices[i * 3 + 1] = 0
	  indices[i * 3 + 2] = i + 1
	  indices[i * 3 + 3] = i + 2
    end
    indices[(point_num - 2) * 3 + 1] = 0
    indices[(point_num - 2) * 3 + 2] = 1
    indices[(point_num - 2) * 3 + 3] = point_num - 1
	object.vertices = verts
	object.indices  = indices
end



PAGE_LEVEL_BASE                     = jojo_DEFAULT_LEVEL
DISPLAY_DEFAULT_LEVEL               = 4
PAGE_LEVEL_NAV                      = jojo_DEFAULT_LEVEL + 6
PAGE_LEVEL_PFD                      = jojo_DEFAULT_LEVEL + 12

FONT_SIZE  = 0.005

FONT_W = FONT_SIZE * 144 / 128

H2W_SCALE = GetAspect()

MFCD_STRINGDEFS_DEF  = {0.80 * FONT_W, 0.80 * FONT_W, 0, 0}

DEF_BOX_INDICES = { 0,1,2, 0,2,3 }

function DegToMilRad(degree)
	return degree*(1000/180)*3.141592
end


function jojo_tex_coord (UL_X,UL_Y,W,H,SZX,SZY)
    local ux = UL_X / SZX
    local uy = UL_Y / SZY
    local w  = W / SZX
    local h  = H / SZY
    return {{ux + w ,uy},
            {ux + w ,uy + h},
            {ux     ,uy + h},
            {ux     ,uy}}
end

function AddElementObject(object)
    if (object.name == nil) or (string.len(object.name) < 1) then
        object.name            = create_guid_string()
    end
    if (type(object.stringdefs) ~= "table") or (next(object.stringdefs) == nil) then
        object.stringdefs      = MFCD_STRINGDEFS_DEF
    end
    if (object.h_clip_relation == nil) then
        object.h_clip_relation = h_clip_relations.COMPARE
    end

    if (object.level == nil) or (object.level < jojo_DEFAULT_LEVEL) then
        object.level        = jojo_DEFAULT_LEVEL
    end
    object.use_mipfilter    = true
    object.additive_alpha   = true
    object.collimated       = false
    Add(object)
end

local base_clip            = CreateElement "ceSimple"
base_clip.name             = "base_clip"
base_clip.h_clip_relation  = h_clip_relations.COMPARE
base_clip.level            = jojo_DEFAULT_LEVEL
base_clip.isdraw           = true
base_clip.isvisible        = false
base_clip.init_pos         = {0,0,0}
Add(base_clip)

function AddToClip(elem)
    if (elem.parent_element == nil) or (string.len(elem.parent_element) < 1) then
        elem.parent_element  = "base_clip"
    end

    AddElementObject(elem)
    return elem
end

function SetCircleMesh(obj, radius_outer, radius_inner, iarc, iclipped)
    local verts    = {}
    local inds     = {}
    local solid    = radius_inner == nil or radius_inner == 0
    local arc      = iarc or 360
    local count    = 36
    local delta    = math.rad(arc/count)
    local clipped  = iclipped or false

    if arc > 360 or arc < 0 then
        arc = 360
    end

    local min_i    = 1
    local max_i    = count + 1
    verts[1] = {0,0}
    for i=min_i,max_i do
        k = i

        ---- for ADI clipped ball shape
        -- clip nodes are 3 from each side
        if clipped then
            if i < 4 or i > 34 then -- equal to 3, 33
                k = 4
            elseif i > 16 and i < 22 then -- equal to 15, 21
                k = 16
            end
        end

        if solid then
            verts[1 + i]      = { radius_outer * math.cos(delta *(k-1)), radius_outer * math.sin(delta *(k-1)), }
            inds[3*(i-1) + 1] = 0
            inds[3*(i-1) + 2] = i - 1
            inds[3*(i-1) + 3] = i
        else
            verts[2*(i - 1) + 1] = { radius_outer * math.cos(delta *(k-1)), radius_outer * math.sin(delta *(k-1)), }
            verts[2*(i - 1) + 2] = { radius_inner * math.cos(delta *(k-1)), radius_inner * math.sin(delta *(k-1)), }

            if i == max_i  then
              if arc == 360 then
                inds[6*(i-1) + 1] = 2*(i     - 1)
                inds[6*(i-1) + 2] = 2*(min_i - 1)
                inds[6*(i-1) + 3] = 2*(i     - 1) + 1
                inds[6*(i-1) + 4] = 2*(i     - 1) + 1
                inds[6*(i-1) + 5] = 2*(min_i - 1)
                inds[6*(i-1) + 6] = 2*(min_i - 1) + 1
              end
            else
                inds[6*(i-1) + 1] = 2*(i - 1)
                inds[6*(i-1) + 2] = 2*(i)
                inds[6*(i-1) + 3] = 2*(i - 1) + 1
                inds[6*(i-1) + 4] = 2*(i - 1) + 1
                inds[6*(i-1) + 5] = 2*(i)
                inds[6*(i-1) + 6] = 2*(i)     + 1
            end
        end
    end
    obj.vertices = verts
    obj.indices  = inds
end
