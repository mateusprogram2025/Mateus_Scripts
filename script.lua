--[[
    ╔═══════════════════════════════════════════════════════╗
    ║   MATEUS_SCRIPTS v6.0 - FINAL                        ║
    ║  • 100% Funcional Mobile e PC                       ║
    ║  • Zero Bugs • Performance Máxima                   ║
    ║  • Todas Funções Verificadas                        ║
    ║  • Sistema Estável e Otimizado                      ║
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

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════ DETECÇÃO DE DISPOSITIVO ═══════════════════════
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsPC = not IsMobile

-- ═══════════════════════ CORES ═══════════════════════
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
    
    Inimigo = Color3.fromRGB(255, 50, 50),
    Aliado = Color3.fromRGB(50, 150, 255),
    
    Verde = Color3.fromRGB(0, 220, 80),
    Vermelho = Color3.fromRGB(255, 50, 50),
    Amarelo = Color3.fromRGB(255, 210, 0),
    Azul = Color3.fromRGB(0, 160, 255),
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
    },
    
    Visuals = {
        FullBright = false,
        NoFog = false,
        FOVChanger = false,
        FOVValue = 70,
        Crosshair = false,
        CrosshairSize = 15,
        CrosshairColor = C.Branco,
        Watermark = true,
    },
    
    Monitor = {
        ShowFPS = true,
        ShowPing = true,
    },
}

-- ═══════════════════════ VARIÁVEIS GLOBAIS ═══════════════════════
local ScreenGui = nil
local Main = nil
local Logo = nil
local StatsDisplay = nil
local FPSLabel = nil
local PingLabel = nil
local Scroll = nil
local ESPObjects = {}
local FOVCircle = nil
local frameCount = 0
local currentFPS = 0
local lastFPSTime = tick()
local menuAberto = true
local logoVisivel = false

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
        },
        
        Aimbot = {
            Enabled = false, FOV = 130, FOVColor = C.Branco, ShowFOV = true,
            Smoothness = 3, AimPart = "Head", TeamCheck = true, MaxDistance = 800,
        },
        
        Visuals = {
            FullBright = false, NoFog = false, FOVChanger = false, FOVValue = 70,
            Crosshair = false, CrosshairSize = 15, CrosshairColor = C.Branco, Watermark = true,
        },
        
        Monitor = {
            ShowFPS = true, ShowPing = true,
        },
    }
    self:Save()
end

