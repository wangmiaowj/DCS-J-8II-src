local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)
local efm = GetSelf()
local element = {
    get_clickable_element_reference("PNT_1001"),
    get_clickable_element_reference("PNT_1002"),
    get_clickable_element_reference("PNT_1003"),
    get_clickable_element_reference("PNT_1004"),
    get_clickable_element_reference("PNT_1005"),
    get_clickable_element_reference("PNT_1006"),
    get_clickable_element_reference("PNT_1007"),
    get_clickable_element_reference("PNT_1008"),
    get_clickable_element_reference("PNT_1009"),
    get_clickable_element_reference("PNT_1010"),
    get_clickable_element_reference("PNT_1011"),
    get_clickable_element_reference("PNT_1012"),
    get_clickable_element_reference("PNT_1013"),
    get_clickable_element_reference("PNT_1014"),
    get_clickable_element_reference("PNT_1015"),
    get_clickable_element_reference("PNT_1016"),
    get_clickable_element_reference("PNT_1017"),
    get_clickable_element_reference("PNT_1018"),
    get_clickable_element_reference("PNT_1019"),
    get_clickable_element_reference("PNT_1020"),
    get_clickable_element_reference("PNT_1021"),
    get_clickable_element_reference("PNT_1022"),
    get_clickable_element_reference("PNT_1081"),
    get_clickable_element_reference("PNT_1082"),
    get_clickable_element_reference("PNT_1083"),
    get_clickable_element_reference("PNT_1084"),
    get_clickable_element_reference("PNT_1085"),
    get_clickable_element_reference("PNT_1086"),
    get_clickable_element_reference("PNT_1087"),
    get_clickable_element_reference("PNT_1088"),
    get_clickable_element_reference("PNT_1089"),
    get_clickable_element_reference("PNT_1090"),
    get_clickable_element_reference("PNT_1091"),
    get_clickable_element_reference("PNT_1099"),
    ------------------------------------------
    get_clickable_element_reference("PNT_1141"),
    get_clickable_element_reference("PNT_1142"),
    get_clickable_element_reference("PNT_1143"),
    get_clickable_element_reference("PNT_1144"),
    get_clickable_element_reference("PNT_1146"),
    get_clickable_element_reference("PNT_1147"),
    get_clickable_element_reference("PNT_1148"),
    get_clickable_element_reference("PNT_1149"),
    get_clickable_element_reference("PNT_1150"),
    get_clickable_element_reference("R_ENG_IDLE"),
    get_clickable_element_reference("L_ENG_IDLE"),
    
}
function post_initialize()

end

function SetCommand(command,value)

end

function update()
    for k, v in pairs(element) do
        if v~= nil then
            v:update()
        end
    end
end