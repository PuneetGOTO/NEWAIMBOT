-- Puneet Aimbot Key System V14

-- 创建UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystem"
ScreenGui.Parent = game.CoreGui

-- 主窗口
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Parent = ScreenGui

-- 圆角
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Parent = MainFrame

-- 标题栏圆角
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- 标题
local Title = Instance.new("TextLabel")
Title.Text = "Puneet脚本 - 密钥系统"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar

-- 输入框
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderText = "输入密钥..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
KeyInput.Text = ""
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.SourceSans
KeyInput.Parent = MainFrame
KeyInput.ClearTextOnFocus = false

-- 输入框圆角
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = KeyInput

-- 提交按钮
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.8, 0, 0, 35)
SubmitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Text = "验证"
SubmitButton.TextSize = 16
SubmitButton.Font = Enum.Font.SourceSansBold
SubmitButton.Parent = MainFrame
SubmitButton.AutoButtonColor = false

-- 提交按钮圆角
local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 6)
SubmitCorner.Parent = SubmitButton

-- 状态标签
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.8, 0, 0, 25)
StatusLabel.Position = UDim2.new(0.1, 0, 0.85, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
StatusLabel.Text = ""
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Parent = MainFrame

-- 阴影
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 24, 1, 24)
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.Parent = MainFrame
Shadow.ZIndex = 0

-- 加载动画
local LoadingIcon = Instance.new("ImageLabel")
LoadingIcon.Size = UDim2.new(0, 20, 0, 20)
LoadingIcon.Position = UDim2.new(0, 10, 0.5, -10)
LoadingIcon.BackgroundTransparency = 1
LoadingIcon.Image = "rbxassetid://3926305904"
LoadingIcon.ImageRectOffset = Vector2.new(284, 924)
LoadingIcon.ImageRectSize = Vector2.new(36, 36)
LoadingIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
LoadingIcon.Parent = SubmitButton
LoadingIcon.Visible = false

-- 服务
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- 动画效果
local function playLoadingAnimation()
    LoadingIcon.Visible = true
    local rotationTween = TweenService:Create(LoadingIcon, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
        Rotation = 360
    })
    rotationTween:Play()
    return rotationTween
end

-- 按钮悬停效果
SubmitButton.MouseEnter:Connect(function()
    TweenService:Create(SubmitButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(0, 100, 220)
    }):Play()
end)

SubmitButton.MouseLeave:Connect(function()
    TweenService:Create(SubmitButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    }):Play()
end)

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

-- 关闭按钮
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 密钥验证
local function verifyKey(key)
    -- 这里是密钥验证逻辑
    -- 可以根据需要修改验证方式
    return key == "puneet666"
end

-- 加载主脚本
local function loadMainScript()
    local success, result = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/loader_v14.lua"))()
    end)
    
    if not success then
        StatusLabel.Text = "脚本加载失败"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
        task.wait(2)
        ScreenGui:Destroy()
    else
        ScreenGui:Destroy()
    end
end

-- 提交按钮点击
local isVerifying = false
SubmitButton.MouseButton1Click:Connect(function()
    if isVerifying then return end
    isVerifying = true
    
    -- 开始加载动画
    local loadingTween = playLoadingAnimation()
    SubmitButton.Text = "验证中..."
    
    -- 模拟验证延迟
    task.wait(1)
    
    -- 验证密钥
    local key = KeyInput.Text
    if verifyKey(key) then
        StatusLabel.Text = "密钥正确！正在加载脚本..."
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        -- 停止加载动画
        if loadingTween then
            loadingTween:Cancel()
        end
        LoadingIcon.Visible = false
        
        -- 加载主脚本
        task.wait(1)
        loadMainScript()
    else
        StatusLabel.Text = "密钥错误！"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
        
        -- 停止加载动画
        if loadingTween then
            loadingTween:Cancel()
        end
        LoadingIcon.Visible = false
        SubmitButton.Text = "验证"
        isVerifying = false
    end
end)

print("Puneet Aimbot Key System V14 已加载！")
