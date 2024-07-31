--!strict
local Players = require(script.Players)

local PlayerService = {}
PlayerService.__index = PlayerService

--// SERVICE METHODS

function PlayerService.Add(player: Player)
    local self = {
        Player = player
    }
    self = setmetatable(self, PlayerService)

    Players[player.UserId] = self
    return self
end

function PlayerService.Remove(playerID: number)
    Players[playerID]:Destroy()
    Players[playerID] = nil
end

function PlayerService.GetPlayers()
    return Players
end

function PlayerService.GetPlayer(player: Player)
    return Players[player.UserId]
end

function PlayerService.GetPlayerFromID(playerID: number)
    return Players[playerID]
end

--// INSTANCE METHODS

function PlayerService:Destroy()
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

return PlayerService