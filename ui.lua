local UserInterface = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- UI Elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local NavBar = Instance.new("Frame")
local CombatButton = Instance.new("TextButton")
local MiscButton = Instance.new("TextButton")
local TeleportsButton = Instance.new("TextButton")
local PlayerButton = Instance.new("TextButton")
local SettingsButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local CombatPage = Instance.new("ScrollingFrame")

-- Callbacks
local callbacks = {}
local sliderCallbacks = {}

-- UI Creation
local function CreateToggle(parent, text, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, -20, 0, 30)
    Toggle.BackgroundTransparency = 1
    Toggle.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Toggle
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.2, 0, 0.8, 0)
    Button.Position = UDim2.new(0.8, 0, 0.1, 0)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = ""
    Button.Parent = Toggle
    
    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        Button.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
        callback(enabled)
    end)
    
    return Toggle
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, -20, 0, 50)
    Slider.BackgroundTransparency = 1
    Slider.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Size = UDim2.new(1, 0, 0.4, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Slider
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, 0, 0.2, 0)
    SliderBar.Position = UDim2.new(0, 0, 0.6, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.Parent = Slider
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0.1, 0, 1.5, 0)
    SliderButton.Position = UDim2.new((default - min) / (max - min), 0, -0.25, 0)
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.Text = ""
    SliderButton.Parent = SliderBar
    
    local value = default
    local dragging = false
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local relativePos = mousePos.X - SliderBar.AbsolutePosition.X
            local percentage = math.clamp(relativePos / SliderBar.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * percentage
            SliderButton.Position = UDim2.new(percentage, 0, -0.25, 0)
            callback(value)
        end
    end)
    
    return Slider
end

function UserInterface:Init()
    -- Setup ScreenGui
    ScreenGui.Parent = game.CoreGui
    
    -- Setup MainFrame
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Parent = ScreenGui
    
    -- Setup TitleBar
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.Parent = MainFrame
    
    Title.Text = "Combat Settings"
    Title.Size = UDim2.new(1, -30, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = TitleBar
    
    CloseButton.Text = "X"
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Parent = TitleBar
    
    -- Setup Combat Page
    CombatPage.Size = UDim2.new(1, 0, 1, -30)
    CombatPage.Position = UDim2.new(0, 0, 0, 30)
    CombatPage.BackgroundTransparency = 1
    CombatPage.ScrollBarThickness = 6
    CombatPage.Parent = MainFrame
    
    -- Create Combat Settings
    local EnabledToggle = CreateToggle(CombatPage, "Enabled", function(enabled)
        if callbacks["Enabled"] then
            callbacks["Enabled"](enabled)
        end
    end)
    
    local TeamCheckToggle = CreateToggle(CombatPage, "Team Check", function(enabled)
        if callbacks["Team Check"] then
            callbacks["Team Check"](enabled)
        end
    end)
    
    local WallCheckToggle = CreateToggle(CombatPage, "Wall Check", function(enabled)
        if callbacks["Wall Check"] then
            callbacks["Wall Check"](enabled)
        end
    end)
    
    local AutoBlockToggle = CreateToggle(CombatPage, "Auto Block", function(enabled)
        if callbacks["Auto Block"] then
            callbacks["Auto Block"](enabled)
        end
    end)
    
    local ManualOverrideToggle = CreateToggle(CombatPage, "Manual Override", function(enabled)
        if callbacks["Manual Override"] then
            callbacks["Manual Override"](enabled)
        end
    end)
    
    local FullAutoToggle = CreateToggle(CombatPage, "Full Auto", function(enabled)
        if callbacks["Full Auto"] then
            callbacks["Full Auto"](enabled)
        end
    end)
    
    local ThirdPersonToggle = CreateToggle(CombatPage, "Third Person", function(enabled)
        if callbacks["Third Person"] then
            callbacks["Third Person"](enabled)
        end
    end)
    
    local FOVSlider = CreateSlider(CombatPage, "FOV", 0, 360, 90, function(value)
        if sliderCallbacks["FOV"] then
            sliderCallbacks["FOV"](value)
        end
    end)
    
    local SensitivitySlider = CreateSlider(CombatPage, "Sensitivity", 0, 1, 0, function(value)
        if sliderCallbacks["Sensitivity"] then
            sliderCallbacks["Sensitivity"](value)
        end
    end)
    
    local ThirdPersonSensSlider = CreateSlider(CombatPage, "Third Person Sensitivity", 1, 50, 30, function(value)
        if sliderCallbacks["Third Person Sensitivity"] then
            sliderCallbacks["Third Person Sensitivity"](value)
        end
    end)
    
    -- Make UI draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

function UserInterface:SetCallback(callback)
    callbacks = callback
end

function UserInterface:SetSliderCallback(callback)
    sliderCallbacks = callback
end

function UserInterface:Show()
    self:Init()
end

return UserInterface
