dofile(LockOn_Options.script_path .. "Displays/HUD/Indicator/hud_def.lua")

IS_HUD = true
IndicatorName = 'HUD_DIS_ENABLE'
local base_simple = AddSimple()
--AddBox(nil,nil,nil,nil,nil,MakeMaterial(nil,{0,0,0,255}),DEFAULT_LEVEL,COMPARE,base_simple)

local mask_level = DEFAULT_LEVEL+2

--速度
local spd_simple = AddSimple({-0.8*Width,0},nil,base_simple)
local w = 0.15*Width
local h = 0.7*Height

AddBox(nil,w,h,nil,nil,'DBG_RED',mask_level,REWRITE_LEVEL,spd_simple,nil,nil,true)
local spd_mv_simple = AddSimple(nil,nil,spd_simple,{'SPD_VAL'},{{'move_up_down_using_parameter',0,-0.00098}})
for i = 0, 300, 1 do
    local txt_ = (math.fmod(i,5) == 0 and i > 0)
    if txt_ then
        local line = AddSimpleLine(nil,0.008*Width,{{0,0},{-0.8*w,0}},{w,0.14*i*h},nil,'DBG_GREEN',nil,mask_level,spd_mv_simple)
        AddText(nil,tostring(i),'hud_font_base',{-0.8*w,0},'RightCenter',DEFAULT_FONT_SIZE[1],nil,mask_level,line)
    else
        AddSimpleLine(nil,0.004*Width,{{0,0},{-0.4*w,0}},{w,0.15*i*h},nil,'DBG_GREEN',nil,mask_level,spd_mv_simple)
    end
end
local spd_box = AddBoxBorder(nil,0.7*w,0.05*h,0.005*Width,{-0.3*w,0},nil,'DBG_GREEN',mask_level,nil,spd_simple)
--速度显示
AddText(nil,nil,'hud_font_base',{0.95*0.7*w,0},'RightCenter',DEFAULT_FONT_SIZE[1],nil,mask_level,spd_box,{'%.0f'},{'SPD_VAL'},{{'text_using_parameter',0}})

--高度
local alt_simple = AddSimple({0.8*Width,0},nil,base_simple)
AddBox(nil,0.15*Width,0.7*Height,nil,nil,'DBG_RED',mask_level,REWRITE_LEVEL,alt_simple,nil,nil,true)
local alt_mv_simple = AddSimple(nil,nil,alt_simple,{'BALT_VAL'},{{'move_up_down_using_parameter',0,-0.000098}})
for i = 0, 300, 1 do
    local txt_ = (math.fmod(i,5) == 0 and i > 0)
    if txt_ then
        local line = AddSimpleLine(nil,0.008*Width,{{0,0},{0.8*w,0}},{-w,0.14*i*h},nil,'DBG_GREEN',nil,mask_level,alt_mv_simple)
        AddText(nil,tostring(i),'hud_font_base',{0.8*w,0},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,mask_level,line)
    else
        AddSimpleLine(nil,0.004*Width,{{0,0},{0.4*w,0}},{-w,0.15*i*h},nil,'DBG_GREEN',nil,mask_level,alt_mv_simple)
    end
end
local alt_box = AddBoxBorder(nil,0.7*w,0.05*h,0.005*Width,{0.3*w,0},nil,'DBG_GREEN',mask_level,nil,alt_simple)
--高度显示
AddText(nil,nil,'hud_font_base',{-0.95*0.7*w,0},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,mask_level,alt_box,{'%.0f'},{'HUD_ALT_DIS'},{{'text_using_parameter',0}})

