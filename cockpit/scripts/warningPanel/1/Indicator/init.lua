dofile(LockOn_Options.common_script_path.."devices_defs.lua") --加载默认，不知道原因，没有在里面找到有效函数
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua") --大多数的非hud显示器均加载了这一个文件(似乎是视角控制函数)

indicator_type       = indicator_types.COMMON	--大多数hud采用COLLIMATOR，主显示器均采用COMMON，此处存疑
purposes 	   = {render_purpose.GENERAL} --渲染模型

--子页面 id
BASE    = 1    --这是最上层的裁剪框
BASIC_PAGE = 2 --这是基础仪表页面

--子页面
page_subsets  = {
	[BASE]    		= LockOn_Options.script_path.."warningPanel/1/Indicator/base_page.lua",    --底页面
	[BASIC_PAGE]    = LockOn_Options.script_path.."warningPanel/1/Indicator/indication_page.lua",	--基础飞行数据页面
}
--目前暂时无法控制页面集显示,所以只用一个页面控制
--页面集
pages = {
	{ BASE, BASIC_PAGE}, --只有一个页面集，多页面集情况为增加这个数组
}

-- 注：关于多个屏幕控制的问题，这里可以加载一个function来区分不同屏幕初始化，basepage要弄三个

init_pageID = 1 --TEST_NORMAL --默认加载为第一个页面集