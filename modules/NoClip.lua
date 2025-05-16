local NoClip = {}
NoClip.Enabled = false

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

function NoClip:SetEnabled(value)
    self.Enabled = value
    if value then
        self:Enable()
    else
        self:Disable()
    end
end

function NoClip:Enable()
    self.Connection = RunService.Stepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

function NoClip:Disable()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
    if player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

return NoClip
