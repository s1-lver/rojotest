local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local CameraService = {}

-- local MAX_LENGTH = 900000

local cooldown = 100
local currenttime = cooldown

local Player
local Character
local JumpedOrFalling = 0
local ShiftlockEnabled = false

local Cam = nil

local count = 0
local TweenPos
local Offset = CFrame.new(0, 2, 0)

local function createCam(char)
    Character = Player.Character

    if currenttime < cooldown then return end
    
    count += 1
    Cam = nil

    currenttime = 0

    Cam = Instance.new("Part", char)
    Cam.Parent = char
    Cam.Transparency = 1
    Cam.Anchored = true
    Cam.CanCollide = false
    Cam.Name = "SmoothCam" .. count
    Cam.CFrame = Character:WaitForChild("HumanoidRootPart").CFrame * Offset

    local camera = workspace.CurrentCamera

    if char:WaitForChild("HumanoidRootPart", 5) and char:WaitForChild(Cam.Name, 5) then
        camera.CameraSubject = Cam
    else
        createCam(char)
    end

    TweenPos = Character:WaitForChild("HumanoidRootPart").CFrame * Offset
end

-- does all the tweening stuff
local function Update()
    currenttime = math.clamp(currenttime + 1, 0, cooldown)
    if Character:FindFirstChild("HumanoidRootPart") then
        TweenPos = Character:WaitForChild("HumanoidRootPart").CFrame * Offset
        if not Cam or not Character:FindFirstChild(Cam.Name) then
            createCam(Character)
        end
        if Character:FindFirstChild(Cam.Name) or Cam ~= nil then
            local tween
            if JumpedOrFalling == 0 then
                tween = TweenService:Create(Cam, TweenInfo.new(0.75, Enum.EasingStyle.Back), {CFrame = TweenPos})
            elseif JumpedOrFalling == 1 then
                tween = TweenService:Create(Cam, TweenInfo.new(0.45, Enum.EasingStyle.Back), {CFrame = TweenPos})
            end
            tween:Play()
        else
        end
    end
end

function CameraService.Init(player)
    Player = player
    Character = player.Character
    createCam(Character)

    Character.Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
        if Character.Humanoid.FloorMaterial == Enum.Material.Air then
            JumpedOrFalling = 1
        else
            JumpedOrFalling = 0
        end
    end)

    TweenPos = Character:WaitForChild("HumanoidRootPart").CFrame * Offset
    Cam:Destroy()
    createCam(Character)

    RunService.RenderStepped:Connect(function()
        Update()
    end)
end

function CameraService.ToggleShiftlock()
    if ShiftlockEnabled then
        ShiftlockEnabled = false
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        Offset = CFrame.new(0, 2, 0)
    else
        ShiftlockEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        Offset = CFrame.new(0, 4, 0)
    end
end

-- idk wtf this is for dont press me
--[[ function CameraService.GetUpdatedCameraCFrame(ROOT, CAMERA)
    return CFrame.new(ROOT.Position, Vector3.new(CAMERA.CFrame.LookVector.X * MAX_LENGTH, ROOT.Position.Y, CAMERA.CFrame.LookVector.Z * MAX_LENGTH))
end ]]

return CameraService