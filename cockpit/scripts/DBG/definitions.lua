dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

DBG_DEFAULT_LEVEL = 4
DBG_DEFAULT_NOCLIP_LEVEL  = DBG_DEFAULT_LEVEL - 1
DBG_SCALE = 10--1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= DBG_DEFAULT_LEVEL
    Add(object)
end

----------------------------------------------------------------------------------------