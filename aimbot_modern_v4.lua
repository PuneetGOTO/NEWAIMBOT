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

--// UI Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local StatusLabel = Instance.new("TextLabel")  -- 添加状态显示

-- Setup UI
ScreenGui.Parent = game.CoreGui
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

Title.Text = "Combat Settings"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- 添加状态显示
StatusLabel.Size = UDim2.new(0, 80, 0, 25)
StatusLabel.Position = UDim2.new(1, -140, 0, 5)
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "ON"
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Parent = TitleBar

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 4)
StatusCorner.Parent = StatusLabel

CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar

ContentFrame.Size = UDim2.new(1, -20, 1, -45)
ContentFrame.Position = UDim2.new(0, 10, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 2
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.Parent = ContentFrame

-- UI Elements Creation Functions
local LastPosition = 5
local ElementSpacing = 10

local function CreateCategory(name)
    local Category = Instance.new("Frame")
    Category.Size = UDim2.new(1, 0, 0, 25)
    Category.Position = UDim2.new(0, 0, 0, LastPosition)
    Category.BackgroundTransparency = 1
    Category.Parent = ScrollingFrame
    
    local Label = Instance.new("TextLabel")
    Label.Text = name
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Category
    
    LastPosition = LastPosition + 30
    return Category
end

local function CreateToggle(text, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, 0, 0, 35)
    Toggle.Position = UDim2.new(0, 0, 0, LastPosition)
    Toggle.BackgroundTransparency = 1
    Toggle.Parent = ScrollingFrame
    
    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, -5)
    Background.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Background.BackgroundTransparency = 0.8
    Background.Parent = Toggle
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Background
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Toggle
    
    local Button = Instance.new("Frame")
    Button.Size = UDim2.new(0, 40, 0, 20)
    Button.Position = UDim2.new(1, -50, 0.5, -10)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Parent = Toggle
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Button
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 2, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = Button
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Knob
    
    local enabled = false
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            local targetPos = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            local targetColor = enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(50, 50, 50)
            
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = targetPos}):Play()
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
            callback(enabled)
        end
    end)
    
    LastPosition = LastPosition + 40
    return Toggle, Button, Knob
end

local function CreateSlider(text, min, max, default, callback)
    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, 0, 0, 50)
    Slider.Position = UDim2.new(0, 0, 0, LastPosition)
    Slider.BackgroundTransparency = 1
    Slider.Parent = ScrollingFrame
    
    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, -5)
    Background.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Background.BackgroundTransparency = 0.8
    Background.Parent = Slider
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Background
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Size = UDim2.new(1, -50, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Slider
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Text = tostring(default)
    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
    ValueLabel.Position = UDim2.new(1, -45, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 14
    ValueLabel.Font = Enum.Font.SourceSans
    ValueLabel.Parent = Slider
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -20, 0, 4)
    SliderBar.Position = UDim2.new(0, 10, 0, 35)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.Parent = Slider
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = SliderBar
    
    local Progress = Instance.new("Frame")
    Progress.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Progress.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    Progress.Parent = SliderBar
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Progress
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = SliderBar
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Knob
    
    local dragging = false
    Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = SliderBar.AbsolutePosition
            local sliderSize = SliderBar.AbsoluteSize
            local percent = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
            local value = min + (max - min) * percent
            
            Progress.Size = UDim2.new(percent, 0, 1, 0)
            Knob.Position = UDim2.new(percent, -6, 0.5, -6)
            ValueLabel.Text = string.format("%.1f", value)
            callback(value)
        end
    end)
    
    LastPosition = LastPosition + 55
    return Slider
end

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

CreateCategory("Settings")
CreateSlider("FOV", 0, 360, 90, function(value)
    Environment.FOVSettings.Amount = value
end)

CreateSlider("Sensitivity", 0, 1, 0, function(value)
    Environment.Settings.Sensitivity = value
end)

CreateSlider("Third Person Sensitivity", 1, 50, 30, function(value)
    Environment.Settings.ThirdPersonSensitivity = value / 10
end)

-- Update ScrollingFrame canvas size
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, LastPosition + 5)

-- Make window draggable
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

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
            if Input.KeyCode == Enum.KeyCode[Environment.Settings.HotKey] then
                Environment.Settings.Enabled = not Environment.Settings.Enabled
                
                -- 更新UI状态
                StatusLabel.Text = Environment.Settings.Enabled and "ON" or "OFF"
                StatusLabel.TextColor3 = Environment.Settings.Enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 70, 70)
                
                -- 更新开关状态
                local targetPos = Environment.Settings.Enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
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
    ScreenGui:Destroy()

    getgenv().Aimbot = nil
end

--// Start
Load()

print("NEWAIMBOT V4 loaded successfully!")