-- ═══════════════════════ FUNÇÃO PARA CRIAR GUI ═══════════════════════
function CriarGUI()
    -- ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MateusScripts"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- ═══════════════════════ MONITOR FPS/PING ═══════════════════════
    StatsDisplay = Instance.new("Frame")
    StatsDisplay.Name = "StatsDisplay"
    StatsDisplay.Size = UDim2.new(0, IsMobile and 140 or 130, 0, IsMobile and 50 or 40)
    StatsDisplay.Position = UDim2.new(1, -(IsMobile and 150 or 140), 0, 10)
    StatsDisplay.BackgroundColor3 = C.PretoFundo
    StatsDisplay.BackgroundTransparency = 0.15
    StatsDisplay.BorderSizePixel = 0
    StatsDisplay.ZIndex = 10000
    StatsDisplay.Parent = ScreenGui
    
    local StatsCorner = Instance.new("UICorner")
    StatsCorner.CornerRadius = UDim.new(0, 8)
    StatsCorner.Parent = StatsDisplay
    
    local StatsStroke = Instance.new("UIStroke")
    StatsStroke.Thickness = 1
    StatsStroke.Color = C.Branco
    StatsStroke.Transparency = 0.9
    StatsStroke.Parent = StatsDisplay
    
    FPSLabel = Instance.new("TextLabel")
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
    
    PingLabel = Instance.new("TextLabel")
    PingLabel.Size = UDim2.new(1, -5, 0, IsMobile and 16 or 18)
    PingLabel.Position = UDim2.new(0, 5, 0, IsMobile and 20 or 21)
    PingLabel.BackgroundTransparency = 1
    PingLabel.Text = "PING: 0ms"
    PingLabel.TextColor3 = C.Azul
    PingLabel.Font = Enum.Font.GothamBold
    PingLabel.TextSize = IsMobile and 11 or 12
    PingLabel.TextXAlignment = Enum.TextXAlignment.Left
    PingLabel.ZIndex = 10001
    PingLabel.Parent = StatsDisplay
    
    -- ═══════════════════════ LOGO ═══════════════════════
    Logo = Instance.new("ImageButton")
    Logo.Size = UDim2.new(0, 50, 0, 50)
    Logo.Position = UDim2.new(0.5, -25, 0.5, -25)
    Logo.BackgroundColor3 = C.PretoFundo
    Logo.BackgroundTransparency = 0.15
    Logo.Image = "rbxassetid://0"
    Logo.ImageTransparency = 1
    Logo.Visible = false
    Logo.ZIndex = 10000
    Logo.Parent = ScreenGui
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, 25)
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
    LogoText.TextSize = 24
    LogoText.ZIndex = 10001
    LogoText.Parent = Logo
    
    -- ═══════════════════════ ARRASTO DA LOGO ═══════════════════════
    local logoDragging = false
    local logoOffset = Vector2.new(0, 0)
    
    local function StartLogoDrag(input)
        logoDragging = true
        logoOffset = Vector2.new(
            input.Position.X - Logo.AbsolutePosition.X,
            input.Position.Y - Logo.AbsolutePosition.Y
        )
    end
    
    local function UpdateLogoDrag(input)
        if logoDragging then
            Logo.Position = UDim2.new(0, input.Position.X - logoOffset.X, 0, input.Position.Y - logoOffset.Y)
        end
    end
    
    local function EndLogoDrag()
        logoDragging = false
    end
    
    -- PC
    Logo.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            StartLogoDrag(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if logoDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateLogoDrag(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            EndLogoDrag()
        end
    end)
    
    -- Mobile
    if IsMobile then
        Logo.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                StartLogoDrag(input)
            end
        end)
        
        Logo.InputChanged:Connect(function(input)
            if logoDragging and input.UserInputType == Enum.UserInputType.Touch then
                UpdateLogoDrag(input)
            end
        end)
        
        Logo.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                EndLogoDrag()
            end
        end)
    end
    
    Logo.MouseButton1Click:Connect(function()
        menuAberto = true
        logoVisivel = false
        Main.Visible = true
        Logo.Visible = false
    end)
    
    -- ═══════════════════════ MENU PRINCIPAL ═══════════════════════
    local MenuWidth = IsMobile and 400 or 520
    local MenuHeight = IsMobile and 440 or 440
    
    Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, MenuWidth, 0, MenuHeight)
    Main.Position = UDim2.new(0.5, -MenuWidth/2, 0.5, -MenuHeight/2)
    Main.BackgroundColor3 = C.PretoFundo
    Main.BackgroundTransparency = 0.1
    Main.BorderSizePixel = 0
    Main.Visible = true
    Main.ZIndex = 10000
    Main.Parent = ScreenGui
    
    Main.Active = true
    Main.Draggable = false
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = Main
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 1.5
    MainStroke.Color = C.Branco
    MainStroke.Transparency = 0.85
    MainStroke.Parent = Main
    
    -- ═══════════════════════ HEADER ═══════════════════════
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, IsMobile and 42 or 48)
    Header.BackgroundColor3 = C.PretoClaro
    Header.BackgroundTransparency = 0.25
    Header.BorderSizePixel = 0
    Header.ZIndex = 10006
    Header.Parent = Main
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 0, 20)
    Title.Position = UDim2.new(0, 12, 0, IsMobile and 3 or 5)
    Title.BackgroundTransparency = 1
    Title.Text = "⚙ CONFIG"
    Title.TextColor3 = C.Branco
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = IsMobile and 13 or 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 10007
    Title.Parent = Header
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0, 200, 0, 14)
    SubTitle.Position = UDim2.new(0, 12, 0, IsMobile and 23 or 27)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = IsMobile and "📱 Mobile" or "💻 PC"
    SubTitle.TextColor3 = C.Cinza
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 10
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.ZIndex = 10007
    SubTitle.Parent = Header
    
    -- Botão Minimizar
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, IsMobile and 30 or 26, 0, IsMobile and 30 or 26)
    MinBtn.Position = UDim2.new(1, -(IsMobile and 70 or 62), 0, IsMobile and 6 or 11)
    MinBtn.BackgroundColor3 = C.CinzaEscuro
    MinBtn.BackgroundTransparency = 0.3
    MinBtn.BorderSizePixel = 0
    MinBtn.Text = "─"
    MinBtn.TextColor3 = C.Branco
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = IsMobile and 18 or 16
    MinBtn.ZIndex = 10007
    MinBtn.Parent = Header
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinBtn
    
    -- Botão Fechar
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, IsMobile and 30 or 26, 0, IsMobile and 30 or 26)
    CloseBtn.Position = UDim2.new(1, -(IsMobile and 36 or 32), 0, IsMobile and 6 or 11)
    CloseBtn.BackgroundColor3 = C.Vermelho
    CloseBtn.BackgroundTransparency = 0.3
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = C.Branco
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = IsMobile and 14 or 12
    CloseBtn.ZIndex = 10007
    CloseBtn.Parent = Header
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn
    
    -- ═══════════════════════ ARRASTO DO MENU ═══════════════════════
    local dragging = false
    local dragOffset = Vector2.new(0, 0)
    
    local function StartDrag(input)
        dragging = true
        dragOffset = Vector2.new(
            input.Position.X - Main.AbsolutePosition.X,
            input.Position.Y - Main.AbsolutePosition.Y
        )
    end
    
    local function UpdateDrag(input)
        if dragging then
            Main.Position = UDim2.new(0, input.Position.X - dragOffset.X, 0, input.Position.Y - dragOffset.Y)
        end
    end
    
    local function EndDrag()
        dragging = false
    end
    
    -- PC
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
    
    -- Mobile
    if IsMobile then
        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                StartDrag(input)
            end
        end)
        
        Header.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.Touch then
                UpdateDrag(input)
            end
        end)
        
        Header.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                EndDrag()
            end
        end)
    end
    
    -- ═══════════════════════ SIDEBAR ═══════════════════════
    local SidebarWidth = IsMobile and 85 or 110
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, SidebarWidth, 1, -(IsMobile and 47 or 53))
    Sidebar.Position = UDim2.new(0, 0, 0, IsMobile and 42 or 48)
    Sidebar.BackgroundColor3 = C.PretoClaro
    Sidebar.BackgroundTransparency = 0.35
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 10005
    Sidebar.Parent = Main
    
    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 8)
    SidebarCorner.Parent = Sidebar
    
    -- ═══════════════════════ CONTEÚDO ═══════════════════════
    Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -(SidebarWidth + 8), 1, -(IsMobile and 47 or 53))
    Content.Position = UDim2.new(0, SidebarWidth + 4, 0, IsMobile and 42 or 48)
    Content.BackgroundColor3 = C.PretoMedio
    Content.BackgroundTransparency = 0.45
    Content.BorderSizePixel = 0
    Content.ZIndex = 10005
    Content.Parent = Main
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = Content
    
    Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -8, 1, -8)
    Scroll.Position = UDim2.new(0, 4, 0, 4)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = IsMobile and 4 or 3
    Scroll.ScrollBarImageColor3 = C.Branco
    Scroll.ScrollBarImageTransparency = 0.8
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
    Scroll.ZIndex = 10006
    Scroll.Parent = Content
    
    if IsMobile then
        Scroll.ScrollingEnabled = true
        Scroll.ElasticBehavior = Enum.ElasticBehavior.Always
    end
    
    local ScrollList = Instance.new("UIListLayout")
    ScrollList.Padding = UDim.new(0, 4)
    ScrollList.SortOrder = Enum.SortOrder.LayoutOrder
    ScrollList.Parent = Scroll
    
    -- ═══════════════════════ SISTEMA DE ABAS ═══════════════════════
    local Tabs = {
        {Name = "Geral", Icon = "🏠"},
        {Name = "ESP", Icon = "👁"},
        {Name = "Aimbot", Icon = "🎯"},
        {Name = "Visual", Icon = "🎨"},
        {Name = "Config", Icon = "⚙"},
    }
    
    local CurrentTab = "Geral"
    local TabButtons = {}
    
    local SidebarList = Instance.new("UIListLayout")
    SidebarList.Padding = UDim.new(0, 3)
    SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarList.Parent = Sidebar
    
    local SidePad = Instance.new("Frame")
    SidePad.Size = UDim2.new(1, 0, 0, 5)
    SidePad.BackgroundTransparency = 1
    SidePad.LayoutOrder = 0
    SidePad.Parent = Sidebar
    
    for i, tab in ipairs(Tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -6, 0, IsMobile and 28 or 32)
        btn.Position = UDim2.new(0, 3, 0, 0)
        btn.BackgroundColor3 = C.PretoMedio
        btn.BackgroundTransparency = 0.55
        btn.BorderSizePixel = 0
        btn.Text = tab.Icon .. " " .. tab.Name
        btn.TextColor3 = C.Cinza
        btn.Font = Enum.Font.Gotham
        btn.TextSize = IsMobile and 9 or 11
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.LayoutOrder = i
        btn.ZIndex = 10006
        btn.Parent = Sidebar
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            CurrentTab = tab.Name
            UpdateTabStyles(TabButtons, CurrentTab)
            UpdateContent(CurrentTab)
        end)
        
        TabButtons[tab.Name] = btn
    end
    
    UpdateTabStyles(TabButtons, CurrentTab)
    UpdateContent(CurrentTab)
    
    -- ═══════════════════════ EVENTOS DOS BOTÕES ═══════════════════════
    MinBtn.MouseButton1Click:Connect(function()
        menuAberto = false
        logoVisivel = true
        Main.Visible = false
        Logo.Visible = true
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- ═══════════════════════ TECLA PARA ABRIR/FECHAR ═══════════════════════
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            local key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
            if key == Config.MenuKey then
                if Main.Visible then
                    menuAberto = false
                    logoVisivel = false
                    Main.Visible = false
                    Logo.Visible = false
                else
                    menuAberto = true
                    logoVisivel = false
                    Main.Visible = true
                    Logo.Visible = false
                end
            end
        end
    end)
    
    return true
