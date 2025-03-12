-- Pages页面切换逻辑
return function(MainContent, PagesFrame, HomeButton, PagesButton)
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
