
dofile(LockOn_Options.script_path .. "avRwr/indicator/definitions.lua")


local contact_scale = 0.030
local pct_display_fill = 0.90

local txtsize_center = 0.005*0.85
local strdefcenter = {txtsize_center, txtsize_center / 4, -txtsize_center / 8, 0}

local RWR_Simp = CreateElement "ceSimple"
RWR_Simp.name = "RWR_Simp"
RWR_Simp.init_pos = {0,0}
Add(RWR_Simp)

local txt_CP = CreateElement "ceStringPoly"
txt_CP.name = "txt_CP"
txt_CP.material = RWR_FONT
txt_CP.init_pos = {-0.02, 0, 0}
txt_CP.init_rot = {0, 0, 0}
txt_CP.alignment = "CenterCenter"
txt_CP.stringdefs = strdefcenter
txt_CP.h_clip_relation = h_clip_relations.COMPARE
txt_CP.level            = RWR_DEFAULT_LEVEL
txt_CP.value = "+"
txt_CP.element_params = {"RWR_DISPLAY"}
txt_CP.controllers = {{"opacity_using_parameter", 0}}
txt_CP.parent_element = RWR_Simp.name
Add(txt_CP)

local function make_inner_ring(material, pct_inner_ring)
    local rwr_inner_ring = CreateElement "ceMeshPoly"
    rwr_inner_ring.name = create_guid_string()
    rwr_inner_ring.primitivetype = "triangles"
    set_circle(rwr_inner_ring, (pct_display_fill*pct_inner_ring) + 0.01, (pct_display_fill*pct_inner_ring) - 0.01, 360, 64)
    rwr_inner_ring.material = material
    rwr_inner_ring.parent_element = RWR_Simp.name
    rwr_inner_ring.element_params = {"RWR_DISPLAY"}
    rwr_inner_ring.controllers = {{"opacity_using_parameter", 0}}
    rwr_inner_ring.h_clip_relation = h_clip_relations.COMPARE
    rwr_inner_ring.level            = RWR_DEFAULT_LEVEL
    rwr_inner_ring.isdraw          = true
	rwr_inner_ring.collimated      = false
	rwr_inner_ring.isvisible	=true
    Add(rwr_inner_ring)
end

local function make_line(material,starPos,endPos,thickness,isMirror,rotation)
    local _rotation = 0
    if rotation ~=nil then
        _rotation =rotation
    end
    local rwr_line = CreateElement "ceMeshPoly"
    rwr_line.name = create_guid_string()
    rwr_line.primitivetype = "triangles"
    rwr_line.vertices = {{starPos,thickness},{starPos,-thickness},{endPos,-thickness},{endPos,thickness}}
    rwr_line.indices = {0,1,2,2,3,0}
    if isMirror then
        rwr_line.vertices = {{starPos,thickness},{starPos,-thickness},{endPos,-thickness},{endPos,thickness},{-starPos,thickness},{-starPos,-thickness},{-endPos,-thickness},{-endPos,thickness}}
        rwr_line.indices = {0,1,2,2,3,0,4,5,6,6,7,4}
    end
    rwr_line.init_rot = {_rotation,0}
    rwr_line.material = material
    rwr_line.parent_element = RWR_Simp.name
    rwr_line.element_params = {"RWR_DISPLAY"}
    rwr_line.controllers = {{"opacity_using_parameter", 0}}
    rwr_line.h_clip_relation = h_clip_relations.COMPARE
    rwr_line.level            = RWR_DEFAULT_LEVEL
    rwr_line.isdraw          = true
	rwr_line.collimated      = false
	rwr_line.isvisible	=true
    Add(rwr_line)
end

--make_inner_ring("DBG_BLACK", true)
make_inner_ring("DBG_GREEN", 0.2)
make_inner_ring("DBG_GREEN", 0.6)
make_line("DBG_GREEN",0.2,1,0.01,true)
make_line("DBG_GREEN",0.2,1,0.01,true,90)

-- CONTACT SYMBOLOGY
local txtsize = 0.005
local strdefsymbol = {txtsize, txtsize / 4, -txtsize / 20, 0}

