local AntiFling = {}
AntiFling.Enabled = false

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

function AntiFling:SetEnabled(value)
    self.Enabled = value
    if value then
        self:Start()
    else
        self:Stop()
    end
end

function AntiFling:Start()
    self.Connection = RunService.Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            player.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end)
end

function AntiFling:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

return AntiFling
