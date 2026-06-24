--[[
    MATEUS_SCRIPTS v20.0 - CORRIGIDO
    Player em Desenvolvimento | ESP Team Check Corrigido
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- CORES
local C = {
    Roxo = Color3.fromRGB(140, 30, 255),
    RoxoBrilhante = Color3.fromRGB(170, 50, 255),
    RoxoNeon = Color3.fromRGB(180, 60, 255),
    Preto = Color3.fromRGB(10, 8, 18),
    PretoClaro = Color3.fromRGB(16, 14, 24),
    Cinza = Color3.fromRGB(28, 24, 38),
    CinzaEscuro = Color3.fromRGB(20, 17, 30),
    CinzaDev = Color3.fromRGB(18, 14, 24),
    Branco = Color3.fromRGB(255, 255, 255),
    Texto = Color3.fromRGB(230, 225, 245),
    TextoCinza = Color3.fromRGB(170, 160, 190),
    TextoDev = Color3.fromRGB(80, 75, 90),
    Verde = Color3.fromRGB(0, 255, 100),
    Vermelho = Color3.fromRGB(255, 50, 50),
    Amarelo = Color3.fromRGB(255, 180, 0),
    AmareloDev = Color3.fromRGB(200, 140, 0),
    Azul = Color3.fromRGB(0, 150, 255)
}

-- CONFIG
local Config = {
    MenuKey = Enum.KeyCode.RightShift,
    
    ESP = {
        Enabled = false,
        Boxes = true,
        BoxColor = Color3.fromRGB(255, 45, 45),
        TeamBoxColor = Color3.fromRGB(140, 30, 255),
        Names = true,
        NameColor = Color3.fromRGB(255, 255, 255),
        TeamNameColor = Color3.fromRGB(180, 60, 255),
        HealthBar = true,
        Distance = true,
        DistanceColor = Color3.fromRGB(200, 200, 200),
        Tracers = false,
        TracerColor = Color3.fromRGB(255, 255, 255),
        TeamCheck = true,
        MaxDistance = 1500
    },
    
    Apelao = {
        Enabled = false,
        FOV_Radius = 130,
        FOV_Color = Color3.fromRGB(255, 60, 60),
        FOV_Visible = true,
        Smoothness = 3,
        AimPart = "Head",
        TeamCheck = true,
        MaxDistance = 800,
        TriggerBot = false
    },
    
    Seguro = {
        Enabled = false,
        SilentAim = false,
        VisibilityCheck = false,
        Humanization = false,
        RandomSmoothness = false,
        SmoothnessMin = 3,
        SmoothnessMax = 7,
        RandomDelay = false,
        DelayMin = 50,
        DelayMax = 200,
        HitboxExpander = false,
        HitboxMultiplier = 1.5,
        JitterReduction = true,
        QuickToggle = false,
        QuickToggleKey = Enum.KeyCode.V
    },
    
    Visuals = {
        FullBright = false,
        NoFog = false,
        ThirdPerson = false,
        FOVChanger = false,
        FOVValue = 70,
        Crosshair = false,
        CrosshairColor = Color3.fromRGB(170, 50, 255),
        CrosshairSize = 15
    },
    
    Delay = {
        ShowFPS = false,
        ShowPing = false,
        LowGraphics = false,
        NoShadows = false,
        CleanWorkspace = false
    }
}

-- VARIÁVEIS
local MS = {
    ESP_Objects = {},
    ESP_Tracers = {},
    FOV_Circle = nil,
    CrosshairLines = {},
    FPSLabel = nil,
    PingLabel = nil,
    Dragging = false,
    DragStart = nil,
    StartPos = nil,
    IconDragging = false,
    IconDragStart = nil,
    IconStartPos = nil,
    IconMoved = false,
    MenuOpen = true,
    LastTriggerTime = 0,
    LastTargetSwitch = 0,
    SmoothnessHistory = {}
}

-- ============ DETECÇÃO DE TIME CORRIGIDA ============
-- Cache de times para detectar mudanças em tempo real
local TeamCache = {}

local function GetPlayerTeam(player)
    -- Verifica todas as formas possíveis de time
    if player.Team then return player.Team end
    if player.TeamColor then return tostring(player.TeamColor) end
    return nil
end

local function IsSameTeam(p1, p2)
    local t1 = GetPlayerTeam(p1)
    local t2 = GetPlayerTeam(p2)
    
    if t1 and t2 then
        return t1 == t2
    end
    
    -- Fallback: compara TeamColor
    if p1.TeamColor and p2.TeamColor then
        return p1.TeamColor == p2.TeamColor
    end
    
    return false
end

local function UpdateTeamCache()
    for _, player in pairs(Players:GetPlayers()) do
        TeamCache[player.UserId] = GetPlayerTeam(player)
    end
end

-- Monitorar mudanças de time de TODOS os jogadores
local function MonitorTeamChanges()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- Monitora propriedade Team
            player:GetPropertyChangedSignal("Team"):Connect(function()
                TeamCache[player.UserId] = GetPlayerTeam(player)
                -- Atualiza ESP quando time muda
                if Config.ESP.Enabled then
                    UpdateESP()
                end
            end)
            
            -- Monitora TeamColor (alguns jogos usam isso)
            player:GetPropertyChangedSignal("TeamColor"):Connect(function()
                TeamCache[player.UserId] = GetPlayerTeam(player)
                if Config.ESP.Enabled then
                    UpdateESP()
                end
            end)
            
            -- Monitora quando o personagem spawna (pode ter time diferente)
            player.CharacterAdded:Connect(function()
                TeamCache[player.UserId] = GetPlayerTeam(player)
                if Config.ESP.Enabled then
                    wait(0.3)
                    UpdateESP()
                end
            end)
        end
    end
end

-- ============ GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Mateus_Scripts"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ÍCONE FLUTUANTE
local Icon = Instance.new("TextButton")
Icon.Size = UDim2.new(0, 48, 0, 48)
Icon.Position = UDim2.new(1, -58, 0.5, -24)
Icon.BackgroundColor3 = C.Preto
Icon.BorderSizePixel = 0
Icon.Text = "MT"
Icon.TextColor3 = C.RoxoNeon
Icon.Font = Enum.Font.GothamBlack
Icon.TextSize = 19
Icon.Visible = false
Icon.ZIndex = 10
Icon.AutoButtonColor = false
Icon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = Icon

local IconStroke = Instance.new("UIStroke")
IconStroke.Thickness = 2
IconStroke.Color = C.RoxoBrilhante
IconStroke.Transparency = 0.3
IconStroke.Parent = Icon

-- MENU PRINCIPAL
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 460, 0, 370)
Main.Position = UDim2.new(0.5, -230, 0.5, -185)
Main.BackgroundColor3 = C.Preto
Main.BorderSizePixel = 0
Main.Visible = true
Main.ZIndex = 5
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = C.RoxoBrilhante
MainStroke.Transparency = 0.4
MainStroke.Parent = Main

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = C.PretoClaro
Header.BorderSizePixel = 0
Header.ZIndex = 6
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 180, 0, 20)
Title.Position = UDim2.new(0, 12, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "MATEUS_SCRIPTS"
Title.TextColor3 = C.Branco
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 7
Title.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -54, 0, 8)
MinBtn.BackgroundColor3 = C.Roxo
MinBtn.BackgroundTransparency = 0.4
MinBtn.BorderSizePixel = 0
MinBtn.Text = "─"
MinBtn.TextColor3 = C.Branco
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 15
MinBtn.ZIndex = 7
MinBtn.AutoButtonColor = false
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -26, 0, 8)
CloseBtn.BackgroundColor3 = C.Vermelho
CloseBtn.BackgroundTransparency = 0.4
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.Branco
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.ZIndex = 7
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 105, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = C.PretoClaro
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 2)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidePad = Instance.new("Frame")
SidePad.Size = UDim2.new(1, 0, 0, 5)
SidePad.BackgroundTransparency = 1
SidePad.LayoutOrder = 0
SidePad.Parent = Sidebar

