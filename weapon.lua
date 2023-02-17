function copyTable(target, src)
	for i, v in pairs(src) do
		if type(v) == 'table' then
			if not target[i] then
				target[i] = {}
			end
			copyTable(target[i], v)
		else
			target[i] = v
		end
	end
end

local Aspide_FM =
{
	mass                = 231,
	caliber             = 0.2,
	wind_sigma          = 0.0,
	wind_time           = 0.0,
	tail_first          = 1,
	fins_part_val       = 0,
	rotated_fins_inp    = 0,
	delta_max           = math.rad(20),
	draw_fins_conv      = { math.rad(90), 1, 1 },
	L                   = 0.2,
	S                   = 0.0324,
	Ix                  = 3.5,
	Iy                  = 127.4,
	Iz                  = 127.4,
	Mxd                 = 0.3 * 57.3,
	Mxw                 = -44.5,
	table_scale         = 0.2,
	table_degree_values = 1,
	--	Mach	  | 0.0		0.2		0.4		0.6		0.8		1.0		1.2		1.4		1.6		1.8		2.0		2.2		2.4		2.6		2.8		3.0		3.2		3.4		3.6		3.8		4.0	 |
	Cx0                 = { 0.34, 0.34, 0.34, 0.34, 0.35, 1.10, 1.27, 1.23, 1.19, 1.12, 1.05, 1.0, 0.95, 0.91, 0.87, 0.84,
		0.81, 0.78, 0.76, 0.74, 0.72 },
	CxB                 = { 0.11, 0.11, 0.11, 0.11, 0.11, 0.18, 0.19, 0.17, 0.16, 0.14, 0.13, 0.12, 0.12, 0.11, 0.11, 0.10,
		0.09, 0.09, 0.08, 0.08, 0.07 },
	K1                  = { 0.0056, 0.0056, 0.0056, 0.0056, 0.0056, 0.0056, 0.0056, 0.0056, 0.0052, 0.0048, 0.0045, 0.0041,
		0.0037, 0.0036, 0.0034, 0.0032, 0.0031, 0.0030, 0.0029, 0.0027, 0.0026 },
	K2                  = { 0.0055, 0.0055, 0.0055, 0.0055, 0.0055, 0.0055, 0.0055, 0.0055, 0.0051, 0.0047, 0.0043, 0.0037,
		0.0031, 0.0032, 0.0033, 0.0035, 0.0036, 0.0037, 0.0038, 0.0039, 0.0040 },
	Cya                 = { 1.14, 1.14, 1.14, 1.14, 1.14, 1.42, 1.46, 1.39, 1.32, 1.15, 1.06, 1.00, 0.94, 0.89, 0.83, 0.78,
		0.73, 0.69, 0.65, 0.61, 0.57 },
	Cza                 = { 1.14, 1.14, 1.14, 1.14, 1.14, 1.42, 1.46, 1.39, 1.32, 1.15, 1.06, 1.00, 0.94, 0.89, 0.83, 0.78,
		0.73, 0.69, 0.65, 0.61, 0.57 },
	Mya                 = { -0.5, -0.5 },
	Mza                 = { -0.5, -0.5 },
	Myw                 = { -2.0, -2.0 },
	Mzw                 = { -2.0, -2.0 },
	A1trim              = { 10.0, 10.0 },
	A2trim              = { 10.0, 10.0 },
	model_roll          = math.rad(45),
	fins_stall          = 1,
}

