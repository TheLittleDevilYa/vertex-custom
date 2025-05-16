local AutoGun = {}
AutoGun.Enabled = false
local RunService = game:GetService("RunService")

function AutoGun:SetEnabled(value)
    self.Enabled = value
    if value then
        self:Start()
    else
        self:Stop()
    end
end

function AutoGun:Start()
    self.Connection = RunService.Heartbeat:Connect(function()
        if not self.Enabled then return end
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            local tool = player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("RemoteEvent") then
                -- Disparar el arma, ejemplo básico
                tool.RemoteEvent:FireServer()
            end
        end
    end)
end

function AutoGun:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

return AutoGun
