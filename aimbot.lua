--// Cache

local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

--// Preventing Multiple Processes

pcall(function()
	getgenv().Aimbot.Functions:Exit()
end)

--// Environment

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Variables

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

--// Script Settings

Environment.Settings = {
	Enabled = true,
	TeamCheck = false,
	AliveCheck = true,
	WallCheck = false, -- Laggy
	Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
	ThirdPerson = false, -- Uses mousemoverel instead of CFrame to support locking in third person (could be choppy)
	ThirdPersonSensitivity = 3, -- Boundary: 0.1 - 5
	TriggerKey = "MouseButton2",
	Toggle = false,
	LockPart = "Head", -- Body part to lock on
	NoCollision = false, -- 添加无碰撞设置
	AntiAFK = false -- 添加反AFK设置
}

Environment.FOVSettings = {
	Enabled = true,
	Visible = true,
	Amount = 90,
	Color = Color3.fromRGB(255, 255, 255),
	LockedColor = Color3.fromRGB(255, 70, 70),
	Transparency = 0.5,
	Sides = 60,
	Thickness = 1,
	Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")

--// GUI Creation
local AimbotGui = {}

local function CreateReopenButton()
    -- 如果已存在则先移除
    pcall(function()
        if game:GetService("CoreGui"):FindFirstChild("ReopenGUI") then
            game:GetService("CoreGui"):FindFirstChild("ReopenGUI"):Destroy()
        end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    local ReopenButton = Instance.new("TextButton")
    
    ScreenGui.Name = "ReopenGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999999
    
    ReopenButton.Name = "ReopenButton"
    ReopenButton.Parent = ScreenGui
    ReopenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ReopenButton.BackgroundTransparency = 1
    ReopenButton.Position = UDim2.new(0, 10, 0.4, 0)
    ReopenButton.Size = UDim2.new(0, 50, 0, 50)
    ReopenButton.Font = Enum.Font.GothamBold
    ReopenButton.Text = "神"
    ReopenButton.TextColor3 = Color3.fromRGB(255, 192, 203) -- 粉色
    ReopenButton.TextSize = 35.000
    ReopenButton.TextStrokeColor3 = Color3.fromRGB(255, 182, 193) -- 浅粉色描边
    ReopenButton.TextStrokeTransparency = 0.5
    
    -- 添加点击事件
    ReopenButton.MouseButton1Down:Connect(function()
        ScreenGui:Destroy()
        AimbotGui.Show()
    end)
    
    -- 添加悬停效果
    ReopenButton.MouseEnter:Connect(function()
        ReopenButton.TextSize = 40
    end)
    
    ReopenButton.MouseLeave:Connect(function()
        ReopenButton.TextSize = 35
    end)
end

function AimbotGui.Show()
    -- 如果已存在则先移除
    pcall(function()
        if game:GetService("CoreGui"):FindFirstChild("AimbotGUI") then
            game:GetService("CoreGui"):FindFirstChild("AimbotGUI"):Destroy()
        end
    end)
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local ToggleButton = Instance.new("TextButton")
    local TeamCheckButton = Instance.new("TextButton")
    local WallCheckButton = Instance.new("TextButton")
    local NoCollisionButton = Instance.new("TextButton")
    local AntiAFKButton = Instance.new("TextButton")
    local TeleportButton = Instance.new("TextButton") -- 新增传送按钮
    local FOVSlider = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    local FOVValue = Instance.new("TextLabel")
    local SensitivitySlider = Instance.new("Frame")
    local SensSliderButton = Instance.new("TextButton")
    local SensValue = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local SocialInfo = Instance.new("TextLabel")
    
    -- 设置GUI属性
    ScreenGui.Name = "AimbotGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999999
    ScreenGui.ResetOnSpawn = false  -- 防止重生时GUI消失
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Size = UDim2.new(0, 280, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
    MainFrame.Active = true         -- 确保可以拖动
    MainFrame.Draggable = true      -- 启用拖动
    MainFrame.Visible = true        -- 确保可见
    
    -- 添加圆角
    local function addCorner(element)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = element
    end
    
    addCorner(MainFrame)
    
    -- 设置标题
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 20, 0, 10)  -- 调整位置
    Title.Size = UDim2.new(0, 240, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "PUPUHUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 32.000
    Title.Visible = true           -- 确保可见
    
    -- 设置按钮基础属性
    local function setupButton(button, position, text)
        button.Position = position
        button.Size = UDim2.new(0, 200, 0, 30)
        button.Font = Enum.Font.GothamBold
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14.000
        button.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
        button.BorderSizePixel = 0
        button.Visible = true      -- 确保可见
        addCorner(button)
    end
    
    -- 设置所有按钮
    setupButton(ToggleButton, UDim2.new(0.5, -100, 0, 70), "ENABLED")
    setupButton(TeamCheckButton, UDim2.new(0.5, -100, 0, 110), "TEAM CHECK: OFF")
    setupButton(WallCheckButton, UDim2.new(0.5, -100, 0, 150), "WALL CHECK: OFF")
    setupButton(NoCollisionButton, UDim2.new(0.5, -100, 0, 190), "NO COLLISION: OFF")
    setupButton(AntiAFKButton, UDim2.new(0.5, -100, 0, 230), "ANTI AFK: OFF")
    setupButton(TeleportButton, UDim2.new(0.5, -100, 0, 270), "TELEPORT: OFF")
    
    -- 设置社交信息
    SocialInfo.Name = "SocialInfo"
    SocialInfo.Parent = MainFrame
    SocialInfo.BackgroundTransparency = 1
    SocialInfo.Position = UDim2.new(0, 10, 1, -40)
    SocialInfo.Size = UDim2.new(1, -20, 0, 30)
    SocialInfo.Font = Enum.Font.GothamBold
    SocialInfo.Text = "DC @puneet | discord.gg/eyrMV7MKck"
    SocialInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    SocialInfo.TextSize = 12.000
    SocialInfo.Visible = true     -- 确保可见
    
    -- 统一按钮风格
    local function styleButton(button)
        button.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
        button.Font = Enum.Font.GothamBold
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14.000
        button.BorderSizePixel = 0
        
        -- 添加渐变效果
        local buttonGradient = Instance.new("UIGradient")
        buttonGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
        })
        buttonGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.9),
            NumberSequenceKeypoint.new(1, 0.8)
        })
        buttonGradient.Rotation = 45
        buttonGradient.Parent = button
        
        -- 添加悬停效果
        button.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(200, 20, 50)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(180, 0, 30)
            }):Play()
        end)
    end
    
    local buttonHeight = 35
    local buttonSpacing = 0.02
    local startY = 0.15
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = MainFrame
    ToggleButton.Position = UDim2.new(0.1, 0, startY, 0)
    ToggleButton.Size = UDim2.new(0.8, 0, 0, buttonHeight)
    styleButton(ToggleButton)
    ToggleButton.Text = "ENABLED"
    
    TeamCheckButton.Name = "TeamCheckButton"
    TeamCheckButton.Parent = MainFrame
    TeamCheckButton.Position = UDim2.new(0.1, 0, startY + 0.1, 0)
    TeamCheckButton.Size = UDim2.new(0.8, 0, 0, buttonHeight)
    styleButton(TeamCheckButton)
    TeamCheckButton.Text = "TEAM CHECK: OFF"
    
    WallCheckButton.Name = "WallCheckButton"
    WallCheckButton.Parent = MainFrame
    WallCheckButton.Position = UDim2.new(0.1, 0, startY + 0.2, 0)
    WallCheckButton.Size = UDim2.new(0.8, 0, 0, buttonHeight)
    styleButton(WallCheckButton)
    WallCheckButton.Text = "WALL CHECK: OFF"
    
    NoCollisionButton.Name = "NoCollisionButton"
    NoCollisionButton.Parent = MainFrame
    NoCollisionButton.Position = UDim2.new(0.1, 0, startY + 0.3, 0)
    NoCollisionButton.Size = UDim2.new(0.8, 0, 0, buttonHeight)
    styleButton(NoCollisionButton)
    NoCollisionButton.Text = "NO COLLISION: OFF"
    
    AntiAFKButton.Name = "AntiAFKButton"
    AntiAFKButton.Parent = MainFrame
    AntiAFKButton.Position = UDim2.new(0.1, 0, startY + 0.4, 0)
    AntiAFKButton.Size = UDim2.new(0.8, 0, 0, buttonHeight)
    styleButton(AntiAFKButton)
    AntiAFKButton.Text = "ANTI AFK: OFF"
    
    -- 添加传送按钮
    TeleportButton.Name = "TeleportButton"
    TeleportButton.Parent = MainFrame
    TeleportButton.Position = UDim2.new(0.1, 0, startY + 0.5, 0)
    TeleportButton.Size = UDim2.new(0.8, 0, 0, buttonHeight)
    styleButton(TeleportButton)
    TeleportButton.Text = "TELEPORT: OFF"
    
    -- 设置FOV滑块
    FOVSlider.Name = "FOVSlider"
    FOVSlider.Parent = MainFrame
    FOVSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FOVSlider.Position = UDim2.new(0.5, -100, 0, 310)
    FOVSlider.Size = UDim2.new(0, 200, 0, 5)
    FOVSlider.BorderSizePixel = 0
    addCorner(FOVSlider)
    
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = FOVSlider
    SliderButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    SliderButton.Position = UDim2.new(Environment.FOVSettings.Amount / 180, -5, -1, 0)
    SliderButton.Size = UDim2.new(0, 10, 0, 20)
    SliderButton.Text = ""
    SliderButton.BorderSizePixel = 0
    addCorner(SliderButton)
    
    FOVValue.Name = "FOVValue"
    FOVValue.Parent = MainFrame
    FOVValue.BackgroundTransparency = 1
    FOVValue.Position = UDim2.new(0.5, -100, 0, 290)
    FOVValue.Size = UDim2.new(0, 200, 0, 20)
    FOVValue.Font = Enum.Font.GothamBold
    FOVValue.Text = "FOV: " .. Environment.FOVSettings.Amount
    FOVValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    FOVValue.TextSize = 14.000
    FOVValue.Visible = true
    
    -- 设置灵敏度滑块
    SensitivitySlider.Name = "SensitivitySlider"
    SensitivitySlider.Parent = MainFrame
    SensitivitySlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SensitivitySlider.Position = UDim2.new(0.5, -100, 0, 350)
    SensitivitySlider.Size = UDim2.new(0, 200, 0, 5)
    SensitivitySlider.BorderSizePixel = 0
    addCorner(SensitivitySlider)
    
    SensSliderButton.Name = "SensSliderButton"
    SensSliderButton.Parent = SensitivitySlider
    SensSliderButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    SensSliderButton.Position = UDim2.new(Environment.Settings.Sensitivity, -5, -1, 0)
    SensSliderButton.Size = UDim2.new(0, 10, 0, 20)
    SensSliderButton.Text = ""
    SensSliderButton.BorderSizePixel = 0
    addCorner(SensSliderButton)
    
    SensValue.Name = "SensValue"
    SensValue.Parent = MainFrame
    SensValue.BackgroundTransparency = 1
    SensValue.Position = UDim2.new(0.5, -100, 0, 330)
    SensValue.Size = UDim2.new(0, 200, 0, 20)
    SensValue.Font = Enum.Font.GothamBold
    SensValue.Text = "SENSITIVITY: " .. Environment.Settings.Sensitivity
    SensValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    SensValue.TextSize = 14.000
    SensValue.Visible = true
    
    -- 滑块拖动功能
    local function updateFOV(input)
        local sliderPosition = math.clamp((input.Position.X - FOVSlider.AbsolutePosition.X) / FOVSlider.AbsoluteSize.X, 0, 1)
        local newFOV = math.floor(sliderPosition * 180)
        Environment.FOVSettings.Amount = newFOV
        FOVValue.Text = "FOV: " .. newFOV
        SliderButton.Position = UDim2.new(sliderPosition, -5, -1, 0)
    end
    
    local function updateSensitivity(input)
        local sliderPosition = math.clamp((input.Position.X - SensitivitySlider.AbsolutePosition.X) / SensitivitySlider.AbsoluteSize.X, 0, 1)
        local newSens = math.floor(sliderPosition * 10) / 10
        Environment.Settings.Sensitivity = newSens
        SensValue.Text = "SENSITIVITY: " .. newSens
        SensSliderButton.Position = UDim2.new(sliderPosition, -5, -1, 0)
    end
    
    -- FOV滑块事件
    local draggingFOV = false
    SliderButton.MouseButton1Down:Connect(function()
        draggingFOV = true
    end)
    
    -- 灵敏度滑块事件
    local draggingSens = false
    SensSliderButton.MouseButton1Down:Connect(function()
        draggingSens = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingFOV = false
            draggingSens = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if draggingFOV then
                updateFOV(input)
            elseif draggingSens then
                updateSensitivity(input)
            end
        end
    end)
    
    -- 统一按钮状态颜色
    local function updateButtonState(button, enabled)
        local targetColor = enabled and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
        local targetText = button.Text:gsub("ON", "OFF"):gsub("OFF", "ON")
        
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = targetColor
        }):Play()
        
        if enabled then
            button.Text = button.Text:gsub("OFF", "ON")
        else
            button.Text = button.Text:gsub("ON", "OFF")
        end
    end
    
    -- 按钮功能
    ToggleButton.MouseButton1Down:Connect(function()
        Environment.Settings.Enabled = not Environment.Settings.Enabled
        updateButtonState(ToggleButton, Environment.Settings.Enabled)
    end)
    
    TeamCheckButton.MouseButton1Down:Connect(function()
        Environment.Settings.TeamCheck = not Environment.Settings.TeamCheck
        updateButtonState(TeamCheckButton, Environment.Settings.TeamCheck)
    end)
    
    WallCheckButton.MouseButton1Down:Connect(function()
        Environment.Settings.WallCheck = not Environment.Settings.WallCheck
        updateButtonState(WallCheckButton, Environment.Settings.WallCheck)
    end)
    
    -- 添加无碰撞按钮功能
    NoCollisionButton.MouseButton1Down:Connect(function()
        Environment.Settings.NoCollision = not Environment.Settings.NoCollision
        updateButtonState(NoCollisionButton, Environment.Settings.NoCollision)
        
        -- 处理无碰撞逻辑
        local function updateCollision()
            if not Environment.Settings.NoCollision then return end
            
            local localPlayer = game:GetService("Players").LocalPlayer
            if not localPlayer or not localPlayer.Character then return end
            
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= localPlayer and player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
        
        -- 如果开启无碰撞
        if Environment.Settings.NoCollision then
            -- 初始更新
            updateCollision()
            
            -- 添加心跳更新
            if not Environment.NoCollisionConnection then
                Environment.NoCollisionConnection = game:GetService("RunService").Heartbeat:Connect(updateCollision)
            end
        else
            -- 关闭时断开连接
            if Environment.NoCollisionConnection then
                Environment.NoCollisionConnection:Disconnect()
                Environment.NoCollisionConnection = nil
            end
            
            -- 恢复碰撞
            local localPlayer = game:GetService("Players").LocalPlayer
            if localPlayer and localPlayer.Character then
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= localPlayer and player.Character then
                        for _, part in pairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = true
                            end
                        end
                    end
                end
            end
        end
    end)
    
    -- 添加反AFK按钮功能
    AntiAFKButton.MouseButton1Down:Connect(function()
        Environment.Settings.AntiAFK = not Environment.Settings.AntiAFK
        updateButtonState(AntiAFKButton, Environment.Settings.AntiAFK)
        
        -- 处理反AFK逻辑
        if Environment.Settings.AntiAFK then
            -- 检查firesignal支持
            if not Environment.AntiAFKConnection then
                pcall(function()
                    assert(firesignal, "Your exploit does not support firesignal.")
                    local UserInputService = game:GetService("UserInputService")
                    local RunService = game:GetService("RunService")
                    
                    Environment.AntiAFKConnection = UserInputService.WindowFocusReleased:Connect(function()
                        RunService.Stepped:Wait()
                        pcall(firesignal, UserInputService.WindowFocused)
                    end)
                end)
            end
        else
            -- 关闭时断开连接
            if Environment.AntiAFKConnection then
                Environment.AntiAFKConnection:Disconnect()
                Environment.AntiAFKConnection = nil
            end
        end
    end)
    
    -- 传送按钮点击事件
    TeleportButton.MouseButton1Down:Connect(function()
        _G.WRDClickTeleport = not _G.WRDClickTeleport
        updateButtonState(TeleportButton, _G.WRDClickTeleport)
        
        -- 显示通知
        game.StarterGui:SetCore("SendNotification", {
            Title = "PUPUHUB",
            Text = "Click teleport " .. (_G.WRDClickTeleport and "enabled" or "disabled"),
            Duration = 5
        })
    end)
    
    -- 设置关闭按钮
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14.000
    CloseButton.BorderSizePixel = 0
    CloseButton.Visible = true
    addCorner(CloseButton)
    
    -- 添加关闭按钮悬停效果
    CloseButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(200, 20, 50)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(180, 0, 30)
        }):Play()
    end)
    
    -- 关闭按钮点击事件
    CloseButton.MouseButton1Down:Connect(function()
        ScreenGui:Destroy()
        CreateReopenButton()  -- 创建重新打开按钮
        
        -- 显示通知
        game.StarterGui:SetCore("SendNotification", {
            Title = "PUPUHUB",
            Text = "Interface minimized. Click 神 to reopen.",
            Duration = 5
        })
    end)
    
    -- 初始化按钮状态
    updateButtonState(ToggleButton, Environment.Settings.Enabled)
    updateButtonState(TeamCheckButton, Environment.Settings.TeamCheck)
    updateButtonState(WallCheckButton, Environment.Settings.WallCheck)
    updateButtonState(NoCollisionButton, Environment.Settings.NoCollision)
    updateButtonState(AntiAFKButton, Environment.Settings.AntiAFK)
    updateButtonState(TeleportButton, _G.WRDClickTeleport)
