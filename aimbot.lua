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
	LockPart = "Head" -- Body part to lock on
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
local function CreateReopenButton()
    local ScreenGui = Instance.new("ScreenGui")
    local ReopenButton = Instance.new("TextButton")
    
    ScreenGui.Name = "ReopenGUI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    ReopenButton.Name = "ReopenButton"
    ReopenButton.Parent = ScreenGui
    ReopenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ReopenButton.BackgroundTransparency = 1
    ReopenButton.Position = UDim2.new(0, 10, 0.5, -15)
    ReopenButton.Size = UDim2.new(0, 40, 0, 30)
    ReopenButton.Font = Enum.Font.GothamBold
    ReopenButton.Text = "神"
    ReopenButton.TextColor3 = Color3.fromRGB(255, 192, 203) -- 粉色
    ReopenButton.TextSize = 24.000
    ReopenButton.TextStrokeColor3 = Color3.fromRGB(255, 182, 193) -- 浅粉色描边
    ReopenButton.TextStrokeTransparency = 0.5
    
    -- 添加圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = ReopenButton
    
    -- 添加点击事件
    ReopenButton.MouseButton1Click:Connect(function()
        if not game:GetService("CoreGui"):FindFirstChild("AimbotGUI") then
            CreateAimbotGUI()
            ScreenGui:Destroy()
        end
    end)
    
    -- 添加悬停效果
    ReopenButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(ReopenButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        }):Play()
    end)
    
    ReopenButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(ReopenButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        }):Play()
    end)
end

