
dofile(LockOn_Options.script_path .. "Displays/avRwr/indicator/definitions.lua")

IndicatorName = "RWR_DISPLAY"

local contact_scale = 0.030
local pct_display_fill = 0.90

local txtsize_center = 0.005*0.85
local strdefcenter = {txtsize_center, txtsize_center / 4, -txtsize_center / 8, 0}

local RWR_Simp = AddSimple()

AddText(nil,'+',RWR_FONT,{-0.02, 0},nil,strdefcenter,nil,nil,RWR_Simp)

local function make_line(material,starPos,endPos,thickness,isMirror,rotation)
    local vertices = {{starPos,thickness},{starPos,-thickness},{endPos,-thickness},{endPos,thickness}}
    local indices = {0,1,2,2,3,0}
    if isMirror then
        vertices = {{starPos,thickness},{starPos,-thickness},{endPos,-thickness},{endPos,thickness},{-starPos,thickness},{-starPos,-thickness},{-endPos,-thickness},{-endPos,thickness}}
        indices = {0,1,2,2,3,0,4,5,6,6,7,4}
    end
    AddMeshPoly(nil,vertices,indices,nil,rotation,material,nil,nil,RWR_Simp)
end

AddCircle(nil,(pct_display_fill*0.2) + 0.01, (pct_display_fill*0.2) - 0.01, 360, 72,nil,nil,'DBG_GREEN',nil,nil,RWR_Simp)
AddCircle(nil,(pct_display_fill*0.6) + 0.01, (pct_display_fill*0.6) - 0.01, 360, 72,nil,nil,'DBG_GREEN',nil,nil,RWR_Simp)
make_line("DBG_GREEN",0.2,1,0.01,true)
make_line("DBG_GREEN",0.2,1,0.01,true,{90,0})

-- CONTACT SYMBOLOGY
local txtsize = 0.005
local strdefsymbol = {txtsize, txtsize / 4, -txtsize / 20, 0}

for ia = 1, 20 do
    local rwr_contact = AddSimple(nil, nil, RWR_Simp,
        {
            string.format("RWR_CONTACT_%02.0f_AZIMUTH",ia),
            string.format("RWR_CONTACT_%02.0f_POWER_SYM",ia),
            string.format("RWR_CONTACT_%02.0f_SCAN_SYM",ia),
        },
        {
            { "rotate_using_parameter",       0, 1 },
            { "parameter_in_range",           1, 0.1,          1.09 },
            { "move_up_down_using_parameter", 2, contact_scale },
        })
    AddText(nil, nil, RWR_FONT, nil, nil, strdefsymbol, nil, nil, rwr_contact, { '%s' },
        {
            string.format("RWR_CONTACT_%02.0f_UNIT_TYPE_SYM",ia),
            string.format("RWR_CONTACT_%02.0f_AZIMUTH",ia),
            string.format("RWR_CONTACT_%02.0f_UNIT_TYPE_IS_NUMERIC",ia),
            "RWR_PLACEHODER",
            "RWR_PLACEHODER",
            string.format("RWR_CONTACT_%02.0f_COLOR",ia),
        }, {
            { "text_using_parameter", 0, 0 },
            { "rotate_using_parameter",  1, -1 },
            { "parameter_in_range",      2, 0.1, 0.8 },
            --{"parameter_in_range", 4, 0.9, 1.1},
            YELLOW_CONTACT, RED_CONTACT, GREEN_CONTACT
        })
    AddText(nil, nil, RWR_FONT, nil, nil, strdefsymbol, nil, nil, rwr_contact, { '%.f' },
        {
            string.format("RWR_CONTACT_%02.0f_UNIT_TYPE_SYM",ia),
            string.format("RWR_CONTACT_%02.0f_AZIMUTH",ia),
            string.format("RWR_CONTACT_%02.0f_UNIT_TYPE_IS_NUMERIC",ia),
            "RWR_PLACEHODER",
            "RWR_PLACEHODER",
            string.format("RWR_CONTACT_%02.0f_COLOR",ia),
        },
        {
            { "text_using_parameter",  0, 0 },
            { "rotate_using_parameter",  1, -1 },
            { "parameter_in_range",      2, 0.8, 1.09 },
            --{"parameter_in_range", 4, 0.9, 1.1},
            YELLOW_CONTACT, RED_CONTACT, GREEN_CONTACT
        })
end
