local start_custom_command   = 10000
local __count_custom = start_custom_command-1
local function __custom_counter()
	__count_custom = __count_custom + 1
	return __count_custom
end
Keys =
{
	PlaneChangeWaypoint						= 102,
	PlaneBrightnessILS						= 156,
	PlaneNightVisionGogglesOnOff			= 438,
	
	--[[HOTAS--]]
	HOTAS_CoolieUp	 = 539,
	HOTAS_CoolieDown = 540,
	HOTAS_CoolieLeft = 541,
	HOTAS_CoolieRight= 542,
	HOTAS_CoolieOff  = 543,
	
	HOTAS_TargetManagementSwitchUp	  = 544,
	HOTAS_TargetManagementSwitchDown  = 545,
	HOTAS_TargetManagementSwitchLeft  = 546,
	HOTAS_TargetManagementSwitchRight = 547,
	HOTAS_TargetManagementSwitchOff   = 548,

	HOTAS_DataManagementSwitchUp   = 549,
	HOTAS_DataManagementSwitchDown = 550,
	HOTAS_DataManagementSwitchLeft = 551,
	HOTAS_DataManagementSwitchRight= 552,
	HOTAS_DataManagementSwitchOff  = 553,
	
	

	
	
--from iCommand.h
	PlaneSAUAutomatic = 58,				-- Стабилизация углов
	PlaneSAUHBarometric = 59,			-- Стабилизация абсолютной высоты
	PlaneSAUHRadio = 60,			-- Полет с огибанием рельефа
	PlaneSAUHorizon = 61,				-- Приведение к горизонту
	PlaneAutopilot = 62,					-- Автопилот
	PlaneAUTOnOff = 63,					-- Переключение режима АУТ
	PlaneAUTIncrease = 64,				-- Увеличить заданную скорость
	PlaneAUTDecrease = 65,				-- Уменьшить заданную скорость
	PlaneGear = 68,						-- Шасси
	PlaneHook = 69,						-- Гак
	PlanePackWing = 70,				-- Складывание крыльев
	PlaneFonar = 71,						-- Фонарь
	PlaneFlaps = 72,						-- Закрылки
	PlaneAirBrake = 73,					-- Воздушный тормоз
	PlaneWheelBrakeOn = 74,				-- Включение тормоза колес
	PlaneWheelBrakeOff = 75,				-- Выключение тормоза колес
	PlaneParachute = 76,					-- Парашют
	PlaneDropSnar = 77,					-- Сброс ловушек
	PlaneWingtipSmokeOnOff = 78,			-- Вкл/выкл дымовых шашек на концах крыльев
	PlaneFuelOn = 79,					-- Включение слива топлива или заправки
	PlaneFuelOff = 80,				-- Выключение слива топлива или заправки
	PlaneSalvoOnOff = 81,				-- Залповый режим вкл/выкл
	PlaneJettisonWeapons = 82,			-- Сброс оружия парами
	PlaneEject = 83,						-- Катапультирование
	PlaneFire = 84,						-- Гашетка
	PlaneFireOff = 85,					-- Гашетку отпустили
	PlaneRadarOnOff = 86,				-- Включение / выключение радара
	PlaneEOSOnOff = 87,					-- Включение / выключение ОЛС
	PlaneRadarLeft = 88,					-- Поворот антенны РЛС влево
	PlaneRadarRight = 89,				-- Поворот антенны РЛС вправо
	PlaneRadarUp = 90,				-- Поворот антенны РЛС вверх
	PlaneRadarDown = 91,					-- Поворот антенны РЛС вниз
	PlaneRadarCenter = 92,				-- Возврат антенны РЛС в центр
	PlaneTrimLeft = 93,					-- Триммер влево
	PlaneTrimRight = 94,					-- Триммер вправо
	PlaneTrimUp = 95,					-- Триммер вверх
	PlaneTrimDown = 96,					-- Триммер вниз
	PlaneTrimCancel = 97,				-- Сброс триммера
	PlaneTrimLeftRudder = 98,			-- Триммер левой педали
	PlaneTrimRightRudder = 99,			-- Триммер правой педали
	PlaneChangeLock = 100,			-- Переключение подрежимов / захват
	PlaneChangeWeapon = 101,				-- Переключение подрежимов / перебор оружия
	PlaneChangeTarget = 102,				-- Перебор целей
	PlaneZoomIn = 103,					-- Изменение масштаба МФД +
	PlaneZoomOut = 104,					-- Изменение масштаба МФД -
	PlaneModeNAV = 105,					-- Переход в режим навигации
	PlaneModeBVR = 106,					-- Переход в режим дальнего воздушного боя
	PlaneModeVS = 107,					-- Переход в режим ближнего воздушного боя (полоса)
	PlaneModeBore = 108,					-- Переход в режим ближнего воздушного боя (кольцо)
	PlaneModeHelmet = 109,				-- Переход в режим ближнего воздушного боя (шлем)
	PlaneModeFI0 = 110,				-- Переход в режим FI0
	PlaneModeGround = 111,				-- Переход в режим атаки наземных целей
	PlaneModeGrid = 112,					-- Переход в режим "сетка"
	PlaneModeCannon = 113,				-- Включение/выключение пушки
	PlaneDoAndHome = 114,					-- Выполни задание и вернись на базу
	PlaneDoAndBack = 115,					-- Выполни задание и вернись ко мне
	PlaneFormation = 116,					-- Идти рассеянным/плотным строем
	PlaneJoinUp    = 117,					-- Собраться
	PlaneAttackMyTarget = 118,			-- Атакуй мою цель
	PlaneCoverMySix = 119,				-- Прикрой меня сзади
	PlaneShipTakeOff = 120,			-- Хочу взлететь с авианосца

	ActiveJamming = 136,
	LandDetailsIncrease = 137,			-- Отладочное увеличение детализации (Non-simulation Action)
	LandDetailsDecrease = 138,			-- Отладочное уменьшение детализации (Non-simulation Action)
	SelecterLeft = 139,				    -- движение маркера захвата целей на HUD влево
	SelecterRight = 140,			-- вправо
	SelecterUp  =141,					    -- вверх
	SelecterDown = 142,					-- вниз
	RefusalTWS = 143,						-- отказ от СНП
	PlaneResetMasterWarning = 144,
	PlaneFlapsOn = 145,
	PlaneFlapsOff = 146,
	PlaneAirBrakeOn = 147,
	PlaneAirBrakeOff = 148,
	PlaneAirRefuel = 155,				-- Переключатель положения штанги заправки
	BrightnessILS = 156,				-- Яркость ILS
	PlaneAUTIncreaseLeft = 161,
	PlaneAUTDecreaseLeft = 162,
	PlaneAUTIncreaseRight = 163,
	PlaneAUTDecreaseRight = 164,
	PlaneLightsOnOff = 175,			-- Вкл/выкл огни на своем самолете
	PlaneDropSnarOnce = 176,			-- Однократный сброс ловушек
	PlaneJettisonFuelTanks = 178,		-- Сброс топливных баков
	PlaneWingmenCommand = 179,		-- Вызов панели команд ведомым
	PlaneDown = 186,					-- Тонкое управление автопилотом по высоте
	PlaneUp = 187,
	PlaneLeft = 188,
	PlaneRight = 189,
    PlaneUpStart = 193,
    PlaneUpStop = 194,
    PlaneDownStart = 195,
    PlaneDownStop = 196,
    PlaneLeftStart = 197,
    PlaneLeftStop = 198,
    PlaneRightStart = 199,
    PlaneRightStop = 200,
    PlaneLeftRudderStart = 201,
    PlaneLeftRudderStop = 202,
    PlaneRightRudderStart = 203,
    PlaneRightRudderStop = 204,
    PlaneTrimStop = 215,
    SelecterUpRight = 226,
    SelecterDownRight = 227,
    SelecterDownLeft = 228,
    SelecterUpLeft = 229,
    SelecterStop = 230,
    PlaneRadarUpRight = 231,
    PlaneRadarDownRight = 232,
    PlaneRadarDownLeft = 233,
    PlaneRadarUpLeft = 234,
    PlaneRadarStop = 235,
	PlaneHUDFilterOnOff = 247,			-- Поднять/опустить светофильтр ИЛС (Ka-50)
	PlaneMasterCaution = 252,				-- Аналог "Экран вызов" (МиГ-29), кнопка-лампа ЦСО (Ка-50)
	PlaneScalesReject	= 253,				-- Scales reject / огранич. индикац. на ИЛС (Ка-50)
	PlaneBettyRepeat = 254,				-- Repeat Betty messages (Rf-50)
	ThreatMissilePadlock = 258,
	AllMissilePadlock = 259,
	DecreaseRadarScanArea = 262,
    IncreaseRadarScanArea = 263,
	AWACSHomeBearing = 267,
	AWACSTankerBearing = 268,
	AWACSBanditBearing = 269,
    AWACSDeclare = 270,
    EasyRadarOnOff = 271,
    AutoLockOnNearestAircraft = 272,
    AutoLockOnCenterAircraft = 273,
    AutoLockOnNextAircraft = 274,
    AutoLockOnPreviousAircraft = 275,
    AutoLockOnNearestSurfaceTarget = 276,
    AutoLockOnCenterSurfaceTarget = 277,
    AutoLockOnNextSurfaceTarget = 278,
    AutoLockOnPreviousSurfaceTarget = 279,
	ChangeGunRateOfFire = 280,
	ChangeRippleQuantity = 281,
	ChangeRippleInterval = 282,
	SwitchMasterArm = 283,
	ChangeReleaseMode = 284,
    PlaneRadarChangeMode = 285,
	ChangeRWRMode = 286,
	FlightClockReset = 288,
	PlaneCockpitIllumination = 300,
	ChangeRippleIntervalDown = 308,		-- Изменение интервала сброса бомб в залпе для А10 в обратном направлении
	PlaneEnginesStart = 309,				-- Запуск двигателей
	PlaneEnginesStop = 310,			-- Выключение двигателей

	PlaneLeftEngineStart = 311,			-- Запуск левого двигателя
	PlaneRightEngineStart = 312,			-- Запуск правого двигателя

	PlaneLeftEngineStop = 313,				-- Выключение левого двигателя
	PlaneRightEngineStop = 314,			-- Выключение правого двигателя

	PowerOnOff = 315,					-- Включение/выключение электропитания

	AltimeterPressureIncrease = 316,	-- Увеличение давления на ВД
	AltimeterPressureDecrease = 317,	-- Уменьшение давления на ВД
	AltimeterPressureStop = 318,

	PlaneHeadLightOnOff = 328,		-- Вкл/выкл фары на передней стойке шасси
	
	PlaneLockPadlock = 329,				-- Следить за ближайшим объектом
	PlaneUnlockPadlock = 330,		-- Бросить следить за объектом

	PlaneLaunchPermissionOverride = 349,	-- Снятие блокировки с оружия
	PlanePickleOn = 350,		-- Пуск ракет/сброс бомб для западных самолетов
	PlanePickleOff = 351,
	PlaneDropFlareOnce = 357,			-- Однократный сброс ИК-ловушек
	PlaneDropChaffOnce = 358,			-- Однократный сброс дипольных отражателей

	-- CMD
	PlaneCMDDispence = 364,				-- Пассивные средства РЭБ выброс ловушек
	PlaneCMDDispenceOff = 365,
	PlaneCMDDispenceStop = 366,			-- Пассивные средства РЭБ остановка выброса ловушек
	PlaneCMDDispenceStopOff = 367,
	PlaneCMDChangeRippleQuantity = 368,	-- Пассивные средства РЭБ изменить количество в серии
	PlaneCMDChangeRippleQuantityOff = 369,
	PlaneCMDChangeRippleInterval = 370,	-- Пассивные средства РЭБ изменить интервал в серии
	PlaneCMDChangeRippleIntervalOff = 371,
	PlaneCMDChangeBurstAmount = 372,		-- Пассивные средства РЭБ изменить количество серий
	PlaneCMDChangeBurstAmountOff = 373,
	PlaneCMDCancelCurrentProgram = 374,	-- Пассивные средства РЭБ сброс программы
	PlaneCMDCancelCurrentProgramOff = 375,
	PlaneCMDChangeBoard = 376,			-- Пассивные средства РЭБ выбор борта
	PlaneCMDShowAmountOrProgram = 377,	-- Пассивные средства РЭБ смена индикации - наличие ловушек или текущая программа
	
	PlaneCancelWeaponsDelivery = 378,		-- сброс режима работы авионики (Ка - 50)
	PlaneMasterCautionOff = 379,
	PlaneStabTangBank = 386,			-- Стабилизация тангажа и крена
	PlaneStabHbarBank = 387,			-- Стабилизация Hbar и крена
	PlaneStabHorizon = 388,			-- Стабилизация тангажа и крена
	PlaneStabHbar = 389,				-- Стабилизация Hbar
	PlaneStabHrad = 390,				-- Стабилизация Hrad
	ActiveIRJamming = 391,			-- IR OnOff
	PlaneLaserRangerOnOff = 392, 		-- Вкл/Выкл лазерный дальномер
	PlaneNightTVOnOff = 393,         -- Вкл/Выкл ночной канал телевизионной системы (IR or LLTV) 
	PlaneChangeRadarPRF = 394,       -- Изменить частоту повторения импульсов радара
	PlaneStabCancel = 408,			-- Сброс всех режимов стабилизации и автопилота
	PlaneThreatWarnSoundVolumeDown = 409,	-- Уменьшение громкости звуковых сигналов СПО
	PlaneThreatWarnSoundVolumeUp = 410,	-- Увеличение громкости звуковых сигналов СПО
	ViewLaserOnOff = 411,
	PlaneIncreaseBase_Distance = 412,     -- Увеличение базы цели
	PlaneDecreaseBase_Distance = 413,     -- Уменьшение базы цели
	PlaneStopBase_Distance = 414,
	PlaneAutopilotOverrideOn =427,
	PlaneAutopilotOverrideOff = 428,
	PlaneRouteAutopilot = 429,
	PlaneGearUp = 430,
	PlaneGearDown = 431,
	ViewNightVisionGogglesOn = 438,
	PlaneDesignate_CageOn = 439,
	PlaneDesignate_CageOff = 440,
	PlaneDesignate_CageOn_vertical = 441,
	PlaneDesignate_CageOn_horizontal = 442,

	--Data Link Panel PRTs (Пульт Режимов Целеуказания ПРЦ)
	PlaneDLK_Target1 = 443,
	PlaneDLK_Target2 = 444,
	PlaneDLK_Target3 = 445,
	PlaneDLK_RefPoint = 446,
	PlaneDLK_Wingman1 = 447,
	PlaneDLK_Wingman2 = 448,
	PlaneDLK_Wingman3 = 449,
	PlaneDLK_Wingman4 = 450,
	PlaneDLK_All = 451,
	PlaneDLK_Erase = 452,
	PlaneDLK_Ingress = 453,
	PlaneDLK_SendMemory = 454,

	-- NAV panel controls (Ка-50 - щиток ПВИ)
	PlaneNavChangePanelModeRight = 455,
	PlaneNavChangePanelModeLeft = 456,
	PlaneNavSetFixtakingMode = 457,
	PlaneNav_DLK_OnOff = 458,
	PlaneNav_PB1 = 459,
	PlaneNav_PB2 = 460,
	PlaneNav_PB3 = 461,
	PlaneNav_PB4 = 462,
	PlaneNav_PB5 = 463,
	PlaneNav_PB6 = 464,
	PlaneNav_PB7 = 465,
	PlaneNav_PB8 = 466,
	PlaneNav_PB9 = 467,
	PlaneNav_PB0 = 468,
	PlaneNav_Steerpoints = 469,
	PlaneNav_INU_realign = 470,
	PlaneNav_POS_corrMode = 471,
	PlaneNav_INU_precise_align = 472,
	PlaneNav_Airfields =473,
	PlaneNav_INU_normal_align  = 474,
	PlaneNav_Targets = 475,
	PlaneNav_Enter = 476,
	PlaneNav_Cancel = 477,
	PlaneNav_POS_init = 478,
	PlaneNav_SelfCoord = 479,
	PlaneNav_CourseTimeRange = 480,
	PlaneNav_Wind = 481,
	PlaneNav_THeadingTimeRangeF = 482,
	PlaneNav_BearingRangeT = 483,


	PlaneCockpitIlluminationPanels = 493,
	PlaneCockpitIlluminationGauges = 494,

	Plane_RouteMode = 506,
	Plane_DescentMode = 507,
	Plane_DescentModeOff = 508,

	Plane_SpotLight_left  = 511,
	Plane_SpotLight_right = 512,
	Plane_SpotLight_up	= 513,
	Plane_SpotLight_down = 514,
	Plane_SpotLight_stop = 515,

	PlaneRotorTipLights = 516,
	Plane_SpotSelect_switch = 517,
	PlaneAntiCollisionLights = 518,
	PlaneNavLights_CodeModeOn = 519,
	PlaneNavLights_CodeModeOff = 520,
	PlaneFormationLights = 521,

	Plane_EngageAirDefenses = 522,
	Plane_EngageGroundTargets = 523,

	Plane_AutomaticTracking_Gunsight_switch  = 524,
	Plane_AutomaticTurn = 526,
	Plane_GroundMovingTarget = 527,
	Plane_AirborneTarget = 528,
	Plane_HeadOnAspect = 529,
	Plane_ChangeDeliveryMode_right = 530,
	Plane_ChangeDeliveryMode_left = 531,

	Plane_WeaponMode_Manual_Auto = 532,
	Plane_WeaponMode_switch = 533,
	Plane_AmmoTypeSelect = 534,
	Plane_FireRate = 535,

	PlaneDropSnarOnceOff = 536,

	HelicopterHover = 537,
	AutopilotEmergOFF = 538,
	
	Plane_HOTAS_CoolieUp = 539,
	Plane_HOTAS_CoolieDown = 540,
	Plane_HOTAS_CoolieLeft = 541,
	Plane_HOTAS_CoolieRight = 542,
	Plane_HOTAS_CoolieOff = 543,

	Plane_HOTAS_TargetManagementSwitchUp = 544,
	Plane_HOTAS_TargetManagementSwitchDown = 545,
	Plane_HOTAS_TargetManagementSwitchLeft = 546,
	Plane_HOTAS_TargetManagementSwitchRight = 547,
	Plane_HOTAS_TargetManagementSwitchOff = 548,

	Plane_HOTAS_DataManagementSwitchUp = 549,
	Plane_HOTAS_DataManagementSwitchDown = 550,
	Plane_HOTAS_DataManagementSwitchLeft = 551,
	Plane_HOTAS_DataManagementSwitchRight = 552,
	Plane_HOTAS_DataManagementSwitchOff = 553,
	
	Plane_HOTAS_TriggerSecondStage = 554,
	Plane_HOTAS_TriggerFirstStage = 555,
	
	Plane_HOTAS_CMS_Up = 556,
	Plane_HOTAS_CMS_Down = 557,
	Plane_HOTAS_CMS_Left = 558,
	Plane_HOTAS_CMS_Right = 559,
	Plane_HOTAS_CMS_Off = 560,

	Plane_HOTAS_MasterModeControlButton = 561,
	Plane_HOTAS_NoseWheelSteeringButton = 562,
	Plane_HOTAS_NoseWheelSteeringButtonOff = 606,
	
	Plane_HOTAS_BoatSwitchForward = 563,
	Plane_HOTAS_BoatSwitchAft = 564,
	Plane_HOTAS_BoatSwitchCenter = 565,
	
	Plane_HOTAS_ChinaHatForward = 566,
	Plane_HOTAS_ChinaHatAft = 567,
	Plane_HOTAS_ChinaHatOff = 589,

	Plane_HOTAS_PinkySwitchForward = 568,
	Plane_HOTAS_PinkySwitchAft = 569,
	Plane_HOTAS_PinkySwitchCenter = 570,

	Plane_HOTAS_LeftThrottleButton = 571,

	Plane_HOTAS_MIC_SwitchUp = 572,
	Plane_HOTAS_MIC_SwitchDown = 573,
	Plane_HOTAS_MIC_SwitchLeft = 574,
	Plane_HOTAS_MIC_SwitchRight = 575,
	Plane_HOTAS_MIC_SwitchOff = 576,

	Plane_HOTAS_SpeedBrakeSwitchForward = 577,
	Plane_HOTAS_SpeedBrakeSwitchAft = 578,
	Plane_HOTAS_SpeedBrakeSwitchCenter = 579,
	
	Plane_HOTAS_MasterModeControlButtonUP = 633,
	
	Plane_HOTAS_TDC_depress_on  = 634,
	Plane_HOTAS_TDC_depress_off = 635,

	Plane_HOTAS_TriggerSecondStage_Off = 638,
	Plane_HOTAS_TriggerFirstStage_Off  = 639,
	
	Plane_HOTAS_CMS_Zaxis 		= 1041,
	Plane_HOTAS_CMS_Zaxis_Off 	= 1042,

	Plane_HOTAS_BoatSwitchOff	= 822,
	Plane_HOTAS_BoatSwitchForwardMomentary = 823,
	Plane_HOTAS_BoatSwitchAftMomentary = 824,

	Plane_HOTAS_LeftThrottleButton_Off = 1557,
--end
	PlaneThrustCommon = 2004,
	PlaneThrustLeft = 2005,
	PlaneThrustRight = 2006,
-- analog commands
	PlaneRadarHorizontal 	   = 2025,
	PlaneRadarVertical 		   = 2026,
	PlaneRadarHorizontalAbs    = 2027,
	PlaneRadarVerticalAbs 	   = 2028,
	PlaneMFDZoom 		       = 2029,
	PlaneMFDZoomAbs			   = 2030,
	PlaneSelecterHorizontal    = 2031,
	PlaneSelecterVertical 	   = 2032,
	PlaneSelecterHorizontalAbs = 2033,
	PlaneSelecterVerticalAbs   = 2034,
	PlaneBase_Distance 		   = 2040,
	PlaneBase_DistanceAbs 	   = 2041,
	
		
	
	LampsControl							= 762,
	LampsControl_up							= 800,
	-- 自定义按键从这里开始，可以自动从10000开始增加，避免冲突 --
    ThrottleAxis = __custom_counter(),  --油门位置
    EnginesStart = __custom_counter(), --自定义引擎启动输入
	Starter = __custom_counter(),--起动机
	LeftEngineStart = __custom_counter(),--左发启动
	RightEngineStart = __custom_counter(),--右发启动
    EnginesStop = __custom_counter(), --自定义引擎关闭输入
	LeftEngineStop = __custom_counter(),--左发停止
	RightEngineStop = __custom_counter(),--右发停止
    EnginesStartStop = __custom_counter(), --自定义引擎开关按下
    EnginesStartStopUp = __custom_counter(), --自定义引擎开关松开

    BrakesOn = __custom_counter(), --自定义刹车
    BrakesOff = __custom_counter(), --自定义刹车关闭

    DragParachute = __custom_counter(), --自定义减速伞释放

    --PlaneFlapsStop = __custom_counter(),      --目前屏蔽手动缝翼
    --PlaneFlapsUpHotas = __custom_counter(),   --
    --PlaneFlapsDownHotas = __custom_counter(), --
    
    SpoilersArmToggle = __custom_counter(),
    SpoilersArmOn = __custom_counter(),
    SpoilersArmOff = __custom_counter(),
    WeaponLaunchOn		= __custom_counter(), -- replaces iCommandPlaneFire
    WeaponLaunchOff	= __custom_counter(), -- replaces iCommandPlaneFireOff
    PickleOn = __custom_counter(),  -- replaces iCommandPlanePickleOn
    PickleOff = __custom_counter(), -- replaces iCommandPlanePickleOff

    -- 武器测试用按键
    WeaponSelectNext = __custom_counter(),
    WeaponLaunch = __custom_counter(),

    -- 襟翼动作
    FlapUp = __custom_counter(),
    FlapDown = __custom_counter(),

    ParkingBrakesOn = __custom_counter(),
    ParkingBrakesOff = __custom_counter(),
    ParkingBrakes = __custom_counter(),

    LeftThrottleAxis = __custom_counter(),
    RightThrottleAxis = __custom_counter(),

    LeftThrottleCrank = __custom_counter(),
    RightThrottleCrank = __custom_counter(),

    LeftThrottleCrankUP = __custom_counter(),
    RightThrottleCrankUP = __custom_counter(),

    LeftSpeedDriveUP = __custom_counter(),
    RightSpeedDriveUP = __custom_counter(),

    LeftSpeedDriveDOWN = __custom_counter(),
    RightSpeedDriveDOWN = __custom_counter(),

    NWWSwitch = __custom_counter(),
    CSDSwitch = __custom_counter(),
    AirCondSwitch = __custom_counter(),

    FuelMasterLeft = __custom_counter(),
    FuelMasterRight = __custom_counter(),

    LeftEngineIDLE = __custom_counter(),
    RightEngineIDLE = __custom_counter(),
    
    FuelDisMain = __custom_counter(),
    FuelDisWing = __custom_counter(),
    FuelDisCtr = __custom_counter(),
    FuelDisLout = __custom_counter(),
    FuelDisLin = __custom_counter(),
    FuelDisRin = __custom_counter(),
    FuelDisRout = __custom_counter(),

    FuelTankPressUP = __custom_counter(),
    WingDropTankTransUP = __custom_counter(),
    FuelTankPressDOWN = __custom_counter(),
    WingDropTankTransDOWN = __custom_counter(),
    WingTankDump = __custom_counter(),
    FuseTankDump = __custom_counter(),
    FuelReadyUP = __custom_counter(),
    BoostPumpTestUP = __custom_counter(),
    FuelReadyDOWN = __custom_counter(),
    BoostPumpTestDOWN = __custom_counter(),

    LightStrobeUP = __custom_counter(),
    LightStrobeDOWN = __custom_counter(),
    LightTaxiDOWN = __custom_counter(),
    LightTaxiUP = __custom_counter(),
    LightNaviWingUP = __custom_counter(),
    LightNaviWingDOWN = __custom_counter(),
    LightNaviTailUP = __custom_counter(),
    LightNaviTailDOWN = __custom_counter(),
    LightFormationUP = __custom_counter(),
    LightFormationDOWN = __custom_counter(),
    LightFloodUP = __custom_counter(),
    LightFloodDOWN = __custom_counter(),
	LightFlood = __custom_counter(),

    LightConsoleBRT = __custom_counter(),
    LightInstruBRT = __custom_counter(),
    LightApproIndexBRT = __custom_counter(),

    AutoPilotPowerSwitch = __custom_counter(),
    AutoPilotStabSwitch = __custom_counter(),
    AutoPilotCmdSwitch = __custom_counter(),
    AutoPilotAltHoldSwitch = __custom_counter(),
    AutoPilotMachHoldSwitch = __custom_counter(),

    -- ECS aircondition
    AircondMasterSwitch = __custom_counter(),
    AircondAutoManSwitch = __custom_counter(),
    AircondCockpitSwitchUP = __custom_counter(),
    AircondCockpitSwitchDOWN = __custom_counter(),
    AircondCMPTREmerUP = __custom_counter(),
    AircondCMPTREmerDOWN = __custom_counter(),
    DeiceEngine = __custom_counter(),
    DeiceWindShieldUP = __custom_counter(),
    DeiceWindShieldDOWN = __custom_counter(),
    DeicePitot = __custom_counter(),
    AircondTemp = __custom_counter(),
    AircondDefog = __custom_counter(),

    -- UHF radio
    UHFMode = __custom_counter(),
    UHFFreqAUP = __custom_counter(),
    UHFFreqADOWN = __custom_counter(),
    UHFFreqBDOWN = __custom_counter(),
    UHFFreqBUP = __custom_counter(),
    UHFFreqCDOWN = __custom_counter(),
    UHFFreqCUP = __custom_counter(),
    UHFFreqASTOP = __custom_counter(),
    UHFFreqBSTOP = __custom_counter(),
    UHFFreqCSTOP = __custom_counter(),
    UHFGuard = __custom_counter(),
    UHFVolume = __custom_counter(),

    -- TACAN
    TACANMode = __custom_counter(),
    TACANChanA = __custom_counter(),
    TACANChanB = __custom_counter(),

    -- Radio System Antanna
    TACANAntUP = __custom_counter(),
    TACANAntDOWN = __custom_counter(),
    UHFAntUP = __custom_counter(),
    UHFAntDOWN = __custom_counter(),

    -- VDI System
    VDIControlOff = __custom_counter(),
    VDIControlTC = __custom_counter(),
    VDIControlTest = __custom_counter(),
    VDIControlTCCal = __custom_counter(),
    VDIControlAnalog = __custom_counter(),
    VDIControlSTBY = __custom_counter(),

    -- Gear System add-ons

    HookHandle = __custom_counter(),
    LaunchBarHandle = __custom_counter(),

    -- Weapon System
    MasterArmamentUP = __custom_counter(),
    MasterArmamentDOWN = __custom_counter(),

    Pylon1SelUP = __custom_counter(),
    Pylon1SelDOWN = __custom_counter(),
    Pylon2SelUP = __custom_counter(),
    Pylon2SelDOWN = __custom_counter(),
    Pylon3SelUP = __custom_counter(),
    Pylon3SelDOWN = __custom_counter(),
    Pylon4SelUP = __custom_counter(),
    Pylon4SelDOWN = __custom_counter(),
    Pylon5SelUP = __custom_counter(),
    Pylon5SelDOWN = __custom_counter(),
	Pylon6SelUP = __custom_counter(),
    Pylon6SelDOWN = __custom_counter(),
	Pylon7SelUP = __custom_counter(),
    Pylon7SelDOWN = __custom_counter(),

    ReleaseJettison = __custom_counter(),
    ReleaseGun = __custom_counter(),
    ReleaseMissile = __custom_counter(),
    ReleaseRocketSalvo = __custom_counter(),
    ReleaseRocketTrain = __custom_counter(),
    ReleaseBombSalve = __custom_counter(),
    ReleaseBombTrain = __custom_counter(),
    ReleaseStep = __custom_counter(),

    AttackGCB = __custom_counter(),
    AttackDelay = __custom_counter(),
    AttackLabTGT = __custom_counter(),
    AttackLabIP = __custom_counter(),
    AttackRocket = __custom_counter(),
    AttackHILoft = __custom_counter(),
    AttackStraight = __custom_counter(),
    AttackGeneral = __custom_counter(),

    MechArmUP = __custom_counter(),
    MechArmDOWN = __custom_counter(),
    RocketModeSwitch = __custom_counter(),
    GunsModeSwitchUP = __custom_counter(),
    GunsModeSwitchDOWN = __custom_counter(),
	
    MissileControl = __custom_counter(),
    MissileCoolingUP = __custom_counter(),
    MissileCoolingDOWN = __custom_counter(),

    -- power system
	BatteryPower = __custom_counter(),
    ElecPowerDCGenL = __custom_counter(),
    ElecPowerDCGenR = __custom_counter(),
	InverterLeft = __custom_counter(),
	InverterRight = __custom_counter(),
	ADIPwr = __custom_counter(),
	HSIPwr = __custom_counter(),
	RadioAltPwr = __custom_counter(),
	OilPressIndPwr = __custom_counter(),
	EmergConverter = __custom_counter(),
	WeaponPwr = __custom_counter(),
	HUDPwr = __custom_counter(),
	RWRPwr = __custom_counter(),
	EjectPwr1 = __custom_counter(),
	EjectPwr2 = __custom_counter(),
	EjectPwr3 = __custom_counter(),
	UnknownSwitch1 = __custom_counter(),
	UnknownSwitch2 = __custom_counter(),
	CameraGunPwrSwitch = __custom_counter(),
	MissileWarmingSwitch = __custom_counter(),
	MissileFilamentSwitch = __custom_counter(),
	MissileLaunchSwitch = __custom_counter(),
	pylon1Pwr = __custom_counter(),
	pylon2Pwr = __custom_counter(),
	pylon3Pwr = __custom_counter(),
	pylon4Pwr = __custom_counter(),
	pylon5Pwr = __custom_counter(),
	pylon6Pwr = __custom_counter(),
	pylon7Pwr = __custom_counter(),
	blackBoxPwr = __custom_counter(),
	rspPwr = __custom_counter(),
	apkPwr = __custom_counter(),
	lidSow_Hide = __custom_counter(),
	batteryHeating = __custom_counter(),
	
    -- this part is fpr music player
    MusicPauseOrPlay = __custom_counter(),
    MusicNext = __custom_counter(),
    MusicLast = __custom_counter(),
    MusicFastForward = __custom_counter(),
    MusicFastBack = __custom_counter(),
    MusicLrcViewTrigger = __custom_counter(),
    MusicVolUp = __custom_counter(),
    MusicVolDown = __custom_counter(),
	
	Eject = __custom_counter(),
	DropTankInd = __custom_counter(),--副油箱指示
	windshieldAntiIce = __custom_counter(),--风挡除冰
	pump3 = __custom_counter(),
	pump4 = __custom_counter(),
	groupSwitch01Up = __custom_counter(),--左墙板组合开关1（上）
	groupSwitch01Down = __custom_counter(),--左墙板组合开关1（上）
	groupSwitch02Up = __custom_counter(),--左墙板组合开关2（下）
	groupSwitch02Down = __custom_counter(),--左墙板组合开关2（下）
	oilPump = __custom_counter(),
	startUnit = __custom_counter(),
	genOilPress = __custom_counter(),
	afterBurn = __custom_counter(),
	ThrustCommon = __custom_counter(),
	ThrustLeft = __custom_counter(),
	ThrustRight = __custom_counter(),
	
	RadarRangeAxis = __custom_counter(),
	RadarLightA = __custom_counter(),
	RadarLightnessAxis = __custom_counter(),
	RadarLightB = __custom_counter(),
	RadarModeUp = __custom_counter(),
	RadarModeDown = __custom_counter(),
	RadarMaxRange = __custom_counter(),
	ToGun = __custom_counter(),
	ToAAMIr = __custom_counter(),
	ToAAMRdr = __custom_counter(),
	HK_L_Up = __custom_counter(),
	HK_L_Down = __custom_counter(),
	HK_R_Up = __custom_counter(),
	HK_R_Down = __custom_counter(),
	
	IntervalTumbWheel100_UP = __custom_counter(),
    IntervalTumbWheel10_UP = __custom_counter(),
    IntervalTumbWheel_UP = __custom_counter(),
	IntervalTumbWheel100_DN = __custom_counter(),
    IntervalTumbWheel10_DN = __custom_counter(),
    IntervalTumbWheel_DN = __custom_counter(),

    QuantityTumbWheel10_UP = __custom_counter(),
    QuantityTumbWheel_UP = __custom_counter(),
	QuantityTumbWheel10_DN = __custom_counter(),
    QuantityTumbWheel_DN = __custom_counter(),

	MultTumbWheel10_UP = __custom_counter(),
	MultTumbWheel_UP = __custom_counter(),
	MultTumbWheel10_DN = __custom_counter(),
    MultTumbWheel_DN = __custom_counter(),
	RwrOnOffSwitch = __custom_counter(),
	ICS_UNDEF_KNOB_ROT = __custom_counter(),
	RwrVolume = __custom_counter(),
	RwrLightness = __custom_counter(),
	
	autoStart = __custom_counter(),
	autoStop = __custom_counter(),
	ShowParamList = __custom_counter(),
    --起落架手柄 5001// 5050 EFM - 6000 for EFM
	
    NoseWheelSteeringOn = 5050,
    NoseWheelSteeringOff = 5051,
    -- LeftEngineOFF = __custom_counter(),
    -- RightEngineOFF = __custom_counter(),
    YawDamperSwitch = 5052,

    -- Weapon Part till 5070
    WingPylonSmokeOn = 5053,
    NozzleSmokeOn = 5054,
    WeaponFireOn = 5055,
    WeaponFireOff = 5056,
    WeaponConfigAll = 5057,
    WeaponConfigSingle = 5058,
    WeaponConfigPairs = 5059,
    WeaponMasterSwitch = 5060,
    WeaponAirGroundChange = 5061,
    GunSightInstall = 5062,
    GunSightUninstall = 5063,

    -- special functions
    SpecialSence = 5070,

    -- Flight Control Key start from 5071 - 5100
    AirbrakePauseMove = 5071,
    Flap_Pos_Up = 5072,
    Flap_Pos_Half = 5073,
    Flap_Pos_Down = 5074,

    -- CustomMenu Trigger
    Custom_Menu = 5090,
    Custom_Menu_Enter = 5091,

    -- 5100-5500 Navigation input
    -- GNS 430
    COM_Freq_Swap = 5100,
    VLOC_Freq_Swap = 5101,
    Freq_Degi = 5102,
    Freq_Num = 5103,
    Freq_Knob_Push = 5104,
    Nav_Map_range_increse = 5105, -- range + zoom out
    Nav_Map_range_decrease = 5106, -- range -
    Nav_Direct_to = 5107,
    Nav_Menu = 5108,
    Nav_Clear = 5109,
    Nav_Ent = 5110,
    Nav_CDI = 5111,
    Nav_OBS = 5112,
    Nav_MSG = 5113,
    Nav_FPL = 5114,
    Nav_PROC = 5115,
    Nav_Right_Knob_L = 5116,
    Nav_Right_Knob_S = 5117,
    Nav_Right_Knob_Push = 5118,
    Nav_Vol_PWR = 5119,
    Nav_Vol = 5120,
    -- SN3500
    Nav_Course_Sel = 5150,
    Nav_Heading_Sel = 5151,
    -- EADI
    Display_Brighter = 5200,
    Display_Darker = 5201,
    EALT_BARO = 5202,

    -- 5500 - 5550 Engine Conrol
    L_LP_PUMP = 5501,
    R_LP_PUMP = 5502,
    L_HP_PUMP = 5503,
    R_HP_PUMP = 5504,
    L_STARTER_PRESS = 5505,
    R_STARTER_PRESS = 5506,
    L_STARTER_RELEASE = 5507,
    R_STARTER_RELEASE = 5508,
    L_THROTTLE_IDLE = 5509,
    R_THROTTLE_IDLE = 5510,
    L_THROTTLE_SETIDLE = 5511,
    L_THROTTLE_SETOFF = 5512,
    R_THROTTLE_SETIDLE = 5513,
    R_THROTTLE_SETOFF = 5514,

    -- 5601 - 5700 for UHF radio
    UHF_Vol_Up = 5601,
    UHF_Vol_Down = 5602,
    UHF_SQLACK_Up = 5603,
    UHF_SQLACK_Down = 5604,
    UHF_Mode_Left = 5605,
    UHF_Mode_Right = 5606,
    UHF_TAKE_Button_Press = 5607,
    UHF_TAKE_Button_Release = 5608,
    UHF_Vol = 5609,
    UHF_Key_0 = 5610,
    UHF_Key_1 = 5611,
    UHF_Key_2 = 5612,
    UHF_Key_3 = 5613,
    UHF_Key_4 = 5614,
    UHF_Key_5 = 5615,
    UHF_Key_6 = 5616,
    UHF_Key_7 = 5617,
    UHF_Key_8 = 5618,
    UHF_Key_9 = 5619,
    UHF_Key_MAN = 5620,
    UHF_Key_ENT = 5621,
    RadioUpdate = 5622,

    -- 6000 - 6100 for sound trigger
    SND_LEFT_PANEL = 6001,
    SND_CENTER_PANEL = 6002,
    SND_RIGHT_PANEL = 6003,
    SND_ELECTRIC = 6004,
    SND_GEAR   = 6005,
    SND_BEACON_ROT = 6006,
}

--从5000开始递增点击指令
local start_command   = 5000
local __count_click = start_command-1
local function __click_counter()
	__count_click = __count_click + 1
	return __count_click
end


Click_cmd =
{
    GearLevel = __click_counter(), --起落架手柄
}
