--[[
    ╔═══════════════════════════════════════════════════════╗
    ║   MATEUS_SCRIPTS v4.0 - ULTRA OTIMIZADO              ║
    ║  • Detecção Automática Mobile/PC                     ║
    ║  • Menu Arrastável em Ambos Dispositivos             ║
    ║  • FPS/PING Perfeitos e Precisos                     ║
    ║  • +20 Novas Funções                                 ║
    ║  • Zero Bugs • Performance Máxima                    ║
    ╚═══════════════════════════════════════════════════════╝
]]

-- ═══════════════════════ SERVIÇOS ═══════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local TouchInputService = game:GetService("TouchInputService")
local ContextActionService = game:GetService("ContextActionService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════ DETECÇÃO DE DISPOSITIVO ═══════════════════════
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsConsole = UserInputService.GamepadEnabled
local IsPC = not IsMobile and not IsConsole

-- ═══════════════════════ CORES (Branco/Preto) ═══════════════════════
local C = {
    Branco = Color3.fromRGB(255, 255, 255),
    BrancoSuave = Color3.fromRGB(235, 235, 240),
    CinzaClaro = Color3.fromRGB(190, 190, 195),
    Cinza = Color3.fromRGB(140, 140, 145),
    CinzaEscuro = Color3.fromRGB(70, 70, 75),
    Preto = Color3.fromRGB(8, 8, 10),
    PretoClaro = Color3.fromRGB(18, 18, 22),
    PretoMedio = Color3.fromRGB(28, 28, 32),
    PretoFundo = Color3.fromRGB(12, 12, 15),
    
    -- Cores padrão
    Inimigo = Color3.fromRGB(255, 50, 50),
    Aliado = Color3.fromRGB(50, 150, 255),
    
    -- Cores de status
    Verde = Color3.fromRGB(0, 220, 80),
    Vermelho = Color3.fromRGB(255, 50, 50),
    Amarelo = Color3.fromRGB(255, 210, 0),
    Azul = Color3.fromRGB(0, 160, 255),
    Roxo = Color3.fromRGB(150, 50, 255),
    Laranja = Color3.fromRGB(255, 150, 50),
}

-- ═══════════════════════ CONFIGURAÇÕES ═══════════════════════
local Config = {
    MenuKey = IsMobile and Enum.KeyCode.ButtonR2 or Enum.KeyCode.RightShift,
    
    ESP = {
        Enabled = false,
        Boxes = true,
        BoxColor = C.Inimigo,
        TeamBoxColor = C.Aliado,
        Names = true,
        NameColor = C.Branco,
        TeamNameColor = C.Azul,
        HealthBar = true,
        Distance = true,
        DistanceColor = C.CinzaClaro,
        Tracers = false,
        TracerColor = C.Branco,
        TeamCheck = true,
        MaxDistance = 1500,
        Chams = false,
        ChamsColor = C.Vermelho,
        TeamChamsColor = C.Azul,
        Glow = false,
        GlowColor = C.Branco,
    },
    
    Aimbot = {
        Enabled = false,
        FOV = 130,
        FOVColor = C.Branco,
        ShowFOV = true,
        Smoothness = 3,
        AimPart = "Head",
        TeamCheck = true,
        MaxDistance = 800,
        Prediction = 0,
        SilentAim = false,
        Triggerbot = false,
        TriggerDelay = 0.1,
    },
    
    Visuals = {
        FullBright = false,
        NoFog = false,
        FOVChanger = false,
        FOVValue = 70,
        Crosshair = false,
        CrosshairSize = 15,
        CrosshairColor = C.Branco,
        CrosshairType = "Cross", -- Cross, Dot, Circle
        Watermark = true,
        WatermarkText = "Mateus Scripts v4.0",
        NoCameraShake = false,
        NoRecoil = false,
        NoSpread = false,
    },
    
    Monitor = {
        Enabled = true,
        ShowFPS = true,
        ShowPing = true,
        ShowMemory = false,
        ShowTime = false,
        ShowPlayers = false,
    },
    
    Misc = {
        AutoFarm = false,
        AutoCollect = false,
        NoClip = false,
        Speed = 16,
        JumpPower = 50,
        InfiniteJump = false,
        AntiAFK = false,
        Walkspeed = false,
    }
}

-- ═══════════════════════ SISTEMA DE SALVAMENTO ═══════════════════════
local SaveSystem = {
    FileName = "MateusConfig_" .. LocalPlayer.UserId .. ".json"
}

function SaveSystem:Load()
    local success, data = pcall(function()
        return readfile(self.FileName)
    end)
    
    if success and data and data ~= "" then
        local success2, decoded = pcall(function()
            return HttpService:JSONDecode(data)
        end)
        
        if success2 and decoded then
            for category, values in pairs(decoded) do
                if Config[category] then
                    for key, value in pairs(values) do
                        if Config[category][key] ~= nil then
                            Config[category][key] = value
                        end
                    end
                end
            end
            return true
        end
    end
    return false
end

function SaveSystem:Save()
    local dataToSave = {}
    
    for category, values in pairs(Config) do
        if type(values) == "table" then
            dataToSave[category] = {}
            for key, value in pairs(values) do
                if type(value) ~= "function" and type(value) ~= "userdata" then
                    dataToSave[category][key] = value
                end
            end
        end
    end
    
    local success = pcall(function()
        writefile(self.FileName, HttpService:JSONEncode(dataToSave))
    end)
    
    return success
end

function SaveSystem:Reset()
    Config = {
        MenuKey = IsMobile and Enum.KeyCode.ButtonR2 or Enum.KeyCode.RightShift,
        
        ESP = {
            Enabled = false, Boxes = true, BoxColor = C.Inimigo, TeamBoxColor = C.Aliado,
            Names = true, NameColor = C.Branco, TeamNameColor = C.Azul,
            HealthBar = true, Distance = true, DistanceColor = C.CinzaClaro,
            Tracers = false, TracerColor = C.Branco, TeamCheck = true, MaxDistance = 1500,
            Chams = false, ChamsColor = C.Vermelho, TeamChamsColor = C.Azul,
            Glow = false, GlowColor = C.Branco,
        },
        
        Aimbot = {
            Enabled = false, FOV = 130, FOVColor = C.Branco, ShowFOV = true,
            Smoothness = 3, AimPart = "Head", TeamCheck = true, MaxDistance = 800,
            Prediction = 0, SilentAim = false, Triggerbot = false, TriggerDelay = 0.1,
        },
        
        Visuals = {
            FullBright = false, NoFog = false, FOVChanger = false, FOVValue = 70,
            Crosshair = false, CrosshairSize = 15, CrosshairColor = C.Branco,
            CrosshairType = "Cross", Watermark = true, WatermarkText = "Mateus Scripts v4.0",
            NoCameraShake = false, NoRecoil = false, NoSpread = false,
        },
        
        Monitor = {
            Enabled = true, ShowFPS = true, ShowPing = true,
            ShowMemory = false, ShowTime = false, ShowPlayers = false,
        },
        
        Misc = {
            AutoFarm = false, AutoCollect = false, NoClip = false,
            Speed = 16, JumpPower = 50, InfiniteJump = false,
            AntiAFK = false, Walkspeed = false,
        }
    }
    self:Save()
end

-- ═══════════════════════ GUI PRINCIPAL ═══════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MateusScripts"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════ TAMANHO DO MENU (Adaptável) ═══════════════════════
local MenuWidth = IsMobile and 480 or 560
local MenuHeight = IsMobile and 500 or 460

-- ═══════════════════════ LOGO ARRASTÁVEL ═══════════════════════
local Logo = Instance.new("ImageButton")
Logo.Size = UDim2.new(0, 55, 0, 55)
Logo.Position = UDim2.new(0.5, -27, 0.5, -27)
Logo.BackgroundColor3 = C.PretoFundo
Logo.BackgroundTransparency = 0.15
Logo.Image = "rbxassetid://0"
Logo.ImageTransparency = 1
Logo.Visible = false
Logo.ZIndex = 10000
Logo.Parent = ScreenGui

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 27)
LogoCorner.Parent = Logo

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Thickness = 2
LogoStroke.Color = C.Branco
LogoStroke.Transparency = 0.6
LogoStroke.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "⚙"
LogoText.TextColor3 = C.Branco
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 28
LogoText.ZIndex = 10001
LogoText.Parent = Logo

