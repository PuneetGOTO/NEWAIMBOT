-- Puneet Aimbot Loader V9

-- 创建一个漂亮的启动按钮
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PuneetLoader"
ScreenGui.Parent = game.CoreGui

-- 主按钮
local MainButton = Instance.new("TextButton")
MainButton.Name = "PuneetButton"
MainButton.Size = UDim2.new(0, 180, 0, 45)
MainButton.Position = UDim2.new(0.5, -90, 0, 20)  -- 屏幕顶部中间
MainButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "Puneet脚本"
MainButton.Font = Enum.Font.GothamBold
MainButton.TextSize = 20
MainButton.Parent = ScreenGui
MainButton.ZIndex = 999999
MainButton.AutoButtonColor = false  -- 自定义悬停效果

-- 圆角
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButton

-- 渐变效果
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
})
UIGradient.Parent = MainButton

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
Shadow.Parent = MainButton

-- 加载图标
local LoadingIcon = Instance.new("ImageLabel")
LoadingIcon.Size = UDim2.new(0, 20, 0, 20)
LoadingIcon.Position = UDim2.new(0, 10, 0.5, -10)
LoadingIcon.BackgroundTransparency = 1
LoadingIcon.Image = "rbxassetid://3926305904"  -- 使用Roblox的加载图标
LoadingIcon.ImageRectOffset = Vector2.new(284, 924)
LoadingIcon.ImageRectSize = Vector2.new(36, 36)
LoadingIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
LoadingIcon.Parent = MainButton
LoadingIcon.Visible = false

-- 动画效果
local TweenService = game:GetService("TweenService")

-- 旋转动画
local function playLoadingAnimation()
    LoadingIcon.Visible = true
    local rotationTween = TweenService:Create(LoadingIcon, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
        Rotation = 360
    })
    rotationTween:Play()
end

-- 悬停效果
MainButton.MouseEnter:Connect(function()
    TweenService:Create(MainButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(0, 185, 0, 47)  -- 略微放大
    }):Play()
    
    TweenService:Create(Shadow, TweenInfo.new(0.3), {
        ImageTransparency = 0.4
    }):Play()
end)

MainButton.MouseLeave:Connect(function()
    TweenService:Create(MainButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Size = UDim2.new(0, 180, 0, 45)  -- 恢复原始大小
    }):Play()
    
    TweenService:Create(Shadow, TweenInfo.new(0.3), {
        ImageTransparency = 0.6
    }):Play()
end)

-- 点击效果
MainButton.MouseButton1Down:Connect(function()
    TweenService:Create(MainButton, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 175, 0, 43)  -- 按下时缩小
    }):Play()
end)

MainButton.MouseButton1Up:Connect(function()
    TweenService:Create(MainButton, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 180, 0, 45)  -- 松开时恢复
    }):Play()
end)

-- 加载主脚本
MainButton.MouseButton1Click:Connect(function()
    -- 显示加载动画
    playLoadingAnimation()
    MainButton.Text = "正在加载..."
    
    -- 加载主脚本
    task.spawn(function()
        local success, result = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot_modern_v5.lua"))()
        end)
        
        if success then
            -- 成功加载后销毁加载器
            ScreenGui:Destroy()
        else
            -- 加载失败显示错误
            MainButton.Text = "加载失败"
            LoadingIcon.Visible = false
            task.wait(2)
            MainButton.Text = "Puneet脚本"
        end
    end)
end)

print("Puneet Aimbot Loader V9 已加载！点击屏幕顶部的按钮开始使用。")
