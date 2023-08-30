dofile(LockOn_Options.script_path.."Displays/common_definitions.lua")
HUD_DAY_COLOR               = {0,255,0,255}
-- 定义hud默认长宽
default_hud_x = 2000
default_hud_y = 2000

function hud_vert_gen(width, height)
    return {{(0 - width) / 2 / default_hud_x , (0 + height) / 2 / default_hud_y},
    {(0 + width) / 2 / default_hud_x , (0 + height) / 2 / default_hud_y},
    {(0 + width) / 2 / default_hud_x , (0 - height) / 2 / default_hud_y},
    {(0 - width) / 2 / default_hud_x , (0 - height) / 2 / default_hud_y},}
end

function hud_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_hud_x , (0 + total_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 + total_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 + not_include_height) / 2 / default_hud_y},
        {(0 - width) / 2 / default_hud_x , (0 + not_include_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 - not_include_height) / 2 / default_hud_y},
        {(0 - width) / 2 / default_hud_x , (0 - not_include_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 - total_height) / 2 / default_hud_y},
        {(0 - width) / 2 / default_hud_x , (0 - total_height) / 2 / default_hud_y},
    }
end

-- 自动算贴图位置
function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    -- 参数说明，裁减点X,y 要裁减的宽高，原图尺寸
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end

-- 反向贴图生成
function mirror_tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{(x_dis + width) / size_X , y_dis / size_Y},
			{x_dis / size_X , y_dis / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},}
end