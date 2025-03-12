-- Puneet Aimbot Loader V6
local MainURL = "https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot_modern_v6.lua"

-- 创建加载按钮
local LoadButton = Instance.new("TextButton")
LoadButton.Size = UDim2.new(0, 150, 0, 40)
LoadButton.Position = UDim2.new(0.5, -75, 0, 20)  -- 放在屏幕顶部中间
LoadButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.Text = "Puneet脚本"
LoadButton.Font = Enum.Font.SourceSansBold
LoadButton.TextSize = 18
LoadButton.Parent = game.CoreGui
LoadButton.ZIndex = 999999

-- 添加阴影效果
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.Parent = LoadButton

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = LoadButton

-- 添加悬停效果
LoadButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(LoadButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(0, 155, 0, 42)
    }):Play()
end)

LoadButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(LoadButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Size = UDim2.new(0, 150, 0, 40)
    }):Play()
end)

-- 加载主脚本
LoadButton.MouseButton1Click:Connect(function()
    LoadButton:Destroy()
    loadstring(game:HttpGet(MainURL))()
end)

print("Puneet Aimbot Loader V6 已加载！点击屏幕顶部的按钮开始使用。")