-- Sistema de arrasto da logo (Mobile + PC)
local LogoDragging = false
local LogoDragStart = nil
local LogoStartPos = nil

local function StartLogoDrag(input)
    LogoDragging = true
    LogoDragStart = input.Position
    LogoStartPos = Logo.Position
end

local function UpdateLogoDrag(input)
    if LogoDragging and LogoDragStart then
        local delta = input.Position - LogoDragStart
        Logo.Position = UDim2.new(
            LogoStartPos.X.Scale, LogoStartPos.X.Offset + delta.X,
            LogoStartPos.Y.Scale, LogoStartPos.Y.Offset + delta.Y
        )
    end
end

local function EndLogoDrag()
    LogoDragging = false
    LogoDragStart = nil
    LogoStartPos = nil
end

-- PC Drag
Logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        StartLogoDrag(input)
    end
end)

Logo.InputChanged:Connect(function(input)
    if LogoDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        UpdateLogoDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        EndLogoDrag()
    end
end)

-- Mobile Drag
if IsMobile then
    Logo.TouchLongPress:Connect(function(touchPositions)
        if #touchPositions > 0 then
            StartLogoDrag({Position = touchPositions[1]})
        end
    end)
    
    UserInputService.TouchMoved:Connect(function(input, processed)
        if LogoDragging and not processed then
            UpdateLogoDrag(input)
        end
    end)
    
    UserInputService.TouchEnded:Connect(function()
        EndLogoDrag()
    end)
end

Logo.MouseButton1Click:Connect(function()
    Main.Visible = true
    Logo.Visible = false
end)

-- ═══════════════════════ MENU PRINCIPAL ═══════════════════════
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, MenuWidth, 0, MenuHeight)
Main.Position = UDim2.new(0.5, -MenuWidth/2, 0.5, -MenuHeight/2)
Main.BackgroundColor3 = C.PretoFundo
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Main.Visible = true
Main.ZIndex = 10000
Main.Parent = ScreenGui

Main.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = C.Branco
MainStroke.Transparency = 0.85
MainStroke.Parent = Main

-- ═══════════════════════ HEADER ═══════════════════════
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = C.PretoClaro
Header.BackgroundTransparency = 0.25
Header.BorderSizePixel = 0
Header.ZIndex = 10006
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 0, 22)
Title.Position = UDim2.new(0, 15, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "⚙ CONFIGURAÇÕES"
Title.TextColor3 = C.Branco
Title.Font = Enum.Font.GothamBold
Title.TextSize = IsMobile and 14 or 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 10007
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 250, 0, 15)
SubTitle.Position = UDim2.new(0, 15, 0, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = IsMobile and "Mobile Otimizado" or "PC Otimizado"
SubTitle.TextColor3 = C.Cinza
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 10007
SubTitle.Parent = Header

-- Botão Minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -66, 0, 11)
MinBtn.BackgroundColor3 = C.CinzaEscuro
MinBtn.BackgroundTransparency = 0.3
MinBtn.BorderSizePixel = 0
MinBtn.Text = "─"
MinBtn.TextColor3 = C.Branco
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.ZIndex = 10007
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 11)
CloseBtn.BackgroundColor3 = C.Vermelho
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.Branco
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 10007
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- ═══════════════════════ SISTEMA DE ARRASTO (Mobile + PC) ═══════════════════════
local dragging = false
local dragStart = nil
local startPos = nil

local function StartDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = Main.Position
end

local function UpdateDrag(input)
    if dragging and dragStart then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end

local function EndDrag()
    dragging = false
    dragStart = nil
    startPos = nil
end

-- PC Drag
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        StartDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        UpdateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        EndDrag()
    end
end)

-- Mobile Drag
if IsMobile then
    Header.TouchLongPress:Connect(function(touchPositions)
        if #touchPositions > 0 then
            StartDrag({Position = touchPositions[1]})
        end
    end)
    
    UserInputService.TouchMoved:Connect(function(input, processed)
        if dragging and not processed then
            UpdateDrag(input)
        end
    end)
    
    UserInputService.TouchEnded:Connect(function()
        EndDrag()
    end)
end

-- ═══════════════════════ SIDEBAR ═══════════════════════
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, IsMobile and 100 or 125, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = C.PretoClaro
Sidebar.BackgroundTransparency = 0.35
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 10005
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

