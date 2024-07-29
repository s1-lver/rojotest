local UserInputService = game:GetService("UserInputService")
local CameraService = require(script:WaitForChild("CameraService"))
local Player = game.Players.LocalPlayer

Player.CharacterAdded:Connect(function(character)
    CameraService.Initialise(Player, character)

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if input.KeyCode == Enum.KeyCode.LeftShift then
            CameraService.ToggleShiftlock()
        end
    end)
end)