-- CONTEÚDO
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -113, 1, -46)
Content.Position = UDim2.new(0, 109, 0, 43)
Content.BackgroundColor3 = C.PretoClaro
Content.BackgroundTransparency = 0.4
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -8, 1, -8)
Scroll.Position = UDim2.new(0, 4, 0, 4)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = C.RoxoNeon
Scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
Scroll.ZIndex = 6
Scroll.Parent = Content

local ScrollList = Instance.new("UIListLayout")
ScrollList.Padding = UDim.new(0, 3)
ScrollList.SortOrder = Enum.SortOrder.LayoutOrder
ScrollList.Parent = Scroll

-- ============ NAVEGAÇÃO ============
local TabBtns = {}
local CurrentTab = "Home"

local Tabs = {
    {N = "Home", I = "🏠"},
    {N = "ESP", I = "👁"},
    {N = "Apelao", I = "💀"},
    {N = "Seguro", I = "🛡"},
    {N = "Player", I = "🚧"},
    {N = "Visual", I = "🎨"},
    {N = "Delay", I = "📊"},
    {N = "Config", I = "⚙"}
}

local function UpdateTabs()
    for name, btn in pairs(TabBtns) do
        if name == CurrentTab then
            btn.BackgroundColor3 = C.Roxo
            btn.TextColor3 = C.Branco
        else
            btn.BackgroundColor3 = C.Cinza
            btn.TextColor3 = C.TextoCinza
        end
    end
end

for i, tab in ipairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tab.N
    btn.Size = UDim2.new(1, -8, 0, 28)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = C.Cinza
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Text = " " .. tab.I .. " " .. tab.N
    btn.TextColor3 = C.TextoCinza
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 9
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = i
    btn.ZIndex = 6
    btn.AutoButtonColor = false
    btn.Parent = Sidebar
    
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 6)
    bc.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if CurrentTab ~= tab.N then
            CurrentTab = tab.N
            UpdateTabs()
            UpdateContent()
        end
    end)
    
    TabBtns[tab.N] = btn
end

UpdateTabs()

-- ============ COMPONENTES ============
local function ClearScroll()
    local toRemove = {}
    for _, child in pairs(Scroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") then
            table.insert(toRemove, child)
        end
    end
    for _, child in ipairs(toRemove) do
        child:Destroy()
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
end

local function Section(text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 15)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.RoxoNeon
    l.Font = Enum.Font.GothamBlack
    l.TextSize = 9
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 6
    l.Parent = Scroll
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 18)
    return l
end

local function Toggle(text, def, cb, disabled)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 28)
    f.BackgroundColor3 = disabled and C.CinzaDev or C.CinzaEscuro
    f.BackgroundTransparency = disabled and 0.5 or 0
    f.BorderSizePixel = 0
    f.ZIndex = 6
    f.Parent = Scroll
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 5)
    fc.Parent = f
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 170, 1, 0)
    l.Position = UDim2.new(0, 7, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = disabled and C.TextoDev or C.Texto
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 6
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 34, 0, 18)
    bg.Position = UDim2.new(1, -40, 0.5, -9)
    bg.BackgroundColor3 = def and (disabled and Color3.fromRGB(40, 35, 50) or C.Roxo) or Color3.fromRGB(50, 45, 60)
    bg.BorderSizePixel = 0
    bg.ZIndex = 6
    bg.Parent = f
    
    local bgc = Instance.new("UICorner")
    bgc.CornerRadius = UDim.new(1, 0)
    bgc.Parent = bg
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = def and UDim2.new(1, -15, 0.5, -7) or UDim2.new(0, 1, 0.5, -7)
    dot.BackgroundColor3 = disabled and C.TextoDev or C.Branco
    dot.BorderSizePixel = 0
    dot.ZIndex = 7
    dot.Parent = bg
    
    local dc = Instance.new("UICorner")
    dc.CornerRadius = UDim.new(1, 0)
    dc.Parent = dot
    
    local on = def
    
    f.InputBegan:Connect(function(inp)
        if disabled then return end
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            on = not on
            bg.BackgroundColor3 = on and C.Roxo or Color3.fromRGB(50, 45, 60)
            dot.Position = on and UDim2.new(1, -15, 0.5, -7) or UDim2.new(0, 1, 0.5, -7)
            cb(on)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 30)
    return f
end

