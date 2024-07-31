--// SERVICES
local NametagInstance = require(script.NametagService)
local PlayerService = require(script.PlayerService)

local Players = PlayerService.GetPlayers()

game.Players.PlayerAdded:Connect(function(player)
    local _addedPlayer = PlayerService.Add(player)
    print(Players)
    player.CharacterAdded:Connect(function()
        local _nametag = NametagInstance.New(player)
        print(Players)
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    PlayerService.Remove(player.UserId)
    print(Players)
end)