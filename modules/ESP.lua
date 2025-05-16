-- ESP para MM2 - por TheLittleDevilYa

local ESPModule = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local espObjects = {}
local active = false

local function GetRole(player)
    local role = player:FindFirstChild("Role")
    if role and role:IsA("StringValue") then
        return role.Value
    end
    return "Desconocido"
end

local function CreateESP(player)
    if player == Players.LocalPlayer then return end
    if not player.Character then return end
    if player.Character:FindFirstChild("ESPHighlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = player.Character
    highlight.Parent = player.Character

    local role = GetRole(player)

    if role == "Murderer" then
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
    elseif role == "Sheriff" then
        highlight.FillColor = Color3.fromRGB(0, 0, 255)
    else
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
    end

    espObjects[player] = highlight
end

local function RemoveESP(player)
    if espObjects[player] then
        espObjects[player]:Destroy()
        espObjects[player] = nil
    end
end

function ESPModule:SetEnabled(state)
    active = state
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            CreateESP(player)
        end

        -- Cuando un nuevo jugador entra o resetea personaje
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                task.wait(1)
                CreateESP(p)
            end)
        end)

        for _, p in pairs(Players:GetPlayers()) do
            p.CharacterAdded:Connect(function()
                task.wait(1)
                CreateESP(p)
            end)
        end

    else
        for _, player in pairs(Players:GetPlayers()) do
            RemoveESP(player)
        end
    end
end

return ESPModule
