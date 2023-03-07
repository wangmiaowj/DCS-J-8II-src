local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)
local efm = GetSelf()
local element = {
    
    ------------------------------------------
    
    
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