-- Modern Combat Aimbot with UI and NoCollision

--// Cache
local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

--// Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Environment
getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Settings
Environment.Settings = {
    Enabled = true,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false,
    Sensitivity = 0,
    ThirdPerson = false,
    ThirdPersonSensitivity = 3,
    TriggerKey = "MouseButton2",
    Toggle = false,
    LockPart = "Head",
    AutoBlock = false,
    ManualOverride = false,
    FullAuto = false,
    HotKey = "RightAlt",
    NoCollision = false  -- 添加无碰撞设置
}

{{ ... }}

-- Initialize UI Elements
CreateCategory("Aimbot")
local EnabledToggle, EnabledButton, EnabledKnob = CreateToggle("Enabled", function(enabled)
    Environment.Settings.Enabled = enabled
    StatusLabel.Text = enabled and "ON" or "OFF"
    StatusLabel.TextColor3 = enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 70, 70)
end)

CreateToggle("Toggle Mode", function(enabled)
    Environment.Settings.Toggle = enabled
end)

CreateToggle("Team Check", function(enabled)
    Environment.Settings.TeamCheck = enabled
end)

CreateToggle("Wall Check", function(enabled)
    Environment.Settings.WallCheck = enabled
end)

CreateToggle("Third Person", function(enabled)
    Environment.Settings.ThirdPerson = enabled
end)

CreateCategory("Combat")
CreateToggle("Auto Block", function(enabled)
    Environment.Settings.AutoBlock = enabled
end)

CreateToggle("Manual Override", function(enabled)
    Environment.Settings.ManualOverride = enabled
end)

CreateToggle("Full Auto", function(enabled)
    Environment.Settings.FullAuto = enabled
end)

CreateToggle("No Collision", function(enabled)  -- 添加无碰撞开关
    Environment.Settings.NoCollision = enabled
    -- 更新所有玩家的碰撞状态
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not enabled
                end
            end
        end
    end
end)

{{ ... }}

--// Main Loop
local function Load()
    -- 处理新加入的玩家
    Players.PlayerAdded:Connect(function(player)
        if Environment.Settings.NoCollision then
            player.CharacterAdded:Connect(function(character)
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
    end)

    ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
        -- 无碰撞功能
        if Environment.Settings.NoCollision then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end

        {{ ... }}  -- 保持原有的功能代码不变
    end)

    {{ ... }}  -- 保持原有的其他代码不变
end

{{ ... }}
