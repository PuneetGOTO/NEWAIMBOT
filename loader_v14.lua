-- Puneet Aimbot Loader V14

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
local UserInputService = game:GetService("UserInputService")

-- 旋转动画
local function playLoadingAnimation()
    LoadingIcon.Visible = true
    local rotationTween = TweenService:Create(LoadingIcon, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
        Rotation = 360
    })
    rotationTween:Play()
    return rotationTween
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

-- 右键拖动功能
local dragging = false
local dragStart = nil
local startPos = nil

MainButton.MouseButton2Down:Connect(function(input)
    dragging = true
    dragStart = UserInputService:GetMouseLocation()
    startPos = MainButton.Position
    
    -- 添加拖动提示效果
    TweenService:Create(MainButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 60)  -- 拖动时变暗
    }):Play()
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UserInputService:GetMouseLocation() - dragStart
        local newPosition = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        
        -- 确保按钮不会完全离开屏幕
        local buttonSize = MainButton.AbsoluteSize
        local screenSize = MainButton.Parent.AbsoluteSize
        
        local minX = -buttonSize.X * 0.5
        local maxX = screenSize.X - buttonSize.X * 0.5
        local minY = 0
        local maxY = screenSize.Y - buttonSize.Y
        
        newPosition = UDim2.new(
            0,
            math.clamp(newPosition.X.Offset, minX, maxX),
            0,
            math.clamp(newPosition.Y.Offset, minY, maxY)
        )
        
        MainButton.Position = newPosition
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        dragging = false
        -- 恢复正常颜色
        TweenService:Create(MainButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()
    end
end)

-- 加载主脚本
local loadedScript = false
local loadingTween = nil

MainButton.MouseButton1Click:Connect(function()
    if not loadedScript then
        -- 显示加载动画
        loadingTween = playLoadingAnimation()
        MainButton.Text = "正在加载..."
        
        -- 加载主脚本
        task.spawn(function()
            local success, result = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot_modern_v14.lua"))()
            end)
            
            if success then
                -- 成功加载后
                loadedScript = true
                if loadingTween then
                    loadingTween:Cancel()
                end
                LoadingIcon.Visible = false
                MainButton.Text = "Puneet脚本"
                -- 隐藏按钮（主脚本会在需要时显示它）
                MainButton.Visible = false
                
                -- 立即显示UI
                if getgenv().Aimbot and getgenv().Aimbot.ShowUI then
                    getgenv().Aimbot.ShowUI()
                end
            else
                -- 加载失败显示错误
                if loadingTween then
                    loadingTween:Cancel()
                end
                LoadingIcon.Visible = false
                MainButton.Text = "加载失败"
                task.wait(2)
                MainButton.Text = "Puneet脚本"
                loadedScript = false  -- 重置状态，允许重试
            end
        end)
    else
        -- 如果脚本已经加载，显示UI
        if getgenv().Aimbot and getgenv().Aimbot.ShowUI then
            getgenv().Aimbot.ShowUI()
        end
    end
end)

-- 导出按钮，供主脚本使用
getgenv().PuneetButton = MainButton

print("Puneet Aimbot Loader V14 已加载！点击屏幕顶部的按钮开始使用。右键可以拖动按钮位置！")
