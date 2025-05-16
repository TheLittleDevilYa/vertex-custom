if shared.executedCustom then return end
shared.executedCustom = true

local function isPremium(userId)
    local HttpService = game:GetService("HttpService")
    local success, response = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/TheLittleDevilYa/vertex-custom/main/API.csv")
    end)
    if not success then return false end

    for _, line in ipairs(string.split(response, "\n")) do
        if line ~= "" then
            if line == tostring(userId) then
                return true
            end
        end
    end
    return false
end

shared.premium = isPremium(game.Players.LocalPlayer.UserId)

local function loadScriptFromURL(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then
        warn("Error loading module:", url)
        return
    end

    local func, err = loadstring(result)
    if not func then
        warn("Error loading string:", err)
        return
    end

    local success2, err2 = pcall(func)
    if not success2 then
        warn("Error executing script:", err2)
    end
end

-- Carga el módulo según el ID del juego
local gameId = tostring(game.PlaceId)
local moduleUrl = "https://raw.githubusercontent.com/TheLittleDevilYa/vertex-custom/main/modules/" .. gameId .. ".lua"

loadScriptFromURL(moduleUrl)
