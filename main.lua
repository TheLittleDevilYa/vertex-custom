-- Vertex 2.0 - Principal por TheLittleDevilYa

local UserIdPremium = 2224118622 -- Tu UserId premium

local Modules = {}

-- Función para verificar premium
local function IsPremium(userId)
    return userId == UserIdPremium
end

-- Cargar módulo
local function LoadModule(name)
    local success, module = pcall(function()
        return require(script.Modules[name])
    end)
    if success and module then
        Modules[name] = module
        print("[Vertex2] Módulo "..name.." cargado.")
    else
        warn("[Vertex2] No se pudo cargar el módulo "..name)
    end
end

-- Cargar librería Rayfield para GUI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Crear ventana
local Window = Rayfield:CreateWindow({
    Name = "Vertex 2.0 - TheLittleDevilYa",
    LoadingTitle = "Cargando Vertex 2.0",
    LoadingSubtitle = "Por TheLittleDevilYa",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Vertex2Config",
        FileName = "Config"
    }
})

local Tabs = {}
Tabs.Main = Window:CreateTab("Principal")

-- Ejemplo toggle ESP
Tabs.Main:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(value)
        if Modules.ESP then
            Modules.ESP:SetEnabled(value)
        end
    end
})

-- Agregar toggles para otros módulos (después los completamos)
Tabs.Main:CreateToggle({
    Name = "AutoGun",
    CurrentValue = false,
    Flag = "AutoGun",
    Callback = function(value)
        if Modules.AutoGun then
            Modules.AutoGun:SetEnabled(value)
        end
    end
})

Tabs.Main:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(value)
        if Modules.NoClip then
            Modules.NoClip:SetEnabled(value)
        end
    end
})

Tabs.Main:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(value)
        if Modules.InfiniteJump then
            Modules.InfiniteJump:SetEnabled(value)
        end
    end
})

Tabs.Main:CreateToggle({
    Name = "Anti Fling",
    CurrentValue = false,
    Flag = "AntiFling",
    Callback = function(value)
        if Modules.AntiFling then
            Modules.AntiFling:SetEnabled(value)
        end
    end
})

local function Init()
    local player = game.Players.LocalPlayer
    if not IsPremium(player.UserId) then
        warn("No sos premium para usar Vertex 2.0")
        return
    end

    -- Cargar todos los módulos
    LoadModule("ESP")
    LoadModule("AutoGun")
    LoadModule("NoClip")
    LoadModule("InfiniteJump")
    LoadModule("AntiFling")

    print("Vertex 2.0 cargado correctamente.")
end

Init()