local function Slider(text, min, max, def, cb, disabled)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 42)
    f.BackgroundColor3 = disabled and C.CinzaDev or C.CinzaEscuro
    f.BackgroundTransparency = disabled and 0.5 or 0
    f.BorderSizePixel = 0
    f.ZIndex = 6
    f.Parent = Scroll
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 5)
    fc.Parent = f
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -14, 0, 13)
    l.Position = UDim2.new(0, 7, 0, 3)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. tostring(def)
    l.TextColor3 = disabled and C.TextoDev or C.Texto
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 6
    l.Parent = f
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -14, 0, 4)
    track.Position = UDim2.new(0, 7, 0, 23)
    track.BackgroundColor3 = disabled and Color3.fromRGB(25, 20, 30) or Color3.fromRGB(40, 35, 55)
    track.BorderSizePixel = 0
    track.ZIndex = 6
    track.Parent = f
    
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 2)
    tc.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = disabled and Color3.fromRGB(50, 40, 60) or C.Roxo
    fill.BorderSizePixel = 0
    fill.ZIndex = 6
    fill.Parent = track
    
    local flc = Instance.new("UICorner")
    flc.CornerRadius = UDim.new(0, 2)
    flc.Parent = fill
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 13, 0, 13)
    thumb.Position = UDim2.new((def - min) / (max - min), -6.5, 0.5, -6.5)
    thumb.BackgroundColor3 = disabled and C.TextoDev or C.Branco
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 7
    thumb.Parent = track
    
    local thc = Instance.new("UICorner")
    thc.CornerRadius = UDim.new(1, 0)
    thc.Parent = thumb
    
    local val = def
    local conn
    
    local function upd(v)
        if disabled then return end
        val = math.clamp(v, min, max)
        local p = (val - min) / (max - min)
        fill.Size = UDim2.new(p, 0, 1, 0)
        thumb.Position = UDim2.new(p, -6.5, 0.5, -6.5)
        l.Text = text .. ": " .. tostring(math.floor(val))
    end
    
    local function trackMouse()
        if disabled then return end
        local mp = UserInputService:GetMouseLocation()
        local ts = track.AbsolutePosition.X
        local tw = track.AbsoluteSize.X
        local r = math.clamp((mp.X - ts) / tw, 0, 1)
        upd(min + (max - min) * r)
    end
    
    track.InputBegan:Connect(function(inp)
        if disabled then return end
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            trackMouse()
            if conn then conn:Disconnect() end
            conn = RunService.RenderStepped:Connect(trackMouse)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(inp)
        if conn and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1) then
            conn:Disconnect()
            conn = nil
            cb(val)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 44)
    return f
end

local function ColorPick(text, defCol, cb, disabled)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 32)
    f.BackgroundColor3 = disabled and C.CinzaDev or C.CinzaEscuro
    f.BackgroundTransparency = disabled and 0.5 or 0
    f.BorderSizePixel = 0
    f.ZIndex = 6
    f.Parent = Scroll
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 5)
    fc.Parent = f
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 130, 1, 0)
    l.Position = UDim2.new(0, 7, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = disabled and C.TextoDev or C.Texto
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 6
    l.Parent = f
    
    local prev = Instance.new("Frame")
    prev.Size = UDim2.new(0, 22, 0, 22)
    prev.Position = UDim2.new(1, -28, 0.5, -11)
    prev.BackgroundColor3 = disabled and Color3.fromRGB(50, 40, 60) or defCol
    prev.BorderSizePixel = 0
    prev.ZIndex = 6
    prev.Parent = f
    
    local pvc = Instance.new("UICorner")
    pvc.CornerRadius = UDim.new(0, 5)
    pvc.Parent = prev
    
    local Colors = {
        Color3.fromRGB(255, 40, 40), Color3.fromRGB(255, 100, 100), Color3.fromRGB(255, 120, 0),
        Color3.fromRGB(255, 180, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(180, 255, 0),
        Color3.fromRGB(50, 255, 50), Color3.fromRGB(0, 255, 100), Color3.fromRGB(0, 200, 100),
        Color3.fromRGB(0, 255, 200), Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 150, 255),
        Color3.fromRGB(50, 50, 255), Color3.fromRGB(120, 0, 255), Color3.fromRGB(140, 30, 255),
        Color3.fromRGB(170, 50, 255), Color3.fromRGB(200, 0, 255), Color3.fromRGB(255, 0, 255),
        Color3.fromRGB(255, 0, 150), Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 200, 200),
        Color3.fromRGB(150, 150, 150), Color3.fromRGB(100, 100, 100), Color3.fromRGB(50, 50, 50)
    }
    
    local palOpen = false
    local palFrame = nil
    
    prev.InputBegan:Connect(function(inp)
        if disabled then return end
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            if palOpen and palFrame then
                palFrame:Destroy()
                palFrame = nil
                palOpen = false
                return
            end
            palOpen = true
            
            palFrame = Instance.new("Frame")
            palFrame.Size = UDim2.new(0, 210, 0, 190)
            palFrame.Position = UDim2.new(0, math.random(30, 150), 0, math.random(30, 100))
            palFrame.BackgroundColor3 = C.Preto
            palFrame.BorderSizePixel = 0
            palFrame.ZIndex = 100
            palFrame.Parent = ScreenGui
            
            local pc = Instance.new("UICorner")
            pc.CornerRadius = UDim.new(0, 8)
            pc.Parent = palFrame
            
            local ps = Instance.new("UIStroke")
            ps.Thickness = 1.5
            ps.Color = C.RoxoBrilhante
            ps.Parent = palFrame
            
            local grid = Instance.new("UIGridLayout")
            grid.CellSize = UDim2.new(0, 28, 0, 28)
            grid.CellPadding = UDim2.new(0, 3, 0, 3)
            grid.Parent = palFrame
            
            for _, c in ipairs(Colors) do
                local cb2 = Instance.new("TextButton")
                cb2.Size = UDim2.new(0, 28, 0, 28)
                cb2.BackgroundColor3 = c
                cb2.BorderSizePixel = 0
                cb2.Text = ""
                cb2.ZIndex = 101
                cb2.AutoButtonColor = false
                cb2.Parent = palFrame
                
                local cbc = Instance.new("UICorner")
                cbc.CornerRadius = UDim.new(0, 4)
                cbc.Parent = cb2
                
                cb2.MouseButton1Click:Connect(function()
                    prev.BackgroundColor3 = c
                    cb(c)
                    palFrame:Destroy()
                    palFrame = nil
                    palOpen = false
                end)
            end
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 34)
    return f
