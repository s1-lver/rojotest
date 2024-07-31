local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetsFolder = ReplicatedStorage.Assets

--// SERVICES
local PlayerService = require(script.Parent.PlayerService)
local InstanceUtil = require(ReplicatedStorage.Utilities.InstanceUtil)

local NametagService = {}
NametagService.__index = NametagService

--// SERVICE METHODS

function NametagService.New(player: Player)
    local self = {
        GUI = AssetsFolder.Nametag:Clone(),
        _Player = player
    }
    self = setmetatable(self, NametagService)

    PlayerService.GetPlayer(player).Nametag = self
    task.wait(2)
    self:Update()

    return self
end

--// INSTANCE METHODS

function NametagService:Update(name: string)
    if name == nil then name = self._Player.Name end
    local Character = self._Player.Character

    InstanceUtil.SetProperties(self.GUI, {
        Parent = Character,
        Adornee = Character.Head,
        ExtentsOffsetWorldSpace = Vector3.new(0, 2 + self:CalculateYOffset(), 0)
    })

    self.GUI.NameLabel.Text = name
end

function NametagService:CalculateYOffset(): number
    local Character = self._Player.Character
    
    local Extents = Character:GetExtentsSize()
    local FaceCenterAttachment = Character.Head.FaceCenterAttachment
    local HumanoidRootPart = Character.HumanoidRootPart
    local RootAttachment = HumanoidRootPart.RootAttachment
    local RightLeg = Character["Right Leg"]

    local bottomPosition = (RootAttachment.WorldCFrame.Position.Y - HumanoidRootPart.Size.Y / 2) - RightLeg.Size.Y
    local distanceToHead = FaceCenterAttachment.WorldCFrame.Position.Y - bottomPosition
    local headToYExtent = Extents.Y - distanceToHead

    return headToYExtent
end

return NametagService