local function CreateAimbotGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local ToggleButton = Instance.new("TextButton")
    local TeamCheckButton = Instance.new("TextButton")
    local WallCheckButton = Instance.new("TextButton")
    local FOVSlider = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    local FOVValue = Instance.new("TextLabel")
    local SensitivitySlider = Instance.new("Frame")
    local SensSliderButton = Instance.new("TextButton")
    local SensValue = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    
    -- 设置GUI属性
    ScreenGui.Name = "AimbotGUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
    MainFrame.Size = UDim2.new(0, 300, 0, 250)
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.5, -75, 0.05, 0)
    Title.Size = UDim2.new(0, 150, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "PUPUHUB AIMBOT"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20.000
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = MainFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    ToggleButton.Size = UDim2.new(0.8, 0, 0, 30)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "ENABLED"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 14.000
    
    TeamCheckButton.Name = "TeamCheckButton"
    TeamCheckButton.Parent = MainFrame
    TeamCheckButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    TeamCheckButton.Position = UDim2.new(0.1, 0, 0.35, 0)
    TeamCheckButton.Size = UDim2.new(0.8, 0, 0, 30)
    TeamCheckButton.Font = Enum.Font.GothamBold
    TeamCheckButton.Text = "TEAM CHECK: OFF"
    TeamCheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeamCheckButton.TextSize = 14.000
    
    WallCheckButton.Name = "WallCheckButton"
    WallCheckButton.Parent = MainFrame
    WallCheckButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    WallCheckButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    WallCheckButton.Size = UDim2.new(0.8, 0, 0, 30)
    WallCheckButton.Font = Enum.Font.GothamBold
    WallCheckButton.Text = "WALL CHECK: OFF"
    WallCheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    WallCheckButton.TextSize = 14.000
    
    FOVSlider.Name = "FOVSlider"
    FOVSlider.Parent = MainFrame
    FOVSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FOVSlider.Position = UDim2.new(0.1, 0, 0.65, 0)
    FOVSlider.Size = UDim2.new(0.8, 0, 0, 5)
    
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = FOVSlider
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.Position = UDim2.new(0.5, -5, -1, 0)
    SliderButton.Size = UDim2.new(0, 10, 0, 20)
    SliderButton.Text = ""
    
    FOVValue.Name = "FOVValue"
    FOVValue.Parent = FOVSlider
    FOVValue.BackgroundTransparency = 1
    FOVValue.Position = UDim2.new(0, 0, -1.5, 0)
    FOVValue.Size = UDim2.new(1, 0, 0, 20)
    FOVValue.Font = Enum.Font.GothamBold
    FOVValue.Text = "FOV: 90"
    FOVValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    FOVValue.TextSize = 14.000
    
    SensitivitySlider.Name = "SensitivitySlider"
    SensitivitySlider.Parent = MainFrame
    SensitivitySlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SensitivitySlider.Position = UDim2.new(0.1, 0, 0.8, 0)
    SensitivitySlider.Size = UDim2.new(0.8, 0, 0, 5)
    
    SensSliderButton.Name = "SensSliderButton"
    SensSliderButton.Parent = SensitivitySlider
    SensSliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SensSliderButton.Position = UDim2.new(0, -5, -1, 0)
    SensSliderButton.Size = UDim2.new(0, 10, 0, 20)
    SensSliderButton.Text = ""
    
    SensValue.Name = "SensValue"
    SensValue.Parent = SensitivitySlider
    SensValue.BackgroundTransparency = 1
    SensValue.Position = UDim2.new(0, 0, -1.5, 0)
    SensValue.Size = UDim2.new(1, 0, 0, 20)
    SensValue.Font = Enum.Font.GothamBold
    SensValue.Text = "SENSITIVITY: 0"
    SensValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    SensValue.TextSize = 14.000
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(180, 0, 30)
    CloseButton.Position = UDim2.new(0.1, 0, 0.9, 0)
    CloseButton.Size = UDim2.new(0.8, 0, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "CLOSE"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14.000
    
    -- 添加圆角
    local function addCorner(element)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = element
    end
    
    addCorner(MainFrame)
    addCorner(ToggleButton)
    addCorner(TeamCheckButton)
    addCorner(WallCheckButton)
    addCorner(FOVSlider)
    addCorner(SliderButton)
    addCorner(SensitivitySlider)
    addCorner(SensSliderButton)
    addCorner(CloseButton)
    
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
    
    -- 按钮功能
    ToggleButton.MouseButton1Click:Connect(function()
        Environment.Settings.Enabled = not Environment.Settings.Enabled
        ToggleButton.Text = Environment.Settings.Enabled and "ENABLED" or "DISABLED"
        ToggleButton.BackgroundColor3 = Environment.Settings.Enabled and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
    end)
    
    TeamCheckButton.MouseButton1Click:Connect(function()
        Environment.Settings.TeamCheck = not Environment.Settings.TeamCheck
        TeamCheckButton.Text = "TEAM CHECK: " .. (Environment.Settings.TeamCheck and "ON" or "OFF")
        TeamCheckButton.BackgroundColor3 = Environment.Settings.TeamCheck and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
    end)
    
    WallCheckButton.MouseButton1Click:Connect(function()
        Environment.Settings.WallCheck = not Environment.Settings.WallCheck
        WallCheckButton.Text = "WALL CHECK: " .. (Environment.Settings.WallCheck and "ON" or "OFF")
        WallCheckButton.BackgroundColor3 = Environment.Settings.WallCheck and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
    end)
    
    -- FOV滑块功能
    local function updateFOV(input)
        local sliderPosition = math.clamp((input.Position.X - FOVSlider.AbsolutePosition.X) / FOVSlider.AbsoluteSize.X, 0, 1)
        local newFOV = math.floor(sliderPosition * 180)
        Environment.FOVSettings.Amount = newFOV
        FOVValue.Text = "FOV: " .. newFOV
        SliderButton.Position = UDim2.new(sliderPosition, -5, -1, 0)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                updateFOV(input)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    -- Sensitivity滑块功能
    local function updateSensitivity(input)
        local sliderPosition = math.clamp((input.Position.X - SensitivitySlider.AbsolutePosition.X) / SensitivitySlider.AbsoluteSize.X, 0, 1)
        local newSens = math.floor(sliderPosition * 10) / 10
        Environment.Settings.Sensitivity = newSens
        SensValue.Text = "SENSITIVITY: " .. newSens
        SensSliderButton.Position = UDim2.new(sliderPosition, -5, -1, 0)
    end
    
    SensSliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                updateSensitivity(input)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
            CreateReopenButton()
        end
    end)
    
    -- 初始化按钮状态
    ToggleButton.BackgroundColor3 = Environment.Settings.Enabled and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
    TeamCheckButton.BackgroundColor3 = Environment.Settings.TeamCheck and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
    WallCheckButton.BackgroundColor3 = Environment.Settings.WallCheck and Color3.fromRGB(0, 180, 30) or Color3.fromRGB(180, 0, 30)
    
    -- 初始化滑块位置
    SliderButton.Position = UDim2.new(Environment.FOVSettings.Amount / 180, -5, -1, 0)
    SensSliderButton.Position = UDim2.new(Environment.Settings.Sensitivity / 1, -5, -1, 0)
end

-- 创建GUI
if not game:GetService("CoreGui"):FindFirstChild("AimbotGUI") then
    CreateAimbotGUI()
else
    CreateReopenButton()
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
		LockPart = "Head" -- Body part to lock on
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