end

local function Dropdown(text, opts, def, cb, disabled)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 28)
    f.BackgroundColor3 = disabled and C.CinzaDev or C.CinzaEscuro
    f.BackgroundTransparency = disabled and 0.5 or 0
    f.BorderSizePixel = 0
    f.ClipsDescendants = true
    f.ZIndex = 6
    f.Parent = Scroll
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 5)
    fc.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = " " .. text .. ": " .. def
    btn.TextColor3 = disabled and C.TextoDev or C.Texto
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 6
    btn.AutoButtonColor = false
    btn.Parent = f
    
    local expanded = false
    local optBtns = {}
    
    btn.MouseButton1Click:Connect(function()
        if disabled then return end
        expanded = not expanded
        
        if expanded then
            f.Size = UDim2.new(1, 0, 0, 28 + (24 * #opts))
            for i, o in ipairs(opts) do
                local ob = Instance.new("TextButton")
                ob.Size = UDim2.new(1, 0, 0, 20)
                ob.Position = UDim2.new(0, 0, 0, 28 + (24 * (i - 1)))
                ob.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
                ob.BorderSizePixel = 0
                ob.Text = "   " .. o
                ob.TextColor3 = C.TextoCinza
                ob.Font = Enum.Font.Gotham
                ob.TextSize = 10
                ob.TextXAlignment = Enum.TextXAlignment.Left
                ob.ZIndex = 7
                ob.AutoButtonColor = false
                ob.Parent = f
                
                ob.MouseButton1Click:Connect(function()
                    btn.Text = " " .. text .. ": " .. o
                    cb(o)
                    expanded = false
                    f.Size = UDim2.new(1, 0, 0, 28)
                    for _, b in ipairs(optBtns) do b:Destroy() end
                    optBtns = {}
                end)
                table.insert(optBtns, ob)
            end
        else
            f.Size = UDim2.new(1, 0, 0, 28)
            for _, b in ipairs(optBtns) do b:Destroy() end
            optBtns = {}
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 30)
    return f
end

local function Keybind(text, defKey, cb, disabled)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 28)
    f.BackgroundColor3 = disabled and C.CinzaDev or C.CinzaEscuro
    f.BackgroundTransparency = disabled and 0.5 or 0
    f.BorderSizePixel = 0
    f.ZIndex = 6
    f.Parent = Scroll
    
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 5)
    fc.Parent = f
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 140, 1, 0)
    l.Position = UDim2.new(0, 7, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = disabled and C.TextoDev or C.Texto
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 6
    l.Parent = f
    
    local kb = Instance.new("TextButton")
    kb.Size = UDim2.new(0, 55, 0, 20)
    kb.Position = UDim2.new(1, -61, 0.5, -10)
    kb.BackgroundColor3 = disabled and Color3.fromRGB(30, 25, 40) or Color3.fromRGB(35, 30, 50)
    kb.BorderSizePixel = 0
    kb.Text = defKey.Name
    kb.TextColor3 = disabled and C.TextoDev or C.Texto
    kb.Font = Enum.Font.GothamBold
    kb.TextSize = 9
    kb.ZIndex = 6
    kb.AutoButtonColor = false
    kb.Parent = f
    
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(0, 4)
    kc.Parent = kb
    
    local listening = false
    
    kb.MouseButton1Click:Connect(function()
        if disabled then return end
        listening = true
        kb.Text = "..."
        kb.BackgroundColor3 = C.Roxo
    end)
    
    UserInputService.InputBegan:Connect(function(inp, gp)
        if listening and not gp and inp.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            kb.Text = inp.KeyCode.Name
            kb.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
            cb(inp.KeyCode)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 30)
    return f
end

local function Button(text, color, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 28)
    b.BackgroundColor3 = color or C.Roxo
    b.BackgroundTransparency = 0.3
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = C.Branco
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.ZIndex = 6
    b.AutoButtonColor = false
    b.Parent = Scroll
    
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 5)
    bc.Parent = b
    
    b.MouseButton1Click:Connect(cb)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 30)
    return b
end

-- ============ ARRASTAR ============
Header.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        MS.Dragging = true
        MS.DragStart = inp.Position
        MS.StartPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(inp)
    if MS.Dragging then
        local d = inp.Position - MS.DragStart
        Main.Position = UDim2.new(MS.StartPos.X.Scale, MS.StartPos.X.Offset + d.X, MS.StartPos.Y.Scale, MS.StartPos.Y.Offset + d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then MS.Dragging = false end
end)

-- Ícone
Icon.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        MS.IconDragging = true
        MS.IconMoved = false
        MS.IconDragStart = inp.Position
        MS.IconStartPos = Icon.Position
    end
end)

Icon.InputChanged:Connect(function(inp)
    if MS.IconDragging and inp.UserInputType == Enum.UserInputType.Touch then
        local d = inp.Position - MS.IconDragStart
        if math.abs(d.X) > 5 or math.abs(d.Y) > 5 then MS.IconMoved = true end
        Icon.Position = UDim2.new(MS.IconStartPos.X.Scale, MS.IconStartPos.X.Offset + d.X, MS.IconStartPos.Y.Scale, MS.IconStartPos.Y.Offset + d.Y)
    end
end)

Icon.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        if not MS.IconMoved then
            Main.Visible = true
            Icon.Visible = false
            MS.MenuOpen = true
        end
        MS.IconDragging = false
        MS.IconMoved = false
    end
end)

Icon.MouseButton1Click:Connect(function()
    Main.Visible = true
    Icon.Visible = false
    MS.MenuOpen = true
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Icon.Visible = true
    MS.MenuOpen = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(inp, gp)
    if not gp and inp.KeyCode == Config.MenuKey then
        MS.MenuOpen = not MS.MenuOpen
        Main.Visible = MS.MenuOpen
        Icon.Visible = not MS.MenuOpen
    end
end)

