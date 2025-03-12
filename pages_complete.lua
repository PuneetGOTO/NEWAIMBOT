-- 完整的Pages功能代码
return function(MainFrame, MainContent, HomeButton, PagesButton, createFeatureButton)
    -- 创建Pages页面框架
    local PagesFrame = Instance.new("Frame")
    PagesFrame.Name = "PagesFrame"
    PagesFrame.Parent = MainFrame
    PagesFrame.BackgroundTransparency = 1
    PagesFrame.Position = UDim2.new(0, 20, 0, 140)
    PagesFrame.Size = UDim2.new(1, -40, 1, -180)
    PagesFrame.Visible = false

    -- 功能按钮配置
    local buttons = {
        {name = "AUTO FARM", desc = "Auto farm levels and\nresources", pos = UDim2.new(0, 0, 0, 0)},
        {name = "STATS", desc = "View and track your\nprogress", pos = UDim2.new(0.52, 0, 0, 0)},
        {name = "TELEPORT", desc = "Quick teleport to\nany location", pos = UDim2.new(0, 0, 0, 90)},
        {name = "RAID", desc = "Join and auto\nraid features", pos = UDim2.new(0.52, 0, 0, 90)},
        {name = "PVP", desc = "Enhanced PVP\ncombat features", pos = UDim2.new(0, 0, 0, 180)},
        {name = "MISC", desc = "Additional utility\nfeatures", pos = UDim2.new(0.52, 0, 0, 180)},
        {name = "TEAM CHECK", desc = "Check team status", pos = UDim2.new(0, 0, 0, 270)},
        {name = "WALL CHECK", desc = "Check wall status", pos = UDim2.new(0.52, 0, 0, 270)},
        {name = "THIRD PERSON", desc = "Toggle third person view", pos = UDim2.new(0, 0, 0, 360)},
        {name = "TOGGLE", desc = "Toggle feature", pos = UDim2.new(0.52, 0, 0, 360)},
        {name = "FOV", desc = "Adjust field of view", pos = UDim2.new(0, 0, 0, 450)},
        {name = "SENSITIVITY", desc = "Adjust sensitivity", pos = UDim2.new(0.52, 0, 0, 450)},
    }

    -- 创建所有功能按钮
    for _, btn in ipairs(buttons) do
        local button = createFeatureButton(btn.name, "rbxassetid://7072721682", btn.desc, btn.pos)
        button.Parent = PagesFrame
        button.Size = UDim2.new(0.48, 0, 0, 80)
    end

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
