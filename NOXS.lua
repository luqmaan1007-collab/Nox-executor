--[[ v1.0.0 https://wearedevs.--[[ v1.0.0 local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local player = game.Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "🔥 NOX FINAL v5.0",
    LoadingTitle = "CLEANING UI CACHE...",
    ConfigurationSaving = {Enabled = false}
})

-- TABS
local LuaTab = Window:CreateTab("💻 LUA", 4483362458)
local SSTab = Window:CreateTab("🖥️ SERVER", 4483362458)
local SpyTab = Window:CreateTab("📡 REMOTE SPY", 4483362458)
local ItemTab = Window:CreateTab("📦 ITEM STEALER", 4483362458)
local LoadTab = Window:CreateTab("🌐 LOADSTRING", 4483362458)

-- ==========================================
-- 💻 LOCAL LUA TAB
-- ==========================================
LuaTab:CreateSection("Client Executor")

local luaInput = LuaTab:CreateInput({
    Name = "Type Lua Code Here",
    PlaceholderText = "print('Local Test')",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text) _G.LBuffer = Text end
})

LuaTab:CreateButton({
    Name = "🚀 EXECUTE LUA",
    Callback = function()
        local f, e = loadstring(_G.LBuffer or "")
        if f then pcall(f) else Rayfield:Notify({Title = "Error", Content = e}) end
    end
})

-- ==========================================
-- 🖥️ SERVERSIDE TAB
-- ==========================================
SSTab:CreateSection("Server Bridge")

SSTab:CreateInput({
    Name = "Type Server Script Here",
    PlaceholderText = "game.Players.LocalPlayer:Kick('Server Force')",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text) _G.SBuffer = Text end
})

SSTab:CreateButton({
    Name = "🔥 FORCE SERVER EXECUTION",
    Callback = function()
        local rem = game:GetService("ReplicatedStorage"):FindFirstChildOfClass("RemoteFunction")
        if rem then
            rem:InvokeServer(_G.SBuffer or "", "server")
            Rayfield:Notify({Title = "Sent", Content = "Script pushed to server bridge."})
        else
            Rayfield:Notify({Title = "Blocked", Content = "No backdoor found in this game."})
        end
    end
})

-- ==========================================
-- 📡 REMOTE SPY
-- ==========================================
SpyTab:CreateSection("Scan & Execute on Remotes")

local remoteDropdown = SpyTab:CreateDropdown({
    Name = "Found Remotes",
    Options = {"Scan first..."},
    CurrentOption = "",
    Callback = function(Option) _G.SelectedRemote = Option end
})

SpyTab:CreateButton({
    Name = "🔍 SCAN FOR REMOTES",
    Callback = function()
        local found = {}
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                table.insert(found, v.Name)
            end
        end
        remoteDropdown:Refresh(found, true)
        Rayfield:Notify({Title = "Scan Complete", Content = "Found " .. #found .. " remotes."})
    end
})

SpyTab:CreateButton({
    Name = "🔥 EXECUTE SERVER CODE ON REMOTE",
    Callback = function()
        if _G.SelectedRemote then
            local target = game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectedRemote, true) or workspace:FindFirstChild(_G.SelectedRemote, true)
            if target then
                if target:IsA("RemoteFunction") then
                    target:InvokeServer(_G.SBuffer, "server")
                else
                    target:FireServer(_G.SBuffer)
                end
                Rayfield:Notify({Title = "Success", Content = "Code fired through: " .. _G.SelectedRemote})
            end
        end
    end
})

-- ==========================================
-- 📦 ITEM STEALER (TELEPORT TILL INVENTORY)
-- ==========================================
ItemTab:CreateSection("Inventory Stealer")

ItemTab:CreateButton({
    Name = "🏗️ ENABLE PHYSICS BYPASS",
    Callback = function()
        settings().Physics.AllowSleep = false
        task.spawn(function()
            while task.wait() do
                player.MaximumSimulationRadius = math.huge
                sethiddenproperty(player, "SimulationRadius", math.huge)
            end
        end)
        Rayfield:Notify({Title = "Bypass Active", Content = "Physics ownership claimed."})
    end
})

ItemTab:CreateButton({
    Name = "🎒 STEAL ALL TO INVENTORY",
    Callback = function()
        local backpack = player:WaitForChild("Backpack")
        local count = 0
        
        for _, v in pairs(workspace:GetDescendants()) do
            -- Letar efter Tools eller specifika namn som Jelly/Kid
            if v:IsA("Tool") or v.Name == "Jelly" or v.Name == "Kid" then
                -- Om det är ett Tool, ändra Parent till Backpack
                if v:IsA("Tool") then
                    v.Parent = backpack
                -- Om det är en Jelly/NPC (Part), försök wrappa den eller flytta den
                elseif v:IsA("BasePart") or v:IsA("Model") then
                    v:MoveTo(player.Character.HumanoidRootPart.Position)
                    -- Vissa spel kräver att man rör föremålet för att "plocka upp" det
                end
                count = count + 1
            end
        end
        Rayfield:Notify({Title = "Steal Complete", Content = "Försökte lägga " .. count .. " föremål i din ryggsäck."})
    end
})

-- ==========================================
-- 🌐 LOADSTRING TAB
-- ==========================================
LoadTab:CreateSection("Remote Scripts")

LoadTab:CreateInput({
    Name = "Paste URL",
    PlaceholderText = "https://raw.github... (Paste Here)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text) _G.UBuffer = Text end
})

LoadTab:CreateButton({
    Name = "🌐 LOAD & RUN",
    Callback = function()
        local s, r = pcall(function() return game:HttpGet(_G.UBuffer) end)
        if s then loadstring(r)() end
    end
})

Rayfield:Notify({Title = "NOX v5.1", Content = "Inventory Stealer Ready!", Duration = 5})
https://wearedevs.net/obfuscator ]] 