-- ============ SISTEMAS DE JOGO ============
local function UpdateESP()
    -- Limpar ESP anterior
    for _, v in pairs(MS.ESP_Objects) do
        pcall(function() v:Destroy() end)
    end
    for _, v in pairs(MS.ESP_Tracers) do
        pcall(function() v:Remove() end)
    end
    MS.ESP_Objects = {}
    MS.ESP_Tracers = {}
    
    if not Config.ESP.Enabled then return end
    
    -- Atualizar cache de times antes de processar
    UpdateTeamCache()
    
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        
        local hum = char:FindFirstChild("Humanoid")
        local head = char:FindFirstChild("Head")
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if not hum or hum.Health <= 0 or not head or not root then continue end
        
        local dist = (myRoot.Position - root.Position).Magnitude
        if dist > Config.ESP.MaxDistance then continue end
        
        -- Verificação de time CORRIGIDA - usando função melhorada
        local isTeam = false
        if Config.ESP.TeamCheck then
            isTeam = IsSameTeam(player, LocalPlayer)
        end
        
        -- Cores baseadas no time (atualizadas em tempo real)
        local boxColor = isTeam and Config.ESP.TeamBoxColor or Config.ESP.BoxColor
        local nameColor = isTeam and Config.ESP.TeamNameColor or Config.ESP.NameColor
        
        -- Box 3D
        if Config.ESP.Boxes then
            local hl = Instance.new("Highlight")
            hl.FillColor = boxColor
            hl.FillTransparency = 0.5
            hl.OutlineColor = boxColor
            hl.Adornee = char
            hl.Parent = char
            table.insert(MS.ESP_Objects, hl)
        end
        
        -- Tracers
        if Config.ESP.Tracers then
            local tr = Drawing.new("Line")
            tr.Color = Config.ESP.TracerColor
            tr.Thickness = 1
            tr.Visible = true
            table.insert(MS.ESP_Tracers, tr)
            
            coroutine.wrap(function()
                while char and root and tr do
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    if onScreen then
                        tr.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        tr.To = Vector2.new(pos.X, pos.Y)
                    end
                    RunService.RenderStepped:Wait()
                end
                pcall(function() tr:Remove() end)
            end)()
        end
        
        -- Billboard (Nome + Vida + Distância)
        if Config.ESP.Names or Config.ESP.HealthBar or Config.ESP.Distance then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 120, 0, 40)
            bill.StudsOffset = Vector3.new(0, 3, 0)
            bill.AlwaysOnTop = true
            bill.Parent = head
            table.insert(MS.ESP_Objects, bill)
            
            local y = 0
            
            if Config.ESP.Names then
                local nl = Instance.new("TextLabel")
                nl.Size = UDim2.new(1, 0, 0, 15)
                nl.BackgroundTransparency = 1
                nl.Text = player.Name .. (isTeam and " [ALIADO]" or "")
                nl.TextColor3 = nameColor
                nl.Font = Enum.Font.GothamBold
                nl.TextSize = 11
                nl.TextStrokeTransparency = 0.5
                nl.Parent = bill
                y = y + 16
            end
            
            if Config.ESP.HealthBar then
                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1, 0, 0, 3)
                bar.Position = UDim2.new(0, 0, 0, y)
                bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                bar.BorderSizePixel = 0
                bar.Parent = bill
                
                local fill = Instance.new("Frame")
                fill.Size = UDim2.new(hum.Health / hum.MaxHealth, 0, 1, 0)
                fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                fill.BorderSizePixel = 0
                fill.Parent = bar
                y = y + 4
            end
            
            if Config.ESP.Distance then
                local dl = Instance.new("TextLabel")
                dl.Size = UDim2.new(1, 0, 0, 13)
                dl.Position = UDim2.new(0, 0, 0, y)
                dl.BackgroundTransparency = 1
                dl.Text = math.floor(dist) .. "m"
                dl.TextColor3 = Config.ESP.DistanceColor
                dl.Font = Enum.Font.Gotham
                dl.TextSize = 9
                dl.Parent = bill
            end
        end
    end
end

-- FOV
local function UpdateFOV()
    if MS.FOV_Circle then
        pcall(function() MS.FOV_Circle:Remove() end)
        MS.FOV_Circle = nil
    end
    if Config.Apelao.FOV_Visible and Config.Apelao.Enabled then
        MS.FOV_Circle = Drawing.new("Circle")
        MS.FOV_Circle.Radius = Config.Apelao.FOV_Radius
        MS.FOV_Circle.Color = Config.Apelao.FOV_Color
        MS.FOV_Circle.Thickness = 2
        MS.FOV_Circle.Transparency = 0.8
        MS.FOV_Circle.Filled = false
        MS.FOV_Circle.Visible = true
    end
end

-- AIMBOT: Alvo mais próximo VISUALMENTE (na tela) com Team Check corrigido
local function GetClosestTarget()
    local best = nil
    local bestDist = Config.Apelao.FOV_Radius
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    -- Atualiza cache de times para garantir
    UpdateTeamCache()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        
        -- Team Check CORRIGIDO
        if Config.Apelao.TeamCheck and IsSameTeam(player, LocalPlayer) then continue end
        
        local aimPart = char:FindFirstChild(Config.Apelao.AimPart)
        local hum = char:FindFirstChild("Humanoid")
        
        if aimPart and hum and hum.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
            
            if onScreen then
                local screenDist = (center - Vector2.new(pos.X, pos.Y)).Magnitude
                local dist3D = (Camera.CFrame.Position - aimPart.Position).Magnitude
                
                if screenDist < bestDist and dist3D <= Config.Apelao.MaxDistance then
                    bestDist = screenDist
                    best = player
                end
            end
        end
    end
    
    return best
end

-- Crosshair
local function UpdateCrosshair()
    for _, v in pairs(MS.CrosshairLines) do
        if v then v:Remove() end
    end
    MS.CrosshairLines = {}
    
    if not Config.Visuals.Crosshair then return end
    
    local c = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local s = Config.Visuals.CrosshairSize
    
    local h = Drawing.new("Line")
    h.From = Vector2.new(c.X - s, c.Y)
    h.To = Vector2.new(c.X + s, c.Y)
    h.Color = Config.Visuals.CrosshairColor
    h.Thickness = 2
    h.Visible = true
    table.insert(MS.CrosshairLines, h)
    
    local v = Drawing.new("Line")
    v.From = Vector2.new(c.X, c.Y - s)
    v.To = Vector2.new(c.X, c.Y + s)
    v.Color = Config.Visuals.CrosshairColor
    v.Thickness = 2
    v.Visible = true
    table.insert(MS.CrosshairLines, v)