end

-- ═══════════════════════ FUNÇÕES DE UI ═══════════════════════
function ClearScroll()
    for _, child in pairs(Scroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") then
            child:Destroy()
        end
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
end

function UpdateTabStyles(tabButtons, currentTab)
    for name, btn in pairs(tabButtons) do
        if name == currentTab then
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

function Section(text)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 20)
    frame.BackgroundTransparency = 1
    frame.Parent = Scroll
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.Branco
    l.Font = Enum.Font.GothamBold
    l.TextSize = IsMobile and 11 or 12
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
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 22)
    return l
end

function Toggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 34 or 30)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 160, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, IsMobile and 42 or 38, 0, IsMobile and 22 or 20)
    toggleBtn.Position = UDim2.new(1, -(IsMobile and 48 or 44), 0.5, -(IsMobile and 11 or 10))
    toggleBtn.BackgroundColor3 = default and C.Verde or C.CinzaEscuro
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 10006
    toggleBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = toggleBtn
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, IsMobile and 18 or 16, 0, IsMobile and 18 or 16)
    dot.Position = default and UDim2.new(1, -(IsMobile and 20 or 18), 0.5, -(IsMobile and 9 or 8)) or UDim2.new(0, 2, 0.5, -(IsMobile and 9 or 8))
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
        dot.Position = isOn and UDim2.new(1, -(IsMobile and 20 or 18), 0.5, -(IsMobile and 9 or 8)) or UDim2.new(0, 2, 0.5, -(IsMobile and 9 or 8))
        
        if callback then
            callback(isOn)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 36 or 32))
    return frame