end

--// Functions

local function CancelLock()
	Environment.Locked = nil
	if Animation then Animation:Cancel() end
	Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
	if not Environment.Locked then
		RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)

		for _, v in next, Players:GetPlayers() do
			if v ~= LocalPlayer then
				if v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
					if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
					if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
					if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

					local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
					local Distance = (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude

					if Distance < RequiredDistance and OnScreen then
						RequiredDistance = Distance
						Environment.Locked = v
					end
				end
			end
		end
	elseif (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
		CancelLock()
	end
end

--// Typing Check

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
	Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
	Typing = false
end)

--// Main

local function Load()
	ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
		if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
			Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
			Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
			Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
			Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
			Environment.FOVCircle.Color = Environment.FOVSettings.Color
			Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
			Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
			Environment.FOVCircle.Position = Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
		else
			Environment.FOVCircle.Visible = false
		end

		if Running and Environment.Settings.Enabled then
			GetClosestPlayer()

			if Environment.Locked then
				if Environment.Settings.ThirdPerson then
					Environment.Settings.ThirdPersonSensitivity = mathclamp(Environment.Settings.ThirdPersonSensitivity, 0.1, 5)

					local Vector = Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
					mousemoverel((Vector.X - UserInputService:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
				else
					if Environment.Settings.Sensitivity > 0 then
						Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
						Animation:Play()
					else
						Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
					end
				end

			Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor

			end
		end
	end)

	ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
		if not Typing then
			pcall(function()
				if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)

			pcall(function()
				if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)
		end
	end)

	ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
		if not Typing then
			if not Environment.Settings.Toggle then
				pcall(function()
					if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)

				pcall(function()
					if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)
			end
		end
	end)
