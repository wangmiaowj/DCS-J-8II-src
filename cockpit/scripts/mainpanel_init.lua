--初始化座舱模型
shape_name   	   = "Cockpit_J-8II"
is_EDM			   = true
new_model_format   = true

-- 一些颜色定义，基本没啥用
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}

-- 一些不用动的数据
dusk_border					 = 0.4
draw_pilot					 = false

-- 定义外部舱盖模型的arg值
external_model_canopy_arg	 = 38

-- 是否使用外部模型的座舱（指是否默认设置好114隐藏外部模型的座舱
use_external_views = false

local controllers = LoRegisterPanelControls()

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

-- mirror settings
mirrors_data = {
    center_point      	= { 0.418, 0.2 , 0.0 }, --F/B,U/D,L/R location of reflection image generation--{ 0.279, 0.4, 0.00 } 0.279, 0.3, 0.00, difference from cockpit_local_point {2.00, 0.2553,-0.2576},
    width 			  	= 1.9, --integrated (keep in mind that mirrors can be none planar old=0.7)
    aspect 			  	= 1,--0.8/0.3,
	rotation 	 	 	= math.rad(0);
	animation_speed  	= 2.0;
	near_clip 		  	= 0.1;
	--middle_clip		= 100;		
	--far_clip		  	= 60000;	
	arg_value_when_on 	= 1.0;
}

TEMP_VAR = {}

-- 这是封装的设置舱内动画与parameter绑定的函数

function create_cockpit_animation_controller(input_num, set_parameter, _arg_number, _input, _output, _controller)
    if (_input == nil) then
        _input = {-1,1}
    end
    if (_output == nil) then
        _output = {-1,1}
    end
	if _controller ~= nil then
		TEMP_VAR[input_num] = CreateGauge()
		TEMP_VAR[input_num].controller		= _controller
	else
		TEMP_VAR[input_num] = CreateGauge("parameter")
		TEMP_VAR[input_num].parameter_name		= set_parameter
	end
    TEMP_VAR[input_num].arg_number		    = _arg_number
    TEMP_VAR[input_num].input				= _input
    TEMP_VAR[input_num].output			    = _output
end

counter_rec = 0

function _counter()
    counter_rec = counter_rec + 1
    return(counter_rec)
end

