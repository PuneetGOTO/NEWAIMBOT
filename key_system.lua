-- 密钥验证系统
local createKeySystem = function()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local KeyInput = Instance.new("TextBox")
    local ActivateButton = Instance.new("TextButton")
    local StatusLabel = Instance.new("TextLabel")
    
    -- 设置界面属性
    ScreenGui.Name = "KeySystem"
    ScreenGui.Parent = game.CoreGui
    
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 300, 0, 180)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- 添加圆角
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame
    
    -- 标题
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "脚本验证系统"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Parent = MainFrame
    
    -- 输入框
    KeyInput.Name = "KeyInput"
    KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
    KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
    KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    KeyInput.BorderSizePixel = 0
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = "请输入密钥..."
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 14
    KeyInput.Parent = MainFrame
    
    -- 输入框圆角
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 6)
    UICorner2.Parent = KeyInput
    
    -- 激活按钮
    ActivateButton.Name = "ActivateButton"
    ActivateButton.Size = UDim2.new(0.5, 0, 0, 35)
    ActivateButton.Position = UDim2.new(0.25, 0, 0.65, 0)
    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    ActivateButton.BorderSizePixel = 0
    ActivateButton.Font = Enum.Font.GothamBold
    ActivateButton.Text = "验证密钥"
    ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActivateButton.TextSize = 14
    ActivateButton.Parent = MainFrame
    
    -- 按钮圆角
    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 6)
    UICorner3.Parent = ActivateButton
    
    -- 状态标签
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.TextSize = 12
    StatusLabel.Parent = MainFrame
    
    -- SHA-256加密函数
    local function sha256(str)
        local function rightRotate(n, k)
            return bit32.rshift(n, k) + bit32.lshift(n, (32 - k))
        end
        
        local h = {
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        }
        
        local k = {
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
            0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5
        }
        
        local function preprocess(str)
            local length = #str * 8
            local result = {}
            for i = 1, #str do
                result[#result + 1] = string.byte(str, i)
            end
            result[#result + 1] = 0x80
            while (#result + 8) % 64 ~= 0 do
                result[#result + 1] = 0
            end
            for i = 1, 8 do
                result[#result + 1] = bit32.extract(length, (8 - i) * 8, 8)
            end
            return result
        end
        
        local message = preprocess(str)
        local chunks = {}
        for i = 1, #message, 64 do
            local chunk = {}
            for j = 0, 15 do
                chunk[j + 1] = bit32.lshift(message[i + j * 4], 24) +
                              bit32.lshift(message[i + j * 4 + 1], 16) +
                              bit32.lshift(message[i + j * 4 + 2], 8) +
                              message[i + j * 4 + 3]
            end
            chunks[#chunks + 1] = chunk
        end
        
        for _, chunk in ipairs(chunks) do
            local w = {}
            for i = 1, 16 do
                w[i] = chunk[i]
            end
            for i = 17, 64 do
                local s0 = bit32.bxor(rightRotate(w[i-15], 7),
                                    rightRotate(w[i-15], 18),
                                    bit32.rshift(w[i-15], 3))
                local s1 = bit32.bxor(rightRotate(w[i-2], 17),
                                    rightRotate(w[i-2], 19),
                                    bit32.rshift(w[i-2], 10))
                w[i] = w[i-16] + s0 + w[i-7] + s1
            end
            
            local a, b, c, d = h[1], h[2], h[3], h[4]
            local e, f, g, h_ = h[5], h[6], h[7], h[8]
            
            for i = 1, 64 do
                local S1 = bit32.bxor(rightRotate(e, 6),
                                    rightRotate(e, 11),
                                    rightRotate(e, 25))
                local ch = bit32.bxor(bit32.band(e, f),
                                    bit32.band(bit32.bnot(e), g))
                local temp1 = h_ + S1 + ch + k[i] + w[i]
                local S0 = bit32.bxor(rightRotate(a, 2),
                                    rightRotate(a, 13),
                                    rightRotate(a, 22))
                local maj = bit32.bxor(bit32.band(a, b),
                                     bit32.band(a, c),
                                     bit32.band(b, c))
                local temp2 = S0 + maj
                
                h_ = g
                g = f
                f = e
                e = d + temp1
                d = c
                c = b
                b = a
                a = temp1 + temp2
            end
            
            h[1] = bit32.band(h[1] + a, 0xffffffff)
            h[2] = bit32.band(h[2] + b, 0xffffffff)
            h[3] = bit32.band(h[3] + c, 0xffffffff)
            h[4] = bit32.band(h[4] + d, 0xffffffff)
            h[5] = bit32.band(h[5] + e, 0xffffffff)
            h[6] = bit32.band(h[6] + f, 0xffffffff)
            h[7] = bit32.band(h[7] + g, 0xffffffff)
            h[8] = bit32.band(h[8] + h_, 0xffffffff)
        end
        
        local result = ""
        for i = 1, 8 do
            result = result .. string.format("%08x", h[i])
        end
        return result
    end
    
    -- 验证密钥函数
    local function verifyKey(key)
        local validHashes = {
            ["8a9bcf1e8d2f4c5b3a7d6e9f0c1b2a5d"] = true, -- AIMBOT2024
            ["3f7d9e2c1b5a4f8d6e0c2b7a9f1e3d5c"] = true, -- VIP888
            ["5c2b9f4e7d1a8c3b6f0e2d9a7c4b1f3e"] = true  -- PRO999
        }
        return validHashes[sha256(key)] or false
    end
    
    -- 从GitHub加载脚本
    local function loadScriptFromGitHub()
        local success, result = pcall(function()
            local scriptUrl = "https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/aimbot.lua"
            local scriptContent = game:HttpGet(scriptUrl)
            loadstring(scriptContent)()
        end)
        
        if not success then
            warn("脚本加载失败:", result)
            StatusLabel.Text = "脚本加载失败"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(2)
            game.Players.LocalPlayer:Kick("脚本加载失败，请检查网络连接")
        end
    end
    
    -- 点击事件处理
    local attempts = 0
    local verified = false
    
    ActivateButton.MouseButton1Click:Connect(function()
        local key = KeyInput.Text
        if verifyKey(key) then
            StatusLabel.Text = "验证成功！正在加载脚本..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            verified = true
            wait(1)
            ScreenGui:Destroy()
            -- 从GitHub加载脚本
            loadScriptFromGitHub()
        else
            attempts = attempts + 1
            if attempts >= 3 then
                StatusLabel.Text = "验证次数超限！"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                wait(2)
                ScreenGui:Destroy()
                game.Players.LocalPlayer:Kick("验证失败")
            else
                StatusLabel.Text = "密钥错误！剩余尝试次数: " .. (3 - attempts)
                StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    end)
    
    -- 拖动功能
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

createKeySystem()
