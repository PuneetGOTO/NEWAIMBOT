-- Pages页面基本框架
return function(MainFrame)
    local PagesFrame = Instance.new("Frame")
    PagesFrame.Name = "PagesFrame"
    PagesFrame.Parent = MainFrame
    PagesFrame.BackgroundTransparency = 1
    PagesFrame.Position = UDim2.new(0, 20, 0, 140)
    PagesFrame.Size = UDim2.new(1, -40, 1, -180)
    PagesFrame.Visible = false
    
    return PagesFrame
end