animation_list = {
    {"RADAR_ALT_MIN", 0},
    {"G_METER", 6,{-2,11},{0,1},controllers.base_gauge_VerticalAcceleration},
    {"AOA_METER", 7,{-10,40},{0,1}},
    {"AIRSPEED_IND", 8},
    {"RADAR_ALT_METER", 9,{0,600},{0,1}},
    {"ALT_METER_OUT", 10},
    {"ALT_METER_IN", 11,{0,30000},{0,1},controllers.base_gauge_BarometricAltitude},
    {"L_ENG_TMP", 12, {-70,150}, {0,1}, controllers.base_gauge_EngineLeftTemperatureBeforeTurbine},
    {"R_ENG_TMP", 14, {-70,150}, {0,1}, controllers.base_gauge_EngineRightTemperatureBeforeTurbine},
    {"L_RPM", 16, {0,1.1}, {0,1}},
    {"R_RPM", 17, {0,1.1}, {0,1}},
    {"CLOCK_M", 18},
    {"CLOCK_H", 19},
    {"CLOCK_S",21},
    {"FUEL_01", 22, {0,4000}, {0,1}, controllers.base_gauge_TotalFuelWeight},
    {"FUEL_02", 23,{0,1300}, {0,1}, controllers.base_gauge_TotalFuelWeight},
    {"CLIMB_RATE", 24,{-200,200},{-1,1},controllers.base_gauge_VerticalVelocity},
    {"HORIZONTAL_G", 25, {-1,1},{-1,1},controllers.base_gauge_Roll},
    {"HORIZONTAL_G_BALL", 26,{-1,1},{-1,1},controllers.base_gauge_LateralAcceleration},
    {"ADI_ROLL", 30,{-180,180},{-1,1}},
    {"ADI_BALL", 31,{-1,1},{-1,1},controllers.base_gauge_LateralAcceleration},
    {"HSI_HEADING", 32,{-180,180},{0,1}},
    {"HSI_CRS_01", 33,{-1,1},{-1,1}},
    {"HSI_CRS_02", 34,{-1,1},{-1,1}},
	{"HSI_COURSE", 35, {0, 360}, {0, 1}},
    {"HSI_ADF", 36,{0, 360}, {0, 1}},
    {"TIMER", 37},
    {"FLIGHT_DURATION", 38},
    {"L_WHEEL_IND", 39, {-1,1}, {-0.5,0.5}},
    {"F_WHEEL_IND", 40, {-1,1}, {-0.5,0.5}},
    {"R_WHEEL_IND", 41, {-1,1}, {-0.5,0.5}},
    {"FLAP_IND", 42, {0,0.1}, {0,1}},
    {"AIRBRAKE_IND", 44, {0,0.1}, {0,1}},
    {"LANDING_WARNING_LIGHT", 46},
    {"STICK_PITCH", 71,{-100,100},{-1,1}},
    {"STICK_ROLL", 74,{-100,100},{-1,1}},
    {"ADI_PITCH", 81,{-160,160},{-1,1}},
	{"LDG_Handle", 83,{0,1},{0,1}},
    {"ADI_PITCH_KNOB", 84},
    --{"???", 99},
    --{"???", 100},
	{"R_ENG_IDLE", 102,{0,1},{0,1}},
    {"L_ENG_IDLE", 103,{0,1},{0,1}},
    {"R_THROTTLE", 104,{0,1},{0,1}},
    {"L_THROTTLE", 105,{0,1},{0,1}},
    {"MASTER_CAUTION", 107},
    {"HSI_DISTANCE_x100", 111},
    {"HSI_DISTANCE_x10", 112},
    {"HSI_DISTANCE_x1", 113},
    {"HSI_LOCK_1", 121},
    {"HSI_LOCK_2", 122},
    {"HSI_R_KNOB", 126},
    {"MASTER_CAUTION_RESET", 128},
    {"HSI_L_KNOB", 129},
    {"HSI_LOCK_3", 147},
    {"CPT_LIGHTING", 180,{0,1},{0,1}},
    {"CPT_COVER", 181,{0,1},{0,1}},
	{"CPT_PRESSURE_1", 230},
	{"G_METER_MAX", 258},
	{"G_METER_MIN", 259},
	{"FLAP_BTN", 279},
    {"CPT_PRESSURE_2", 280,{-0.2,0.6},{-1,1}},
    {"HSI_HDG_x100", 301},
    {"HSI_HDG_x10", 302},
	{"HSI_HDG_x1", 303},
    {"OXY_ELEMENT", 317},
    {"AIRBRAKE_BTN", 339},
    {"RUDDER_PADEL", 500,{-85,85},{-1,1}},
	
	--右侧板1
    {"PNT_1001", 1001},
    {"PNT_1002", 1002},
    {"PNT_1003", 1003},
    {"PNT_1004", 1004},
	{"PNT_1005", 1005}, --{0, 1}, {0.12, 0.19}},
    {"PNT_1006", 1006}, --{0, 1}, {0.7, 1}},
	{"PNT_1007", 1007},
	{"PNT_1008", 1008},
    {"PNT_1009", 1009},
	{"PNT_1010", 1010},
    {"PNT_1011", 1011},
    {"PNT_1012", 1012},
    {"PNT_1013", 1013},
	{"PNT_1014", 1014},
	{"PNT_1015", 1015},
	{"PNT_1016", 1016},
    {"PNT_1017", 1017},
    {"PNT_1018", 1018},
    {"PNT_1019", 1019},
    {"PNT_1020", 1020},
    {"PNT_1021", 1021},
    {"PNT_1022", 1022},
    {"PNT_1023", 1023},
	
	--右侧板2
    {"PNT_1031", 1031},--0
	{"PNT_1032", 1032},--1
	{"PNT_1033", 1033},--2
	{"PNT_1034", 1034},--3
	{"PNT_1035", 1035},--4
	{"PNT_1036", 1036},--5
	{"PNT_1037", 1037},--6
	{"PNT_1038", 1038},--7
	{"PNT_1039", 1039},--8
	{"PNT_1040", 1040},--9
	--{"PNT_1041", 1041},
	{"PNT_1042", 1042},
	{"PNT_1043", 1043},
	{"PNT_1044", 1044},
	{"PNT_1045", 1045},
	{"PNT_1046", 1046},
	{"PNT_1047", 1047},
	{"PNT_1048", 1048},
	{"PNT_1049", 1049},
	--{"PNT_1050", 1050},
	{"PNT_1051", 1051},--确认
	{"PNT_1052", 1052},--清除
	
    -- 右侧面板3
    {"PNT_1061", 1061},
    {"PNT_1062", 1062},
	{"PNT_1063", 1063},
	{"PNT_1064", 1064},
	{"PNT_1065", 1065},
	{"PNT_1066", 1066},
	{"PNT_1067", 1067},
	{"PNT_1068", 1068},
	{"PNT_1069", 1069},
	{"PNT_1070", 1070},

    -- 右侧面板4
    {"PNT_1081", 1081},
    {"PNT_1082", 1082},
	{"PNT_1083", 1083},
	{"PNT_1084", 1084},
	{"PNT_1085", 1085},
	{"PNT_1086", 1086},
	{"PNT_1087", 1087},
	{"PNT_1088", 1088},
	{"PNT_1089", 1089},
	{"PNT_1090", 1090},
	{"PNT_1091", 1091},
	{"PNT_1092", 1092},
	{"PNT_1093", 1093},
	{"PNT_1094", 1094},
	{"PNT_1095", 1095},
	{"PNT_1096", 1096},
	{"PNT_1097", 1097},
	{"PNT_1098", 1098},
	{"PNT_1099", 1099,{0,1},{0,1}},

    -- 右面板
    {"PNT_1101", 1101},
	{"PNT_1102", 1102},
	{"PNT_1103", 1103},
	{"PNT_1107", 1104},
	{"PNT_1105", 1105},
	{"PNT_1106", 1106},
	{"PNT_1107", 1107},--ИНД-АРК
	{"PNT_1108", 1108},
	{"PNT_1109", 1109},
    {"PNT_1110", 1110},
    {"PNT_1111", 1111},
    {"PNT_1112", 1112},

    -- 左面板
    {"PNT_1121", 1121},
    {"PNT_1122", 1122},
	{"PNT_1123", 1123},
    {"PNT_1124", 1124},
    {"PNT_1125", 1125},
    {"PNT_1126", 1126},
    {"PNT_1127", 1127},
    {"PNT_1128", 1128},
    {"PNT_1129", 1129},
	
	-- 左侧面板1
    {"PNT_1141", 1141},
    {"PNT_1142", 1142},
	{"PNT_1143", 1143},
	{"PNT_1144", 1144},
	{"PNT_1145", 1145},
	{"PNT_1146", 1146},
	{"PNT_1147", 1147},
    {"PNT_1148", 1148},
    {"PNT_1149", 1149},
    {"PNT_1150", 1150},
    {"PNT_1151", 1151},
	
	--左侧面板2
    {"PNT_1161", 1161},
    {"PNT_1162", 1162},
    {"PNT_1163", 1163},
    {"PNT_1164", 1164},
    {"PNT_1165", 1165},
    {"PNT_1166", 1166},
    {"PNT_1167", 1167},
    {"PNT_1168", 1168},
	
	--左侧面板3
    {"PNT_1171", 1171},
    {"PNT_1172", 1172},
    {"PNT_1173", 1173},
    {"PNT_1174", 1174},
	{"PNT_1175", 1175},
	{"PNT_1176", 1176},
	{"PNT_1177", 1177},
	{"PNT_1178", 1178},
	{"PNT_1179", 1179},
	{"PNT_1180", 1180},
	{"PNT_1181", 1181},
	
	--仪表
	{"PNT_1191", 1191},
	{"PNT_1192", 1192},
	{"PNT_1193", 1193},
	{"PNT_1194", 1194},--切换MAX/MIN的G值指针控制
	{"PNT_1195", 1195},
	{"PNT_1196", 1196},
	{"PNT_1197", 1197},
	{"PNT_1198", 1198},--气压高度表的一个旋钮
	{"PNT_1199", 1199},
	{"PNT_1120", 1200},
	
	--火控台
	{"PNT_1201", 1201},
	{"PNT_1202", 1202},
	{"PNT_1203", 1203},
	{"PNT_1204", 1204},
	{"PNT_1205", 1205},
	{"PNT_1206", 1206},
	{"PNT_1207", 1207},
	
	--雷达示波器
	{"PNT_1211", 1211},
	{"PNT_1212", 1212},
	{"PNT_1213", 1213},
	{"PNT_1214", 1214},
	{"PNT_1215", 1215},
	{"PNT_1216", 1216},
	
	--右下角警告面板
	{"PNT_1221", 1221},
	{"PNT_1222", 1222},
	{"PNT_1223", 1223},
	{"PNT_1224", 1224},
	{"PNT_1225", 1225},
	{"PNT_1226", 1226},
	{"BATTERY_CAPACITY", 1227,{0,1000},{0,1}},
	
	--右下角集成仪表
	{"EXHAUST_GAS_TMP_L", 1231, {300,900}, {0,1}},
	{"EXHAUST_GAS_TMP_R", 1232, {300,900}, {0,1}},
	{"UNKNOW_METER_002_L", 1233},
	{"UNKNOW_METER_002_R", 1234},
	{"UNKNOW_METER_003_L", 1235},
	{"UNKNOW_METER_003_R", 1236},
	{"UNKNOW_METER_004_L", 1237},
	{"UNKNOW_METER_004_R", 1238},
	
	--底部仪表
	{"OXYGEN_FLOW", 1241},
	{"MANO_BRAKE_01",1242},
	{"MANO_BRAKE_02",1243},
	{"PNT_234",1244},
	
	--??
	{"PNT_1251",1251},
	{"PNT_1252",1252},
	{"PNT_1253",1253},
	{"PNT_1254",1254},
	{"PNT_1255",1255},
	{"PNT_1256",1256},
	{"PNT_1257",1257},
	{"UNKNOW_METER_005",1258},
	
	--pylon select
	{"PNT_1261",1261,{0,1},{0,1}},
	{"PNT_1262",1262,{0,1},{0,1}},
	{"PNT_2263",2263,{0,1},{0,1}},--3号挂架选择开关
	{"PNT_1263",1263,{0,1},{0,1}},
	{"PNT_2264",2264,{0,1},{0,1}},--5号挂架选择开关
	{"PNT_1264",1264,{0,1},{0,1}},
	{"PNT_1265",1265,{0,1},{0,1}},

	--pylon selected
	{"PNT_1266",1266,{0,1},{0,1}},
	{"PNT_1267",1267,{0,1},{0,1}},
	{"PNT_2267",2267,{0,1},{0,1}},
	{"PNT_1268",1268,{0,1},{0,1}},
	{"PNT_2269",2269,{0,1},{0,1}},
	{"PNT_1269",1269,{0,1},{0,1}},
	{"PNT_1270",1270,{0,1},{0,1}},
	
	
	
	--pylon ammo count
	{"PNT_1271",1271},
	{"PNT_1272",1272},
	{"PNT_1272",1272},
	{"PNT_1273",1273},
	{"PNT_2273",2273},--3x10
	{"PNT_2274",2274},--3x1
	{"PNT_1274",1274},
	{"PNT_1275",1275},
	{"PNT_2277",2277},--5x10
	{"PNT_2278",2278},--5x1
	{"PNT_1276",1276},
	{"PNT_1277",1277},
	{"PNT_1278",1278},
	{"PNT_1279",1279},
	{"PNT_1280",1280},
	
	--gun ammo count
	{"PNT_1281",1281,{0,1},{0,1}},
	
	--weapon params
	{"PNT_1282",1282,{0,1},{0,1}},
	{"PNT_1283",1283,{0,1},{0,1}},
	{"PNT_1284",1284,{0,1},{0,1}},
	{"PNT_1285",1285,{0,1},{0,1}},
	{"PNT_1286",1286,{0,1},{0,1}},
	{"PNT_1287",1287,{0,1},{0,1}},
	{"PNT_1288",1288,{0,1},{0,1}},
	{"PNT_1289",1289,{0,1},{0,1}},
	{"PNT_1290",1290,{0,1},{0,1}},
	
	{"PNT_1294",1294},
	{"PNT_1295",1295},
	{"PNT_1296",1296},
	{"PNT_1297",1297},
	{"PNT_1298",1298},
	{"PNT_1299",1299},
	{"PNT_1300",1300},

	{"PNT_1311",1311,{0,1},{1,0}},--RWR亮度
	{"PNT_1312",1312,{0,1},{1,0}},--RWR音量

	
	
	{"MOTOR_RPM",114514,{0,100},{0,1}},
}

