--/N/ 08. Aug 2014. rev may 2020
--/M/ 02. Dec 2015.

local self_ID = "J-8B by shenHaiSanXi"

declare_plugin(self_ID,
{
dirName	 	 = current_mod_path,
displayName		= _("J-8II"),
shortName		= "J-8II",
fileMenuName	= _("J-8II"),
version		 = __DCS_VERSION__,
state		 = "installed",
info		 = _("J-8II Info"),
developerName	= _("shenHaiSanXi"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
--binaries     = {'avSimplest','CustomFM'},
Skins =
{
	{
		name	= "J-8II",
		dir		= "Theme"
	},
},
Missions =
{
	{
		name	= _("J-8II"),
		dir		= "Missions",
		CLSID	= "{J-8II missions}",
	},
},
LogBook =
{
	{
		name	= _("J-8II"),
		type	= "J-8II",
	},
},
Options =
{
	{
		name		= _("J-8II"),
		nameId		= "J-8II",
		dir			= "Options",
		CLSID		= "{J-8II options}"
	},
},
InputProfiles = 
{
	["J-8II"]		= current_mod_path .. '/Input/J-8II/',
},
})

mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path(current_mod_path.."/Textures")

---------------------------------------------------------
dofile(current_mod_path.."/weapon.lua")
dofile(current_mod_path.."/J-8II.lua")
dofile(current_mod_path.."/Views.lua") --View Settings.

local cfg_path = current_mod_path .. '/FM/config.lua'
dofile(cfg_path)

J8II_FM[1]           = self_ID
J8II_FM[2]           = 'CustomFM'
J8II_FM.config_path  = cfg_path
--J-8II_FM.user_options = ac_name

make_flyable('J-8II', current_mod_path..'/Cockpit/Scripts/', nil, current_mod_path..'/comm.lua') 
make_view_settings('J-8II', ViewSettings, SnapViews) 
---------------------------------------------------------

plugin_done()