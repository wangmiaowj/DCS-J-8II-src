
--dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

-------MATERIALS-------
materials = {}
materials["DBG_GREY"]    = {2, 2, 2, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 255}
materials["DBG_YELLOW"]   = {255, 255, 0, 255}
materials["DBG_BLUE"]   = {0, 0, 100, 100}
materials["DBG_GREEN"]   = {0, 80, 0, 100}
materials["DBG_RED"]     = {255, 0, 0, 255}
materials["DBG_CLEAR"]   = {0, 0, 0, 0}
materials["BLOB_COLOR"] = {0,128,0,192}
materials["TEST_MATERIAL"] 	= {17,80,7,20}
materials["RADAR_GRID"] = {0,100,0,192}
materials["RADAR_SCRIBE"] = {0,200,0,192}
materials["GUNSIGHT_GLASS"] = {0,120,0,128}
materials["TEST_COLOR"] = {50,250,0,255}
materials["HUD_DAY_COLOR"]          = {0,200,0,200}
materials["EALT_BG_COLOR"]	= {0,50,255,255}
materials["EALT_BG_DARK_COLOR"]	= {0,30,120,255}

-- EADI
materials["SKY_BLUE"] = {0,170,230,255}
materials["GROUND_YELLOW"] = {42,34,29,255}

-- MENU
materials["MENU_GREY"]    = {30, 30, 30, 150}
materials["DBG_WHITE"] = {200,200,200,255}


local IndicationFontPath = LockOn_Options.script_path.."../Textures/Fonts/"

-------TEXTURES-------
textures = {}

-------------------------------------------------------
-------FONTS-------
fontdescription = {}

Font_size_mult = 2
Font_xsize = 29 * Font_size_mult
Font_ysize = 64 * Font_size_mult