end

--// Click Teleport Feature
if _G.WRDClickTeleport == nil then
    _G.WRDClickTeleport = false
    
    local player = game:GetService("Players").LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local mouse = player:GetMouse()

    --Waits until the player's mouse is found
    repeat wait() until mouse
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            --Only click teleport if the toggle is enabled
            if _G.WRDClickTeleport and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z)) 
            end
        end
    end)
end

--// Functions

Environment.Functions = {}

function Environment.Functions:Exit()
	for _, v in next, ServiceConnections do
		v:Disconnect()
	end

	if Environment.FOVCircle.Remove then Environment.FOVCircle:Remove() end

	getgenv().Aimbot.Functions = nil
	getgenv().Aimbot = nil
	
	Load = nil; GetClosestPlayer = nil; CancelLock = nil
end

function Environment.Functions:Restart()
	for _, v in next, ServiceConnections do
		v:Disconnect()
	end

	Load()
end

function Environment.Functions:ResetSettings()
	Environment.Settings = {
		Enabled = true,
		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,
		Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
		ThirdPerson = false, -- Uses mousemoverel instead of CFrame to support locking in third person (could be choppy)
		ThirdPersonSensitivity = 3, -- Boundary: 0.1 - 5
		TriggerKey = "MouseButton2",
		Toggle = false,
		LockPart = "Head", -- Body part to lock on
		NoCollision = false, -- 添加无碰撞设置
		AntiAFK = false -- 添加反AFK设置
	}

	Environment.FOVSettings = {
		Enabled = true,
		Visible = true,
		Amount = 90,
		Color = Color3.fromRGB(255, 255, 255),
		LockedColor = Color3.fromRGB(255, 70, 70),
		Transparency = 0.5,
		Sides = 60,
		Thickness = 1,
		Filled = false
	}
end

--// Load

Load()

-- 初始化界面
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("AimbotGUI") then
        game:GetService("CoreGui"):FindFirstChild("AimbotGUI"):Destroy()
    end
    if game:GetService("CoreGui"):FindFirstChild("ReopenGUI") then
        game:GetService("CoreGui"):FindFirstChild("ReopenGUI"):Destroy()
    end
    AimbotGui.Show()
end)

--// Return Environment
return Environment