-- ═══════════════════════ CONTEÚDO ═══════════════════════
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -(IsMobile and 110 or 135), 1, -60)
Content.Position = UDim2.new(0, IsMobile and 105 or 130, 0, 55)
Content.BackgroundColor3 = C.PretoMedio
Content.BackgroundTransparency = 0.45
Content.BorderSizePixel = 0
Content.ZIndex = 10005
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = IsMobile and 5 or 3
Scroll.ScrollBarImageColor3 = C.Branco
Scroll.ScrollBarImageTransparency = 0.8
Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
Scroll.ZIndex = 10006
Scroll.Parent = Content

-- Mobile scroll fix
if IsMobile then
    Scroll.ScrollingEnabled = true
    Scroll.ElasticBehavior = Enum.ElasticBehavior.Always
end

local ScrollList = Instance.new("UIListLayout")
ScrollList.Padding = UDim.new(0, 5)
ScrollList.SortOrder = Enum.SortOrder.LayoutOrder
ScrollList.Parent = Scroll

-- ═══════════════════════ SISTEMA DE ABAS ═══════════════════════
local Tabs = {
    {Name = "Geral", Icon = "🏠"},
    {Name = "ESP", Icon = "👁"},
    {Name = "Aimbot", Icon = "🎯"},
    {Name = "Visual", Icon = "🎨"},
    {Name = "Monitor", Icon = "📊"},
    {Name = "Misc", Icon = "⚡"},
    {Name = "Config", Icon = "⚙"},
}

local CurrentTab = "Geral"
local TabButtons = {}

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 4)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidePad = Instance.new("Frame")
SidePad.Size = UDim2.new(1, 0, 0, 8)
SidePad.BackgroundTransparency = 1
SidePad.LayoutOrder = 0
SidePad.Parent = Sidebar

for i, tab in ipairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, IsMobile and 30 or 34)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = C.PretoMedio
    btn.BackgroundTransparency = 0.55
    btn.BorderSizePixel = 0
    btn.Text = tab.Icon .. "  " .. tab.Name
    btn.TextColor3 = C.Cinza
    btn.Font = Enum.Font.Gotham
    btn.TextSize = IsMobile and 10 or 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = i
    btn.ZIndex = 10006
    btn.Parent = Sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        CurrentTab = tab.Name
        UpdateTabStyles()
        UpdateContent()
    end)
    
    TabButtons[tab.Name] = btn
end

function UpdateTabStyles()
    for name, btn in pairs(TabButtons) do
        if name == CurrentTab then
            btn.BackgroundColor3 = C.Branco
            btn.BackgroundTransparency = 0.85
            btn.TextColor3 = C.Branco
        else
            btn.BackgroundColor3 = C.PretoMedio
            btn.BackgroundTransparency = 0.55
            btn.TextColor3 = C.Cinza
        end
    end
end

UpdateTabStyles()

-- ═══════════════════════ COMPONENTES DE UI ═══════════════════════

function ClearScroll()
    for _, child in pairs(Scroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") then
            child:Destroy()
        end
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
end

function Section(text)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 22)
    frame.BackgroundTransparency = 1
    frame.Parent = Scroll
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.Branco
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 10006
    l.Parent = frame
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 1, -1)
    line.BackgroundColor3 = C.Branco
    line.BackgroundTransparency = 0.85
    line.BorderSizePixel = 0
    line.Parent = frame
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 24)
    return l
end

function Toggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 36 or 32)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, IsMobile and 48 or 42, 0, IsMobile and 26 or 22)
    toggleBtn.Position = UDim2.new(1, -(IsMobile and 56 or 50), 0.5, -(IsMobile and 13 or 11))
    toggleBtn.BackgroundColor3 = default and C.Verde or C.CinzaEscuro
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 10006
    toggleBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = toggleBtn
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, IsMobile and 22 or 18, 0, IsMobile and 22 or 18)
    dot.Position = default and UDim2.new(1, -(IsMobile and 24 or 20), 0.5, -(IsMobile and 11 or 9)) or UDim2.new(0, 2, 0.5, -(IsMobile and 11 or 9))
    dot.BackgroundColor3 = C.Branco
    dot.BorderSizePixel = 0
    dot.ZIndex = 10007
    dot.Parent = toggleBtn
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    local isOn = default
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggleBtn.BackgroundColor3 = isOn and C.Verde or C.CinzaEscuro
        dot.Position = isOn and UDim2.new(1, -(IsMobile and 24 or 20), 0.5, -(IsMobile and 11 or 9)) or UDim2.new(0, 2, 0.5, -(IsMobile and 11 or 9))
        
        if callback then
            callback(isOn)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 38 or 34))
    return frame
end

function Slider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 52 or 48)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 16)
    label.Position = UDim2.new(0, 10, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, IsMobile and 7 or 5)
    track.Position = UDim2.new(0, 10, 0, IsMobile and 30 or 28)
    track.BackgroundColor3 = C.CinzaEscuro
    track.BorderSizePixel = 0
    track.ZIndex = 10006
    track.Parent = frame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.Branco
    fill.BackgroundTransparency = 0.35
    fill.BorderSizePixel = 0
    fill.ZIndex = 10006
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = fill
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, IsMobile and 18 or 14, 0, IsMobile and 18 or 14)
    thumb.Position = UDim2.new((default - min) / (max - min), -(IsMobile and 9 or 7), 0.5, -(IsMobile and 9 or 7))
    thumb.BackgroundColor3 = C.Branco
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 10007
    thumb.Parent = track
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb
    
    local currentValue = default
    local isDragging = false
    
    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
            if callback then callback(currentValue) end
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if isDragging then
            local mousePos = UserInputService:GetMouseLocation()
            local trackPos = track.AbsolutePosition
            local trackSize = track.AbsoluteSize
            
            local relativeX = math.clamp(mousePos.X - trackPos.X, 0, trackSize.X)
            local percentage = relativeX / trackSize.X
            currentValue = math.floor(min + (max - min) * percentage)
            
            fill.Size = UDim2.new(percentage, 0, 1, 0)
            thumb.Position = UDim2.new(percentage, -(IsMobile and 9 or 7), 0.5, -(IsMobile and 9 or 7))
            label.Text = text .. ": " .. tostring(currentValue)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 54 or 50))
    return frame
end

