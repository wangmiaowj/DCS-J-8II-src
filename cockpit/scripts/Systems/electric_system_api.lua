--电力状态api,返回全部为布尔型
--初步仅设置两条电力总线:交流115v总线和直流28v总线

elec_ac1_status = get_param_handle("ELEC_AC1_BUS") -- 1 or 0
elec_ac2_status = get_param_handle("ELEC_AC2_BUS") -- 1 or 0
elec_dc_status = get_param_handle("ELEC_DC_BUS") -- 1 or 0
elec_charging_status = get_param_handle("ELEC_DC_CHARGE") -- 1 or 0
elec_battery_status = get_param_handle("ELEC_DC_BATT") -- 1 or 0

function get_elec_ac_status()
    if elec_ac1_status:get() == 1 or elec_ac2_status:get() then
        return true
    else
        return false
    end
end

function get_elec_dc_status()
    if elec_dc_status:get() == 1 then
        return true
    else
        return false
    end
end