local Combat = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Combat Functions
function Combat.AutoBlock(settings)
    if not settings.AutoBlock or settings.ManualOverride then return end
    
    local nearbyPlayers = Players:GetPlayers()
    for _, player in ipairs(nearbyPlayers) do
        if player ~= LocalPlayer and 
           player.Character and 
           player.Character:FindFirstChild("HumanoidRootPart") and
           LocalPlayer.Character and 
           LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            
            local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            
            if distance <= 10 then  -- Auto block when players are within 10 studs
                if settings.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Trigger block
                local blockRemote = ReplicatedStorage:FindFirstChild("BlockRemote")
                if blockRemote then
                    blockRemote:FireServer(true)
                end
            end
        end
    end
end

function Combat.FullAuto(target, settings)
    if not settings.FullAuto or not target then return end
    
    -- Execute attack
    local attackRemote = ReplicatedStorage:FindFirstChild("AttackRemote")
    if attackRemote then
        attackRemote:FireServer(target)
    end
end

return Combat