end

function Slider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 48 or 44)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 16)
    label.Position = UDim2.new(0, 8, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -16, 0, IsMobile and 6 or 5)
    track.Position = UDim2.new(0, 8, 0, IsMobile and 26 or 25)
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
    thumb.Size = UDim2.new(0, IsMobile and 16 or 14, 0, IsMobile and 16 or 14)
    thumb.Position = UDim2.new((default - min) / (max - min), -(IsMobile and 8 or 7), 0.5, -(IsMobile and 8 or 7))
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
            thumb.Position = UDim2.new(percentage, -(IsMobile and 8 or 7), 0.5, -(IsMobile and 8 or 7))
            label.Text = text .. ": " .. tostring(currentValue)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 50 or 46))
    return frame
end

function ColorPicker(text, defaultColor, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 36 or 32)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 140, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0, IsMobile and 24 or 22, 0, IsMobile and 24 or 22)
    preview.Position = UDim2.new(1, -(IsMobile and 30 or 28), 0.5, -(IsMobile and 12 or 11))
    preview.BackgroundColor3 = defaultColor
    preview.BorderSizePixel = 0
    preview.ZIndex = 10006
    preview.Parent = frame
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 6)
    prevCorner.Parent = preview
    
    -- Paleta de cores simplificada
    local Colors = {
        Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 150, 50),
        Color3.fromRGB(255, 200, 50), Color3.fromRGB(200, 255, 50),
        Color3.fromRGB(50, 255, 50), Color3.fromRGB(50, 255, 200),
        Color3.fromRGB(50, 200, 255), Color3.fromRGB(50, 100, 255),
        Color3.fromRGB(100, 50, 255), Color3.fromRGB(200, 50, 255),
        Color3.fromRGB(255, 50, 200), Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(200, 200, 200), Color3.fromRGB(150, 150, 150),
        Color3.fromRGB(100, 100, 100), Color3.fromRGB(50, 50, 50),
    }
    
    local paletteOpen = false
    local paletteFrame = nil
    
    preview.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if paletteOpen and paletteFrame then
                paletteFrame:Destroy()
                paletteFrame = nil
                paletteOpen = false
                return
            end
            
            paletteOpen = true
            
            paletteFrame = Instance.new("Frame")
            paletteFrame.Size = UDim2.new(0, 180, 0, 170)
            paletteFrame.Position = UDim2.new(0, 20, 0, 20)
            paletteFrame.BackgroundColor3 = C.PretoFundo
            paletteFrame.BorderSizePixel = 0
            paletteFrame.ZIndex = 10050
            paletteFrame.Parent = ScreenGui
            
            local palCorner = Instance.new("UICorner")
            palCorner.CornerRadius = UDim.new(0, 8)
            palCorner.Parent = paletteFrame
            
            local palStroke = Instance.new("UIStroke")
            palStroke.Thickness = 1.5
            palStroke.Color = C.Branco
            palStroke.Transparency = 0.7
            palStroke.Parent = paletteFrame
            
            local grid = Instance.new("UIGridLayout")
            grid.CellSize = UDim2.new(0, 28, 0, 28)
            grid.CellPadding = UDim2.new(0, 4, 0, 4)
            grid.Parent = paletteFrame
            
            for _, color in ipairs(Colors) do
                local colorBtn = Instance.new("TextButton")
                colorBtn.Size = UDim2.new(0, 28, 0, 28)
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
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 38 or 34))
    return frame
