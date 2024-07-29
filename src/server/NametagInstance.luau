local RS = game:GetService("ReplicatedStorage")
local AssetsFolder = RS.Assets

local NametagInstance = {}
NametagInstance.__index = NametagInstance

function NametagInstance.New(_Player)
    local newNametag = setmetatable({}, NametagInstance)
    local nametagAsset = AssetsFolder.Nametag

    newNametag.Nametag = nametagAsset:Clone()
    newNametag.Player = _Player

    newNametag:Update()

    return newNametag
end

function NametagInstance:Update(Name)
    if Name == nil then Name = self.Player.Name end
    local char = self.Player.Character
    local extents = char:GetExtentsSize()
    local head = char.Head

    local footPosY = char["Right Leg"].Position.Y - char["Right Leg"].Size.Y / 2
    local headPosY = head.Position.Y
    local headSizeY = head.Size.Y

    local OffsetY = extents.Y - (headPosY - footPosY)

    self.Nametag.NameLabel.Text = Name
    self.Nametag.Parent = head
    self.Nametag.ExtentsOffsetWorldSpace = Vector3.new(0, 2 + OffsetY, 0)
end

return NametagInstance