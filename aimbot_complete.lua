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
        title.Size = UDim2.new(1, -20, 0, 20)
        title.Font = Enum.Font.GothamBold
        title.Text = name
        title.TextColor3 = Color3.fromRGB(255, 70, 70)
        title.TextSize = 16
        title.TextXAlignment = Enum.TextXAlignment.Left

        local desc = Instance.new("TextLabel")
        desc.Name = "Description"
        desc.Parent = button
        desc.BackgroundTransparency = 1
        desc.Position = UDim2.new(0, 10, 0, 35)
        desc.Size = UDim2.new(1, -20, 0, 40)
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

    -- 创建Pages页面框架
    local PagesFrame = Instance.new("Frame")
    PagesFrame.Name = "PagesFrame"
    PagesFrame.Parent = MainFrame
    PagesFrame.BackgroundTransparency = 1
    PagesFrame.Position = UDim2.new(0, 20, 0, 140)
    PagesFrame.Size = UDim2.new(1, -40, 1, -180)
    PagesFrame.Visible = false

    -- 创建开关按钮
    local function createToggleButton(name, position)
        local button = Instance.new("Frame")
        button.Name = name
        button.Parent = PagesFrame
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.Position = position
        button.Size = UDim2.new(0, 180, 0, 35)
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button

        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Parent = button
        title.BackgroundTransparency = 1
        title.Position = UDim2.new(0, 10, 0, 0)
        title.Size = UDim2.new(0.6, 0, 1, 0)
        title.Font = Enum.Font.GothamBold
        title.Text = name
        title.TextColor3 = Color3.fromRGB(255, 165, 0) -- 橙色，和图片一致
        title.TextSize = 14
        title.TextXAlignment = Enum.TextXAlignment.Left

        local status = Instance.new("TextLabel")
        status.Name = "Status"
        status.Parent = button
        status.BackgroundTransparency = 1
        status.Position = UDim2.new(0.7, 0, 0, 0)
        status.Size = UDim2.new(0.3, 0, 1, 0)
        status.Font = Enum.Font.GothamBold
        status.Text = "OFF"
        status.TextColor3 = Color3.fromRGB(200, 200, 200)
        status.TextSize = 14
        status.TextXAlignment = Enum.TextXAlignment.Right

        -- 添加点击效果
        local buttonClick = Instance.new("TextButton")
        buttonClick.Name = "ButtonClick"
        buttonClick.Parent = button
        buttonClick.BackgroundTransparency = 1
        buttonClick.Size = UDim2.new(1, 0, 1, 0)
        buttonClick.Text = ""

        -- 添加点击切换效果
        local isOn = false
        buttonClick.MouseButton1Click:Connect(function()
            isOn = not isOn
            status.Text = isOn and "ON" or "OFF"
            status.TextColor3 = isOn and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(200, 200, 200)
        end)

        return button
    end

    -- 创建滑块
    local function createSlider(name, position, default)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Name = name
        sliderFrame.Parent = PagesFrame
        sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        sliderFrame.Position = position
        sliderFrame.Size = UDim2.new(0, 180, 0, 35)
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = sliderFrame

        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Parent = sliderFrame
        title.BackgroundTransparency = 1
        title.Position = UDim2.new(0, 10, 0, 0)
        title.Size = UDim2.new(0.4, 0, 1, 0)
        title.Font = Enum.Font.GothamBold
        title.Text = name
        title.TextColor3 = Color3.fromRGB(255, 165, 0) -- 橙色，和图片一致
        title.TextSize = 14
        title.TextXAlignment = Enum.TextXAlignment.Left

        local value = Instance.new("TextLabel")
        value.Name = "Value"
        value.Parent = sliderFrame
        value.BackgroundTransparency = 1
        value.Position = UDim2.new(0.7, 0, 0, 0)
        value.Size = UDim2.new(0.3, 0, 1, 0)
        value.Font = Enum.Font.GothamBold
        value.Text = tostring(default)
        value.TextColor3 = Color3.fromRGB(200, 200, 200)
        value.TextSize = 14
        value.TextXAlignment = Enum.TextXAlignment.Right

        -- 创建滑块背景
        local sliderBg = Instance.new("Frame")
        sliderBg.Name = "SliderBg"
        sliderBg.Parent = sliderFrame
        sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        sliderBg.Position = UDim2.new(0.4, 0, 0.5, -2)
        sliderBg.Size = UDim2.new(0.3, 0, 0, 4)
        
        local sliderBgCorner = Instance.new("UICorner")
        sliderBgCorner.CornerRadius = UDim.new(0, 2)
        sliderBgCorner.Parent = sliderBg

        -- 创建滑块按钮
        local sliderButton = Instance.new("TextButton")
        sliderButton.Name = "SliderButton"
        sliderButton.Parent = sliderBg
        sliderButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        sliderButton.Position = UDim2.new(0, -6, 0.5, -6)
        sliderButton.Size = UDim2.new(0, 12, 0, 12)
        sliderButton.Text = ""
        
        local sliderButtonCorner = Instance.new("UICorner")
        sliderButtonCorner.CornerRadius = UDim.new(0, 6)
        sliderButtonCorner.Parent = sliderButton

        -- 添加滑块拖动功能
        local dragging = false
        local startPos
        local startValue

        sliderButton.MouseButton1Down:Connect(function(x)
            dragging = true
            startPos = x
            startValue = tonumber(value.Text)
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position.X - startPos
                local maxValue = name == "FOV" and 360 or 100
                local newValue = math.clamp(startValue + math.floor(delta / 2), 0, maxValue)
                value.Text = tostring(newValue)
                local percent = newValue / maxValue
                sliderButton.Position = UDim2.new(percent, -6, 0.5, -6)
            end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        return sliderFrame
    end

    -- 创建所有功能按钮
    createToggleButton("TEAM CHECK", UDim2.new(0, 0, 0, 0))
    createToggleButton("WALL CHECK", UDim2.new(0, 0, 0, 45))
    createToggleButton("THIRD PERSON", UDim2.new(0, 0, 0, 90))
    createToggleButton("TOGGLE", UDim2.new(0, 0, 0, 135))
    createSlider("FOV", UDim2.new(0, 0, 0, 180), 90)
    createSlider("Sensitivity", UDim2.new(0, 0, 0, 225), 0)

    -- 添加页面切换逻辑
    HomeButton.MouseButton1Click:Connect(function()
        MainContent.Visible = true
        PagesFrame.Visible = false
        HomeButton.TextColor3 = Color3.fromRGB(255, 70, 70)
        PagesButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)

    PagesButton.MouseButton1Click:Connect(function()
        MainContent.Visible = false
        PagesFrame.Visible = true
        HomeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        PagesButton.TextColor3 = Color3.fromRGB(255, 70, 70)
    end)
end

--// Cache
local select = select
local pcall = pcall
local pairs = pairs
local game = game
local Color3 = Color3
local Vector2 = Vector2
local math = math
local table = table
local task = task
local coroutine = coroutine

--// Environment
getgenv().Environment = {
    Settings = {
        Enabled = true,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = false,
        Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
        ThirdPerson = false, -- Uses third person camera if available
        ThirdPersonSensitivity = 3,
        TriggerKey = "MouseButton2",
        Toggle = false,
        LockPart = "Head" -- Body part to lock on
    },

    FOVSettings = {
        Enabled = true,
        Visible = true,
        Amount = 90,
        Color = Color3.fromRGB(255, 255, 255),
        LockedColor = Color3.fromRGB(255, 70, 70),
        Transparency = 0.5,
        Sides = 60,
        Thickness = 1,
        Filled = false
    },

    FOVCircle = Drawing.new("Circle"),

    Locked = nil,
    ServiceConnections = {}
}

--// Main
local function Load()
    ServiceConnections.RenderSteppedConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = Environment.Locked and Environment.FOVSettings.LockedColor or Environment.FOVSettings.Color
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2.new(game:GetService("UserInputService"):GetMouseLocation().X, game:GetService("UserInputService"):GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end
    end)

    ServiceConnections.InputBeganConnection = game:GetService("UserInputService").InputBegan:Connect(function(Input)
        if Environment.Settings.Toggle then
            if Input.KeyCode.Name == Environment.Settings.TriggerKey or Input.UserInputType.Name == Environment.Settings.TriggerKey then
                Environment.Settings.Enabled = not Environment.Settings.Enabled
            end
        end
    end)

    ServiceConnections.InputEndedConnection = game:GetService("UserInputService").InputEnded:Connect(function(Input)
        if not Environment.Settings.Toggle then
            if Input.KeyCode.Name == Environment.Settings.TriggerKey or Input.UserInputType.Name == Environment.Settings.TriggerKey then
                Environment.Settings.Enabled = false
            end
        end
    end)
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

function Environment.Functions:Unload()
    Environment.FOVCircle:Remove()
    
    for _, Connection in pairs(Environment.ServiceConnections) do
        Connection:Disconnect()
    end
end

createMainGUI()
Load()

return Environment
