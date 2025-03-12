local function createMainGUI()
    -- 检查并移除已存在的GUI
    pcall(function()
        if game:GetService("CoreGui"):FindFirstChild("PUPUHUBGUI") then
            game:GetService("CoreGui"):FindFirstChild("PUPUHUBGUI"):Destroy()
        end
    end)

    -- 创建主GUI
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Logo = Instance.new("TextLabel")
    local Navigation = Instance.new("Frame")
    local HomeButton = Instance.new("TextButton")
    local PagesButton = Instance.new("TextButton")
    local CreditsButton = Instance.new("TextButton")
    local MainContent = Instance.new("Frame")
    local WelcomeText = Instance.new("TextLabel")
    local SubText = Instance.new("TextLabel")
    local SocialIcons = Instance.new("Frame")
    local ButtonsFrame = Instance.new("Frame")
    local ConfigFrame = Instance.new("Frame")

    -- GUI设置
    ScreenGui.Name = "PUPUHUBGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- 主框架设置
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- 添加圆角
    local function addCorner(instance, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 8)
        corner.Parent = instance
    end
    addCorner(MainFrame)

    -- 顶部栏
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    addCorner(TopBar)

    -- Logo
    Logo.Name = "Logo"
    Logo.Parent = TopBar
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 20, 0, 0)
    Logo.Size = UDim2.new(0, 100, 1, 0)
    Logo.Font = Enum.Font.GothamBold
    Logo.Text = "HOHO"
    Logo.TextColor3 = Color3.fromRGB(255, 70, 70)
    Logo.TextSize = 24
    Logo.TextXAlignment = Enum.TextXAlignment.Left

    -- 导航按钮
    Navigation.Name = "Navigation"
    Navigation.Parent = TopBar
    Navigation.BackgroundTransparency = 1
    Navigation.Position = UDim2.new(0.5, -100, 0, 0)
    Navigation.Size = UDim2.new(0, 300, 1, 0)

    -- 创建导航按钮函数
    local function createNavButton(name, position)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Parent = Navigation
        button.BackgroundTransparency = 1
        button.Position = position
        button.Size = UDim2.new(0, 80, 1, 0)
        button.Font = Enum.Font.GothamSemibold
        button.Text = name
        button.TextColor3 = name == "Home" and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(200, 200, 200)
        button.TextSize = 16
        return button
    end

    HomeButton = createNavButton("Home", UDim2.new(0, 0, 0, 0))
    PagesButton = createNavButton("Pages", UDim2.new(0.33, 0, 0, 0))
    CreditsButton = createNavButton("Credits", UDim2.new(0.66, 0, 0, 0))

    -- 主内容区域
    MainContent.Name = "MainContent"
    MainContent.Parent = MainFrame
    MainContent.BackgroundTransparency = 1
    MainContent.Position = UDim2.new(0, 0, 0, 50)
    MainContent.Size = UDim2.new(1, 0, 1, -50)

    -- 欢迎文本
    WelcomeText.Name = "WelcomeText"
    WelcomeText.Parent = MainContent
    WelcomeText.BackgroundTransparency = 1
    WelcomeText.Position = UDim2.new(0, 40, 0, 20)
    WelcomeText.Size = UDim2.new(0.5, 0, 0, 60)
    WelcomeText.Font = Enum.Font.GothamBold
    WelcomeText.Text = "WELCOME TO\nBEST FREE\nBLOX FRUIT HUB"
    WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeText.TextSize = 28
    WelcomeText.TextXAlignment = Enum.TextXAlignment.Left

    -- 功能按钮区域
    ButtonsFrame.Name = "ButtonsFrame"
    ButtonsFrame.Parent = MainContent
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Position = UDim2.new(0, 40, 0.5, 0)
    ButtonsFrame.Size = UDim2.new(1, -80, 0, 150)

    -- 创建功能按钮
    local function createFeatureButton(name, icon, description, position)
        local button = Instance.new("Frame")
        button.Name = name
        button.Parent = ButtonsFrame
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.Position = position
        button.Size = UDim2.new(0.3, 0, 0, 80)
        addCorner(button)

        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Parent = button
        title.BackgroundTransparency = 1
        title.Position = UDim2.new(0, 10, 0, 10)
        title.Size = UDim2.new(1, -20, 0.5, 0)
        title.Font = Enum.Font.GothamBold
        title.Text = name
        title.TextColor3 = Color3.fromRGB(255, 70, 70)
        title.TextSize = 16
        title.TextXAlignment = Enum.TextXAlignment.Left

        local desc = Instance.new("TextLabel")
        desc.Name = "Description"
        desc.Parent = button
        desc.BackgroundTransparency = 1
        desc.Position = UDim2.new(0, 10, 0.7, 0)
        desc.Size = UDim2.new(1, -20, 0.3, 0)
        desc.Font = Enum.Font.GothamSemibold
        desc.Text = description
        desc.TextColor3 = Color3.fromRGB(200, 200, 200)
        desc.TextSize = 12
        desc.TextWrapped = true
        desc.TextXAlignment = Enum.TextXAlignment.Left

        -- 添加图标
        local iconLabel = Instance.new("ImageLabel")
        iconLabel.Name = "Icon"
        iconLabel.Parent = button
        iconLabel.BackgroundTransparency = 1
        iconLabel.Position = UDim2.new(1, -30, 0, 10)
        iconLabel.Size = UDim2.new(0, 20, 0, 20)
        iconLabel.Image = icon

        -- 添加点击效果
        local buttonClick = Instance.new("TextButton")
        buttonClick.Name = "ButtonClick"
        buttonClick.Parent = button
        buttonClick.BackgroundTransparency = 1
        buttonClick.Size = UDim2.new(1, 0, 1, 0)
        buttonClick.Text = ""

        -- 添加悬停效果
        buttonClick.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            }):Play()
        end)

        buttonClick.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            }):Play()
        end)

        return button
    end

    -- 创建三个主要功能按钮
    createFeatureButton("CONFIG", "rbxassetid://3926305904", "Set up the script before\nthe 'handless' journey", UDim2.new(0, 0, 0, 0))
    createFeatureButton("MISC", "rbxassetid://3926307971", "Cool features like\nESP or Teleport", UDim2.new(0.35, 0, 0, 0))
    createFeatureButton("SETTING", "rbxassetid://3926307971", "Fully customize your\nfavorite script hub", UDim2.new(0.7, 0, 0, 0))

    -- 添加社交媒体图标
    SocialIcons.Name = "SocialIcons"
    SocialIcons.Parent = MainContent
    SocialIcons.BackgroundTransparency = 1
    SocialIcons.Position = UDim2.new(0, 40, 0, 100)
    SocialIcons.Size = UDim2.new(0, 120, 0, 30)

    local function createSocialIcon(name, position)
        local icon = Instance.new("ImageButton")
        icon.Name = name
        icon.Parent = SocialIcons
        icon.BackgroundTransparency = 1
        icon.Position = position
        icon.Size = UDim2.new(0, 30, 0, 30)
        icon.Image = "rbxassetid://3926305904"
        return icon
    end

    createSocialIcon("Discord", UDim2.new(0, 0, 0, 0))
    createSocialIcon("YouTube", UDim2.new(0, 40, 0, 0))
    createSocialIcon("TikTok", UDim2.new(0, 80, 0, 0))

    -- 创建配置区域
    ConfigFrame.Name = "ConfigFrame"
    ConfigFrame.Parent = MainFrame
    ConfigFrame.BackgroundTransparency = 1
    ConfigFrame.Position = UDim2.new(0, 20, 0, 60)
    ConfigFrame.Size = UDim2.new(1, -40, 1, -80)

    -- 创建功能按钮
    local teamCheckBtn = Instance.new("TextButton")
    teamCheckBtn.Name = "TeamCheck"
    teamCheckBtn.Parent = ConfigFrame
    teamCheckBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    teamCheckBtn.Position = UDim2.new(0, 0, 0, 0)
    teamCheckBtn.Size = UDim2.new(0, 180, 0, 35)
    teamCheckBtn.Font = Enum.Font.GothamSemibold
    teamCheckBtn.Text = "TEAM CHECK: OFF"
    teamCheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    teamCheckBtn.TextSize = 14
    addCorner(teamCheckBtn)

    local wallCheckBtn = Instance.new("TextButton")
    wallCheckBtn.Name = "WallCheck"
    wallCheckBtn.Parent = ConfigFrame
    wallCheckBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    wallCheckBtn.Position = UDim2.new(0, 0, 0, 45)
    wallCheckBtn.Size = UDim2.new(0, 180, 0, 35)
    wallCheckBtn.Font = Enum.Font.GothamSemibold
    wallCheckBtn.Text = "WALL CHECK: OFF"
    wallCheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    wallCheckBtn.TextSize = 14
    addCorner(wallCheckBtn)

    local thirdPersonBtn = Instance.new("TextButton")
    thirdPersonBtn.Name = "ThirdPerson"
    thirdPersonBtn.Parent = ConfigFrame
    thirdPersonBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    thirdPersonBtn.Position = UDim2.new(0, 0, 0, 90)
    thirdPersonBtn.Size = UDim2.new(0, 180, 0, 35)
    thirdPersonBtn.Font = Enum.Font.GothamSemibold
    thirdPersonBtn.Text = "THIRD PERSON: OFF"
    thirdPersonBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    thirdPersonBtn.TextSize = 14
    addCorner(thirdPersonBtn)

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "Toggle"
    toggleBtn.Parent = ConfigFrame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleBtn.Position = UDim2.new(0, 0, 0, 135)
    toggleBtn.Size = UDim2.new(0, 180, 0, 35)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.Text = "TOGGLE: OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 14
    addCorner(toggleBtn)

    -- 添加按钮功能
    teamCheckBtn.MouseButton1Click:Connect(function()
        getgenv().Aimbot.Settings.TeamCheck = not getgenv().Aimbot.Settings.TeamCheck
        teamCheckBtn.Text = "TEAM CHECK: " .. (getgenv().Aimbot.Settings.TeamCheck and "ON" or "OFF")
    end)

    wallCheckBtn.MouseButton1Click:Connect(function()
        getgenv().Aimbot.Settings.WallCheck = not getgenv().Aimbot.Settings.WallCheck
        wallCheckBtn.Text = "WALL CHECK: " .. (getgenv().Aimbot.Settings.WallCheck and "ON" or "OFF")
    end)

    thirdPersonBtn.MouseButton1Click:Connect(function()
        getgenv().Aimbot.Settings.ThirdPerson = not getgenv().Aimbot.Settings.ThirdPerson
        thirdPersonBtn.Text = "THIRD PERSON: " .. (getgenv().Aimbot.Settings.ThirdPerson and "ON" or "OFF")
    end)

    toggleBtn.MouseButton1Click:Connect(function()
        getgenv().Aimbot.Settings.Toggle = not getgenv().Aimbot.Settings.Toggle
        toggleBtn.Text = "TOGGLE: " .. (getgenv().Aimbot.Settings.Toggle and "ON" or "OFF")
    end)

    -- 创建滑块
    local function createSlider(name, position, parent, min, max, default, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Name = name .. "Slider"
        sliderFrame.Parent = parent
        sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        sliderFrame.Position = position
        sliderFrame.Size = UDim2.new(0, 180, 0, 35)
        addCorner(sliderFrame)

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.Parent = sliderFrame
        valueLabel.BackgroundTransparency = 1
        valueLabel.Position = UDim2.new(0, 10, 0, 0)
        valueLabel.Size = UDim2.new(1, -20, 0.5, 0)
        valueLabel.Font = Enum.Font.GothamSemibold
        valueLabel.Text = name .. ": " .. default
        valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        valueLabel.TextSize = 14
        valueLabel.TextXAlignment = Enum.TextXAlignment.Left

        local sliderBG = Instance.new("Frame")
        sliderBG.Name = "Background"
        sliderBG.Parent = sliderFrame
        sliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        sliderBG.Position = UDim2.new(0, 10, 0.7, 0)
        sliderBG.Size = UDim2.new(1, -20, 0, 4)
        addCorner(sliderBG, 2)

        local sliderFill = Instance.new("Frame")
        sliderFill.Name = "Fill"
        sliderFill.Parent = sliderBG
        sliderFill.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        addCorner(sliderFill, 2)

        local dragButton = Instance.new("TextButton")
        dragButton.Name = "DragButton"
        dragButton.Parent = sliderBG
        dragButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dragButton.Position = UDim2.new((default - min) / (max - min), -5, -0.5, -3)
        dragButton.Size = UDim2.new(0, 10, 0, 10)
        dragButton.Text = ""
        addCorner(dragButton, 10)

        local dragging = false
        dragButton.MouseButton1Down:Connect(function() dragging = true end)
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                local framePos = sliderBG.AbsolutePosition
                local frameSize = sliderBG.AbsoluteSize
                local relativeX = math.clamp((mousePos.X - framePos.X) / frameSize.X, 0, 1)
                local value = min + (max - min) * relativeX
                value = math.floor(value * 10) / 10

                sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                dragButton.Position = UDim2.new(relativeX, -5, -0.5, -3)
                valueLabel.Text = name .. ": " .. value
                callback(value)
            end
        end)
    end

    -- 创建FOV和灵敏度滑块
    createSlider("FOV", UDim2.new(0, 0, 0, 180), ConfigFrame, 0, 180, getgenv().Aimbot.FOVSettings.Amount, function(value)
        getgenv().Aimbot.FOVSettings.Amount = value
    end)

    createSlider("Sensitivity", UDim2.new(0, 0, 0, 225), ConfigFrame, 0, 1, getgenv().Aimbot.Settings.Sensitivity, function(value)
        getgenv().Aimbot.Settings.Sensitivity = value
    end)

    -- 创建社交媒体信息
    local socialInfo = Instance.new("TextLabel")
    socialInfo.Name = "SocialInfo"
    socialInfo.Parent = MainFrame
    socialInfo.BackgroundTransparency = 1
    socialInfo.Position = UDim2.new(0, 20, 1, -30)
    socialInfo.Size = UDim2.new(1, -40, 0, 20)
    socialInfo.Font = Enum.Font.GothamSemibold
    socialInfo.Text = "DC @puneet | discord.gg/eyrMV7MKck"
    socialInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    socialInfo.TextSize = 12
    socialInfo.TextXAlignment = Enum.TextXAlignment.Left

    -- 初始化Pages功能
    local initPages = loadstring(game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/pages_complete.lua"))()
    initPages(MainFrame, MainContent, HomeButton, PagesButton, createFeatureButton)
end

--// Cache

local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

--// Preventing Multiple Processes

pcall(function()
    getgenv().Aimbot.Functions:Exit()
end)

--// Environment

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Variables

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

--// Script Settings

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
    LockPart = "Head"
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

Environment.FOVCircle = Drawing.new("Circle")

--// Functions

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

--// Typing Check

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

--// Main

local function Load()
    ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
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

                Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
            end
        end
    end)

    ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
        if not Typing then
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
                        Running = false; CancelLock()
                    end
                end)

                pcall(function()
                    if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)
            end
        end
    end)
end

--// Functions

Environment.Functions = {}

function Environment.Functions:Exit()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end

    if Environment.FOVCircle.Remove then Environment.FOVCircle:Remove() end

    getgenv().Aimbot.Functions = nil
    getgenv().Aimbot = nil
end

function Environment.Functions:Restart()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end

    Load()
end

function Environment.Functions:ResetSettings()
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
        LockPart = "Head"
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
end

--// GUI Creation
createMainGUI()

-- 初始化
Load()
