dofile(LockOn_Options.script_path .. "Rod/Indicator/definitions.lua")

controll_base          = CreateElement "ceSimple"
controll_base.name     = "controll_base"
controll_base.init_pos = { 0, 0, 0 }
Add(controll_base)

---------------------------------------------------
local controll_view         = CreateElement "ceMeshPoly"
controll_view.name          = "controll_view"
controll_view.primitivetype = "triangles"

controll_view.vertices = {{1,1},{1,-1},{-1,-1},{-1,1}}
controll_view.indices  = {0,1,2,2,3,0}

controll_view.material        = MakeMaterial(nil, { 128, 0, 0, 32 })
controll_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
controll_view.level           = ROD_DEFAULT_NOCLIP_LEVEL
controll_view.controllers     = {
    { "parameter_in_range", 0,0.9,1.1},
}
controll_view.element_params  = { "ROD_DISPLAY", }
controll_view.isdraw          = true
controll_view.collimated      = false
controll_view.isvisible       = false --false
controll_view.parent_element  = "controll_base"
Add(controll_view)
---------------------------------
local controll_backPanel         = CreateElement "ceMeshPoly"
controll_backPanel.name          = "controll_backPanel"
controll_backPanel.primitivetype = "triangles"

controll_backPanel.vertices = {{1,1},{1,-1},{-1,-1},{-1,1}}
controll_backPanel.indices  = {0,1,2,2,3,0}

controll_backPanel.material        = MakeMaterial(nil, { 128, 0, 0, 32 })
controll_backPanel.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
controll_backPanel.level           = ROD_DEFAULT_NOCLIP_LEVEL
controll_backPanel.controllers     = {
    { "parameter_in_range", 0,0.9,1.1},
}
controll_backPanel.element_params  = { "ROD_DISPLAY", }
controll_backPanel.isdraw          = true
controll_backPanel.collimated      = false
controll_backPanel.isvisible       = true --false
controll_backPanel.parent_element  = "controll_base"
Add(controll_backPanel)