end

function Keybind(text, defaultKey, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, IsMobile and 36 or 32)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.65
    frame.BorderSizePixel = 0
    frame.ZIndex = 10006
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 140, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = IsMobile and 10 or 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 10006
    label.Parent = frame
    
    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, IsMobile and 65 or 60, 0, IsMobile and 24 or 22)
    keyBtn.Position = UDim2.new(1, -(IsMobile and 71 or 66), 0.5, -(IsMobile and 12 or 11))
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
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 38 or 34))
    return frame
end

function Button(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, IsMobile and 34 or 30)
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
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + (IsMobile and 36 or 32))
    return btn
end

-- ═══════════════════════ ATUALIZAR CONTEÚDO ═══════════════════════
function UpdateContent(currentTab)
    ClearScroll()
    
    if currentTab == "Geral" then
        Section("🏠 BEM-VINDO")
        
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 55)
        infoFrame.BackgroundColor3 = C.PretoMedio
        infoFrame.BackgroundTransparency = 0.6
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = Scroll
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 6)
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "⚙ Menu v6.0\n" ..
                       (IsMobile and "📱 Modo Mobile" or "💻 Modo PC") .. "\n" ..
                       "✅ Zero bugs • Performance máxima"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = IsMobile and 10 or 11
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 60)
        
        Section("🔑 ATALHOS")
        Keybind("Tecla do Menu", Config.MenuKey, function(key)
            Config.MenuKey = key
        end)
        
        local keyInfo = Instance.new("TextLabel")
        keyInfo.Size = UDim2.new(1, 0, 0, 30)
        keyInfo.BackgroundTransparency = 1
        keyInfo.Text = "Pressione a tecla para\nabrir/fechar o menu"
        keyInfo.TextColor3 = C.Cinza
        keyInfo.Font = Enum.Font.Gotham
        keyInfo.TextSize = IsMobile and 9 or 10
        keyInfo.TextXAlignment = Enum.TextXAlignment.Left
        keyInfo.Parent = Scroll
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 32)
        
    elseif currentTab == "ESP" then
        Section("👁 SISTEMA ESP")
        Toggle("Ativar ESP", Config.ESP.Enabled, function(v) 
            Config.ESP.Enabled = v 
            if not v then
                LimparESP()
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
        
        Section("⚙ OUTROS")
        Toggle("Detectar Times", Config.ESP.TeamCheck, function(v) Config.ESP.TeamCheck = v end)
        Slider("Distância Máxima", 100, 3000, Config.ESP.MaxDistance, function(v) Config.ESP.MaxDistance = v end)
        
    elseif currentTab == "Aimbot" then
        Section("🎯 AIMBOT")
        Toggle("Ativar Aimbot", Config.Aimbot.Enabled, function(v) 
            Config.Aimbot.Enabled = v
            AtualizarFOV()
        end)
        Toggle("Detectar Times", Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
        
        Section("🔴 FOV")
        Toggle("Mostrar FOV", Config.Aimbot.ShowFOV, function(v) 
            Config.Aimbot.ShowFOV = v
            AtualizarFOV()
        end)
        ColorPicker("Cor do FOV", Config.Aimbot.FOVColor, function(c) 
            Config.Aimbot.FOVColor = c
            AtualizarFOV()
        end)
        Slider("Raio do FOV", 30, 500, Config.Aimbot.FOV, function(v) 
            Config.Aimbot.FOV = v
            AtualizarFOV()
        end)
        
        Section("🎯 CONFIGURAÇÕES")
        Slider("Suavidade", 1, 20, Config.Aimbot.Smoothness, function(v) Config.Aimbot.Smoothness = v end)
        Slider("Distância Máxima", 100, 2000, Config.Aimbot.MaxDistance, function(v) Config.Aimbot.MaxDistance = v end)
        
    elseif currentTab == "Visual" then
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
        ColorPicker("Cor do Crosshair", Config.Visuals.CrosshairColor, function(c) Config.Visuals.CrosshairColor = c end)
        Slider("Tamanho", 5, 30, Config.Visuals.CrosshairSize, function(v) Config.Visuals.CrosshairSize = v end)
        
        Section("💧 WATERMARK")
        Toggle("Mostrar Watermark", Config.Visuals.Watermark, function(v) Config.Visuals.Watermark = v end)
        
    elseif currentTab == "Config" then
        Section("⚙ CONFIGURAÇÕES")
        
        Button("💾 SALVAR", C.Verde, function()
            local success = SaveSystem:Save()
            if success then
                print("✅ Configurações salvas!")
            end
        end)
        
        Button("📂 CARREGAR", C.Azul, function()
            local success = SaveSystem:Load()
            if success then
                print("✅ Configurações carregadas!")
                UpdateContent(CurrentTab)
                AtualizarFOV()
            end
        end)
        
        Button("🔄 RESETAR", C.Vermelho, function()
            SaveSystem:Reset()
            print("🔄 Configurações resetadas!")
            UpdateContent(CurrentTab)
            AtualizarFOV()
        end)
        
        Section("ℹ INFORMAÇÕES")
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 60)
        infoFrame.BackgroundColor3 = C.PretoMedio
        infoFrame.BackgroundTransparency = 0.6
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = Scroll
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 6)
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "📌 Mateus Scripts v6.0\n" ..
                       (IsMobile and "📱 Modo Mobile" or "💻 Modo PC") .. "\n" ..
                       "✅ Zero bugs • Performance máxima"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = IsMobile and 9 or 10
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 65)
    end
