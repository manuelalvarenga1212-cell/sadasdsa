-- params : ...

wait()
local player, character, torso = _G.GetBasics()
local camera = game.Workspace.CurrentCamera
local chunks = game.ReplicatedStorage.Chunks
local details = game.ReplicatedStorage.Details
local loaded = {}
local buildings = {}
local draw = 256
local Contains = _G.Contains
local things = game.Workspace.AnchoredObjects:GetChildren()
for d = 1, #things do
  if things[d]:FindFirstChild("Furniture") then
    table.insert(buildings, things[d])
  end
end
LoadFurniture = function(building)
  
  local chunk = chunks:FindFirstChild(building.identity.Value)
  local canc = chunk:GetChildren()
  for er = 1, #canc do
    local furn = details:FindFirstChild(canc[er].Name):clone()
    furn:SetPrimaryPartCFrame(canc[er].Value)
    if furn:FindFirstChild("Color") then
      local colore = furn.Color:GetChildren()
      for d = 1, #colore do
        colore[d].BrickColor = canc[er].Color.Value
      end
    end
    do
      do
        furn.Parent = building.Furniture
        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

CheckDetails = function(building)
  
  local index = Contains(loaded, building)
  local dist = Vector2.new(building.Roof.Position.x - camera.CoordinateFrame.p.x, building.Roof.Position.z - camera.CoordinateFrame.p.z).magnitude
  if not index and dist <= draw then
    table.insert(loaded, building)
    LoadFurniture(building)
  else
    if index and draw < dist then
      building.Furniture:ClearAllChildren()
      table.remove(loaded, index)
    end
  end
end

local groups = 4
while 1 do
  for k = 0, groups - 1 do
    for g = 1 + math.floor(k * #buildings / groups), math.floor((k + 1) * #buildings / groups) do
      if buildings[g] then
        CheckDetails(buildings[g])
      end
    end
    wait(1)
  end
end
