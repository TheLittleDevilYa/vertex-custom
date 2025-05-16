-- Módulo ESP

local ESPModule = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local active = false
local connections = {}

function ESPModule:SetEnabled(value)
    active = value
    if value then
        self:EnableESP()
    else
        self:DisableESP()
    end
end

function ESPModule:EnableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            local esp = Instance.new("Highlight")
            esp.Name = "VertexESP"
            esp.FillColor = Color3.fromRGB(255, 0, 0)
            esp.OutlineColor = Color3.new(0, 0, 0)
            esp.Parent = player.Character or player.CharacterAdded:Wait()
            esp.Adornee = player.Character
        end
    end

    connections["PlayerAdded"] = Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            local esp = Instance.new("Highlight")
            esp.Name = "VertexESP"
            esp.FillColor = Color3.fromRGB(255, 0, 0)
            esp.OutlineColor = Color3.new(0, 0, 0)
            esp.Parent = char
            esp.Adornee = char
        end)
    end)
end

function ESPModule:DisableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("VertexESP") then
            player.Character.VertexESP:Destroy()
        end
    end

    for _, conn in pairs(connections) do
        conn:Disconnect()
    end
    connections = {}
end

return ESPModule