--[[
    animation_list[_counter] = {"RPM_L", 303}
    animation_list[_counter] = {"RPM_R", 304}
    animation_list[_counter] = {"EGT_L", 305}
    animation_list[_counter] = {"EGT_R", 306}
    animation_list[_counter] = {"FF_L", 307}
    animation_list[_counter] = {"FF_R", 308}
    animation_list[_counter] = {"RPM_L", 303}
]]

for k,v in pairs(animation_list) do
    create_cockpit_animation_controller(k,v[1],v[2],v[3],v[4],v[5])
end


-- This is the definition of the traditional model standard
--Initialize cockpit animation


need_to_be_closed = false
--[[
local tablePrinted = {} 
local file = io.open("e:\\00_00_00_海外组_学习\\写入.txt", "w")
assert(file)
function printTableItem(k, v, level) 
    for i = 1, level do 
        file:write("\t")
    end 
	file:write(tostring(k).." = "..tostring(v).."\r\n")
    if type(v) == "table" then 
        if not tablePrinted[v] then 
            tablePrinted[v] = true 
            for k, v in pairs(v) do 
                printTableItem(k, v, level + 1) 
            end 
        end 
    end 
end 
printTableItem("get_aircraft_type",get_aircraft_type(),0)
--]]
--SOUNDS
dofile(LockOn_Options.common_script_path.."tools.lua")