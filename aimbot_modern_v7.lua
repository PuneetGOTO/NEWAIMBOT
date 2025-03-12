-- Modern Combat Aimbot V7

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

--// UI Module
local UIModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot_ui_v7.lua"))()

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
    NoCollision = false
}

Environment.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 90,
    Color = Color3.fromRGB(255, 255, 255),
    LockedColor = Color3.fromRGB(255, 70, 70),
    Transparency = 0.5,
    Sides = 60,
    Thickness = 1,
    Filled = false
}

--// Variables
local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

--// Combat Functions
local function CancelLock()
    Environment.Locked = nil
    if Animation then Animation:Cancel() end
    Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
    if not Environment.Locked then
        RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)

        for _, v in next, Players:GetPlayers() do
            if v ~= LocalPlayer then
                if v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
                    if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
                    if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
                    if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

                    local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
                    local Distance = (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude

                    if Distance < RequiredDistance and OnScreen then
                        RequiredDistance = Distance
                        Environment.Locked = v
                    end
                end
            end
        end
    elseif (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
        CancelLock()
    end
end

--// Initialize FOV Circle
Environment.FOVCircle = Drawing.new("Circle")

--// Main Loop
local function Load()
    -- 创建UI
    local UI = UIModule.CreateUI(Environment)
    local StatusLabel = UI.StatusLabel

    -- 初始化UI元素
    UI.CreateCategory("Aimbot")
    local EnabledToggle, EnabledButton, EnabledKnob = UI.CreateToggle("Enabled", function(enabled)
        Environment.Settings.Enabled = enabled
        StatusLabel.Text = enabled and "ON" or "OFF"
        StatusLabel.TextColor3 = enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 70, 70)
    end)

    UI.CreateToggle("Toggle Mode", function(enabled)
        Environment.Settings.Toggle = enabled
    end)

    UI.CreateToggle("Team Check", function(enabled)
        Environment.Settings.TeamCheck = enabled
    end)

    UI.CreateToggle("Wall Check", function(enabled)
        Environment.Settings.WallCheck = enabled
    end)

    UI.CreateToggle("Third Person", function(enabled)
        Environment.Settings.ThirdPerson = enabled
    end)

    UI.CreateCategory("Combat")
    UI.CreateToggle("Auto Block", function(enabled)
        Environment.Settings.AutoBlock = enabled
    end)

    UI.CreateToggle("Manual Override", function(enabled)
        Environment.Settings.ManualOverride = enabled
    end)

    UI.CreateToggle("Full Auto", function(enabled)
        Environment.Settings.FullAuto = enabled
    end)

    UI.CreateToggle("No Collision", function(enabled)
        Environment.Settings.NoCollision = enabled
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

    UI.CreateCategory("Settings")
    UI.CreateSlider("FOV", 0, 360, 90, function(value)
        Environment.FOVSettings.Amount = value
    end)

    UI.CreateSlider("Sensitivity", 0, 1, 0, function(value)
        Environment.Settings.Sensitivity = value
    end)

    UI.CreateSlider("Third Person Sensitivity", 1, 50, 30, function(value)
        Environment.Settings.ThirdPersonSensitivity = value / 10
    end)

    -- 更新ScrollingFrame画布大小
    UI.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UI.LastPosition + 5)

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

        if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = Environment.FOVSettings.Color
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end

        if Running and Environment.Settings.Enabled then
            GetClosestPlayer()

            if Environment.Locked then
                if Environment.Settings.ThirdPerson then
                    Environment.Settings.ThirdPersonSensitivity = mathclamp(Environment.Settings.ThirdPersonSensitivity, 0.1, 5)
                    local Vector = Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
                    mousemoverel((Vector.X - UserInputService:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
                else
                    if Environment.Settings.Sensitivity > 0 then
                        Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
                        Animation:Play()
                    else
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
                    end
                end

                if Environment.Settings.FullAuto then
                    local attackRemote = game:GetService("ReplicatedStorage"):FindFirstChild("AttackRemote")
                    if attackRemote then
                        attackRemote:FireServer(Environment.Locked)
                    end
                end

                Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
            end
        end

        -- Auto Block
        if Environment.Settings.AutoBlock and not Environment.Settings.ManualOverride then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and 
                   player.Character and 
                   player.Character:FindFirstChild("HumanoidRootPart") and
                   LocalPlayer.Character and 
                   LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    
                    local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance <= 10 then
                        if Environment.Settings.TeamCheck and player.Team == LocalPlayer.Team then
                            continue
                        end
                        local blockRemote = game:GetService("ReplicatedStorage"):FindFirstChild("BlockRemote")
                        if blockRemote then
                            blockRemote:FireServer(true)
                        end
                    end
                end
            end
        end
    end)

    ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
        if not Typing then
            -- 热键开关
            if Input.KeyCode == Enum.KeyCode.RightAlt then
                Environment.Settings.Enabled = not Environment.Settings.Enabled
                
                -- 更新UI状态
                StatusLabel.Text = Environment.Settings.Enabled and "ON" or "OFF"
                StatusLabel.TextColor3 = Environment.Settings.Enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 70, 70)
                
                -- 更新开关状态
                local targetPos = Environment.Settings.Enabled and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
                local targetColor = Environment.Settings.Enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(50, 50, 50)
                
                TweenService:Create(EnabledKnob, TweenInfo.new(0.2), {Position = targetPos}):Play()
                TweenService:Create(EnabledButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
            end

            pcall(function()
                if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running
                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)

            pcall(function()
                if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running
                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)
        end
    end)

    ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
        if not Typing then
            if not Environment.Settings.Toggle then
                pcall(function()
                    if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                        Running = false
                        CancelLock()
                    end
                end)

                pcall(function()
                    if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                        Running = false
                        CancelLock()
                    end
                end)
            end
        end
    end)

    ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
        Typing = true
    end)

    ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
        Typing = false
    end)
end

--// Exit Function
Environment.Functions = {}

function Environment.Functions:Exit()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end

    Environment.FOVCircle:Remove()
    if game.CoreGui:FindFirstChild("PuneetAimbot") then
        game.CoreGui.PuneetAimbot:Destroy()
    end

    getgenv().Aimbot = nil
end

--// Start
Load()

print("NEWAIMBOT V7 loaded successfully!")