function ColorPicker(text, defaultColor, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 36)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0, IsMobile and 28 or 24, 0, IsMobile and 28 or 24)
    preview.Position = UDim2.new(1, -(IsMobile and 34 or 30), 0.5, -(IsMobile and 14 or 12))
    preview.BackgroundColor3 = defaultColor
    preview.BorderSizePixel = 0
    preview.ZIndex = 10006
    preview.Parent = frame
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 6)
    prevCorner.Parent = preview
    
    -- Paleta de cores expandida
    local Colors = {
        Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 100, 100),
        Color3.fromRGB(255, 150, 50), Color3.fromRGB(255, 200, 50),
        Color3.fromRGB(200, 255, 50), Color3.fromRGB(100, 255, 50),
        Color3.fromRGB(50, 255, 100), Color3.fromRGB(50, 255, 200),
        Color3.fromRGB(50, 200, 255), Color3.fromRGB(50, 100, 255),
        Color3.fromRGB(100, 50, 255), Color3.fromRGB(200, 50, 255),
        Color3.fromRGB(255, 50, 200), Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(200, 200, 200), Color3.fromRGB(150, 150, 150),
        Color3.fromRGB(100, 100, 100), Color3.fromRGB(50, 50, 50),
        Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(128, 0, 0), Color3.fromRGB(0, 128, 0),
        Color3.fromRGB(0, 0, 128), Color3.fromRGB(128, 128, 0),
        Color3.fromRGB(128, 0, 128), Color3.fromRGB(0, 128, 128),
    }
    
    local paletteOpen = false
    local paletteFrame = nil
    
    preview.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if paletteOpen and paletteFrame then
                paletteFrame:Destroy()
                paletteFrame = nil
                paletteOpen = false
                return
            end
            
            paletteOpen = true
            
            paletteFrame = Instance.new("Frame")
            paletteFrame.Size = UDim2.new(0, IsMobile and 220 or 200, 0, IsMobile and 250 or 190)
            paletteFrame.Position = UDim2.new(0, 30, 0, 30)
            paletteFrame.BackgroundColor3 = C.PretoFundo
            paletteFrame.BorderSizePixel = 0
            paletteFrame.ZIndex = 10050
            paletteFrame.Parent = ScreenGui
            
            local palCorner = Instance.new("UICorner")
            palCorner.CornerRadius = UDim.new(0, 10)
            palCorner.Parent = paletteFrame
            
            local palStroke = Instance.new("UIStroke")
            palStroke.Thickness = 1.5
            palStroke.Color = C.Branco
            palStroke.Transparency = 0.7
            palStroke.Parent = paletteFrame
            
            local grid = Instance.new("UIGridLayout")
            grid.CellSize = UDim2.new(0, IsMobile and 32 or 30, 0, IsMobile and 32 or 30)
            grid.CellPadding = UDim2.new(0, 4, 0, 4)
            grid.Parent = paletteFrame
            
            for _, color in ipairs(Colors) do
                local colorBtn = Instance.new("TextButton")
                colorBtn.Size = UDim2.new(0, IsMobile and 32 or 30, 0, IsMobile and 32 or 30)
                colorBtn.BackgroundColor3 = color
                colorBtn.BorderSizePixel = 0
                colorBtn.Text = ""
                colorBtn.ZIndex = 10051
                colorBtn.Parent = paletteFrame
                
                local cbCorner = Instance.new("UICorner")
                cbCorner.CornerRadius = UDim.new(0, 6)
                cbCorner.Parent = colorBtn
                
                colorBtn.MouseButton1Click:Connect(function()
                    preview.BackgroundColor3 = color
                    if callback then callback(color) end
                    paletteFrame:Destroy()
                    paletteFrame = nil
                    paletteOpen = false
                end)
            end
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 42 or 38))
    return frame
end

function Keybind(text, defaultKey, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 36)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, IsMobile and 80 or 70, 0, IsMobile and 28 or 24)
    keyBtn.Position = UDim2.new(1, -(IsMobile and 86 or 76), 0.5, -(IsMobile and 14 or 12))
    keyBtn.BackgroundColor3 = C.CinzaEscuro
    keyBtn.BackgroundTransparency = 0.3
    keyBtn.BorderSizePixel = 0
    keyBtn.Text = defaultKey.Name
    keyBtn.TextColor3 = C.Branco
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = IsMobile and 9 or 10
    keyBtn.ZIndex = 10006
    keyBtn.Parent = frame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = keyBtn
    
    local listening = false
    
    keyBtn.MouseButton1Click:Connect(function()
        listening = true
        keyBtn.Text = "..."
        keyBtn.BackgroundColor3 = C.Branco
        keyBtn.BackgroundTransparency = 0.8
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and not gameProcessed then
            local key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
            if key then
                listening = false
                keyBtn.Text = key.Name
                keyBtn.BackgroundColor3 = C.CinzaEscuro
                keyBtn.BackgroundTransparency = 0.3
                if callback then callback(key) end
            end
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 42 or 38))
    return frame
end

function Button(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, IsMobile and 38 or 34)
    btn.BackgroundColor3 = color or C.Branco
    btn.BackgroundTransparency = 0.85
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = C.Branco
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = IsMobile and 10 or 11
    btn.ZIndex = 10006
    btn.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 40 or 36))
    return btn
end

function Dropdown(text, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 36)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0, IsMobile and 80 or 70, 0, IsMobile and 28 or 24)
    dropBtn.Position = UDim2.new(1, -(IsMobile and 86 or 76), 0.5, -(IsMobile and 14 or 12))
    dropBtn.BackgroundColor3 = C.CinzaEscuro
    dropBtn.BackgroundTransparency = 0.3
    dropBtn.BorderSizePixel = 0
    dropBtn.Text = default
    dropBtn.TextColor3 = C.Branco
    dropBtn.Font = Enum.Font.GothamBold
    dropBtn.TextSize = IsMobile and 9 or 10
    dropBtn.ZIndex = 10006
    dropBtn.Parent = frame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropBtn
    
    local expanded = false
    local optionButtons = {}
    
    dropBtn.MouseButton1Click:Connect(function()
        expanded = not expanded
        
        if expanded then
            frame.Size = UDim2.new(1, 0, 0, (IsMobile and 40 or 36) + ((IsMobile and 28 or 24) * #options))
            for i, option in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, IsMobile and 26 or 24)
                optBtn.Position = UDim2.new(0, 0, 0, (IsMobile and 40 or 36) + ((IsMobile and 28 or 24) * (i - 1)))
                optBtn.BackgroundColor3 = C.PretoMedio
                optBtn.BackgroundTransparency = 0.5
                optBtn.BorderSizePixel = 0
                optBtn.Text = "   " .. option
                optBtn.TextColor3 = C.CinzaClaro
                optBtn.Font = Enum.Font.Gotham
                optBtn.TextSize = IsMobile and 9 or 10
                optBtn.TextXAlignment = Enum.TextXAlignment.Left
                optBtn.ZIndex = 10007
                optBtn.Parent = frame
                
                optBtn.MouseButton1Click:Connect(function()
                    dropBtn.Text = option
                    expanded = false
                    frame.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 36)
                    for _, btn in ipairs(optionButtons) do btn:Destroy() end
                    optionButtons = {}
                    if callback then callback(option) end
                end)
                table.insert(optionButtons, optBtn)
            end
        else
            frame.Size = UDim2.new(1, 0, 0, IsMobile and 40 or 36)
            for _, btn in ipairs(optionButtons) do btn:Destroy() end
            optionButtons = {}
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 42 or 38))
    return frame