local Aspide_MK1 =
{
	category               = CAT_AIR_TO_AIR,
	name                   = "Aspide_MK1",
	displayName            = _("Aspide MK1 Semi-Active Radar"),
	user_name              = _("Aspide_MK1"),
	scheme                 = "aa_missile_semi_active",
	class_name             = "wAmmunitionSelfHoming",
	model                  = "Aspide",
	wsTypeOfWeapon         = { wsType_Weapon, wsType_Missile, wsType_AA_Missile, WSTYPE_PLACEHOLDER },
	mass                   = 231,
	Escort                 = 1,
	Head_Type              = 6,
	sigma                  = { 5.6, 5, 5.6 },
	M                      = 231,
	H_max                  = 24400.0,
	H_min                  = 1.0,
	Diam                   = 203.0,
	Cx_pil                 = 2.21,
	D_max                  = 20000.0,
	D_min                  = 1500.0,
	Head_Form              = 1,
	Life_Time              = 110.0,
	Nr_max                 = 25,
	v_min                  = 140.0,
	v_mid                  = 500.0,
	Mach_max               = 3.2,
	t_b                    = 0.5,
	t_acc                  = 3.3,
	t_marsh                = 11.0,
	Range_max              = 50000.0,
	H_min_t                = 15.0,
	Fi_start               = 0.4,
	Fi_rak                 = 3.14152,
	Fi_excort              = 0.96,
	Fi_search              = 0.1,
	OmViz_max              = 0.35,
	exhaust                = { 0.78, 0.78, 0.78, 0.3 },
	X_back                 = -2.0,
	Y_back                 = -0.0,
	Z_back                 = 0.0, -- -0.1,
	Reflection             = 0.08,
	KillDistance           = 12.0,
	ccm_k0                 = 1.0, -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1. The curve is non linear!
	rad_correction         = 0,
	-- The guidance error from the influence of the surface at low altitudes
	height_error_k         = 110, -- если проекция скорости цели на линию визирования меньше этого значения, появляется ошибка
	height_error_max_vel   = 150, -- пропорциональный коэффициент
	height_error_max_h     = 450, -- максимальная высота, где появляется ошибка
	warhead                = predefined_warhead("AIM_7"),
	warhead_air            = predefined_warhead("AIM_7"),
	hoj                    = 1,
	shape_table_data       =
	{
		{
			name     = "Aspide_MK1",
			file     = "Aspide",
			life     = 1,
			fire     = { 0, 1 },
			username = "Aspide_MK1",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area       = 0.007238, -- площадь выходного сечения сопла
	ModelData              = { 58, -- model params count
		0.9, -- characteristic square (характеристическая площадь)

		-- параметры зависимости Сx
		0.0125, -- планка Сx0 на дозвуке ( M << 1)
		0.052, -- высота пика волнового кризиса
		0.010, -- крутизна фронта на подходе к волновому кризису
		0.002, -- планка Cx0 на сверхзвуке ( M >> 1)
		0.5, -- крутизна спада за волновым кризисом
		1.2, -- коэффициент отвала поляры

		-- параметры зависимости Cy
		2.20, -- планка Cya на дозвуке ( M << 1)
		1.05, -- планка Cya на сверхзвуке ( M >> 1)
		1.20, -- крутизна спада(фронта) за волновым кризисом

		0.18, -- ~10 degrees Alfa_max  максимальный балансировачный угол, радианы
		0.00, --угловая скорость создаваймая моментом газовых рулей

		--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
		-1.0, -1.0, 3.7, 10.8, 0.0, 0.0, 1.0e9, -- time interval
		0.0, 0.0, 10.4, 2.02, 0.0, 0.0, 0.0, -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
		0.0, 0.0, 25192.0, 4140.0, 0.0, 0.0, 0.0, -- thrust

		1.0e9, -- таймер самоликвидации, сек
		75.0, -- время работы энергосистемы
		0.0, -- абсалютеая высота самоликвидации, м
		1.5, -- время задержки включения управленя, сек
		1.0e9, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты
		1.0e9, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр)
		0.0, -- синус угла возвышения траектории набора горки
		50.0, -- продольное ускорения взведения взрывателя
		0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
		1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
		1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
		2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
		-- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
		14.0, -- производная дальности по скорости носителя на высоте 1км, ППС
		-21.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
		-2.2, -- производная по высоте производной дальности по скорости цели, ЗПС
		27000, -- дальность ракурс 180(навстречу) град, Н=5000м, V=900км/ч, м
		7000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
		38000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м
		12000.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
		19000.0, -- дальность ракурс 180(навстречу) град, Н=1000м,  V=900км/ч, м
		5000.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м
		2500.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
		0.4, -- процент гарантированной дальности от дальности в ППС на высоте 1км
		-0.014, -- производная процента гарантированной дальности в ППС по высоте
		0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
	},
	controller             = {
		boost_start = 0.5,
		march_start = 4.2,
	},
	boost                  = {
		impulse                         = 247,
		fuel_mass                       = 38.48,
		work_time                       = 3.7,
		nozzle_position                 = { { -1.9, 0, 0 } },
		nozzle_orientationXYZ           = { { 0.0, 0.0, 0.0 } },
		nozzle_exit_area                = 0.00724,
		tail_width                      = 0.4,
		smoke_color                     = { 1.0, 1.0, 1.0 },
		smoke_transparency              = 0.9,
		custom_smoke_dissipation_factor = 0.2,
	},
	march                  = {
		impulse                         = 209,
		fuel_mass                       = 21.82,
		work_time                       = 5.8,
		nozzle_position                 = { { -1.9, 0, 0 } },
		nozzle_orientationXYZ           = { { 0.0, 0.0, 0.0 } },
		nozzle_exit_area                = 0.00724,
		tail_width                      = 0.4,
		smoke_color                     = { 1.0, 1.0, 1.0 },
		smoke_transparency              = 0.9,
		custom_smoke_dissipation_factor = 0.2,
	},
	fm                     = Aspide_FM,
	proximity_fuze         = {
		radius    = 12,
		arm_delay = 1.6,
	},
	seeker                 = {
		delay                = 1.5,
		op_time              = 75,
		FOV                  = math.rad(110),
		max_w_LOS            = math.rad(20),
		sens_near_dist       = 100,
		sens_far_dist        = 30000,
		ccm_k0               = 1.0,
		aim_sigma            = 5.5,
		height_error_k       = 110,
		height_error_max_vel = 150,
		height_error_max_h   = 450,
		hoj                  = 1,
	},
	autopilot              = {
		x_channel_delay        = 0.9,
		delay                  = 1.5,
		op_time                = 75,
		Kconv                  = 3.0,
		Knv                    = 0.02,
		Kd                     = 0.4,
		Ki                     = 0.15,
		Kout                   = 1.0,
		Kx                     = 0.1,
		Krx                    = 2.0,
		fins_limit             = math.rad(20),
		fins_limit_x           = math.rad(5),
		Areq_limit             = 25.0,
		bang_bang              = 0,
		max_side_N             = 10,
		max_signal_Fi          = math.rad(12),
		rotate_fins_output     = 0,
		alg                    = 0,
		PN_dist_data           = { 15000, 1,
			9000, 1 },
		null_roll              = math.rad(45),

		loft_active_by_default = 0,
		loft_add_pitch         = math.rad(30),
		loft_time              = 3.5,
		loft_min_dist          = 6500,
		loft_max_dist          = 20000,
	},
}

declare_weapon(Aspide_MK1)

local LSWM_AA = {
	category               = CAT_AIR_TO_AIR,
	name                   = "LSWM_AA",
	displayName            = _("LSWM 远距离震荡波导弹AA"),
	user_name              = _("LSWM 远距离震荡波导弹AA"),
	scheme			= "aa_missile_amraam2",
	class_name		= "wAmmunitionSelfHoming",
	model			= "aim-120c",
	wsTypeOfWeapon         = { 4, 4, 7, WSTYPE_PLACEHOLDER },
	shape_table_data =
	{
		{
			file  = "agm-154c";
			life  = 1;
			fire  = {0, 1};
			name  	 = "LSWM_AA";
			username = "LSWM_AA";
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
	Escort = 0,
    Head_Type = 2,
	sigma = {5, 5, 5},
    M = 161.48,
    H_max = 26000.0,
    H_min = 1.0,
    Diam = 160.0,
    Cx_pil = 2.5,
    D_max = 16000.0,
    D_min = 700.0,
    Head_Form = 1,
    Life_Time = 90.0,
    Nr_max = 30,
    v_min = 140.0,
    v_mid = 700.0,
    Mach_max = 4.0,
    t_b = 0.4,
    t_acc = 3.0,
    t_marsh = 6.0,
    Range_max = 61000.0,
    H_min_t = 1.0,
    Fi_start = 0.88,
    Fi_rak = 3.14152,
    Fi_excort = 1.05,
    Fi_search = 1.05,
    OmViz_max = 0.52,
    exhaust = {0.8, 0.8, 0.8, 0.05 };
    X_back = -1.98,
    Y_back = 0.0,
    Z_back = 0.0,
    Reflection = 0.07,
    KillDistance = 15.0,
	ccm_k0 = 0.1,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
	loft = 1,
	hoj = 1,
	loft_factor = 4.5,
	PN_gain = 4,
		
	supersonic_A_coef_skew = 0.1, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.011, -- площадь выходного сечения сопла
		
	ModelData = {   58 ,  -- model params count
					0.4 ,   -- characteristic square (характеристическая площадь)
					
					-- параметры зависимости Сx
					0.029 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
					0.06 , -- Cx_k1 высота пика волнового кризиса
					0.01 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
					-0.245, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
					0.08 , -- Cx_k4 крутизна спада за волновым кризисом 
					0.7 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
					
					-- параметры зависимости Cy
					1.4 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
					0.6	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
					1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
						
					0.5 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
					0.0, --угловая скорость создаваймая моментом газовых рулей
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
					-1.0,		-1.0,	8.0,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
					0.0,		0.0,	6.41,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
					0.0,		0.0,	16325.0,	0.0,		0.0,			0.0,		0.0,           -- thrust, newtons
					
					1.0e9, -- таймер самоликвидации, сек
					100.0, -- время работы энергосистемы, сек
					0, -- абсолютная высота самоликвидации, м
					1.0, -- время задержки включения управления (маневр отлета, безопасности), сек
					25000, --40000 -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
					15000, --40000 -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
					0.52356,--0.17, -- синус угла возвышения траектории набора горки
					50.0, -- продольное ускорения взведения взрывателя
					0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					1.19, -- характеристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					1.0, -- характеристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					2.0, -- характеристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					-- ЗРП. Данные для рассчета дальностей пуска (индикация на прицеле)
					21.0, -- производная дальности по скорости носителя на высоте 1км, ППС
					-23.0, -- производная дальности по скорости цели на высоте 1км, ЗПС
					-3.0, -- производная по высоте производной дальности по скорости цели, ЗПС
					35000.0, -- дальность ракурс 180 град (навстречу), Н=5000м, V=900км/ч, м
					12000.0, -- дальность ракурс 0(в догон) град, Н=5000м, V=900км/ч, м
					75000.0, -- дальность ракурс 180(навстречу) град, Н=10000м, V=900км/ч, м 69km
					21500.0, -- дальность ракурс 0(в догон) град, Н=10000м, V=900км/ч, м
					25000.0, -- дальность ракурс 180 град (навстречу), Н=1000м, V=900км/ч, м
					7500.0, -- дальность ракурс 0(в догон) град, Н=1000м, V=900км/ч, м 
					4000.0, -- смещение назад отнсительно нуля задней точки зоны достижимости
					0.4, -- процент гарантированной дальности от дальности в ППС на высоте 1км
					-0.015, -- производная процента гарантированной дальности в ППС по высоте
					0.5,
				},
	
		controller = {
		boost_start = 0,
		march_start = 0.5,
	},

	boost = {
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0.1,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.0132,
		tail_width							= 0.4,
		smoke_color							= {0.8, 0.8, 0.8},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,
	},

	march = {
		impulse								= 234,
		fuel_mass							= 1000.26,
		work_time							= 600,
		nozzle_position						= {{-1.9, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.0132,
		tail_width							= 0.4,
		smoke_color							= {0.8, 0.8, 0.8},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,

--		fuel_rate_data	=	{	--t		rate
--								0.0,	2.0,
--								4.0,	1.8,
--							},
	},

	fm = {
		mass				= 161.48,
		caliber				= 0.178,
		wind_sigma			= 0.0,
		wind_time			= 0.0,
		tail_first			= 0,
		fins_part_val		= 0,
		rotated_fins_inp	= 0,
		delta_max			= math.rad(20),
		draw_fins_conv		= {math.rad(90),1,1},
		L					= 0.178,
		S					= 0.0248,
		Ix					= 1.04,
		Iy					= 125.32,
		Iz					= 125.32,

		Mxd					= 0.1 * 57.3,
		Mxw					= -15.8,

		table_scale	= 0.2,
		table_degree_values = 1,
	--	Mach	  | 0.0		0.2		0.4		0.6		0.8		1.0		1.2		1.4		1.6		1.8		2.0		2.2		2.4		2.6		2.8		3.0		3.2		3.4		3.6		3.8		4.0	 	4.2		4.4		4.6		4.8		5.0 |
		Cx0 	= {	0.468,	0.468,	0.468,	0.468,	0.479,	0.751,	0.88,	0.8572,	0.8132,	0.7645,	0.7205,	0.6808,	0.6447,	0.6119,	0.582,	0.5545,	0.5292,	0.5057,	0.4838,	0.4633,	0.4439,	0.4256,	0.4083,	0.3921,	0.377,	0.364  },
		CxB 	= {	0.021,	0.021,	0.021,	0.021,	0.021,	0.138,	0.153,	0.146,	0.1382,	0.1272,	0.1167,	0.1073,	0.0987,	0.0909,	0.0837,	0.077,	0.0708,	0.065,	0.0595,	0.0544,	0.0495,	0.0449,	0.0406,	0.0364,	0.0324,	0.0286 },
		K1		= { 0.0025,	0.0025,	0.0025,	0.0025,	0.0025,	0.0024,	0.002,	 0.00172, 0.00151, 0.00135,0.00123, 0.00114, 0.00106, 0.00099,0.00094, 0.00088, 0.00084, 0.00079, 0.00074, 0.0007, 0.00066, 0.00062, 0.00058, 0.00055,0.00052, 0.0005  },
		K2		= {-0.0024,-0.0024,-0.0024,-0.0024,-0.0024,-0.0024,-0.00206,-0.00186,-0.00168,-0.0015,-0.00134,-0.00118,-0.00104,-0.0009,-0.00078,-0.00066,-0.00056,-0.00046,-0.00038,-0.0003,-0.00024,-0.00018,-0.00014,-0.0001,-0.00008,-0.00006 },
		Cya		= { 0.318,	0.318,	0.318,	0.318,	0.336,	0.425,	0.467,	0.506,	0.518,	0.503,	0.491,	0.48,	0.471,	0.463,	0.456,	0.45,	0.445,	0.441,	0.438,	0.434,	0.431,	0.429,	0.427,	0.424,	0.423,	0.421 },
		Cza		= { 0.318,	0.318,	0.318,	0.318,	0.336,	0.425,	0.467,	0.506,	0.518,	0.503,	0.491,	0.48,	0.471,	0.463,	0.456,	0.45,	0.445,	0.441,	0.438,	0.434,	0.431,	0.429,	0.427,	0.424,	0.423,	0.421 },
		Mya		= {-0.712, -0.712, -0.712, -0.712, -0.776, -0.916, -0.907, -0.825, -0.7191,-0.5719,-0.4711,-0.4019,-0.3538,-0.3193,-0.2934,-0.2728,-0.2553,-0.2398,-0.2254,-0.2119,-0.199, -0.1868,-0.1754,-0.1649,-0.1557,-0.149 },
		Mza		= {-0.712, -0.712, -0.712, -0.712, -0.776, -0.916, -0.907, -0.825, -0.7191,-0.5719,-0.4711,-0.4019,-0.3538,-0.3193,-0.2934,-0.2728,-0.2553,-0.2398,-0.2254,-0.2119,-0.199, -0.1868,-0.1754,-0.1649,-0.1557,-0.149 },
		Myw		= { -8.8081,-8.8081,-8.8081,-8.8081,-9.0256,-11.32,-10.0494,-10.0967,-10.111,-10.0959,-10.0547,-9.9906,-9.9065,-9.8052,-9.6892,-9.5609,-9.4224,-9.2756,-9.1223,-8.9639,-8.8019,-8.6373,-8.471,-8.3037,-8.1361,-7.9682 },
		Mzw		= { -8.8081,-8.8081,-8.8081,-8.8081,-9.0256,-11.32,-10.0494,-10.0967,-10.111,-10.0959,-10.0547,-9.9906,-9.9065,-9.8052,-9.6892,-9.5609,-9.4224,-9.2756,-9.1223,-8.9639,-8.8019,-8.6373,-8.471,-8.3037,-8.1361,-7.9682 },
		A1trim	= { 28,		28,		28,		28,		28,		31.2,	32.74,	33.39,	33.7,	33.89,	34.04,	34.18,	34.31,	34.44,	34.57,	34.7,	34.83,	34.96,	35.09,	35.22,	35.35,	35.48,	35.61,	35.74,	35.87,	36 },
		A2trim	= { 28,		28,		28,		28,		28,		31.2,	32.74,	33.39,	33.7,	33.89,	34.04,	34.18,	34.31,	34.44,	34.57,	34.7,	34.83,	34.96,	35.09,	35.22,	35.35,	35.48,	35.61,	35.74,	35.87,	36 },

		model_roll = math.rad(45),
		fins_stall = 1,
	},

	sensor = {
		delay						= 1.5,
		op_time						= 1000,
		FOV							= math.rad(15),
		max_w_LOS					= math.rad(30),
		sens_near_dist				= 100,
		sens_far_dist				= 30000,
		ccm_k0						= 0.1,
		aim_sigma					= 3.5,
		height_error_k				= 20,
		height_error_max_vel		= 50,
		height_error_max_h			= 300,
		hoj							= 1,
	},
	
	gimbal = {
		delay				= 0,
		op_time				= 1000,
		pitch_max			= math.rad(60),
		yaw_max				= math.rad(60),
		max_tracking_rate	= math.rad(30),
		tracking_gain		= 50,
	},

	autopilot = {
		delay				= 1.0,
		op_time				= 1000,
		Tf					= 0.1,
		Knav				= 4.0,
		Kd					= 180.0,
		Ka					= 16.0,
		T1					= 309.0,
		Tc					= 0.06,
		Kx					= 0.1,
		Krx					= 2.0,
		gload_limit			= 30.0,
		fins_limit			= math.rad(18),
		fins_limit_x		= math.rad(5),
		null_roll			= math.rad(45),
		accel_coeffs		= { 0, 11.5,-1.2,-0.25, 24.0,
								0.0248 * 0.75 * 0.0091 },

		loft_active			= 1,
		loft_factor			= 4.5,
		loft_sin			= math.sin(30/57.3),
		loft_off_range		= 15000,
		dV0					= 393,
	},

	actuator = {
		Tf					= 0.005,
		D					= 250.0,
		T1					= 0.002,
		T2					= 0.006,
		max_omega			= math.rad(400),
		max_delta			= math.rad(20),
		fin_stall			= 1,
		sim_count			= 4,
	},

	proximity_fuze = {
		radius		= 7.0,
		arm_delay	= 1.6,
	},

	warhead		= predefined_warhead("AIM_120C"),
	warhead_air = predefined_warhead("AIM_120C"),
}
declare_weapon(LSWM_AA)

local LSWM_AS = {
	category         = CAT_MISSILES,
	name             = "LSWM_AS",
	user_name        = _("LSWM 远距离震荡波导弹AS"),
	model            = "agm-154c",
	mass             = 1000,
	wsTypeOfWeapon   = { wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER },
	Escort           = 0,
	Head_Type        = 5, -- 5,
	sigma            = { 8, 8, 8 },
	M                = 1000,
	H_max            = 15000.0,
	H_min            = -1,
	Diam             = 360.0,
	Cx_pil           = 8,
	D_max            = 220000.0,
	D_min            = 2000.0,
	Head_Form        = 1,
	Life_Time        = 1850.0,
	Nr_max           = 15,
	v_min            = 170.0,
	v_mid            = 372.0,
	Mach_max         = 1.3,
	t_b              = 5.0,
	t_acc            = 0.0,
	t_marsh          = 1800.0,
	Range_max        = 220000.0,
	H_min_t          = 0.0,
	Fi_start         = 0.25,
	Fi_rak           = 3.14152,
	Fi_excort        = 3.14152, -- 0.35,
	Fi_search        = 99.9,
	OmViz_max        = 99.9,
	Stage_           = 1,
	Engine_Type      = 5,
	X_back           = -2.566,
	Y_back           = -0.19,
	Z_back           = 0.0,
	Reflection       = 0.09,
	KillDistance     = 0.0,
	manualWeaponFlag = 2,
	LaunchDistData   =
	{
		-- launch altitude: 500m - 7500m
		-- http://www.sinaimg.cn/dy/slidenews/8_img/2011_45/22159_89924_239722.jpg
		12, 7,
		100, 125, 150, 175, 200, 250, 300,
		500, 150000, 155000, 160000, 165000, 170000, 175000, 180000,
		600, 152000, 157000, 162000, 167000, 172000, 177000, 182000,
		700, 154000, 159000, 164000, 169000, 174000, 179000, 184000,
		800, 156000, 161000, 166000, 171000, 176000, 181000, 186000,
		900, 158000, 163000, 168000, 173000, 178000, 183000, 188000,
		1000, 160000, 165000, 170000, 175000, 180000, 185000, 190000,
		1200, 163000, 168000, 173000, 178000, 183000, 188000, 193000,
		2200, 170000, 175000, 180000, 185000, 189000, 194000, 199000,
		3200, 176000, 181000, 186000, 191000, 194000, 199000, 204000,
		4200, 181000, 186000, 191000, 196000, 199000, 203000, 208000,
		5200, 185000, 190000, 195000, 199000, 203000, 207000, 212000,
		7500, 190000, 195000, 200000, 204000, 208000, 212000, 217000,

	},
	warhead          = {
		mass                 = 2000000,
		caliber              = 360,
		expl_mass            = 1.7 * 2000000,
		piercing_mass        = 0.0,
		other_factors        = { 1.0, 1.0, 1.0 },
		concrete_factors     = { 3.0, 1.0, 1.0 },
		concrete_obj_factor  = 2.0,
		obj_factors          = { 3.0, 1.0 },
		cumulative_factor    = 2.0,
		cumulative_thickness = 0.0,
	},
	warhead_air      = {
		mass                 = 2000000,
		caliber              = 360,
		expl_mass            = 1.7 * 1000,
		piercing_mass        = 0.0,
		other_factors        = { 1.0, 1.0, 1.0 },
		concrete_factors     = { 3.0, 1.0, 1.0 },
		concrete_obj_factor  = 2.0,
		obj_factors          = { 3.0, 1.0 },
		cumulative_factor    = 2.0,
		cumulative_thickness = 0.0,
	},
	--add_attributes = {"Anti-Ship missiles"},
	add_attributes   = { "Cruise missiles" },
	shape_table_data = {
		{
			name     = LSWM_AA.shape_table_data[1].name,
			file     = LSWM_AA.shape_table_data[1].file,
			life     = LSWM_AA.shape_table_data[1].life,
			fire     = LSWM_AA.shape_table_data[1].fire,
			username = 'LSWM_AS',
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	--scheme          = "anti_ship_missile_prog_path_stpos_ctrl",
	scheme           = "Harpoon",
	class_name       = "wAmmunitionAntiShip",
	fm               = {
		mass       = 1000,
		caliber    = 0.36,
		cx_coeff   = { 1, 0.3, 0.65, 0.018, 1.6 },
		L          = 5.145,
		I          = 1 / 12 * 1000 * 5.145 * 5.145,
		Ma         = 0.6,
		Mw         = 1.116,
		wind_sigma = 0.0,
		wind_time  = 1000.0,
		Sw         = 0.7,
		dCydA      = { 0.07, 0.036 },
		A          = 0.5,
		maxAoa     = 0.3,
		finsTau    = 0.05,
		Ma_x       = 3,
		Ma_z       = 3,
		Kw_x       = 0.05,
	},
	seeker           = {
		delay                      = 0.0,
		op_time                    = 9999.0,
		FOV                        = math.rad(60.0),
		max_w_LOS                  = 0.06,
		max_target_speed           = 33.0,
		max_target_speed_rnd_coeff = 10.0,
		ship_track_by_default      = 1,
		flag_dist                  = 5000.0,
		sens_near_dist             = 10.0,
		sens_far_dist              = 64000.0,
		primary_target_filter      = 1,
		add_y                      = 3.0,
		sens_ref_rcs               = 10000.0,
		sens_ref_dist              = 32000.0,
		ship_l_error_k             = 0.33,

		min_detectable_rcs         = 50.0,
		max_small_target_rcs       = 29999.999,
		min_large_target_rcs       = 60000.0,
	},
	autopilot        = --inertial autopilot + horiz correction when seeker is on
	{
		glide_height                = 20.0,
		dont_climb_on_cruise_height = 1,
		vel_proj_div                = 6.0,
		default_glide_height        = 1524,
		pre_maneuver_glide_height   = 12,
		skim_glide_height           = 8,
		use_start_bar_height        = 1,
		altim_vel_k                 = 4,
		min_glide_height            = 15,

		delay                       = 1.0,
		op_time                     = 9999,
		Kw                          = 3.5,
		Ks                          = 0.9,
		K                           = 1.6,
		Kd                          = 0.0,
		Ki                          = 20.0, --10
		Kx                          = 0.04,
		Kdx                         = 0.001,
		w_limit                     = math.rad(5),
		fins_limit                  = math.rad(50),
		fins_limit_x                = math.rad(25),
		rotated_WLOS_input          = 0,
		conv_input                  = 0,
		PN_dist_data                = { 2000, 0,
			500, 0 },

		max_climb_angle             = math.rad(10),
		max_dive_angle              = math.rad( -25),
		max_climb_ang_hdiff         = 200,
		max_dive_ang_hdiff          = -500,

		Ksd                         = 0.0,
		Ksi                         = 0.0,
		integr_val_limit            = 0.5,
		hor_err_limit               = 0.5,
		max_climb_vel               = 200,
		min_climb_vel               = 120,
		min_climb_vel_factor        = 0,
		max_climb_h                 = 3000,
		min_climb_h                 = 10000,
		min_climb_h_factor          = 0.5,

		inertial_km_error           = 0.15,
		glide_height_eq_error       = 0.02, -- percent
		glide_height_abs_error      = 1.5,
	},
	final_autopilot  = -- final stage guidance with terminal maneuver
	{
		delay                  = 1.0,
		op_time                = 9999,
		Kw                     = 1.0,
		Ks                     = 5.0,
		K                      = 5.4,
		Kd                     = 0.0,
		Ki                     = 0.0,
		Kx                     = 0.0,
		Kix                    = 0.0,
		w_limit                = math.rad(15),
		fins_limit             = math.rad(50),
		rotated_WLOS_input     = 0,
		conv_input             = 0,
		PN_dist_data           = { 2000, 1,
			500, 1 },

		add_err_val            = 0,
		add_err_vert           = 0,
		add_out_val            = 0.1,
		add_out_vert           = 1,
		loft_angle             = math.rad(8),
		loft_trig_angle        = math.rad(14),
		K_loft_err             = 1,
		loft_angle_vert        = 1,
		loft_active_by_default = 0,
	},
	triggers_control = {
		sensor_tg_dist                          = 20000, -- turn on seeker and start horiz. correction if target is locked
		final_maneuver_tg_dist                  = 9000,
		straight_nav_tg_dist                    = 5000,
		self_destruct_tg_dist                   = 4000, -- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		target_upd_jump_dist                    = 20000,
		update_pos_from_input                   = 0,
		can_increase_tg_dist                    = 1,

		send_final_maneuver_by_default          = 0,
		final_maneuver_trig_v_lim               = 3,
		use_horiz_dist                          = 1,
		pre_maneuver_glide_height               = 20,

		check_self_destruct_dist_with_no_target = 1,
	},
	controller       = {
		boost_start = 0,
		march_start = 1.0,
	},
	boost            = { --    air launch - no booster
		impulse                         = 0,
		fuel_mass                       = 0,
		work_time                       = 0,
		boost_time                      = 0,
		boost_factor                    = 0,
		nozzle_position                 = { { 0, 0, 0 } },
		nozzle_orientationXYZ           = { { 0, 0, 0 } },
		tail_width                      = 0.0,
		smoke_color                     = { 0.0, 0.0, 0.0 },
		smoke_transparency              = 0.0,
		custom_smoke_dissipation_factor = 0.0,
	},
	march            = {
		impulse                         = 700,
		fuel_mass                       = 2000,
		work_time                       = 9999,
		min_fuel_rate                   = 0.005,
		min_thrust                      = 0,
		max_thrust                      = 6000,
		thrust_Tau                      = 0.0017,

		nozzle_position                 = { { -2.566, -0.19, 0.0 } },
		nozzle_orientationXYZ           = { { 0.0, 0.0, 0.0 } },
		tail_width                      = 0.5,
		smoke_color                     = { 0.0, 0.0, 0.0 },
		smoke_transparency              = 0.2,
		custom_smoke_dissipation_factor = 0.2,

		start_burn_effect               = 0,
		start_effect_delay              = { 0.0, 0.3, 0.8 },
		start_effect_time               = { 0.7, 1.0, 0.1 },
		start_effect_size               = { 0.09, 0.104, 0.11 },
		start_effect_smoke              = { 0.01, 0.4, 0.01 },
		start_effect_x_pow              = { 1.0, 1.0, 1.0 },
		start_effect_x_dist             = { 1.1, 0.9, 0.0 },
		start_effect_x_shift            = { 0.15, 0.15, 0.2 },
	},
	engine_control   = {
		default_speed = 300,
		K             = 265,
		Kd            = 0.01,
		Ki            = 0.001,
		speed_delta   = 5,
		--burst_signal     = 9999, -- used in 'anti_ship_missile_tb' scheme
	},
}
declare_weapon(LSWM_AS)

local LSWM_AG = {
	category               = CAT_MISSILES,
	name                   = 'LSWM_AG',
	model                  = 'agm-154c',
	user_name              = _('LSWM 远距离震荡波导弹AG'),
	wsTypeOfWeapon         = { 4, 4, 8, WSTYPE_PLACEHOLDER },
	mass                   = LSWM_AS.mass,
	Escort                 = 0,
	Head_Type              = 3,
	sigma                  = { 10, 10, 10 },
	M                      = LSWM_AS.mass,
	H_max                  = 25000.0,
	H_min                  = -1.0,
	Diam                   = 203.0,
	Cx_pil                 = 2,
	D_max                  = 80000.0,
	D_min                  = 700.0,
	Head_Form              = 1,
	Life_Time              = LSWM_AS.Life_Time,
	Nr_max                 = 25,
	v_min                  = LSWM_AS.v_min,
	v_mid                  = LSWM_AS.v_mid,
	Mach_max               = 1.2,
	t_b                    = 0.0,
	t_acc                  = LSWM_AA.t_acc,
	t_marsh                = LSWM_AA.t_marsh,
	Range_max              = LSWM_AA.Range_max,
	H_min_t                = 1.0,
	Fi_start               = 0.5236,
	Fi_rak                 = 3.14152,
	Fi_excort              = 1.05,
	Fi_search              = 1.05,
	OmViz_max              = 0.52,
	exhaust                = LSWM_AA.exhaust,
	X_back                 = LSWM_AA.X_back,
	Y_back                 = LSWM_AA.Y_back,
	Z_back                 = LSWM_AA.Z_back,
	Reflection             = 0.02,
	KillDistance           = 20.0,
	nozzle_exit_area       = 0.01219,
	Engine_Type            = LSWM_AS.Engine_Type,
	shape_table_data       = {
		{
			name     = 'LSWM_AG',
			file     = LSWM_AA.shape_table_data[1].file,
			life     = LSWM_AA.shape_table_data[1].life,
			fire     = LSWM_AA.shape_table_data[1].fire,
			username = 'LSWM_AG',
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	warhead                = LSWM_AS.warhead,
	warhead_air            = LSWM_AS.warhead,
	LaunchDistData         =
	{
		9, 6,
		100, 150, 200, 250, 300, 350,
		1000, 22000, 23000, 26000, 26000, 27000, 30000,
		2000, 27000, 29000, 32000, 35000, 37000, 40000,
		4000, 32000, 35000, 37000, 40000, 42000, 45000,
		6000, 37000, 40000, 43000, 45000, 47000, 50000,
		7000, 43000, 45000, 47000, 50000, 55000, 60000,
		8000, 45000, 47000, 50000, 55000, 60000, 65000,
		9000, 50000, 52500, 55000, 58000, 65000, 70000,
		10000, 60000, 62500, 65000, 68000, 70000, 75000,
		12000, 65000, 66000, 67000, 70000, 75000, 80000,
	},
	class_name             = "wAmmunitionSelfHoming",
	scheme                 = "anti_radiation_missile2",
	controller             = {
		march_start = 0.021,
	},
	march                  = {
		impulse                         = 205,
		fuel_mass                       = 7000,
		work_time                       = 600,
		boost_time                      = 0,
		boost_factor                    = 0,
		nozzle_position                 = { { -1.74, -0.11, 0 } },
		nozzle_orientationXYZ           = { { 0.0, 0.0, 0.0 } },
		nozzle_exit_area                = 0.01219,
		tail_width                      = 1,
		smoke_color                     = { 0.6, 0.6, 0.6 },
		smoke_transparency              = 0.8,
		custom_smoke_dissipation_factor = 0.2,
	},
	fm                     = {
		mass       = 1000,
		caliber    = 0.203,
		cx_coeff   = { 1, 0.4, 1.1, 0.5, 1.4 },
		L          = 3.8,
		I          = 1 / 12 * 1000 * 3.8 * 3.8,
		Ma         = 0.3,
		Mw         = 1.116,
		wind_sigma = 0.0,
		wind_time  = 0.0,
		Sw         = 0.85,
		dCydA      = { 0.07, 0.036 },
		A          = 0.36,
		maxAoa     = 0.88,
		finsTau    = 0.1,

		Ma_x       = 0.001,
		Kw_x       = 0.001,
		--I_x         = 50,
	},
	proximity_fuze         = {
		radius    = 8,
		arm_delay = 1.6,
	},
	radio_seeker           = {
		FOV              = math.rad(60),
		op_time          = 150,
		keep_aim_time    = 80,
		pos_memory_time  = 600,
		sens_near_dist   = 200.0,
		sens_far_dist    = 120000.0,
		err_correct_time = 1.0,
		err_val          = 0.001,
		lock_err_val     = 0.0,
		calc_aim_dist    = 500000,
		blind_rad_val    = 0.2,
		blind_ctrl_dist  = 1000,
		aim_y_offset     = 2.0,
		min_sens_rad_val = 0.00025,
	},
	simple_gyrostab_seeker = {
		omega_max = math.rad(12)
	},
	fuze_proximity         = {
		ignore_inp_armed = 1,
		arm_delay        = 10,
		radius           = 10,
	},
	autopilot              = {
		K                = 100.0,
		Kg               = 6.0,
		Ki               = 0.0,
		finsLimit        = 0.22,
		useJumpByDefault = 1,
		J_Power_K        = 1.2,
		J_Diff_K         = 0.4,
		J_Int_K          = 0.0,
		J_Angle_K        = math.rad(12),
		J_FinAngle_K     = math.rad(18),
		J_Angle_W        = 3.5,
		delay            = 1.0,
	},
	start_helper           = {
		delay           = 0.2,
		power           = 0.02,
		time            = 2,
		use_local_coord = 0,
		max_vel         = 200,
		max_height      = 400,
		vh_logic_or     = 1,
	}
}
declare_weapon(LSWM_AG)

declare_loadout({
	CLSID             = '{Aspide_MK1}',
	category          = CAT_AIR_TO_AIR,
	Picture           = "us_AIM-7.png",
	PictureBlendColor = "0xffffffff",
	displayName       = Aspide_MK1.user_name,
	Weight            = Aspide_MK1.mass,
	attribute         = Aspide_MK1.wsTypeOfWeapon,
	Elements          =
	{
		[1] =
		{
			DrawArgs =
			{
				[1] = { 1, 1 },
				[2] = { 2, 1 },
				[3] = { 3, 1 },
			}, -- end of DrawArgs
			Position = { 0, 0, 0 },
			ShapeName = Aspide_MK1.model,
		},
	}, -- end of Elements
})

declare_loadout({
	CLSID             = '{LSWM_AA}',
	category          = CAT_AIR_TO_AIR,
	Picture           = "AGM154.png",
	PictureBlendColor = "0xffffffff",
	displayName       = LSWM_AA.user_name,
	Weight            = LSWM_AA.mass,
	attribute         = LSWM_AA.wsTypeOfWeapon,
	Elements          =
	{
		[1] =
		{
			DrawArgs =
			{
				[1] = { 1, 1 },
				[2] = { 2, 1 },
				[3] = { 3, 1 },
			}, -- end of DrawArgs
			Position = { 0, 0, 0 },
			ShapeName = LSWM_AA.model,
		},
	}, -- end of Elements
})
declare_loadout({
	category       = CAT_AIR_TO_AIR,
	CLSID          = "{3*LSWM_AA}",
	Picture        = "AGM154.png",
	adapter_type   = { wsType_Weapon, wsType_GContainer, wsType_Support, 4 },
	Cx_pil         = 0.001959765625,
	displayName    = _("3*" .. LSWM_AA.user_name .. ""),
	Count          = 3,
	Elements       =
	{
		[1] =
		{
			ShapeName = "LAU-88",
			Position  = { 0, 0, 0 },
		},
		[2] =
		{
			Position      = { 0.29, -0.31, 0 },
			Rotation      = { 0, 0, 0 },
			payload_CLSID = "{LSWM_AA}",
		},
		[3] =
		{
			Position      = { 0.29, -0.085, 0.275 },
			Rotation      = { -90, 0, 0 },
			payload_CLSID = "{LSWM_AA}",
		},
		[4] =
		{
			Position      = { 0.29, -0.085, -0.275 },
			Rotation      = { 90, 0, 0 },
			payload_CLSID = "{LSWM_AA}",
		}
	},
	Weight         = 100,
	Weight_Empty   = 30,
	wsTypeOfWeapon = LSWM_AA.wsTypeOfWeapon,
	attribute      = { 4, 4, 32, WSTYPE_PLACEHOLDER },
})
declare_loadout({
	CLSID             = '{LSWM_AS}',
	category          = LSWM_AS.category,
	Picture           = "AGM154.png",
	PictureBlendColor = "0xffffffff",
	displayName       = LSWM_AS.user_name,
	Weight            = LSWM_AS.mass,
	attribute         = LSWM_AS.wsTypeOfWeapon,
	Elements          =
	{
		[1] =
		{
			DrawArgs =
			{
				[1] = { 1, 1 },
				[2] = { 2, 1 },
				[3] = { 3, 1 },
			}, -- end of DrawArgs
			Position = { 0, 0, 0 },
			ShapeName = LSWM_AS.model,
		},
	}, -- end of Elements
})
declare_loadout({
	category       = LSWM_AS.category,
	CLSID          = "{3*LSWM_AS}",
	Picture        = "AGM154.png",
	adapter_type   = { wsType_Weapon, wsType_GContainer, wsType_Support, 4 },
	Cx_pil         = 0.001959765625,
	displayName    = _("3*" .. LSWM_AS.user_name .. ""),
	Count          = 3,
	Elements       =
	{
		[1] =
		{
			ShapeName = "LAU-88",
			Position  = { 0, 0, 0 },
		},
		[2] =
		{
			Position      = { 0.29, -0.31, 0 },
			Rotation      = { 0, 0, 0 },
			payload_CLSID = "{LSWM_AS}",
		},
		[3] =
		{
			Position      = { 0.29, -0.085, 0.275 },
			Rotation      = { -90, 0, 0 },
			payload_CLSID = "{LSWM_AS}",
		},
		[4] =
		{
			Position      = { 0.29, -0.085, -0.275 },
			Rotation      = { 90, 0, 0 },
			payload_CLSID = "{LSWM_AS}",
		}
	},
	Weight         = 100,
	Weight_Empty   = 30,
	wsTypeOfWeapon = LSWM_AS.wsTypeOfWeapon,
	attribute      = { 4, 4, 32, WSTYPE_PLACEHOLDER },
})
declare_loadout({
	CLSID             = '{LSWM_AG}',
	category          = LSWM_AG.category,
	Picture           = "AGM154.png",
	PictureBlendColor = "0xffffffff",
	displayName       = LSWM_AG.user_name,
	Weight            = LSWM_AG.mass,
	attribute         = LSWM_AG.wsTypeOfWeapon,
	Elements          =
	{
		[1] =
		{
			DrawArgs =
			{
				[1] = { 1, 1 },
				[2] = { 2, 1 },
				[3] = { 3, 1 },
			}, -- end of DrawArgs
			Position = { 0, 0, 0 },
			ShapeName = LSWM_AG.model,
		},
	}, -- end of Elements
})
declare_loadout({
	category       = LSWM_AG.category,
	CLSID          = "{3*LSWM_AG}",
	Picture        = "AGM154.png",
	adapter_type   = { wsType_Weapon, wsType_GContainer, wsType_Support, 4 },
	Cx_pil         = 0.001959765625,
	displayName    = _("3*" .. LSWM_AG.user_name .. ""),
	Count          = 3,
	Elements       =
	{
		[1] =
		{
			ShapeName = "LAU-88",
			Position  = { 0, 0, 0 },
		},
		[2] =
		{
			Position      = { 0.29, -0.31, 0 },
			Rotation      = { 0, 0, 0 },
			payload_CLSID = "{LSWM_AG}",
		},
		[3] =
		{
			Position      = { 0.29, -0.085, 0.275 },
			Rotation      = { -90, 0, 0 },
			payload_CLSID = "{LSWM_AG}",
		},
		[4] =
		{
			Position      = { 0.29, -0.085, -0.275 },
			Rotation      = { 90, 0, 0 },
			payload_CLSID = "{LSWM_AG}",
		}
	},
	Weight         = 100,
	Weight_Empty   = 30,
	wsTypeOfWeapon = LSWM_AG.wsTypeOfWeapon,
	attribute      = { 4, 4, 32, WSTYPE_PLACEHOLDER },
})
