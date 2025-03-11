-- 密钥验证系统
local function createKeySystem()
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
        local bit = bit32 or bit
        local band = bit.band
        local bnot = bit.bnot
        local bxor = bit.bxor
        local rshift = bit.rshift
        local lshift = bit.lshift
        local rrotate = bit.rrotate or function(x, n) return band(rshift(x, n), lshift(x, (32 - n))) end
        
        local H = {
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        }
        
        local K = {
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
            0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
            0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3
        }
        
        local function digestblock(msg, i, H)
            local w = {}
            for j = 1, 16 do
                w[j] = band(rshift(msg[i + j - 1], 24), 0xFF) * 0x1000000 +
                       band(rshift(msg[i + j - 1], 16), 0xFF) * 0x10000 +
                       band(rshift(msg[i + j - 1], 8), 0xFF) * 0x100 +
                       band(msg[i + j - 1], 0xFF)
            end
            
            local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
            
            for i = 1, 16 do
                local temp1 = h + bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25)) +
                             bxor(band(e, f), band(bnot(e), g)) + K[i] + w[i]
                local temp2 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22)) +
                             bxor(band(a, b), band(a, c), band(b, c))
                h = g
                g = f
                f = e
                e = band(d + temp1, 0xFFFFFFFF)
                d = c
                c = b
                b = a
                a = band(temp1 + temp2, 0xFFFFFFFF)
            end
            
            H[1] = band(H[1] + a, 0xFFFFFFFF)
            H[2] = band(H[2] + b, 0xFFFFFFFF)
            H[3] = band(H[3] + c, 0xFFFFFFFF)
            H[4] = band(H[4] + d, 0xFFFFFFFF)
            H[5] = band(H[5] + e, 0xFFFFFFFF)
            H[6] = band(H[6] + f, 0xFFFFFFFF)
            H[7] = band(H[7] + g, 0xFFFFFFFF)
            H[8] = band(H[8] + h, 0xFFFFFFFF)
        end
        
        local length = #str
        local msg = {}
        for i = 1, length do
            msg[i] = string.byte(str, i)
        end
        
        msg[length + 1] = 0x80
        local l = length + 1
        while l % 64 ~= 56 do
            l = l + 1
            msg[l] = 0
        end
        
        local bits = length * 8
        for i = 1, 8 do
            msg[l + i] = band(rshift(bits, (8 - i) * 8), 0xFF)
        end
        
        for i = 1, #msg, 64 do
            digestblock(msg, i, H)
        end
        
        local result = ""
        for i = 1, 8 do
            result = result .. string.format("%08x", H[i])
        end
        return result
    end
    
    -- 验证密钥函数
    local function verifyKey(key)
        local validHashes = {
            ["1f4df8e0c4631599fd2f82d83f6c5e24a5a085b89f3e1a31a0c2cfc4dd86c052"] = true, -- AIMBOT2024
            ["481f6cc0511143ccdd7e2d1b1b94faf0a700a8b49cd13922a70b5ae28acaa8c5"] = true, -- VIP888
            ["89e01536ac207279409d4de1e5253e01f4a1769e696db0d6062ca9b8f56767c8"] = true  -- PRO999
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
        if attempts >= 3 then
            StatusLabel.Text = "验证次数超限！"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(2)
            game.Players.LocalPlayer:Kick("验证失败")
            return
        end

        local key = KeyInput.Text
        if verifyKey(key) then
            StatusLabel.Text = "验证成功！正在加载脚本..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            verified = true
            wait(1)
            ScreenGui:Destroy()
            loadScriptFromGitHub()
        else
            attempts = attempts + 1
            StatusLabel.Text = "密钥错误！剩余尝试次数: " .. (3 - attempts)
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            
            if attempts >= 3 then
                wait(2)
                game.Players.LocalPlayer:Kick("验证失败")
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
    
    -- 等待验证结果
    repeat wait() until verified or attempts >= 3
    return verified
end

createKeySystem()