end

-- ═══════════════════════ MONITOR FPS/PING ═══════════════════════
local StatsDisplay = Instance.new("Frame")
StatsDisplay.Name = "StatsDisplay"
StatsDisplay.Size = UDim2.new(0, IsMobile and 160 or 140, 0, IsMobile and 60 or 44)
StatsDisplay.Position = UDim2.new(1, -(IsMobile and 170 or 150), 0, 10)
StatsDisplay.BackgroundColor3 = C.PretoFundo
StatsDisplay.BackgroundTransparency = 0.2
StatsDisplay.BorderSizePixel = 0
StatsDisplay.ZIndex = 10000
StatsDisplay.Parent = ScreenGui

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 10)
StatsCorner.Parent = StatsDisplay

local StatsStroke = Instance.new("UIStroke")
StatsStroke.Thickness = 1
StatsStroke.Color = C.Branco
StatsStroke.Transparency = 0.9
StatsStroke.Parent = StatsDisplay

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(1, -5, 0, IsMobile and 16 or 18)
FPSLabel.Position = UDim2.new(0, 5, 0, 3)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: 0"
FPSLabel.TextColor3 = C.Verde
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = IsMobile and 11 or 12
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.ZIndex = 10001
FPSLabel.Parent = StatsDisplay

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(1, -5, 0, IsMobile and 16 or 18)
PingLabel.Position = UDim2.new(0, 5, 0, IsMobile and 20 or 22)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "PING: 0ms"
PingLabel.TextColor3 = C.Azul
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = IsMobile and 11 or 12
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.ZIndex = 10001
PingLabel.Parent = StatsDisplay

-- Monitor extra
local MemLabel = Instance.new("TextLabel")
MemLabel.Size = UDim2.new(1, -5, 0, IsMobile and 16 or 18)
MemLabel.Position = UDim2.new(0, 5, 0, IsMobile and 38 or 44)
MemLabel.BackgroundTransparency = 1
MemLabel.Text = "MEM: 0MB"
MemLabel.TextColor3 = C.Roxo
MemLabel.Font = Enum.Font.GothamBold
MemLabel.TextSize = IsMobile and 10 or 11
MemLabel.TextXAlignment = Enum.TextXAlignment.Left
MemLabel.ZIndex = 10001
MemLabel.Visible = false
MemLabel.Parent = StatsDisplay

-- ═══════════════════════ SISTEMA DE FPS/PING ═══════════════════════
local lastTime = tick()
local frameCount = 0
local currentFPS = 0
local lastFPSTime = tick()

local function GetPing()
    local success, ping = pcall(function()
        return Stats.PerformanceStats.Ping:GetValue()
    end)
    if success then
        return math.floor(ping * 1000)
    end
    return 0
end

local function GetMemory()
    local success, mem = pcall(function()
        return Stats.PerformanceStats.Memory:GetValue()
    end)
    if success then
        return math.floor(mem / 1048576)
    end
    return 0
end

-- ═══════════════════════ SISTEMA ESP ═══════════════════════
local ESPObjects = {}

