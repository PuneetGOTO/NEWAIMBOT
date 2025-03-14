local function createKeySystem()
    -- 配置
    local config = {
        maxAttempts = inf  -- 最大尝试次数
    }
    
    -- 创建GUI元素
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")  -- 改为TextLabel显示PUPUHUB
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
    Title.Font = Enum.Font.GothamBold
    Title.Text = "PUPUHUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28.000
    
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
    SocialInfo.Text = "DC @puneet | https://discord.gg/eyrMV7MKck"
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
    
    -- 状态变量
    local state = {
        attempts = 0,
        verified = false
    }
    
    -- 验证密钥函数
    local function verifyKey(key)
        -- 检查尝试次数
        if state.attempts >= config.maxAttempts then
            print("超过最大尝试次数")
            return false
        end
        
        -- 增加尝试次数
        state.attempts = state.attempts + 1
        
        print("正在验证密钥:", key)
        print("密钥长度:", #key)
        print("剩余尝试次数:", config.maxAttempts - state.attempts)
        
        -- 检查密钥是否为空
        if key == "" then
            print("密钥不能为空")
            return false
        end
        
        -- 有效的密钥列表
        local validKeys = {
            "VIP888",
            "AIMBOT2024",
            "PRO999"
        }
        
        -- 验证密钥
        for _, validKey in ipairs(validKeys) do
            if key == validKey then
                print("密钥验证成功")
                return true
            end
        end
        
        print("密钥验证失败")
        return false
    end
    
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
        
        -- 检查是否已经验证成功
        if state.verified then
            print("已经验证成功，无需重复验证")
            return
        end
        
        -- 检查是否超过最大尝试次数
        if state.attempts >= config.maxAttempts then
            print("验证次数超限")
            wait(2)
            game.Players.LocalPlayer:Kick("验证失败")
            return
        end
        
        -- 验证密钥
        if verifyKey(key) then
            print("密钥验证成功")
            state.verified = true
            
            -- 等待短暂时间后销毁GUI
            wait(1)
            
            -- 从远程加载脚本
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
                wait(2)
                game.Players.LocalPlayer:Kick("主程序加载失败")
                return
            end
            
            ScreenGui:Destroy()
        else
            if state.attempts >= config.maxAttempts then
                wait(2)
                game.Players.LocalPlayer:Kick("验证失败")
            end
        end
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
