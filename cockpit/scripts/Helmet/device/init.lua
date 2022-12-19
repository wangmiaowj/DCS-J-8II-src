local status_count = 0
local function _status_counter()
    status_count = status_count + 1
    return status_count
end

local display = _status_counter()

local target_status = {
    { display, 0, get_param_handle("FK_DISPLAY") },
}

local current_status = {
    { display, 0, 0 },
}

local function update_element_status()
    for k, v in pairs(target_status) do
        current_status[k][2] = v[2]
        v[3]:set(current_status[k][2])
    end
end

update_time_step = 0.02
make_default_activity(update_time_step)

function post_initialize()

end

function SetCommand(command, value)

end

function update()
    if target_status[display][2] > 65 then
        target_status[display][2] = 0
    else
        target_status[display][2] = target_status[display][2] + update_time_step
    end
    update_element_status()
end