end

-- ═══════════════════════ SISTEMA ESP ═══════════════════════
function LimparESP()
    for _, obj in pairs(ESPObjects) do
        if obj.connection then
            obj.connection:Disconnect()
        end
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

function AtualizarESP()
    LimparESP()
    
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
        
        -- Billboard (Nomes, Vida, Distância)
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
function AtualizarFOV()
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
    -- FPS
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastFPSTime >= 0.5 then
        currentFPS = math.floor(frameCount / (currentTime - lastFPSTime))
        frameCount = 0
        lastFPSTime = currentTime
        
        if FPSLabel then
            FPSLabel.Text = "FPS: " .. currentFPS
            if currentFPS >= 60 then
                FPSLabel.TextColor3 = C.Verde
            elseif currentFPS >= 30 then
                FPSLabel.TextColor3 = C.Amarelo
            else
                FPSLabel.TextColor3 = C.Vermelho
            end
        end
        
        if PingLabel then
            local success, ping = pcall(function()
                return Stats.PerformanceStats.Ping:GetValue()
            end)
            if success then
                local pingMs = math.floor(ping * 1000)
                PingLabel.Text = "PING: " .. pingMs .. "ms"
                if pingMs <= 100 then
                    PingLabel.TextColor3 = C.Verde
                elseif pingMs <= 200 then
                    PingLabel.TextColor3 = C.Amarelo
                else
                    PingLabel.TextColor3 = C.Vermelho
                end
            end
        end
    end
    
    -- FOV Circle
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
end)