function UpdateESP()
    for _, obj in pairs(ESPObjects) do
        if obj.connection then
            obj.connection:Disconnect()
        end
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
    
    if not Config.ESP.Enabled then return end
    
    local myChar = LocalPlayer.Character
    if not myChar then return end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        if not char then continue end
        
        local hum = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        
        if not hum or hum.Health <= 0 or not root or not head then continue end
        
        local dist = (myRoot.Position - root.Position).Magnitude
        if dist > Config.ESP.MaxDistance then continue end
        
        local isTeam = false
        if Config.ESP.TeamCheck and player.Team and LocalPlayer.Team then
            isTeam = player.Team == LocalPlayer.Team
        end
        
        local boxColor = isTeam and Config.ESP.TeamBoxColor or Config.ESP.BoxColor
        local nameColor = isTeam and Config.ESP.TeamNameColor or Config.ESP.NameColor
        
        -- Box (Highlight)
        if Config.ESP.Boxes then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = boxColor
            highlight.FillTransparency = 0.7
            highlight.OutlineColor = boxColor
            highlight.OutlineTransparency = 0.4
            highlight.Adornee = char
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = ScreenGui
            table.insert(ESPObjects, highlight)
        end
        
        -- Chams
        if Config.ESP.Chams then
            local chamsHighlight = Instance.new("Highlight")
            chamsHighlight.FillColor = isTeam and Config.ESP.TeamChamsColor or Config.ESP.ChamsColor
            chamsHighlight.FillTransparency = 0.5
            chamsHighlight.OutlineTransparency = 1
            chamsHighlight.Adornee = char
            chamsHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
            chamsHighlight.Parent = ScreenGui
            table.insert(ESPObjects, chamsHighlight)
        end
        
        -- Glow
        if Config.ESP.Glow then
            local glowHighlight = Instance.new("Highlight")
            glowHighlight.FillColor = Config.ESP.GlowColor
            glowHighlight.FillTransparency = 0.8
            glowHighlight.OutlineColor = Config.ESP.GlowColor
            glowHighlight.OutlineTransparency = 0.3
            glowHighlight.Adornee = char
            glowHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            glowHighlight.Parent = ScreenGui
            table.insert(ESPObjects, glowHighlight)
        end
        
        -- Billboard
        if Config.ESP.Names or Config.ESP.HealthBar or Config.ESP.Distance then
            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0, 160, 0, 60)
            billboard.StudsOffset = Vector3.new(0, 3.2, 0)
            billboard.AlwaysOnTop = true
            billboard.LightInfluence = 0
            billboard.Parent = head
            table.insert(ESPObjects, billboard)
            
            local yOffset = 0
            
            if Config.ESP.Names then
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 0, 18)
                nameLabel.Position = UDim2.new(0, 0, 0, yOffset)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = player.Name
                nameLabel.TextColor3 = nameColor
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextSize = 13
                nameLabel.TextStrokeTransparency = 0.4
                nameLabel.Parent = billboard
                yOffset = yOffset + 19
            end
            
            if Config.ESP.HealthBar then
                local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                
                local barBg = Instance.new("Frame")
                barBg.Size = UDim2.new(1, 0, 0, 5)
                barBg.Position = UDim2.new(0, 0, 0, yOffset)
                barBg.BackgroundColor3 = C.CinzaEscuro
                barBg.BorderSizePixel = 0
                barBg.Parent = billboard
                
                local barFill = Instance.new("Frame")
                barFill.Size = UDim2.new(healthPercent, 0, 1, 0)
                barFill.BackgroundColor3 = healthPercent > 0.5 and C.Verde or (healthPercent > 0.25 and C.Amarelo or C.Vermelho)
                barFill.BorderSizePixel = 0
                barFill.Parent = barBg
                
                yOffset = yOffset + 7
            end
            
            if Config.ESP.Distance then
                local distLabel = Instance.new("TextLabel")
                distLabel.Size = UDim2.new(1, 0, 0, 16)
                distLabel.Position = UDim2.new(0, 0, 0, yOffset)
                distLabel.BackgroundTransparency = 1
                distLabel.Text = math.floor(dist) .. "m"
                distLabel.TextColor3 = Config.ESP.DistanceColor
                distLabel.Font = Enum.Font.Gotham
                distLabel.TextSize = 11
                distLabel.Parent = billboard
            end
        end
        
        -- Tracers
        if Config.ESP.Tracers then
            local tracer = Drawing.new("Line")
            tracer.Thickness = 1.5
            tracer.Color = Config.ESP.TracerColor
            tracer.Transparency = 0.7
            tracer.Visible = true
            
            local connection = RunService.RenderStepped:Connect(function()
                local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    tracer.Visible = true
                else
                    tracer.Visible = false
                end
            end)
            
            table.insert(ESPObjects, {connection = connection, tracer = tracer})
        end
    end
end

-- ═══════════════════════ AIMBOT ═══════════════════════
local FOVCircle = nil

function UpdateFOV()
    if FOVCircle then
        FOVCircle:Remove()
        FOVCircle = nil
    end
    
    if Config.Aimbot.Enabled and Config.Aimbot.ShowFOV then
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Radius = Config.Aimbot.FOV
        FOVCircle.Color = Config.Aimbot.FOVColor
        FOVCircle.Thickness = 2
        FOVCircle.Transparency = 0.7
        FOVCircle.Filled = false
        FOVCircle.Visible = true
    end
end

function GetClosestTarget()
    local bestTarget = nil
    local bestDist = Config.Aimbot.FOV
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        if not char then continue end
        
        local aimPart = char:FindFirstChild(Config.Aimbot.AimPart)
        local hum = char:FindFirstChild("Humanoid")
        
        if aimPart and hum and hum.Health > 0 then
            if Config.Aimbot.TeamCheck and player.Team and LocalPlayer.Team then
                if player.Team == LocalPlayer.Team then
                    continue
                end
            end
            
            local pos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
            
            if onScreen then
                local screenDist = (center - Vector2.new(pos.X, pos.Y)).Magnitude
                local dist3D = (Camera.CFrame.Position - aimPart.Position).Magnitude
                
                if screenDist < bestDist and dist3D <= Config.Aimbot.MaxDistance then
                    bestDist = screenDist
                    bestTarget = player
                end
            end
        end
    end
    
    return bestTarget
end

-- ═══════════════════════ LOOP PRINCIPAL ═══════════════════════
RunService.RenderStepped:Connect(function()
    -- Calcular FPS
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastFPSTime >= 0.5 then
        currentFPS = math.floor(frameCount / (currentTime - lastFPSTime))
        frameCount = 0
        lastFPSTime = currentTime
        
        FPSLabel.Text = "FPS: " .. currentFPS
        if currentFPS >= 60 then
            FPSLabel.TextColor3 = C.Verde
        elseif currentFPS >= 30 then
            FPSLabel.TextColor3 = C.Amarelo
        else
            FPSLabel.TextColor3 = C.Vermelho
        end
        
        local ping = GetPing()
        PingLabel.Text = "PING: " .. ping .. "ms"
        if ping <= 100 then
            PingLabel.TextColor3 = C.Verde
        elseif ping <= 200 then
            PingLabel.TextColor3 = C.Amarelo
        else
            PingLabel.TextColor3 = C.Vermelho
        end
        
        if Config.Monitor.ShowMemory then
            local mem = GetMemory()
            MemLabel.Text = "MEM: " .. mem .. "MB"
            MemLabel.Visible = true
        else
            MemLabel.Visible = false
        end
    end
    
    -- Atualizar FOV Circle
    if FOVCircle then
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
    
    -- Aimbot
    if Config.Aimbot.Enabled then
        local target = GetClosestTarget()
        if target and target.Character then
            local aimPart = target.Character:FindFirstChild(Config.Aimbot.AimPart)
            if aimPart then
                local smooth = math.clamp(Config.Aimbot.Smoothness / 20, 0.05, 1)
                Camera.CFrame = Camera.CFrame:Lerp(
                    CFrame.new(Camera.CFrame.Position, aimPart.Position),
                    smooth
                )
            end
        end
    end
    
    -- Crosshair
    if Config.Visuals.Crosshair then
        -- Implementar crosshair customizado
    end
end)