for ia = 1, 20 do
    if ia < 10 then
        i = "_0" .. ia .. "_"
    else
        i = "_" .. ia .. "_"
    end

    local RWR_contact = CreateElement "ceTexPoly"
    RWR_contact.name = "RWR_contact" .. i .. "name"
    RWR_contact.primitivetype = "triangles"
    --RWR_contact.material = MakeMaterial(nil,{0,0,0,255})

    RWR_contact.controllers = {{"rotate_using_parameter", 0, 1},
                               {"parameter_in_range", 1, 0.1, 1.09},
                               {"move_up_down_using_parameter", 2, contact_scale},
                               }
    RWR_contact.element_params = {"RWR_CONTACT" .. i .. "AZIMUTH",
                                 "RWR_CONTACT" .. i .. "POWER_SYM",
                                  "RWR_CONTACT" .. i .. "SCAN_SYM"
                                }
    RWR_contact.parent_element =  RWR_Simp.name
    RWR_contact.h_clip_relation = h_clip_relations.COMPARE
    RWR_contact.level            = RWR_DEFAULT_LEVEL
    Add(RWR_contact)

    local RWR_type_Str = CreateElement "ceStringPoly"
    RWR_type_Str.name = "RWR_type" .. i .. "name"
    RWR_type_Str.material = RWR_FONT
    RWR_type_Str.stringdefs = strdefsymbol
    RWR_type_Str.alignment = "CenterCenter"
    RWR_type_Str.value = ""
    RWR_type_Str.formats = {"%s"}
    RWR_type_Str.UseBackground = false
    RWR_type_Str.element_params = {"RWR_CONTACT" .. i .. "UNIT_TYPE_SYM",
                                   "RWR_CONTACT" .. i .. "AZIMUTH",
                                   "RWR_CONTACT" .. i .. "UNIT_TYPE_IS_NUMERIC",
                                   "RWR_DISPLAY",
                                   "RWR_Overlay",
                                   "RWR_CONTACT" .. i .. "COLOR",
                                   }
    RWR_type_Str.controllers = {{"text_using_parameter", 0, 0},
                                {"rotate_using_parameter", 1, -1},
                                {"parameter_in_range", 2, 0.1, 0.8},
                                {"opacity_using_parameter", 3},
                                --{"parameter_in_range", 4, 0.9, 1.1},
                                YELLOW_CONTACT, RED_CONTACT,GREEN_CONTACT
                                }
    RWR_type_Str.parent_element = "RWR_contact" .. i .. "name"
    RWR_type_Str.h_clip_relation = h_clip_relations.COMPARE
    RWR_type_Str.level            = RWR_DEFAULT_LEVEL
    Add(RWR_type_Str)

    local RWR_type_Num = CreateElement "ceStringPoly"
    RWR_type_Num.name = "RWR_type" .. i .. "name_num"
    RWR_type_Num.material = RWR_FONT
    RWR_type_Num.stringdefs = strdefsymbol
    RWR_type_Num.alignment = "CenterCenter"
    RWR_type_Num.formats = {"%.f"}
    RWR_type_Num.UseBackground = false
    RWR_type_Num.element_params = {"RWR_CONTACT" .. i .. "UNIT_TYPE_SYM_NUMERIC",
                                   "RWR_CONTACT" .. i .. "AZIMUTH",
                                   "RWR_CONTACT" .. i .. "UNIT_TYPE_IS_NUMERIC",
                                   "RWR_DISPLAY",
                                    "RWR_Overlay",
                                    "RWR_CONTACT" .. i .. "COLOR",
                                   }
    RWR_type_Num.controllers = {{"text_using_parameter", 0, 0},
                                {"rotate_using_parameter", 1, -1},
                                {"parameter_in_range", 2, 0.8, 1.09},
                                {"opacity_using_parameter", 3},
                                --{"parameter_in_range", 4, 0.9, 1.1},
                                YELLOW_CONTACT, RED_CONTACT,GREEN_CONTACT
                                }
    RWR_type_Num.parent_element = "RWR_contact" .. i .. "name"
    RWR_type_Num.h_clip_relation = h_clip_relations.COMPARE
    RWR_type_Num.level            = RWR_DEFAULT_LEVEL
    Add(RWR_type_Num)
end
