dofile(LockOn_Options.script_path .. "Helmet/Indicator/definitions.lua")

base_sim          = CreateElement "ceSimple"
base_sim.name     = create_guid_string()
base_sim.init_pos = { 0, 0, 0 }
Add(base_sim)

---------------------------------------------------
local fk_tip_view         = CreateElement "ceMeshPoly"
fk_tip_view.name          = "fk_tip_view"
fk_tip_view.primitivetype = "triangles"

fk_tip_view.vertices = {{1*FK_SCALE,1*FK_SCALE},{1*FK_SCALE,-1*FK_SCALE},{-1*FK_SCALE,-1*FK_SCALE},{-1*FK_SCALE,1*FK_SCALE}}
fk_tip_view.indices  = {0,1,2,2,3,0}

fk_tip_view.material        = MakeMaterial(nil, { 128, 0, 0, 32 })
fk_tip_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
fk_tip_view.level           = FK_DEFAULT_NOCLIP_LEVEL
fk_tip_view.isdraw          = true
fk_tip_view.collimated      = false
fk_tip_view.isvisible       = false --false
fk_tip_view.parent_element  = base_sim.name
Add(fk_tip_view)
---------------------------------
local fk_tip_backPanel         = CreateElement "ceMeshPoly"
fk_tip_backPanel.name          = "fk_tip_backPanel"
fk_tip_backPanel.primitivetype = "triangles"

fk_tip_backPanel.vertices = {{1*FK_SCALE,1*FK_SCALE},{1*FK_SCALE,-1*FK_SCALE},{-1*FK_SCALE,-1*FK_SCALE},{-1*FK_SCALE,1*FK_SCALE}}
fk_tip_backPanel.indices  = {0,1,2,2,3,0}

fk_tip_backPanel.material        = MakeMaterial(nil, { 128, 0, 0, 32 })
fk_tip_backPanel.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
fk_tip_backPanel.level           = FK_DEFAULT_NOCLIP_LEVEL
fk_tip_backPanel.isdraw          = true
fk_tip_backPanel.collimated      = false
fk_tip_backPanel.isvisible       = false --false
fk_tip_backPanel.parent_element  = base_sim.name
Add(fk_tip_backPanel)