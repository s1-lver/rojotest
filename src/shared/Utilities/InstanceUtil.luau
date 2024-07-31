--// SERVICES
local ErrorService = require(game.ReplicatedStorage.Services.ErrorService)

local InstanceUtil = {}

--// UTILITY METHODS

function InstanceUtil.SetProperties(instance: Instance, properties: {[string]: any})
    for Property, Value in pairs(properties) do
        ErrorService.TryWarn(function()
            instance[Property] = Value
        end)
    end
    
    print("set properties of " ..  instance.Name .. " to", properties)
end

return InstanceUtil