fontdescription["font_HUD"] = {
	texture		= IndicationFontPath.."font_HUD.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {Font_xsize, Font_ysize},
	chars		= {
		[1]   = {64,  Font_xsize, Font_ysize}, -- @ == ©
		[2]   = {18,  Font_xsize, Font_ysize}, -- ^ == \18
		[3]   = {20,  Font_xsize, Font_ysize}, -- ¶ == [] == \20
		[4]   = {26,  Font_xsize, Font_ysize}, -- > == -> == \26
		[5]   = {27,  Font_xsize, Font_ysize}, -- < == <- == \27
		[6]   = {31,  Font_xsize, Font_ysize}, -- SPARE 
		[7]   = {126, Font_xsize, Font_ysize}, -- ~
		[8]   = {32,  Font_xsize, Font_ysize}, -- [space]
		[9]   = {33,  Font_xsize, Font_ysize}, -- !
		[10]  = {35,  Font_xsize, Font_ysize}, -- #
		[11]  = {40,  Font_xsize, Font_ysize}, -- (
		[12]  = {41,  Font_xsize, Font_ysize}, -- )
		[13]  = {42,  Font_xsize, Font_ysize}, -- *
		[14]  = {43,  Font_xsize, Font_ysize}, -- +
		[15]  = {45,  Font_xsize, Font_ysize}, -- -
		[16]  = {46,  Font_xsize, Font_ysize}, -- .
		[17]  = {47,  Font_xsize, Font_ysize}, -- /
		[18]  = {48,  Font_xsize, Font_ysize}, -- 0
		[19]  = {49,  Font_xsize, Font_ysize}, -- 1
		[20]  = {50,  Font_xsize, Font_ysize}, -- 2
		[21]  = {51,  Font_xsize, Font_ysize}, -- 3
		[22]  = {52,  Font_xsize, Font_ysize}, -- 4
		[23]  = {53,  Font_xsize, Font_ysize}, -- 5
		[24]  = {54,  Font_xsize, Font_ysize}, -- 6
		[25]  = {55,  Font_xsize, Font_ysize}, -- 7
		[26]  = {56,  Font_xsize, Font_ysize}, -- 8
		[27]  = {57,  Font_xsize, Font_ysize}, -- 9
		[28]  = {58,  Font_xsize, Font_ysize}, -- :
		[29]  = {61,  Font_xsize, Font_ysize}, -- =
		[30]  = {63,  Font_xsize, Font_ysize}, -- ?
		[31]  = {65,  Font_xsize, Font_ysize}, -- A
		[32]  = {66,  Font_xsize, Font_ysize}, -- B
		[33]  = {67,  Font_xsize, Font_ysize}, -- C
		[34]  = {68,  Font_xsize, Font_ysize}, -- D
		[35]  = {69,  Font_xsize, Font_ysize}, -- E
		[36]  = {70,  Font_xsize, Font_ysize}, -- F
		[37]  = {71,  Font_xsize, Font_ysize}, -- G
		[38]  = {72,  Font_xsize, Font_ysize}, -- H
		[39]  = {73,  Font_xsize, Font_ysize}, -- I
		[40]  = {74,  Font_xsize, Font_ysize}, -- J
		[41]  = {75,  Font_xsize, Font_ysize}, -- K
		[42]  = {76,  Font_xsize, Font_ysize}, -- L
		[43]  = {77,  Font_xsize, Font_ysize}, -- M
		[44]  = {78,  Font_xsize, Font_ysize}, -- N
		[45]  = {79,  Font_xsize, Font_ysize}, -- O
		[46]  = {80,  Font_xsize, Font_ysize}, -- P
		[47]  = {81,  Font_xsize, Font_ysize}, -- Q
		[48]  = {82,  Font_xsize, Font_ysize}, -- R
		[49]  = {83,  Font_xsize, Font_ysize}, -- S
		[50]  = {84,  Font_xsize, Font_ysize}, -- T
		[51]  = {85,  Font_xsize, Font_ysize}, -- U
		[52]  = {86,  Font_xsize, Font_ysize}, -- V
		[53]  = {87,  Font_xsize, Font_ysize}, -- W
		[54]  = {88,  Font_xsize, Font_ysize}, -- X
		[55]  = {89,  Font_xsize, Font_ysize}, -- Y
		[56]  = {90,  Font_xsize, Font_ysize}, -- Z
		[57]  = {91,  Font_xsize, Font_ysize}, -- [
		[58]  = {93,  Font_xsize, Font_ysize}, -- ] 
		[59]  = {124, Font_xsize, Font_ysize}, -- | == ¦
		[60]  = {38,  Font_xsize, Font_ysize}, -- & == +- 
		[61]  = {59,  Font_xsize, Font_ysize}, -- ; == ° 
		[62]  = {95,  Font_xsize, Font_ysize}, -- _
		[63]  = {37,  Font_xsize, Font_ysize},-- %
		[64]  = {24,  Font_xsize, Font_ysize},-- alpha α
	}
}

dofile(LockOn_Options.script_path.."fontUnicode.lua")
fontdescription["font_UTF"] = font_unicode(IndicationFontPath.."Font_UTF.dds")


    fonts = {}
    fonts["font_kneeboard"]			= {fontdescription_cmn["font_general_loc"], 10, {0,0,0,255}}
    fonts["font_kneeboard_hint"]	= {fontdescription_cmn["font_general_loc"], 10, {255,0,0,255}}
	fonts["hud_font_base"]			= {fontdescription["font_HUD"], 10, materials["HUD_DAY_COLOR"] }
	fonts["BS430_font_green"]		= {fontdescription["font_Pixel"], 10, {4,239,113,255} }
	-- this is the chinese unicode font
	fonts["unicode_cn"]				= {fontdescription["font_UTF"], 10, materials["TEST_COLOR"] }
	fonts["unicode_cn_white"]		= {fontdescription["font_UTF"], 10, materials.DBG_WHITE }
	fonts["unicode_cn_red"]		= {fontdescription["font_UTF"], 10, materials.DBG_RED }
	fonts["unicode_cn_green"]		= {fontdescription["font_UTF"], 10, materials.DBG_GREEN }
	fonts["unicode_cn_yellow"]		= {fontdescription["font_UTF"], 10, materials.DBG_YELLOW }
	fonts["unicode_cn_hud"]		= {fontdescription["font_UTF"], 10, materials.HUD_DAY_COLOR }
-- force preload resources to avoid freeze on start (list of texture files)
--[[
preload_texture =
{
}
--]]