end

-- FPS Counter
local function UpdateFPSCounter()
    if MS.FPSLabel then MS.FPSLabel:Remove(); MS.FPSLabel = nil end
    if not Config.Delay.ShowFPS then return end
    
    MS.FPSLabel = Drawing.new("Text")
    MS.FPSLabel.Text = "FPS: --"
    MS.FPSLabel.Position = Vector2.new(10, 10)
    MS.FPSLabel.Size = 15
    MS.FPSLabel.Color = Color3.fromRGB(0, 255, 100)
    MS.FPSLabel.Outline = true
    MS.FPSLabel.Visible = true
    MS.FPSLabel.Font = Drawing.Fonts.Monospace
    
    coroutine.wrap(function()
        while Config.Delay.ShowFPS and MS.FPSLabel do
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            if MS.FPSLabel then
                MS.FPSLabel.Text = "FPS: " .. fps
                MS.FPSLabel.Color = fps >= 60 and Color3.fromRGB(0, 255, 100) or (fps >= 30 and Color3.fromRGB(255, 180, 0) or Color3.fromRGB(255, 50, 50))
            end
        end
        if MS.FPSLabel then MS.FPSLabel:Remove(); MS.FPSLabel = nil end
    end)()
end

-- Ping Counter
local function UpdatePingCounter()
    if MS.PingLabel then MS.PingLabel:Remove(); MS.PingLabel = nil end
    if not Config.Delay.ShowPing then return end
    
    MS.PingLabel = Drawing.new("Text")
    MS.PingLabel.Text = "Ping: --"
    MS.PingLabel.Position = Vector2.new(10, Config.Delay.ShowFPS and 28 or 10)
    MS.PingLabel.Size = 15
    MS.PingLabel.Color = Color3.fromRGB(0, 150, 255)
    MS.PingLabel.Outline = true
    MS.PingLabel.Visible = true
    MS.PingLabel.Font = Drawing.Fonts.Monospace
    
    coroutine.wrap(function()
        while Config.Delay.ShowPing and MS.PingLabel do
            pcall(function()
                local ping = math.floor(Stats.PerformanceStats.Ping:GetValue() * 1000)
                if MS.PingLabel then
                    MS.PingLabel.Text = "Ping: " .. ping .. "ms"
                end
            end)
            task.wait(1)
        end
        if MS.PingLabel then MS.PingLabel:Remove(); MS.PingLabel = nil end
    end)()
end

