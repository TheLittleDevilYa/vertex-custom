-- Módulo ESP simple

local ESP = {}
ESP.Enabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local espObjects = {}

function ESP:SetEnabled(value)
    self.Enabled = value
    if value then
        self:EnableESP()
    else
        self:DisableESP()
    end
end

function ESP:EnableESP()
    -- Crear ESP para todos los jugadores (menos vos)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            self:AddESP(player)
        end
    end

    -- Detectar nuevos jugadores
    Players.PlayerAdded:Connect(function(player)
        if self.Enabled and player ~= Players.LocalPlayer then
            player.CharacterAdded:Connect(function()
                wait(1)
                self:AddESP(player)
            end)
        end
    end)
end

function ESP:AddESP(player)
    if espObjects[player] then return end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Parent = game:GetService("CoreGui")
    espObjects[player] = highlight
end

function ESP:DisableESP()
    for _, highlight in pairs(espObjects) do
        highlight:Destroy()
    end
    espObjects = {}
end

return ESP
