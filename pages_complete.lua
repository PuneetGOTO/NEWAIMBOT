-- 完整的Pages功能代码
return function(MainFrame, MainContent, HomeButton, PagesButton)
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