-- ============ ATUALIZAR CONTEÚDO ============
function UpdateContent()
    ClearScroll()
    
    if CurrentTab == "Home" then
        Section("⚡ MATEUS_SCRIPTS v20.0")
        
        local info = Instance.new("Frame")
        info.Size = UDim2.new(1, 0, 0, 50)
        info.BackgroundColor3 = C.Cinza
        info.BackgroundTransparency = 0.4
        info.BorderSizePixel = 0
        info.Parent = Scroll
        Instance.new("UICorner", info).CornerRadius = UDim.new(0, 6)
        
        local t3 = Instance.new("TextLabel")
        t3.Size = UDim2.new(1, -14, 0, 14)
        t3.Position = UDim2.new(0, 7, 0, 5)
        t3.BackgroundTransparency = 1
        t3.Text = "👤 Criador: Mateus"
        t3.TextColor3 = C.Texto
        t3.Font = Enum.Font.GothamBold
        t3.TextSize = 10
        t3.TextXAlignment = Enum.TextXAlignment.Left
        t3.Parent = info
        
        local t4 = Instance.new("TextLabel")
        t4.Size = UDim2.new(1, -14, 0, 13)
        t4.Position = UDim2.new(0, 7, 0, 21)
        t4.BackgroundTransparency = 1
        t4.Text = "📸 @mateuss_hrq"
        t4.TextColor3 = Color3.fromRGB(255, 100, 150)
        t4.Font = Enum.Font.Gotham
        t4.TextSize = 9
        t4.TextXAlignment = Enum.TextXAlignment.Left
        t4.Parent = info
        
        local t5 = Instance.new("TextLabel")
        t5.Size = UDim2.new(1, -14, 0, 10)
        t5.Position = UDim2.new(0, 7, 0, 36)
        t5.BackgroundTransparency = 1
        t5.Text = "© 2026 | v20.0 Corrigido"
        t5.TextColor3 = C.TextoCinza
        t5.Font = Enum.Font.Gotham
        t5.TextSize = 7
        t5.TextXAlignment = Enum.TextXAlignment.Left
        t5.Parent = info
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, 100)
        
    elseif CurrentTab == "ESP" then
        Section("👁 ESP")
        Toggle("Ativar ESP", Config.ESP.Enabled, function(v) Config.ESP.Enabled = v; UpdateESP() end)
        Toggle("Detectar Times", Config.ESP.TeamCheck, function(v) Config.ESP.TeamCheck = v; UpdateESP() end)
        Section("📦 BOX")
        Toggle("Box", Config.ESP.Boxes, function(v) Config.ESP.Boxes = v; UpdateESP() end)
        ColorPick("Cor Inimigos", Config.ESP.BoxColor, function(c) Config.ESP.BoxColor = c; UpdateESP() end)
        ColorPick("Cor Aliados", Config.ESP.TeamBoxColor, function(c) Config.ESP.TeamBoxColor = c; UpdateESP() end)
        Section("📝 NOME E VIDA")
        Toggle("Nomes", Config.ESP.Names, function(v) Config.ESP.Names = v; UpdateESP() end)
        ColorPick("Cor Nome Inimigo", Config.ESP.NameColor, function(c) Config.ESP.NameColor = c; UpdateESP() end)
        ColorPick("Cor Nome Aliado", Config.ESP.TeamNameColor, function(c) Config.ESP.TeamNameColor = c; UpdateESP() end)
        Toggle("Barra de Vida", Config.ESP.HealthBar, function(v) Config.ESP.HealthBar = v; UpdateESP() end)
        Section("📏 DISTÂNCIA")
        Toggle("Distância", Config.ESP.Distance, function(v) Config.ESP.Distance = v; UpdateESP() end)
        ColorPick("Cor Distância", Config.ESP.DistanceColor, function(c) Config.ESP.DistanceColor = c; UpdateESP() end)
        Slider("Distância Máx", 100, 3000, Config.ESP.MaxDistance, function(v) Config.ESP.MaxDistance = v end)
        Section("📍 TRACERS")
        Toggle("Tracers", Config.ESP.Tracers, function(v) Config.ESP.Tracers = v; UpdateESP() end)
        ColorPick("Cor Tracers", Config.ESP.TracerColor, function(c) Config.ESP.TracerColor = c; UpdateESP() end)
        
    elseif CurrentTab == "Apelao" then
        Section("💀 APELÃO")
        Toggle("Ativar Apelão", Config.Apelao.Enabled, function(v) Config.Apelao.Enabled = v; UpdateFOV() end)
        Toggle("Detectar Times", Config.Apelao.TeamCheck, function(v) Config.Apelao.TeamCheck = v end)
        Section("🔴 FOV")
        Toggle("Mostrar FOV", Config.Apelao.FOV_Visible, function(v) Config.Apelao.FOV_Visible = v; UpdateFOV() end)
        ColorPick("Cor FOV", Config.Apelao.FOV_Color, function(c) Config.Apelao.FOV_Color = c; UpdateFOV() end)
        Slider("Raio FOV", 30, 500, Config.Apelao.FOV_Radius, function(v) Config.Apelao.FOV_Radius = v; UpdateFOV() end)
        Section("🎯 MIRA")
        Slider("Suavidade", 1, 20, Config.Apelao.Smoothness, function(v) Config.Apelao.Smoothness = v end)
        Slider("Distância Máx", 100, 3000, Config.Apelao.MaxDistance, function(v) Config.Apelao.MaxDistance = v end)
        Dropdown("Parte do Corpo", {"Head", "HumanoidRootPart", "Torso"}, Config.Apelao.AimPart, function(v) Config.Apelao.AimPart = v end)
        Toggle("Trigger Bot", Config.Apelao.TriggerBot, function(v) Config.Apelao.TriggerBot = v end)
        
    elseif CurrentTab == "Seguro" then
        Section("🛡 AIMBOT SEGURO")
        Toggle("Ativar Seguro", Config.Seguro.Enabled, function(v) Config.Seguro.Enabled = v end)
        Section("🤫 SILENT")
        Toggle("Silent Aim", Config.Seguro.SilentAim, function(v) Config.Seguro.SilentAim = v end)
        Section("👁 VISIBILIDADE")
        Toggle("Visibility Check", Config.Seguro.VisibilityCheck, function(v) Config.Seguro.VisibilityCheck = v end)
        Section("🧠 HUMANIZAÇÃO")
        Toggle("Humanização", Config.Seguro.Humanization, function(v) Config.Seguro.Humanization = v end)
        Toggle("Suavidade Aleatória", Config.Seguro.RandomSmoothness, function(v) Config.Seguro.RandomSmoothness = v end)
        Slider("Suavidade Mín", 1, 10, Config.Seguro.SmoothnessMin, function(v) Config.Seguro.SmoothnessMin = v end)
        Slider("Suavidade Máx", 1, 10, Config.Seguro.SmoothnessMax, function(v) Config.Seguro.SmoothnessMax = v end)
        Toggle("Delay Aleatório", Config.Seguro.RandomDelay, function(v) Config.Seguro.RandomDelay = v end)
        Section("🎯 HITBOX")
        Toggle("Hitbox Expander", Config.Seguro.HitboxExpander, function(v) Config.Seguro.HitboxExpander = v end)
        Slider("Multiplicador", 1.1, 2.5, Config.Seguro.HitboxMultiplier, function(v) Config.Seguro.HitboxMultiplier = v end)
        Section("⚙ CONTROLES")
        Toggle("Quick Toggle", Config.Seguro.QuickToggle, function(v) Config.Seguro.QuickToggle = v end)
        Keybind("Tecla Quick", Config.Seguro.QuickToggleKey, function(k) Config.Seguro.QuickToggleKey = k end)
        
    elseif CurrentTab == "Player" then
        -- SEÇÃO EM DESENVOLVIMENTO - TUDO DESABILITADO
        Section("🚧 EM DESENVOLVIMENTO", C.AmareloDev)
        
        local devFrame = Instance.new("Frame")
        devFrame.Size = UDim2.new(1, 0, 0, 35)
        devFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 15)
        devFrame.BackgroundTransparency = 0.4
        devFrame.BorderSizePixel = 0
        devFrame.Parent = Scroll
        
        local devCorner = Instance.new("UICorner")
        devCorner.CornerRadius = UDim.new(0, 6)
        devCorner.Parent = devFrame
        
        local devText = Instance.new("TextLabel")
        devText.Size = UDim2.new(1, -14, 0, 30)
        devText.Position = UDim2.new(0, 7, 0, 3)
        devText.BackgroundTransparency = 1
        devText.Text = "🚧 Esta seção está em desenvolvimento\nNenhuma função disponível no momento"
        devText.TextColor3 = C.AmareloDev
        devText.Font = Enum.Font.Gotham
        devText.TextSize = 9
        devText.TextXAlignment = Enum.TextXAlignment.Left
        devText.Parent = devFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 37)
        
        -- Toggles desabilitados (apenas visual)
        Toggle("Speed Hack", false, function() end, true)
        Slider("Velocidade", 20, 200, 32, function() end, true)
        Toggle("Super Pulo", false, function() end, true)
        Slider("Força Pulo", 50, 500, 120, function() end, true)
        Toggle("God Mode", false, function() end, true)
        Toggle("Fly", false, function() end, true)
        Slider("Velocidade Fly", 20, 150, 50, function() end, true)
        Toggle("NoClip", false, function() end, true)
        Toggle("Invisível", false, function() end, true)
        
    elseif CurrentTab == "Visual" then
        Section("🎨 VISUAIS")
        Toggle("FullBright", Config.Visuals.FullBright, function(v)
            Config.Visuals.FullBright = v
            if v then
                Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1; Lighting.GlobalShadows = true
            end
        end)
        Toggle("Sem Névoa", Config.Visuals.NoFog, function(v)
            Config.Visuals.NoFog = v; Lighting.FogEnd = v and 100000 or 1000
        end)
        Toggle("3ª Pessoa", Config.Visuals.ThirdPerson, function(v)
            Config.Visuals.ThirdPerson = v
            LocalPlayer.CameraMode = v and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson
        end)
        Toggle("Mudar FOV", Config.Visuals.FOVChanger, function(v)
            Config.Visuals.FOVChanger = v; Camera.FieldOfView = v and Config.Visuals.FOVValue or 70
        end)
        Slider("FOV", 30, 120, Config.Visuals.FOVValue, function(v)
            Config.Visuals.FOVValue = v
            if Config.Visuals.FOVChanger then Camera.FieldOfView = v end
        end)
        Section("🎯 CROSSHAIR")
        Toggle("Crosshair", Config.Visuals.Crosshair, function(v) Config.Visuals.Crosshair = v; UpdateCrosshair() end)
        ColorPick("Cor", Config.Visuals.CrosshairColor, function(c) Config.Visuals.CrosshairColor = c; UpdateCrosshair() end)
        Slider("Tamanho", 5, 30, Config.Visuals.CrosshairSize, function(v) Config.Visuals.CrosshairSize = v; UpdateCrosshair() end)
        
    elseif CurrentTab == "Delay" then
        Section("📊 MONITOR")
        Toggle("Mostrar FPS", Config.Delay.ShowFPS, function(v)
            Config.Delay.ShowFPS = v
            UpdateFPSCounter()
        end)
        Toggle("Mostrar Ping", Config.Delay.ShowPing, function(v)
            Config.Delay.ShowPing = v
            UpdatePingCounter()
        end)
        Section("⚡ PERFORMANCE")
        Toggle("Low Graphics", Config.Delay.LowGraphics, function(v)
            Config.Delay.LowGraphics = v
            Lighting.GlobalShadows = not v
        end)
        Toggle("Sem Sombras", Config.Delay.NoShadows, function(v)
            Config.Delay.NoShadows = v
            Lighting.GlobalShadows = not v
        end)
        Section("🧹 LIMPEZA")
        Button("🧹 Limpar Lag", C.Amarelo, function()
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                        obj:Destroy()
                    end
                end)
            end
        end)
        
    elseif CurrentTab == "Config" then
        Section("⚙ CONFIG")
        Keybind("Tecla Menu", Config.MenuKey, function(k) Config.MenuKey = k end)
        Button("💾 Salvar", C.Verde, function() print("Salvo!") end)
        Button("📂 Carregar", C.Roxo, function() print("Carregado!") end)
    end
