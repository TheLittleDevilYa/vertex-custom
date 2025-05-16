local InfiniteJump = {}
InfiniteJump.Enabled = false

local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

function InfiniteJump:SetEnabled(value)
    self.Enabled = value
end

UserInputService.JumpRequest:Connect(function()
    if InfiniteJump.Enabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

return InfiniteJump