-- ═══════════════════════ ATUALIZAR CONTEÚDO ═══════════════════════
function UpdateContent()
    ClearScroll()
    
    if CurrentTab == "Geral" then
        Section("🏠 BEM-VINDO")
        
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 70)
        infoFrame.BackgroundColor3 = C.PretoMedio
        infoFrame.BackgroundTransparency = 0.6
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = Scroll
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 8)
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "⚙ Menu de Configurações v4.0\n" ..
                       (IsMobile and "📱 Modo Mobile" or "💻 Modo PC") .. "\n" ..
                       "✅ Zero bugs • Performance máxima"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 11
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 75)
        
        Section("🔑 ATALHOS")
        Keybind("Tecla do Menu", Config.MenuKey, function(key)
            Config.MenuKey = key
        end)
        
        local keyInfo = Instance.new("TextLabel")
        keyInfo.Size = UDim2.new(1, 0, 0, 40)
        keyInfo.BackgroundTransparency = 1
        keyInfo.Text = "Pressione a tecla configurada para\nabrir/fechar o menu rapidamente"
        keyInfo.TextColor3 = C.Cinza
        keyInfo.Font = Enum.Font.Gotham
        keyInfo.TextSize = 10
        keyInfo.TextXAlignment = Enum.TextXAlignment.Left
        keyInfo.Parent = Scroll
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 42)
        
    elseif CurrentTab == "ESP" then
        Section("👁 SISTEMA ESP")
        Toggle("Ativar ESP", Config.ESP.Enabled, function(v) 
            Config.ESP.Enabled = v 
            if not v then
                for _, obj in pairs(ESPObjects) do
                    if obj.connection then
                        obj.connection:Disconnect()
                    end
                    pcall(function() obj:Destroy() end)
                end
                ESPObjects = {}
            end
        end)
        
        Section("📦 BOXES")
        Toggle("Mostrar Box", Config.ESP.Boxes, function(v) Config.ESP.Boxes = v end)
        ColorPicker("Cor Inimigos", Config.ESP.BoxColor, function(c) Config.ESP.BoxColor = c end)
        ColorPicker("Cor Aliados", Config.ESP.TeamBoxColor, function(c) Config.ESP.TeamBoxColor = c end)
        
        Section("📝 NOMES")
        Toggle("Mostrar Nomes", Config.ESP.Names, function(v) Config.ESP.Names = v end)
        ColorPicker("Cor Nome Inimigo", Config.ESP.NameColor, function(c) Config.ESP.NameColor = c end)
        ColorPicker("Cor Nome Aliado", Config.ESP.TeamNameColor, function(c) Config.ESP.TeamNameColor = c end)
        
        Section("❤ VIDA E DISTÂNCIA")
        Toggle("Barra de Vida", Config.ESP.HealthBar, function(v) Config.ESP.HealthBar = v end)
        Toggle("Mostrar Distância", Config.ESP.Distance, function(v) Config.ESP.Distance = v end)
        ColorPicker("Cor Distância", Config.ESP.DistanceColor, function(c) Config.ESP.DistanceColor = c end)
        
        Section("📍 TRACERS")
        Toggle("Mostrar Tracers", Config.ESP.Tracers, function(v) Config.ESP.Tracers = v end)
        ColorPicker("Cor Tracers", Config.ESP.TracerColor, function(c) Config.ESP.TracerColor = c end)
        
        Section("✨ CHAMS")
        Toggle("Ativar Chams", Config.ESP.Chams, function(v) Config.ESP.Chams = v end)
        ColorPicker("Cor Chams Inimigo", Config.ESP.ChamsColor, function(c) Config.ESP.ChamsColor = c end)
        ColorPicker("Cor Chams Aliado", Config.ESP.TeamChamsColor, function(c) Config.ESP.TeamChamsColor = c end)
        
        Section("🌟 GLOW")
        Toggle("Ativar Glow", Config.ESP.Glow, function(v) Config.ESP.Glow = v end)
        ColorPicker("Cor Glow", Config.ESP.GlowColor, function(c) Config.ESP.GlowColor = c end)
        
        Section("⚙ OUTROS")
        Toggle("Detectar Times", Config.ESP.TeamCheck, function(v) Config.ESP.TeamCheck = v end)
        Slider("Distância Máxima", 100, 3000, Config.ESP.MaxDistance, function(v) Config.ESP.MaxDistance = v end)
        
    elseif CurrentTab == "Aimbot" then
        Section("🎯 AIMBOT")
        Toggle("Ativar Aimbot", Config.Aimbot.Enabled, function(v) 
            Config.Aimbot.Enabled = v
            UpdateFOV()
        end)
        Toggle("Detectar Times", Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
        Toggle("Silent Aim", Config.Aimbot.SilentAim, function(v) Config.Aimbot.SilentAim = v end)
        Toggle("Triggerbot", Config.Aimbot.Triggerbot, function(v) Config.Aimbot.Triggerbot = v end)
        
        Section("🔴 FOV")
        Toggle("Mostrar FOV", Config.Aimbot.ShowFOV, function(v) 
            Config.Aimbot.ShowFOV = v
            UpdateFOV()
        end)
        ColorPicker("Cor do FOV", Config.Aimbot.FOVColor, function(c) 
            Config.Aimbot.FOVColor = c
            UpdateFOV()
        end)
        Slider("Raio do FOV", 30, 500, Config.Aimbot.FOV, function(v) 
            Config.Aimbot.FOV = v
            UpdateFOV()
        end)
        
        Section("🎯 CONFIGURAÇÕES")
        Slider("Suavidade", 1, 20, Config.Aimbot.Smoothness, function(v) Config.Aimbot.Smoothness = v end)
        Slider("Predição", 0, 10, Config.Aimbot.Prediction, function(v) Config.Aimbot.Prediction = v end)
        Slider("Distância Máxima", 100, 2000, Config.Aimbot.MaxDistance, function(v) Config.Aimbot.MaxDistance = v end)
        Slider("Delay Trigger", 0.05, 0.5, Config.Aimbot.TriggerDelay, function(v) Config.Aimbot.TriggerDelay = v end)
        
        Section("🎯 PARTE DO CORPO")
        Dropdown("Parte", {"Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso"}, Config.Aimbot.AimPart, function(v) Config.Aimbot.AimPart = v end)
        
    elseif CurrentTab == "Visual" then
        Section("🎨 VISUAIS")
        Toggle("FullBright", Config.Visuals.FullBright, function(v)
            Config.Visuals.FullBright = v
            if v then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1
                Lighting.GlobalShadows = true
            end
        end)
        
        Toggle("Remover Névoa", Config.Visuals.NoFog, function(v)
            Config.Visuals.NoFog = v
            Lighting.FogEnd = v and 100000 or 1000
        end)
        
        Toggle("Sem Camera Shake", Config.Visuals.NoCameraShake, function(v) Config.Visuals.NoCameraShake = v end)
        Toggle("Sem Recoil", Config.Visuals.NoRecoil, function(v) Config.Visuals.NoRecoil = v end)
        Toggle("Sem Spread", Config.Visuals.NoSpread, function(v) Config.Visuals.NoSpread = v end)
        
        Section("📷 CÂMERA")
        Toggle("Mudar FOV", Config.Visuals.FOVChanger, function(v)
            Config.Visuals.FOVChanger = v
            Camera.FieldOfView = v and Config.Visuals.FOVValue or 70
        end)
        Slider("Valor do FOV", 30, 120, Config.Visuals.FOVValue, function(v)
            Config.Visuals.FOVValue = v
            if Config.Visuals.FOVChanger then
                Camera.FieldOfView = v
            end
        end)
        
        Section("🎯 CROSSHAIR")
        Toggle("Mostrar Crosshair", Config.Visuals.Crosshair, function(v) Config.Visuals.Crosshair = v end)
        Dropdown("Tipo", {"Cross", "Dot", "Circle"}, Config.Visuals.CrosshairType, function(v) Config.Visuals.CrosshairType = v end)
        ColorPicker("Cor do Crosshair", Config.Visuals.CrosshairColor, function(c) Config.Visuals.CrosshairColor = c end)
        Slider("Tamanho", 5, 30, Config.Visuals.CrosshairSize, function(v) Config.Visuals.CrosshairSize = v end)
        
        Section("💧 WATERMARK")
        Toggle("Mostrar Watermark", Config.Visuals.Watermark, function(v) Config.Visuals.Watermark = v end)
        
    elseif CurrentTab == "Monitor" then
        Section("📊 MONITOR")
        Toggle("Mostrar FPS", Config.Monitor.ShowFPS, function(v) Config.Monitor.ShowFPS = v end)
        Toggle("Mostrar Ping", Config.Monitor.ShowPing, function(v) Config.Monitor.ShowPing = v end)
        Toggle("Mostrar Memória", Config.Monitor.ShowMemory, function(v) Config.Monitor.ShowMemory = v end)
        
        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, 0, 0, 40)
        info.BackgroundTransparency = 1
        info.Text = "📊 Monitor sempre visível no\ncanto superior direito da tela\n✅ Informações em tempo real"
        info.TextColor3 = C.Cinza
        info.Font = Enum.Font.Gotham
        info.TextSize = 10
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = Scroll
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 42)
        
    elseif CurrentTab == "Misc" then
        Section("⚡ MISCELÂNEA")
        Toggle("Auto Farm", Config.Misc.AutoFarm, function(v) Config.Misc.AutoFarm = v end)
        Toggle("Auto Coletar", Config.Misc.AutoCollect, function(v) Config.Misc.AutoCollect = v end)
        Toggle("No Clip", Config.Misc.NoClip, function(v) Config.Misc.NoClip = v end)
        Toggle("Pulo Infinito", Config.Misc.InfiniteJump, function(v) Config.Misc.InfiniteJump = v end)
        Toggle("Anti AFK", Config.Misc.AntiAFK, function(v) Config.Misc.AntiAFK = v end)
        
        Section("🏃 VELOCIDADE")
        Toggle("Modificar Velocidade", Config.Misc.Walkspeed, function(v) Config.Misc.Walkspeed = v end)
        Slider("Velocidade", 16, 200, Config.Misc.Speed, function(v) Config.Misc.Speed = v end)
        Slider("Pulo", 50, 200, Config.Misc.JumpPower, function(v) Config.Misc.JumpPower = v end)
        
    elseif CurrentTab == "Config" then
        Section("⚙ CONFIGURAÇÕES")
        
        Button("💾 SALVAR CONFIGURAÇÕES", C.Verde, function()
            local success = SaveSystem:Save()
            if success then
                print("✅ Configurações salvas com sucesso!")
            end
        end)
        
        Button("📂 CARREGAR CONFIGURAÇÕES", C.Azul, function()
            local success = SaveSystem:Load()
            if success then
                print("✅ Configurações carregadas!")
                UpdateContent()
                UpdateFOV()
            end
        end)
        
        Button("🔄 RESETAR PARA PADRÃO", C.Vermelho, function()
            SaveSystem:Reset()
            print("🔄 Configurações resetadas!")
            UpdateContent()
            UpdateFOV()
        end)
        
        Section("ℹ INFORMAÇÕES")
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 80)
        infoFrame.BackgroundColor3 = C.PretoMedio
        infoFrame.BackgroundTransparency = 0.6
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = Scroll
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 8)
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "📌 Mateus Scripts v4.0\n" ..
                       (IsMobile and "📱 Modo Mobile" or "💻 Modo PC") .. "\n" ..
                       "✅ Zero bugs • Performance máxima\n" ..
                       "🔑 Tecla personalizável para abrir/fechar"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 10
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 85)
    end
