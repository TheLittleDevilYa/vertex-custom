local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESP = {}
ESP.Enabled = false
local espObjects = {}

local RolesColors = {
    ["Murderer"] = Color3.fromRGB(255, 0, 0),
    ["Sheriff"] = Color3.fromRGB(0, 0, 255),
    ["Innocent"] = Color3.fromRGB(0, 255, 0),
    ["Unknown"] = Color3.fromRGB(255, 255, 255),
}

-- Crear BillboardGui para el jugador
local function CreateBillboard(player)
    if espObjects[player] then return end
    local character = player.Character
    if not character then return end
    local head = character:FindFirstChild("Head")
    if not head then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPRole"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = RolesColors["Unknown"]
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    textLabel.Text = "Loading..."
    textLabel.Parent = billboard

    espObjects[player] = {
        Billboard = billboard,
        TextLabel = textLabel
    }
end

local function UpdateBillboard(player)
    local espObj = espObjects[player]
    if not espObj then return end
    local character = player.Character
    if not character then
        espObj.Billboard.Enabled = false
        return
    end
    local head = character:FindFirstChild("Head")
    if not head then
        espObj.Billboard.Enabled = false
        return
    end

    espObj.Billboard.Enabled = true

    -- Obtener rol (depende del juego, en MM2 suele estar en player:GetAttribute o en alguna StringValue)
    local role = player:GetAttribute("Role") or "Unknown"
    -- Si no está en atributos, buscar en character un StringValue llamado "Role"
    local roleValue = character:FindFirstChild("Role")
    if roleValue and roleValue:IsA("StringValue") then
        role = roleValue.Value
    end

    espObj.TextLabel.Text = role
    espObj.TextLabel.TextColor3 = RolesColors[role] or RolesColors["Unknown"]
end

local function RemoveBillboard(player)
    if espObjects[player] then
        local espObj = espObjects[player]
        if espObj.Billboard then
            espObj.Billboard:Destroy()
        end
        espObjects[player] = nil
    end
end

function ESP:SetEnabled(enabled)
    self.Enabled = enabled
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                CreateBillboard(player)
            end
        end

        self.Connection = RunService.RenderStepped:Connect(function()
            for player, _ in pairs(espObjects) do
                UpdateBillboard(player)
            end
        end)

        Players.PlayerAdded:Connect(function(player)
            if player ~= LocalPlayer then
                CreateBillboard(player)
            end
        end)

        Players.PlayerRemoving:Connect(function(player)
            RemoveBillboard(player)
        end)
    else
        if self.Connection then
            self.Connection:Disconnect()
            self.Connection = nil
        end
        for player, _ in pairs(espObjects) do
            RemoveBillboard(player)
        end
    end
end

return ESP
