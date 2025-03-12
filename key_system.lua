local function createKeySystem()
    -- 配置
    local config = {
        maxAttempts = 10  -- 最大尝试次数
    }
    
    -- 创建GUI元素
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local KeyInput = Instance.new("TextBox")
    local ActivateButton = Instance.new("TextButton")
    local StatusLabel = Instance.new("TextLabel")
    local AttemptsLabel = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local UICorner2 = Instance.new("UICorner")
    local UICorner3 = Instance.new("UICorner")
    
    -- 设置GUI属性
    ScreenGui.Name = "KeySystem"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Frame.Name = "MainFrame"
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.Size = UDim2.new(0, 300, 0, 200)
    
    Title.Name = "Title"
    Title.Parent = Frame
    Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "密钥验证系统"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16.000
    
    KeyInput.Name = "KeyInput"
    KeyInput.Parent = Frame
    KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
    KeyInput.Font = Enum.Font.SourceSans
    KeyInput.PlaceholderText = "请输入密钥..."
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 14.000
    KeyInput.ClearTextOnFocus = true
    KeyInput.TextEditable = true
    
    ActivateButton.Name = "ActivateButton"
    ActivateButton.Parent = Frame
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    ActivateButton.Position = UDim2.new(0.1, 0, 0.55, 0)
    ActivateButton.Size = UDim2.new(0.8, 0, 0, 30)
    ActivateButton.Font = Enum.Font.SourceSansBold
    ActivateButton.Text = "验证"
    ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActivateButton.TextSize = 14.000
    
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Parent = Frame
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Position = UDim2.new(0, 0, 0.75, 0)
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.Font = Enum.Font.SourceSans
    StatusLabel.Text = "请输入密钥"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.TextSize = 14.000
    
    AttemptsLabel.Name = "AttemptsLabel"
    AttemptsLabel.Parent = Frame
    AttemptsLabel.BackgroundTransparency = 1
    AttemptsLabel.Position = UDim2.new(0, 0, 0.85, 0)
    AttemptsLabel.Size = UDim2.new(1, 0, 0, 20)
    AttemptsLabel.Font = Enum.Font.SourceSans
    AttemptsLabel.Text = string.format("剩余尝试次数: %d", config.maxAttempts)
    AttemptsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AttemptsLabel.TextSize = 14.000
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    
    UICorner2.CornerRadius = UDim.new(0, 6)
    UICorner2.Parent = KeyInput
    
    UICorner3.CornerRadius = UDim.new(0, 6)
    UICorner3.Parent = ActivateButton
    
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
        AttemptsLabel.Text = string.format("剩余尝试次数: %d", config.maxAttempts - state.attempts)
        
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
    
    -- 加载主程序
    local function loadMainScript()
        print("正在加载主程序...")
        
        -- 从远程加载脚本
        local success, result = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot.lua")
        end)
        
        if not success then
            warn("下载脚本失败:", result)
            return false
        end
        
        -- 加载并执行脚本
        local success, result = pcall(loadstring(result))
        if not success then
            warn("加载脚本失败:", result)
            return false
        end
        
        print("脚本加载成功")
        return true
    end
    
    -- 点击事件处理
    local function onButtonClick()
        print("按钮被点击")
        
        -- 检查是否已经验证成功
        if state.verified then
            print("已经验证成功，无需重复验证")
            return
        end
        
        -- 检查是否超过最大尝试次数
        if state.attempts >= config.maxAttempts then
            print("验证次数超限")
            StatusLabel.Text = "验证次数超限！"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(2)
            game.Players.LocalPlayer:Kick("验证失败")
            return
        end
        
        -- 获取输入的密钥
        local key = KeyInput.Text
        KeyInput.Text = ""  -- 清空输入框
        
        -- 验证密钥
        if verifyKey(key) then
            print("密钥验证成功")
            state.verified = true
            StatusLabel.Text = "验证成功！正在启动..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            
            -- 等待短暂时间后销毁GUI
            wait(1)
            
            -- 加载主程序
            if loadMainScript() then
                ScreenGui:Destroy()
            else
                StatusLabel.Text = "主程序加载失败！"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                wait(2)
                game.Players.LocalPlayer:Kick("主程序加载失败")
            end
        else
            print("密钥验证失败")
            StatusLabel.Text = "密钥错误！"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            
            if state.attempts >= config.maxAttempts then
                wait(2)
                game.Players.LocalPlayer:Kick("验证失败")
            end
        end
    end
    
    -- 绑定按钮点击事件
    ActivateButton.MouseButton1Click:Connect(onButtonClick)
    print("按钮点击事件绑定完成")
    
    -- 添加按钮视觉反馈
    ActivateButton.MouseButton1Down:Connect(function()
        ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
    end)
    
    ActivateButton.MouseButton1Up:Connect(function()
        ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end)
    
    -- 添加按钮悬停效果
    ActivateButton.MouseEnter:Connect(function()
        ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
    end)
    
    ActivateButton.MouseLeave:Connect(function()
        ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end)
    
    -- 添加键盘事件处理
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Return then
            onButtonClick()
        end
    end)
    
    -- 拖动功能
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Frame.InputChanged:Connect(function(input)
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
