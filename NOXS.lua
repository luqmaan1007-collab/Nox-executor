-- NOX v8.0: MVS2 VISIBLE OPTIMIZED (DELTA)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareDesign/Rayfield/main/source.lua'))()
local player = game.Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "🔥 NOX v8.0: MVS2 EDITION",
    LoadingTitle = "BYPASSING MVS2 SECURITY...",
    ConfigurationSaving = {Enabled = false}
})

-- TABS
local MvsTab = Window:CreateTab("🔫 MVS2 EXPLOITS", 4483362458)
local SpyTab = Window:CreateTab("📡 REMOTE SPY", 4483362458)
local ItemTab = Window:CreateTab("📦 ITEM STEALER", 4483362458)

-- ==========================================
-- 🔫 MVS2 VISIBLE ACTIONS
-- ==========================================
MvsTab:CreateSection("Visible Combat")

MvsTab:CreateButton({
    Name = "⚔️ GIVE ALL WEAPONS (Visible)",
    Callback = function()
        -- MVS2 använder ofta specifika mappar i ReplicatedStorage för vapen
        local toolFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Tools") or 
                           game:GetService("ReplicatedStorage"):FindFirstChild("Weapons")
        
        -- Vi letar efter en remote som hanterar "Equip" eller "Give"
        local giveRemote = game:GetService("ReplicatedStorage"):FindFirstChild("EquipRemote") or 
                           game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"):FindFirstChild("GiveTool")

        if giveRemote then
            for _, v in pairs(toolFolder:GetChildren()) do
                if v:IsA("Tool") then
                    giveRemote:FireServer(v) -- Säger åt servern att ge oss vapnet
                end
            end
            Rayfield:Notify({Title = "Visible", Content = "Vapnen skickades via servern!"})
        else
            -- Fallback: Om ingen remote hittas, försöker vi tvinga fram dem via Physics
            for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if v:IsA("Tool") then
                    local clone = v:Clone()
                    clone.Parent = player.Backpack
                end
            end
            Rayfield:Notify({Title = "Local Only", Content = "Ingen bridge hittad, gav vapen lokalt."})
        end
    end
})

MvsTab:CreateButton({
    Name = "🎯 KILL AURA (Visible Physics)",
    Callback = function()
        -- Detta använder Network Ownership för att skada folk genom att "krocka" i dem
        Rayfield:Notify({Title = "Kill Aura", Content = "Aktiv - Gå nära fiender för att kasta iväg dem!"})
        task.spawn(function()
            while task.wait() do
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 15 then
                            -- Physics Fling
                            p.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1000, 0)
                        end
                    end
                end
            end
        end)
    end
})

-- ==========================================
-- 📡 MVS2 REMOTE SPY (Deep Scan)
-- ==========================================
SpyTab:CreateSection("MVS2 Remote Logger")

local drop = SpyTab:CreateDropdown({
    Name = "MVS2 Remotes",
    Options = {"Skanna..."},
    CurrentOption = "",
    Callback = function(Option) _G.SelectedMVS = Option end
})

SpyTab:CreateButton({
    Name = "🔍 SKANNA MVS2",
    Callback = function()
        local found = {}
        -- MVS2 gömmer ofta remotes i konstiga mappar
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                table.insert(found, v.Name)
            end
        end
        drop:Refresh(found, true)
    end
})

-- ==========================================
-- 📦 UNIVERSAL STEALER (MVS2 FIX)
-- ==========================================
ItemTab:CreateSection("Inventory Stealer")

ItemTab:CreateButton({
    Name = "🏗️ ENABLE PHYSICS (Required for MVS2)",
    Callback = function()
        settings().Physics.AllowSleep = false
        player.MaximumSimulationRadius = math.huge
        pcall(function() sethiddenproperty(player, "SimulationRadius", math.huge) end)
        Rayfield:Notify({Title = "Ready", Content = "Physics Bypass Aktiv!"})
    end
})

ItemTab:CreateButton({
    Name = "🎒 STEAL ALL ITEMS",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Tool") or v:FindFirstChild("TouchInterest") then
                -- I MVS2 måste man ofta teleportera till föremålet först
                if v:IsA("BasePart") then
                    v.CFrame = player.Character.HumanoidRootPart.CFrame
                    v.Parent = player.Backpack
                elseif v:IsA("Tool") then
                    v.Parent = player.Backpack
                end
            end
        end
    end
})

Rayfield:Notify({Title = "NOX MVS2 READY", Content = "Lycka till i matchen!", Duration = 5})