--航向
local hdg_simple = AddSimple({0,0.85*Height},nil,base_simple)
w=0.65*Width
h=0.1*Height
AddBox(nil,w,h,nil,nil,'DBG_RED',mask_level,REWRITE_LEVEL,hdg_simple,nil,nil,true)
local hdg_mv_simple = AddSimple(nil,nil,hdg_simple,{'HDG_DEG'},{{'move_left_right_using_parameter',0,-0.00325}})
for i = -6, 71, 1 do
    local value = nil
    local line_thickness = 0.008
    local line_length = h
    if i == 0 then
        value = 'N'
    elseif i == 18 then
        value = 'E'
    elseif i == 36 then
        value = 'S'
    elseif i == 54 then
        value = 'W'
    elseif math.fmod(i,2)==0 then
        if i<0 then
            value = tostring(36-math.abs(i/2))
        else
            value = tostring(math.abs(i/2))
        end
    else
        line_thickness = 0.004
        line_length = 0.5*h
    end
    local line = AddSimpleLine(nil,line_thickness,{{0,0},{0,line_length}},{0.25*i*w,-h},nil,'DBG_GREEN',nil,mask_level,hdg_mv_simple)
    if value then
        AddText(nil,value,'hud_font_base',{0,h},'CenterBottom',DEFAULT_FONT_SIZE[1],nil,mask_level,line)
    end
end

AddMeshPoly(nil,{{0,0},{-0.1*w,-0.3*h},{0.1*w,-0.3*h}},{0,1,2},{0,-h},nil,'DBG_GREEN',nil,nil,hdg_simple)
local hdg_box = AddBoxBorder(nil,0.1*w,0.4*h,0.005*Width,{0,-1.7*h},nil,'DBG_GREEN',nil,nil,hdg_simple)
AddText(nil,nil,'hud_font_base',nil,nil,DEFAULT_FONT_SIZE[1],nil,nil,hdg_box,{'%.0f'},{'HDG_DEG'},{{'text_using_parameter',0}})

--左上角
--过载
AddText(nil,nil,'hud_font_base',{-0.9*Width,0.85*Height},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,nil,base_simple,{'G:%.1f'},{'HUD_G_DIS'},{{'text_using_parameter',0}})
--攻角
AddText(nil,nil,'hud_font_base',{-0.9*Width,0.75*Height},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,nil,base_simple,{'\24:%.1f','%s'},{'HUD_AOA_DIS'},{{'text_using_parameter',0}})

--左下角
--马赫
AddText(nil,nil,'hud_font_base',{-0.8*Width,-0.75*Height},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,nil,base_simple,{'M:%.1f'},{'HUD_MACH_DIS'},{{'text_using_parameter',0}})
--左发转数
AddText(nil,nil,'hud_font_base',{-0.8*Width,-0.8*Height},'LeftCenter',DEFAULT_FONT_SIZE[3],nil,nil,base_simple,{'L RPM:%.0f'},{'HUD_LN2_DIS'},{{'text_using_parameter',0}})
--右发转数
AddText(nil,nil,'hud_font_base',{-0.8*Width,-0.85*Height},'LeftCenter',DEFAULT_FONT_SIZE[3],nil,nil,base_simple,{'R RPM:%.0f'},{'HUD_RN2_DIS'},{{'text_using_parameter',0}})
--全程最大过载显示
AddText(nil,nil,'hud_font_base',{-0.8*Width,-0.9*Height},'LeftCenter',DEFAULT_FONT_SIZE[3],nil,nil,base_simple,{'GM:%.0f'},{'HUD_GM_DIS'},{{'text_using_parameter',0}})

--右下角
--右下航点显示第一行
AddText(nil,nil,'hud_font_base',{0.65*Width,-0.75*Height},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,nil,base_simple,
    {'%s'},
    {
        "HUD_NAV_DATA_1_DIS",
        "HUD_DETAIL_DATA_DIS"
    },{
        {"text_using_parameter",0},
        {"parameter_in_range",1,0.5,1.1}
    }
)
--右下航点显示第二行
AddText(nil,nil,'hud_font_base',{0.65*Width,-0.81*Height},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,nil,base_simple,
    {'%s'},
    {
        "HUD_NAV_DATA_2_DIS",
        "HUD_DETAIL_DATA_DIS"
    },{
        {"text_using_parameter",0},
        {"parameter_in_range",1,0.5,1.1}
    }
)
--右下航点显示第三行
AddText(nil,nil,'hud_font_base',{0.65*Width,-0.87*Height},'LeftCenter',DEFAULT_FONT_SIZE[1],nil,nil,base_simple,
    {'MODE:%s'},
    {
        "HUD_NAV_DATA_3_DIS",
        "HUD_DETAIL_DATA_DIS"
    },{
        {"text_using_parameter",0},
        {"parameter_in_range",1,0.5,1.1}
    }
)

