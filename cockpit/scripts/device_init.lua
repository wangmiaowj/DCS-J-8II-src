dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua") -- 加载材质

-- set panel
-- 初始化舱内仪表台
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

creators = {}

-- 基础的电力模块
creators[devices.ELECTRIC_SYSTEM] ={"avSimpleElectricSystem",LockOn_Options.script_path.."Systems/electric_system.lua"}
-- 控制面模块
creators[devices.PRISURFACE]      ={"avLuaDevice"           ,LockOn_Options.script_path.."priControlSurface.lua"}
-- 舱盖，最简单的单监听模块
creators[devices.CPY]          ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/canopy.lua"}
-- 刹车包含空气刹车, 主要是看调用刹车系统（dispatch action
creators[devices.BREAK_SYSTEM]    ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/break_system.lua"}
--引擎
creators[devices.ENGINE]    ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/engine.lua"}
-- 武器模块
creators[devices.WEAPON_SYSTEM]	  ={"avSimpleWeaponSystem"  ,LockOn_Options.script_path.."Systems/weapon_system.lua"}
-- 这两个是为了调用地勤
creators[devices.INTERCOM]        ={"avIntercom"            ,LockOn_Options.script_path.."Intercom.lua", {devices.UHF_RADIO} }
creators[devices.UHF_RADIO]       ={"avUHF_ARC_164"         ,LockOn_Options.script_path.."uhf_radio.lua", {devices.INTERCOM, devices.ELECTRIC_SYSTEM} }
-- 雷达模块
creators[devices.RADAR_RAW]		  ={"avSimpleRadar"			,LockOn_Options.script_path.."avRadar/Device/Radar_init.lua"}
-- RWR
creators[devices.RWR]		  ={"avSimpleRWR"			,LockOn_Options.script_path.."avRwr/Device/Rwr_init.lua"}
-- hud Display processor
creators[devices.HUD_DCMS]        ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/dcms_hud.lua"}
-- Basic instrument, including an array that I encapsulated to process instrument animation and update function can simplify basic flight instrument drawing
creators[devices.BASIC_FLIGHT_INS]={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/basic_flight_instru.lua"}
-- 时钟系统，包含读取系统时间（游戏内任务时间
creators[devices.CLOCK]           ={"avLuaDevice"           ,LockOn_Options.script_path.."aviation_clock.lua"}
--
creators[devices.GEAR_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/gear_system.lua"}

creators[devices.LIGHT_SYSTEM]    ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/light_system.lua"}
-- this is 14, dont move this position for now XD, the command from EFM is constant send to lua device 14 
creators[devices.SOUND_SYSTEM]    ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/sound_system.lua"} 
-- warning panel controller 
creators[devices.WARNING_SYSTEM]  ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/warning_system.lua"} 
-- ipad controller
--creators[devices.IPAD_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/ipad_ctrl.lua"} 
-- menu controller
--creators[devices.MENU_SYSTEM]     ={"avLuaDevice"           ,LockOn_Options.script_path.."Systems/menu_ctrl_system.lua"}

-- 定义显示器
indicators = {}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HUD/Indicator/hud_init.lua",nil,{{"HUD_C","HUD_D","HUD_R"}}}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."avRadar/Indicator/init.lua",nil,{{"RDR_C","RDR_D","RDR_R"}}}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."avRwr/Indicator/init.lua",nil,{{"RWR_C","RWR_D","RWR_R"}}}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."UHF/Radio_init.lua",nil,{{"UHF_C","UHF_D","UHF_R"}}}
show_param_handles_list()
-- Enable KneeBoard for Test
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")
---------------------------------------------
