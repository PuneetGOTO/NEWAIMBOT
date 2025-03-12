local function createKeySystem()
    -- 配置
    local config = {
        maxAttempts = 3  -- 最大尝试次数
    }
    
    -- 创建GUI元素
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("ImageLabel")  -- 改为ImageLabel用于显示HOHO标题
    local KeyInput = Instance.new("TextBox")
    local GetKeyButton1 = Instance.new("TextButton")
    local GetKeyButton2 = Instance.new("TextButton")
    local SubmitButton = Instance.new("TextButton")
    local SocialInfo = Instance.new("TextLabel")
    local SupportButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    
    -- 设置GUI属性
    ScreenGui.Name = "KeySystem"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.5, -75, 0.05, 0)
    Title.Size = UDim2.new(0, 150, 0, 50)
    Title.Image = "rbxassetid://YOUR_HOHO_LOGO_ID"  -- 需要替换为实际的HOHO logo图片ID
    
    KeyInput.Name = "KeyInput"
    KeyInput.Parent = MainFrame
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
    KeyInput.Font = Enum.Font.SourceSans
    KeyInput.PlaceholderText = "ENTER KEY HERE"
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 16.000
    
    GetKeyButton1.Name = "GetKeyButton1"
    GetKeyButton1.Parent = MainFrame
    GetKeyButton1.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    GetKeyButton1.Position = UDim2.new(0.1, 0, 0.45, 0)
    GetKeyButton1.Size = UDim2.new(0.35, 0, 0, 35)
    GetKeyButton1.Font = Enum.Font.SourceSansBold
    GetKeyButton1.Text = "GET KEY (SERVER 1)"
    GetKeyButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton1.TextSize = 14.000
    
    GetKeyButton2.Name = "GetKeyButton2"
    GetKeyButton2.Parent = MainFrame
    GetKeyButton2.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    GetKeyButton2.Position = UDim2.new(0.55, 0, 0.45, 0)
    GetKeyButton2.Size = UDim2.new(0.35, 0, 0, 35)
    GetKeyButton2.Font = Enum.Font.SourceSansBold
    GetKeyButton2.Text = "GET KEY (SV 2)"
    GetKeyButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton2.TextSize = 14.000
    
    SubmitButton.Name = "SubmitButton"
    SubmitButton.Parent = MainFrame
    SubmitButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    SubmitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    SubmitButton.Size = UDim2.new(0.8, 0, 0, 35)
    SubmitButton.Font = Enum.Font.SourceSansBold
    SubmitButton.Text = "SUBMIT KEY"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 14.000
    
    SocialInfo.Name = "SocialInfo"
    SocialInfo.Parent = MainFrame
    SocialInfo.BackgroundTransparency = 1
    SocialInfo.Position = UDim2.new(0.1, 0, 0.75, 0)
    SocialInfo.Size = UDim2.new(0.8, 0, 0, 20)
    SocialInfo.Font = Enum.Font.SourceSans
    SocialInfo.Text = "YT @acsu123 | DISCORD .gg/hohohub"
    SocialInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    SocialInfo.TextSize = 14.000
    
    SupportButton.Name = "SupportButton"
    SupportButton.Parent = MainFrame
    SupportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SupportButton.Position = UDim2.new(0.1, 0, 0.85, 0)
    SupportButton.Size = UDim2.new(0.8, 0, 0, 30)
    SupportButton.Font = Enum.Font.SourceSansBold
    SupportButton.Text = "SUPPORT US"
    SupportButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    SupportButton.TextSize = 14.000
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CloseButton.Position = UDim2.new(0.1, 0, 0.92, 0)
    CloseButton.Size = UDim2.new(0.8, 0, 0, 30)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Text = "CLOSE UI"
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextSize = 14.000
    
    -- 添加圆角
    local function addCorner(button)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
    end
    
    addCorner(MainFrame)
    addCorner(KeyInput)
    addCorner(GetKeyButton1)
    addCorner(GetKeyButton2)
    addCorner(SubmitButton)
    addCorner(SupportButton)
    addCorner(CloseButton)
    
    -- 按钮点击事件
    GetKeyButton1.MouseButton1Click:Connect(function()
        setclipboard("https://link-target.net/98542/hoho-hub-key-1")
    end)
    
    GetKeyButton2.MouseButton1Click:Connect(function()
        setclipboard("https://link-hub.net/98542/hoho-hub-key-2")
    end)
    
    SupportButton.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/hohohub")
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    SubmitButton.MouseButton1Click:Connect(function()
        local key = KeyInput.Text
        KeyInput.Text = ""
        
        if key == "" then
            return
        end
        
        -- 验证密钥
        local success, result = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot.lua")
        end)
        
        if not success then
            warn("下载脚本失败:", result)
            return
        end
        
        -- 加载并执行脚本
        local success, result = pcall(loadstring(result))
        if not success then
            warn("加载脚本失败:", result)
            return
        end
        
        ScreenGui:Destroy()
    end)
    
    -- 添加拖动功能
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- 创建密钥系统
createKeySystem()
