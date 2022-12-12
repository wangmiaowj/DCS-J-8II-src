--/N/ 08. Aug 2014. rev may 2020
--/M/ 02. Dec 2015.

local self_ID = "J-8B by shenHaiSanXi"

declare_plugin(self_ID,
{
dirName	 	 = current_mod_path,
displayName		= _("J-8B"),
shortName		= "J-8B",
fileMenuName	= _("J-8B"),
version		 = "2.7.2",--__DCS_VERSION__,
state		 = "installed",
info		 = _("J-8B Info"),
developerName	= _("shenHaiSanXi"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
--binaries     = { 'J-8B_FM' },
Skins =
{
	{
		name	= "J-8B",
		dir		= "Skins/1"
	},
},
Missions =
{
	{
		name	= _("J-8B"),
		dir		= "Missions",
		CLSID	= "{J-8B missions}",
	},
},
LogBook =
{
	{
		name	= _("J-8B"),
		type	= "J-8B",
	},
},
Options =
{
	{
		name		= _("J-8B"),
		nameId		= "J-8B",
		dir			= "Options",
		CLSID		= "{J-8B options}"
	},
},
InputProfiles = 
{
	["J-8B"]		= current_mod_path .. '/Input/J-8B/',
},
})

mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path(current_mod_path.."/Textures")

---------------------------------------------------------
dofile(current_mod_path.."/weapon.lua")
dofile(current_mod_path.."/J-8B.lua")
dofile(current_mod_path.."/Views.lua") --View Settings.

local cfg_path = current_mod_path .. '/FM/config.lua'
dofile(cfg_path)

J8B_FM[1]           = self_ID
J8B_FM[2]           = 'J-8B_FM'
J8B_FM.config_path  = cfg_path
--J8B_FM.user_options = ac_name

make_flyable('J-8B', current_mod_path..'/Cockpit/Scripts/', nil, current_mod_path..'/comm.lua') 
make_view_settings('J-8B', ViewSettings, SnapViews) 
---------------------------------------------------------

plugin_done()