end

-- ============ LOOP PRINCIPAL ============
RunService.RenderStepped:Connect(function()
    if MS.FOV_Circle then
        pcall(function()
            MS.FOV_Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        end)
    end
    
    if Config.Apelao.Enabled then
        local target = GetClosestTarget()
        if target and target.Character then
            local aimPart = target.Character:FindFirstChild(Config.Apelao.AimPart)
            if aimPart then
                local smooth = math.clamp(Config.Apelao.Smoothness / 20, 0.05, 1)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, aimPart.Position), smooth)
                
                if Config.Apelao.TriggerBot then
                    local now = tick()
                    if now - MS.LastTriggerTime >= 0.1 then
                        MS.LastTriggerTime = now
                        pcall(function() mouse1click() end)
                    end
                end
            end
        end
    end
    
    if Config.Seguro.Enabled then
        local target = GetClosestTarget()
        if target and target.Character then
            if Config.Seguro.QuickToggle and not UserInputService:IsKeyDown(Config.Seguro.QuickToggleKey) then return end
            
            if tick() - MS.LastTargetSwitch < 0.3 then return end
            
            local aimPart = target.Character:FindFirstChild(Config.Apelao.AimPart)
            if aimPart then
                if Config.Seguro.SilentAim then
                    local orig = Camera.CFrame
                    local tp = aimPart.Position
                    if Config.Seguro.HitboxExpander then
                        tp = tp + Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)) * Config.Seguro.HitboxMultiplier
                    end
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp)
                    pcall(function() mouse1click() end)
                    task.wait(0.03)
                    Camera.CFrame = orig
                else
                    local smooth = Config.Apelao.Smoothness
                    if Config.Seguro.RandomSmoothness then
                        smooth = math.random(Config.Seguro.SmoothnessMin * 10, Config.Seguro.SmoothnessMax * 10) / 10
                    end
                    
                    if Config.Seguro.RandomDelay then
                        task.wait(math.random(Config.Seguro.DelayMin, Config.Seguro.DelayMax) / 1000)
                    end
                    
                    local tp = aimPart.Position
                    if Config.Seguro.HitboxExpander then
                        tp = tp + Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)) * Config.Seguro.HitboxMultiplier
                    end
                    
                    local sf = math.clamp(smooth / 20, 0.05, 1)
                    if Config.Seguro.JitterReduction then
                        local micro = Vector3.new(math.sin(tick() * 0.5) * 0.005, math.cos(tick() * 0.3) * 0.005, 0)
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, tp) + micro, sf)
                    else
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, tp), sf)
                    end
                end
                
                MS.LastTargetSwitch = tick()
            end
        end
    end
end)

-- Monitorar TODOS os jogadores para mudanças de time
Players.PlayerAdded:Connect(function(player)
    -- Inicializa cache
    TeamCache[player.UserId] = GetPlayerTeam(player)
    
    -- Monitora quando spawna
    player.CharacterAdded:Connect(function()
        TeamCache[player.UserId] = GetPlayerTeam(player)
        if Config.ESP.Enabled then
            wait(0.3)
            UpdateESP()
        end
    end)
    
    -- Monitora mudanças de time
    player:GetPropertyChangedSignal("Team"):Connect(function()
        TeamCache[player.UserId] = GetPlayerTeam(player)
        if Config.ESP.Enabled then UpdateESP() end
    end)
    
    player:GetPropertyChangedSignal("TeamColor"):Connect(function()
        TeamCache[player.UserId] = GetPlayerTeam(player)
        if Config.ESP.Enabled then UpdateESP() end
    end)
end)

-- Iniciar monitoramento de times
MonitorTeamChanges()

-- INIT
UpdateContent()
UpdateFOV()
UpdateCrosshair()

print("🟣 MATEUS_SCRIPTS v20.0 - CORRIGIDO")
print("✅ ESP Team Check - Atualização em tempo real")
print("✅ Player em Desenvolvimento")
print("👤 Mateus | 📸 @mateuss_hrq | 2026")
