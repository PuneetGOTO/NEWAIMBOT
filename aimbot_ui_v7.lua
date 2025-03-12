-- Puneet Aimbot UI Module V7

local UIModule = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function UIModule.CreateUI(Environment)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PuneetAimbot"
    ScreenGui.Parent = game.CoreGui

    -- 主窗口
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Parent = ScreenGui

    -- 添加主窗口阴影
    local MainShadow = Instance.new("ImageLabel")
    MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    MainShadow.BackgroundTransparency = 1
    MainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainShadow.Size = UDim2.new(1, 30, 1, 30)
    MainShadow.Image = "rbxassetid://1316045217"
    MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    MainShadow.ImageTransparency = 0.6
    MainShadow.Parent = MainFrame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- 标题栏
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar

    -- 标题
    local Title = Instance.new("TextLabel")
    Title.Text = "Puneet Aimbot"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    -- 状态显示
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(0, 80, 0, 25)
    StatusLabel.Position = UDim2.new(1, -140, 0.5, -12.5)
    StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    StatusLabel.Text = "ON"
    StatusLabel.TextSize = 14
    StatusLabel.Font = Enum.Font.GothamBold
    StatusLabel.Parent = TitleBar

    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 6)
    StatusCorner.Parent = StatusLabel

    -- 关闭按钮
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "×"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 24
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar

    -- 内容区域
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -50)
    ContentFrame.Position = UDim2.new(0, 10, 0, 45)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.ScrollBarThickness = 3
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.Parent = ContentFrame

    -- 创建重新打开界面的按钮
    local ReopenButton = Instance.new("TextButton")
    ReopenButton.Size = UDim2.new(0, 180, 0, 45)
    ReopenButton.Position = UDim2.new(0.5, -90, 0, 20)  -- 屏幕顶部中间
    ReopenButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ReopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ReopenButton.Text = "Puneet脚本"
    ReopenButton.Font = Enum.Font.GothamBold
    ReopenButton.TextSize = 20
    ReopenButton.Visible = false  -- 初始隐藏
    ReopenButton.Parent = ScreenGui
    ReopenButton.ZIndex = 999999

    -- 重新打开按钮的圆角
    local ReopenCorner = Instance.new("UICorner")
    ReopenCorner.CornerRadius = UDim.new(0, 10)
    ReopenCorner.Parent = ReopenButton

    -- 重新打开按钮的阴影
    local ReopenShadow = Instance.new("ImageLabel")
    ReopenShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    ReopenShadow.BackgroundTransparency = 1
    ReopenShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    ReopenShadow.Size = UDim2.new(1, 24, 1, 24)
    ReopenShadow.Image = "rbxassetid://1316045217"
    ReopenShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ReopenShadow.ImageTransparency = 0.6
    ReopenShadow.Parent = ReopenButton

    -- 重新打开按钮的渐变
    local ReopenGradient = Instance.new("UIGradient")
    ReopenGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
    })
    ReopenGradient.Parent = ReopenButton

    -- UI Elements Creation Functions
    local LastPosition = 5
    local ElementSpacing = 10

    local function CreateCategory(name)
        local Category = Instance.new("Frame")
        Category.Size = UDim2.new(1, 0, 0, 30)
        Category.Position = UDim2.new(0, 0, 0, LastPosition)
        Category.BackgroundTransparency = 1
        Category.Parent = ScrollingFrame
        
        local Label = Instance.new("TextLabel")
        Label.Text = name
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 18
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Category
        
        LastPosition = LastPosition + 35
        return Category
    end

    local function CreateToggle(text, callback)
        local Toggle = Instance.new("Frame")
        Toggle.Size = UDim2.new(1, 0, 0, 40)
        Toggle.Position = UDim2.new(0, 0, 0, LastPosition)
        Toggle.BackgroundTransparency = 1
        Toggle.Parent = ScrollingFrame
        
        local Background = Instance.new("Frame")
        Background.Size = UDim2.new(1, 0, 1, -5)
        Background.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Background.BackgroundTransparency = 0.8
        Background.Parent = Toggle
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Background
        
        local Label = Instance.new("TextLabel")
        Label.Text = text
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 15, 0, 0)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 16
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Toggle
        
        local Button = Instance.new("Frame")
        Button.Size = UDim2.new(0, 44, 0, 24)
        Button.Position = UDim2.new(1, -54, 0.5, -12)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.Parent = Toggle
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = Button
        
        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 18, 0, 18)
        Knob.Position = UDim2.new(0, 3, 0.5, -9)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.Parent = Button
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = Knob
        
        local enabled = false
        Button.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                enabled = not enabled
                local targetPos = enabled and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
                local targetColor = enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(50, 50, 50)
                
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = targetPos}):Play()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
                callback(enabled)
            end
        end)
        
        LastPosition = LastPosition + 45
        return Toggle, Button, Knob
    end

    local function CreateSlider(text, min, max, default, callback)
        local Slider = Instance.new("Frame")
        Slider.Size = UDim2.new(1, 0, 0, 55)
        Slider.Position = UDim2.new(0, 0, 0, LastPosition)
        Slider.BackgroundTransparency = 1
        Slider.Parent = ScrollingFrame
        
        local Background = Instance.new("Frame")
        Background.Size = UDim2.new(1, 0, 1, -5)
        Background.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Background.BackgroundTransparency = 0.8
        Background.Parent = Slider
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Background
        
        local Label = Instance.new("TextLabel")
        Label.Text = text
        Label.Size = UDim2.new(1, -50, 0, 25)
        Label.Position = UDim2.new(0, 15, 0, 5)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 16
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Slider
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Text = tostring(default)
        ValueLabel.Size = UDim2.new(0, 40, 0, 25)
        ValueLabel.Position = UDim2.new(1, -45, 0, 5)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ValueLabel.TextSize = 16
        ValueLabel.Font = Enum.Font.Gotham
        ValueLabel.Parent = Slider
        
        local SliderBar = Instance.new("Frame")
        SliderBar.Size = UDim2.new(1, -30, 0, 4)
        SliderBar.Position = UDim2.new(0, 15, 0, 40)
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
        Knob.Size = UDim2.new(0, 16, 0, 16)
        Knob.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
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
                Knob.Position = UDim2.new(percent, -8, 0.5, -8)
                ValueLabel.Text = string.format("%.1f", value)
                callback(value)
            end
        end)
        
        LastPosition = LastPosition + 60
        return Slider
    end

    -- 窗口拖动
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

    -- 关闭按钮行为
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        ReopenButton.Visible = true  -- 显示重新打开按钮
    end)

    -- 重新打开按钮行为
    ReopenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        ReopenButton.Visible = false  -- 隐藏重新打开按钮
        
        -- 添加打开动画
        MainFrame.Position = UDim2.new(0.5, -150, 0, -400)  -- 从屏幕顶部开始
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {
            Position = UDim2.new(0.5, -150, 0.5, -200)  -- 弹到中间位置
        }):Play()
    end)

    -- 重新打开按钮的悬停效果
    ReopenButton.MouseEnter:Connect(function()
        TweenService:Create(ReopenButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            Size = UDim2.new(0, 185, 0, 47)  -- 略微放大
        }):Play()
    end)

    ReopenButton.MouseLeave:Connect(function()
        TweenService:Create(ReopenButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0, 180, 0, 45)  -- 恢复原始大小
        }):Play()
    end)

    -- 返回UI元素和函数
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        StatusLabel = StatusLabel,
        ScrollingFrame = ScrollingFrame,
        CreateCategory = CreateCategory,
        CreateToggle = CreateToggle,
        CreateSlider = CreateSlider,
        LastPosition = LastPosition
    }
end

return UIModule