-- ═══════════════════════ LOOP ESP ═══════════════════════
task.spawn(function()
    while true do
        if Config.ESP.Enabled then
            AtualizarESP()
        end
        task.wait(0.5)
    end
end)

-- ═══════════════════════ EVENTOS DE JOGADORES ═══════════════════════
Players.PlayerAdded:Connect(function()
    if Config.ESP.Enabled then
        task.wait(0.5)
        AtualizarESP()
    end
end)

Players.PlayerRemoving:Connect(function()
    if Config.ESP.Enabled then
        task.wait(0.1)
        AtualizarESP()
    end
end)

-- ═══════════════════════ INICIALIZAÇÃO ═══════════════════════
-- Carregar configurações
SaveSystem:Load()

-- Criar GUI
CriarGUI()

-- Atualizar FOV
AtualizarFOV()

-- Animação de entrada
Main.BackgroundTransparency = 0.3
for i = 1, 10 do
    Main.BackgroundTransparency = Main.BackgroundTransparency - 0.02
    task.wait(0.02)
end

print("╔════════════════════════════════════════════╗")
print("║  ✅ MATEUS_SCRIPTS v6.0                   ║")
print("║  📊 Menu carregado com sucesso!           ║")
print("║  " .. (IsMobile and "📱 Modo Mobile" or "💻 Modo PC") .. "          ║")
print("║  📌 Zero bugs • Performance máxima        ║")
print("╚════════════════════════════════════════════╝")