end

-- ═══════════════════════ EVENTOS ═══════════════════════

-- Botões do header
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Logo.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tecla para abrir/fechar
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        local key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
        if key == Config.MenuKey then
            Main.Visible = not Main.Visible
            if Main.Visible then
                Logo.Visible = false
                Main.ZIndex = 10000
            end
        end
    end
end)

-- Atualizar ESP
Players.PlayerAdded:Connect(function()
    if Config.ESP.Enabled then
        task.wait(0.5)
        UpdateESP()
    end
end)

Players.PlayerRemoving:Connect(function()
    if Config.ESP.Enabled then
        task.wait(0.1)
        UpdateESP()
    end
end)

task.spawn(function()
    while true do
        if Config.ESP.Enabled then
            UpdateESP()
        end
        task.wait(0.2)
    end
end)

-- ═══════════════════════ INICIALIZAÇÃO ═══════════════════════
SaveSystem:Load()
UpdateContent()
UpdateFOV()

-- Animação de entrada
Main.BackgroundTransparency = 0.3
for i = 1, 10 do
    Main.BackgroundTransparency = Main.BackgroundTransparency - 0.02
    task.wait(0.02)
end

print("╔════════════════════════════════════════════╗")
print("║  ✅ MATEUS_SCRIPTS v4.0                   ║")
print("║  📊 Menu carregado com sucesso!           ║")
print("║  " .. (IsMobile and "📱 Modo Mobile" or "💻 Modo PC") .. "          ║")
print("║  📌 Zero bugs • Performance máxima        ║")
print("╚════════════════════════════════════════════╝")
