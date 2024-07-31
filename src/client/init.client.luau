local UserInputService = game:GetService("UserInputService")
local CameraService = require(script:WaitForChild("CameraService"))
local Player = game.Players.LocalPlayer

Player.CharacterAdded:Connect(function(PlayerCharacter)
    CameraService.Init(Player)
end)

