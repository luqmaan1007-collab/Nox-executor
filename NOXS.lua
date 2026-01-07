-- NOX v8.0: MVS2 VISIBLE OPTIMIZED (DELTA)
-- NOX v24.0: PROXY-COMPILER (Visual Sync Attempt)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareDesign/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 NOX v24.0 [PROXY-COMPILER]",
    LoadingTitle = "Compiling Lua to Network Packets...",
    ConfigurationSaving = {Enabled = false}
})

-- FUNKTIONEN SOM GÖR "TRICKET"
local function ProxyExecute(luaCode)
    -- Vi försöker hitta en väg genom Filtering Enabled (FE)
    -- genom att analysera koden och hitta matchande Remotes
    
    local env = getfenv()
    -- Vi skapar en 'fake' miljö där Server-anrop omdirigeras
    env.ServerScriptService = setmetatable({}, {
        __index = function(_, key)
            -- Letar efter en legitim nätverks-bridge
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild(key, true)
            if remote and remote:IsA("RemoteEvent") then
                Rayfield:Notify({Title = "Bridge Found", Content = "Mapping to: " .. key})
                return remote
            end
        end
    })

    local func, err = loadstring(luaCode)
    if func then
        setfenv(func, env)
        task.spawn(pcall, func)
    else
        warn("Compiler Error: " .. tostring(err))
    end
end

-- EDITOR TAB
local Tab = Window:CreateTab("📜 COMPILER", 4483362458)

local sourceCode = ""
Tab:CreateInput({
    Name = "Lua Source (Visible Sync)",
    PlaceholderText = "print('Syncing...'); game.ServerScriptService.Remote:FireServer()",
    Callback = function(t) sourceCode = t end
})

Tab:CreateButton({
    Name = "⚡ COMPILE & EXECUTE (VISIBLE)",
    Callback = function()
        if sourceCode ~= "" then
            ProxyExecute(sourceCode)
        end
    end
})

Tab:CreateSection("Hur det fungerar")
Tab:CreateParagraph({
    Title = "Proxy-Metoden",
    Content = "När du trycker Execute, letar NOX efter nätverks-tunnlar som matchar namnen i din kod. Om den hittar en matchning, skickas anropet till servern så att det blir synligt för alla."
})
