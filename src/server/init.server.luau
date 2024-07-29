local NametagInstance = require(script.NametagInstance)

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local nametag = NametagInstance.New(player)
    end)
end)