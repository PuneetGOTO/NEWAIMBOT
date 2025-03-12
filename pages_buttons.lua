-- Pages页面功能按钮
return function(PagesFrame, createFeatureButton)
    -- 功能按钮配置
    local buttons = {
        {name = "AUTO FARM", desc = "Auto farm levels and\nresources", pos = UDim2.new(0, 0, 0, 0)},
        {name = "STATS", desc = "View and track your\nprogress", pos = UDim2.new(0.52, 0, 0, 0)},
        {name = "TELEPORT", desc = "Quick teleport to\nany location", pos = UDim2.new(0, 0, 0, 90)},
        {name = "RAID", desc = "Join and auto\nraid features", pos = UDim2.new(0.52, 0, 0, 90)},
        {name = "PVP", desc = "Enhanced PVP\ncombat features", pos = UDim2.new(0, 0, 0, 180)},
        {name = "MISC", desc = "Additional utility\nfeatures", pos = UDim2.new(0.52, 0, 0, 180)}
    }

    -- 创建所有功能按钮
    for _, btn in ipairs(buttons) do
        local button = createFeatureButton(btn.name, "rbxassetid://7072721682", btn.desc, btn.pos)
        button.Parent = PagesFrame
        button.Size = UDim2.new(0.48, 0, 0, 80)
    end
end