--姿态
AddSimpleLine(nil,0.004*Width,{{-0.1*Width,0},{0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,base_simple)
local adi_rot_simple = AddSimple(nil,nil,base_simple,{'HUD_ADI_ROLL'},{{'rotate_using_parameter',0,-math.rad(1)}})
local adi_mov_simple = AddSimple(nil,nil,adi_rot_simple,{'HUD_ADI_PITCH'},{{'move_up_down_using_parameter',0,-0.014}})
local simple = AddSimple(nil,nil,adi_mov_simple)
--左半
IndicatorName = 'ADI_LINE_GROUP'
AddSimpleLine(nil,0.004*Width,{{-0.55*Width,0},{-0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,simple)
--右半
AddSimpleLine(nil,0.004*Width,{{0.55*Width,0},{0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,simple)
AddText(nil,'0','hud_font_base',{-0.6*Width,0},nil,DEFAULT_FONT_SIZE[1],nil,nil,simple)
AddText(nil,'0','hud_font_base',{0.6*Width,0},nil,DEFAULT_FONT_SIZE[1],nil,nil,simple)
for i = 1, 18, 1 do
    --上半部分
    simple = AddSimple({0,0.7*i*Height},nil,adi_mov_simple)
    --左半
    AddSimpleLine(nil,0.004*Width,{{-0.3*Width,0.05*Height},{-0.3*Width,0},{-0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,simple)
    --右半
    AddSimpleLine(nil,0.004*Width,{{0.3*Width,0.05*Height},{0.3*Width,0},{0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,simple)
    AddText(nil,tostring(i*5),'hud_font_base',{-0.35*Width,0},nil,DEFAULT_FONT_SIZE[1],nil,nil,simple)
    AddText(nil,tostring(i*5),'hud_font_base',{0.35*Width,0},nil,DEFAULT_FONT_SIZE[1],nil,nil,simple)

    --下半部分
    simple = AddSimple({0,-0.7*i*Height},nil,adi_mov_simple)
    --左半
    AddSimpleLine(nil,0.004*Width,{{-0.3*Width,-0.05*Height},{-0.3*Width,0},{-0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,simple)
    --右半
    AddSimpleLine(nil,0.004*Width,{{0.3*Width,-0.05*Height},{0.3*Width,0},{0.1*Width,0}},nil,nil,'DBG_GREEN',nil,nil,simple)
    AddText(nil,tostring(i*5),'hud_font_base',{-0.35*Width,0},nil,DEFAULT_FONT_SIZE[1],nil,nil,simple)
    AddText(nil,tostring(i*5),'hud_font_base',{0.35*Width,0},nil,DEFAULT_FONT_SIZE[1],nil,nil,simple)
end
--矢量符
local fd_simple = AddSimple(nil,nil,base_simple,
    {"HUD_FD_X","HUD_FD_Y"},
    {{"move_left_right_using_parameter",0,1},{"move_up_down_using_parameter",1,1},}
)
AddCircle(nil,0.04*Width,0.035*Width,360,36,nil,nil,'DBG_GREEN',nil,nil,fd_simple)
AddSimpleLine(nil,0.004*Width,{{0.04*Width,0},{0.08*Width,0}},nil,nil,'DBG_GREEN',nil,nil,fd_simple)
AddSimpleLine(nil,0.004*Width,{{-0.04*Width,0},{-0.08*Width,0}},nil,nil,'DBG_GREEN',nil,nil,fd_simple)
AddSimpleLine(nil,0.004*Width,{{0,0.04*Height},{0,0.08*Height}},nil,nil,'DBG_GREEN',nil,nil,fd_simple)

IndicatorName = 'HUD_DIS_ENABLE'
--警告相关
--注意文字提示
--AddText(nil,'注意','hud_font_base',{0,-0.2*Height},nil,DEFAULT_FONT_SIZE[1],nil,nil,base_simple,nil,{'WARNING_FLASH'},{{'parameter_in_range',0,0,0.9}})
--危险文字提示
--AddText(nil,'危险','hud_font_base',{0,-0.2*Height},nil,DEFAULT_FONT_SIZE[1],nil,nil,base_simple,nil,{'DANGER_FLASH'},{{'parameter_in_range',0,0,0.9}})

AddCrossHair(nil,0.5*Width,0.5*Width,0.006*Width,nil,{45,0},'DBG_GREEN',nil,nil,base_simple,{'PULLUP_FLASH'},{{'parameter_in_range',0,0,1.1}})

--武器相关
--STT
local x_scale = 1.35
local y_scale = 1.43
local stt_box=AddBoxBorder(nil,0.05*Width,0.05*Width,0.004*Width,nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "TARGET_BOX_DIS_ENABLE",
        "TARGET_BOX_Y",
        "TARGET_BOX_X"
    },{
        {"parameter_in_range",0,0.9,1.1},
        {"move_up_down_using_parameter",1,y_scale},
        {"move_left_right_using_parameter",2,x_scale}
    }
)
--STT连线
AddSimpleLine(nil,0.004*Width,{{0,0},{1,0}},nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {"TARGET_BOX_DIS_ENABLE","TARGET_BOX_X","TARGET_BOX_Y","TARGET_BOX_X_2","TARGET_BOX_Y_2"},
    {
        {"parameter_in_range",0,0.5,1.1},
        {"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},
        {"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}
    }
)
AddText(nil,nil,'hud_font_base',{-0.1*Width,0},'RightCenter',DEFAULT_FONT_SIZE[3],nil,nil,stt_box,
    {'%.2fKM'}
    ,{
        "TARGET_RANGE",
        "TARGET_BOX_DIS_ENABLE"
    },{
        {"text_using_parameter",0},
        {"parameter_in_range",1,0.9,1.1}
    }
)

--IR弹
AddCircle(nil,0.07*Width,0.06*Width,360,36,nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "TARGET_ROUND_DIS_ENABLE",
        "TARGET_ROUND_Y",
        "TARGET_ROUND_X"
    },
    {
        {"parameter_in_range",0,0.9,1.1},
        {"move_up_down_using_parameter",1,y_scale},
        {"move_left_right_using_parameter",2,x_scale}
    }
)
--机炮格子
local gun_grid_sign 				            = CreateElement "ceTexPoly"
gun_grid_sign.vertices                 = hud_vert_gen(2400,2400)-- {{-106,125},{106,125},{106,-143},{-106,-143}}
gun_grid_sign.indices                  = {0,1,2,2,3,0}
gun_grid_sign.tex_coords               = tex_coord_gen(0,0,1024,1024,1024,1024)
gun_grid_sign.material                 = MakeMaterial("./Bazar/Textures/AvionicsCommon/asp17grid.dds", {HUD_DAY_COLOR})
gun_grid_sign.name 			        = create_guid_string()
gun_grid_sign.init_pos                 = {0, -0.3}
gun_grid_sign.init_rot		            = {0, 0}
gun_grid_sign.collimated	            = true
gun_grid_sign.element_params           = {"GUN_GRID"} --, "D_GUNSIGHT_VISIBLE"
gun_grid_sign.controllers              = {{"parameter_in_range",0,0.9,1.1}}
gun_grid_sign.use_mipfilter            = true
gun_grid_sign.additive_alpha           = true
gun_grid_sign.h_clip_relation          = COMPARE
gun_grid_sign.level                    = DEFAULT_LEVEL
gun_grid_sign.parent_element	        = 
Add(gun_grid_sign)

--机炮ccip
AddCircle(nil,0.07*Width,0.06*Width,360,36,nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "GUN_CCIP_DIS_ENABLE",
        "GUN_CCIP_Y",
        "GUN_CCIP_X"
    },
    {
        {"parameter_in_range",0,0.5,1.1},
        {"move_up_down_using_parameter",1,y_scale},
        {"move_left_right_using_parameter",2,x_scale}
    }
)
--机炮ccip连线
AddSimpleLine(nil,0.004*Width,{{0,0},{1,0}},nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "GUN_CCIP_DIS_ENABLE",
        "GUN_CCIP_X",
        "GUN_CCIP_Y",
        "GUN_CCIP_X_2",
        "GUN_CCIP_Y_2"
    },
    {
        {"parameter_in_range",0,0.5,1.1},
        {"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},
        {"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}
    }
)

--火箭弹ccip
AddCircle(nil,0.07*Width,0.06*Width,360,36,nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "ROCKET_CCIP_DIS_ENABLE",
        "ROCKET_CCIP_Y",
        "ROCKET_CCIP_X"
    },
    {
        {"parameter_in_range",0,0.5,1.1},
        {"move_up_down_using_parameter",1,y_scale},
        {"move_left_right_using_parameter",2,x_scale}
    }
)
--火箭弹ccip连线
AddSimpleLine(nil,0.004*Width,{{0,0},{1,0}},nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "ROCKET_CCIP_DIS_ENABLE",
        "ROCKET_CCIP_X",
        "ROCKET_CCIP_Y",
        "ROCKET_CCIP_X_2",
        "ROCKET_CCIP_Y_2"
    },
    {
        {"parameter_in_range",0,0.5,1.1},
        {"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},
        {"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}
    }
)
--炸弹ccip
AddCircle(nil,0.07*Width,0.06*Width,360,36,nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "BOMB_CCIP_DIS_ENABLE",
        "BOMB_CCIP_Y",
        "BOMB_CCIP_X"
    },
    {
        {"parameter_in_range",0,0.5,1.1},
        {"move_up_down_using_parameter",1,y_scale},
        {"move_left_right_using_parameter",2,x_scale}
    }
)
--炸弹ccip连线
AddSimpleLine(nil,0.004*Width,{{0,0},{1,0}},nil,nil,'DBG_GREEN',nil,nil,base_simple,
    {
        "BOMB_CCIP_DIS_ENABLE",
        "BOMB_CCIP_X",
        "BOMB_CCIP_Y",
        "BOMB_CCIP_X_2",
        "BOMB_CCIP_Y_2"
    },
    {
        {"parameter_in_range",0,0.5,1.1},
        {"line_object_set_point_using_parameters",0,1,2,x_scale,y_scale},
        {"line_object_set_point_using_parameters",1,3,4,x_scale,y_scale}
    }
)

AddText(nil,nil,'hud_font_base',{0 , -0.5*Height},nil,DEFAULT_FONT_SIZE[1],nil,nil,base_simple,
    {'%s'},
    {"WEAPON_NAME","WEAPON_NAME_DIS"},
    {
        {"text_using_parameter",0},
        {"parameter_in_range",1,0.5,1.1}
    }
)

--	for ia = 1,999 do
for i = 1, 16 do
    AddSimpleLine(nil,0.01*Width,{{0,0.05*Height},{-0.05*Width,-0.05*Height},{0.05*Width,-0.05*Height}},nil,nil,'DBG_GREEN',nil,nil,base_simple,
        {
            string.format('HUD_RDR_CONTACT_%02.0f_ELEVATION',i),
            string.format('HUD_RDR_CONTACT_%02.0f_AZIMUTH',i),
            string.format('RADAR_CONTACT_%02.0f_RANGE',i),
			string.format('RADAR_CONTACT_%02.0f_FRIENDLY',i),
			string.format('RADAR_CONTACT_%02.0f_RCS',i),
        },{
			{"move_up_down_using_parameter"		,0,y_scale},
			{ "move_left_right_using_parameter", 1, x_scale },
			--{ "move_up_down_using_parameter", 2, ud_scale },
			{ "parameter_in_range", 2, 30, 120000 },
			{ "parameter_in_range", 3, 0,0.9 },
			{ "parameter_in_range", 4, -1,100},
		}
    )
	AddBoxBorder(nil, 0.05*Width,0.05 * Height,0.01*Width,nil,nil,'DBG_GREEN',nil,nil,base_simple,
		{
			string.format('HUD_RDR_CONTACT_%02.0f_ELEVATION',i),
			string.format('HUD_RDR_CONTACT_%02.0f_AZIMUTH',i),
			string.format('RADAR_CONTACT_%02.0f_RANGE',i),
			string.format('RADAR_CONTACT_%02.0f_FRIENDLY',i),
			string.format('RADAR_CONTACT_%02.0f_RCS',i),
		},
		{
			{"move_up_down_using_parameter"		,0,y_scale},
			{ "move_left_right_using_parameter", 1, x_scale },
			--{ "move_up_down_using_parameter", 2, ud_scale },
			{ "parameter_in_range", 2, 30, 80000 },
			{ "parameter_in_range", 3, 0.9, 1.1},
			{ "parameter_in_range", 4, -1,100},
		}
	)
end