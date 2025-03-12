-- NEWAIMBOT Loader
local function LoadScript()
    local BaseUrl = "https://raw.githubusercontent.com/PuneetGOTO/NEWAIMBOT/main/"
    local Files = {
        ["Untitled-1"] = BaseUrl .. "Untitled-1.lua",
        ["ui"] = BaseUrl .. "ui.lua",
        ["combat"] = BaseUrl .. "combat.lua",
        ["config"] = BaseUrl .. "config.lua",
        ["key_system"] = BaseUrl .. "key_system.lua"
    }
    
    -- Create container for our modules
    local Modules = {}
    
    -- Load all files
    for name, url in pairs(Files) do
        local success, content = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success then
            -- Create the module
            local module = loadstring(content)()
            Modules[name] = module
        else
            warn("Failed to load: " .. name)
            return false
        end
    end
    
    -- Initialize the system
    if Modules["Untitled-1"] then
        return true
    end
    
    return false
end

-- Execute the loader
if LoadScript() then
    print("NEWAIMBOT loaded successfully!")
else
    warn("Failed to load NEWAIMBOT!")
end
