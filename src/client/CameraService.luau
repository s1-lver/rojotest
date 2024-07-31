local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local InstanceUtil = require(game.ReplicatedStorage.Utilities.InstanceUtil)

local CameraService = {}

-- local MAX_LENGTH = 900000

workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

local cooldown = 100
local currenttime = cooldown

local Character
local _JumpedOrFalling = 0

local Cam
local count = 0

local TweenPos
local Offset = CFrame.new(0, 2, 0)

local CameraYOffset = 35
local CameraOrientation = CFrame.Angles(-math.rad(-90), -math.rad(-180), -math.rad(0))

function CameraService.Init(player: Player)
    Character = player.Character
    createCam()

    Character.Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
        if Character.Humanoid.FloorMaterial == Enum.Material.Air then
            JumpedOrFalling = 1
        else
            JumpedOrFalling = 0
        end
    end)

    UpdateTweenPos()
    Cam:Destroy()
    createCam()

    RunService.RenderStepped:Connect(function()
        Update()
    end)
end

function createCam()
    if currenttime < cooldown then return end
    
    count += 1
    Cam = nil

    currenttime = 0

    Cam = Instance.new("Part", Character)
    InstanceUtil.SetProperties(Cam, {
        Parent = Character,
        Transparency = 1,
        Anchored = true,
        CanCollide = false,
        Name = "SmoothCam" .. count,
        CFrame = Character:WaitForChild("HumanoidRootPart").CFrame * Offset
    })

    --local camera = workspace.CurrentCamera

    if Character:WaitForChild("HumanoidRootPart", 5) and Character:WaitForChild(Cam.Name, 5) then
        -- camera.CameraSubject = Cam
    else
        createCam()
    end

    UpdateTweenPos()
end

function UpdateTweenPos()
    TweenPos = Character:WaitForChild("HumanoidRootPart").CFrame * Offset
end

-- does all the tweening stuff
function Update()
    currenttime = math.clamp(currenttime + 1, 0, cooldown)
    if Character:FindFirstChild("HumanoidRootPart") then
        UpdateTweenPos()
        if not Cam or not Character:FindFirstChild(Cam.Name) then
            createCam()
        end
        if Character:FindFirstChild(Cam.Name) or Cam ~= nil then
            local tween
            --if JumpedOrFalling == 0 then
                tween = TweenService:Create(Cam, TweenInfo.new(0.75, Enum.EasingStyle.Back), {CFrame = TweenPos})
            --elseif JumpedOrFalling == 1 then
                --tween = TweenService:Create(Cam, TweenInfo.new(0.45, Enum.EasingStyle.Back), {CFrame = TweenPos})
            --end
            tween:Play()
            workspace.CurrentCamera.CFrame = CFrame.new(Cam.CFrame.Position.X, CameraYOffset, Cam.CFrame.Position.Z) * CameraOrientation
        else
        end
    end
end

-- not needed rn
--[[ function CameraService.GetUpdatedCameraCFrame(ROOT, CAMERA)
    return CFrame.new(ROOT.Position, Vector3.new(CAMERA.CFrame.LookVector.X * MAX_LENGTH, ROOT.Position.Y, CAMERA.CFrame.LookVector.Z * MAX_LENGTH))
end ]]

return CameraService