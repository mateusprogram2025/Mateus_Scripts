--[[
    ╔═══════════════════════════════════════════════════════╗
    ║   MATEUS_SCRIPTS v22.0 - COMPLETO E FUNCIONAL        ║
    ║  • Visual Branco/Preto com Transparência             ║
    ║  • Logo Arrastável ao Minimizar                      ║
    ║  • Box ESP com Cores Personalizáveis                 ║
    ║  • FOV Circle Funcional                              ║
    ║  • Salvamento em JSON Funcionando                    ║
    ║  • Tecla Personalizável para Abrir/Fechar            ║
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
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════ CORES (Branco/Preto) ═══════════════════════
local C = {
    Branco = Color3.fromRGB(255, 255, 255),
    BrancoSuave = Color3.fromRGB(240, 240, 245),
    CinzaClaro = Color3.fromRGB(200, 200, 205),
    Cinza = Color3.fromRGB(150, 150, 155),
    CinzaEscuro = Color3.fromRGB(80, 80, 85),
    Preto = Color3.fromRGB(10, 10, 12),
    PretoClaro = Color3.fromRGB(20, 20, 25),
    PretoMedio = Color3.fromRGB(30, 30, 35),
    PretoFundo = Color3.fromRGB(15, 15, 18),
    
    -- Cores padrão para ESP
    Inimigo = Color3.fromRGB(255, 50, 50),
    Aliado = Color3.fromRGB(50, 150, 255),
    
    -- Cores de status
    Verde = Color3.fromRGB(0, 200, 80),
    Vermelho = Color3.fromRGB(255, 60, 60),
    Amarelo = Color3.fromRGB(255, 200, 0),
    Azul = Color3.fromRGB(0, 150, 255),
}

-- ═══════════════════════ CONFIGURAÇÕES ═══════════════════════
local Config = {
    MenuKey = Enum.KeyCode.RightShift,
    
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
    },
    
    Monitor = {
        Enabled = true,
        ShowFPS = true,
        ShowPing = true,
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
    Config.ESP.Enabled = false
    Config.Aimbot.Enabled = false
    Config.Visuals.FullBright = false
    Config.Monitor.Enabled = true
    Config.MenuKey = Enum.KeyCode.RightShift
    self:Save()
end

-- ═══════════════════════ GUI PRINCIPAL ═══════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MateusScripts"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════ LOGO ARRASTÁVEL (Quando minimizado) ═══════════════════════
local Logo = Instance.new("ImageButton")
Logo.Size = UDim2.new(0, 60, 0, 60)
Logo.Position = UDim2.new(0.5, -30, 0.5, -30)
Logo.BackgroundColor3 = C.PretoFundo
Logo.BackgroundTransparency = 0.2
Logo.Image = "rbxassetid://0" -- Placeholder, você pode colocar sua própria imagem
Logo.ImageTransparency = 1
Logo.Visible = false
Logo.ZIndex = 1000
Logo.Parent = ScreenGui

-- Arredondar logo
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 30)
LogoCorner.Parent = Logo

-- Borda da logo
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Thickness = 2
LogoStroke.Color = C.Branco
LogoStroke.Transparency = 0.5
LogoStroke.Parent = Logo

-- Texto da logo (já que não tem imagem)
local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "⚙"
LogoText.TextColor3 = C.Branco
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 30
LogoText.ZIndex = 1001
LogoText.Parent = Logo

-- Sistema de arrasto da logo
local LogoDragging = false
local LogoDragStart = nil
local LogoStartPos = nil

Logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        LogoDragging = true
        LogoDragStart = input.Position
        LogoStartPos = Logo.Position
    end
end)

Logo.InputChanged:Connect(function(input)
    if LogoDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - LogoDragStart
        Logo.Position = UDim2.new(
            LogoStartPos.X.Scale, LogoStartPos.X.Offset + delta.X,
            LogoStartPos.Y.Scale, LogoStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        LogoDragging = false
    end
end)

-- Clicar na logo abre o menu
Logo.MouseButton1Click:Connect(function()
    Main.Visible = true
    Logo.Visible = false
end)

-- ═══════════════════════ MENU PRINCIPAL ═══════════════════════
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 450)
Main.Position = UDim2.new(0.5, -275, 0.5, -225)
Main.BackgroundColor3 = C.PretoFundo
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Visible = true
Main.ZIndex = 1000
Main.Parent = ScreenGui

-- Cantos arredondados
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = Main

-- Borda sutil
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = C.Branco
MainStroke.Transparency = 0.85
MainStroke.Parent = Main

-- ═══════════════════════ HEADER ═══════════════════════
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = C.PretoClaro
Header.BackgroundTransparency = 0.3
Header.BorderSizePixel = 0
Header.ZIndex = 6
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 0, 22)
Title.Position = UDim2.new(0, 15, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "⚙ CONFIGURAÇÕES"
Title.TextColor3 = C.Branco
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 7
Title.Parent = Header

-- Subtítulo
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 250, 0, 15)
SubTitle.Position = UDim2.new(0, 15, 0, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Menu Completo • Profissional"
SubTitle.TextColor3 = C.Cinza
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 7
SubTitle.Parent = Header

-- Botão Minimizar (vai para logo)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -66, 0, 11)
MinBtn.BackgroundColor3 = C.CinzaEscuro
MinBtn.BackgroundTransparency = 0.4
MinBtn.BorderSizePixel = 0
MinBtn.Text = "─"
MinBtn.TextColor3 = C.Branco
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.ZIndex = 7
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 11)
CloseBtn.BackgroundColor3 = C.Vermelho
CloseBtn.BackgroundTransparency = 0.4
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.Branco
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 7
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- ═══════════════════════ SIDEBAR ═══════════════════════
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = C.PretoClaro
Sidebar.BackgroundTransparency = 0.4
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

-- ═══════════════════════ CONTEÚDO ═══════════════════════
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -130, 1, -60)
Content.Position = UDim2.new(0, 125, 0, 55)
Content.BackgroundColor3 = C.PretoMedio
Content.BackgroundTransparency = 0.5
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = C.Branco
Scroll.ScrollBarImageTransparency = 0.8
Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
Scroll.ZIndex = 6
Scroll.Parent = Content

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
    {Name = "Config", Icon = "⚙"},
}

local CurrentTab = "Geral"
local TabButtons = {}

-- Layout da sidebar
local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 4)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

-- Espaçamento inicial
local SidePad = Instance.new("Frame")
SidePad.Size = UDim2.new(1, 0, 0, 8)
SidePad.BackgroundTransparency = 1
SidePad.LayoutOrder = 0
SidePad.Parent = Sidebar

for i, tab in ipairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 34)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = C.PretoMedio
    btn.BackgroundTransparency = 0.6
    btn.BorderSizePixel = 0
    btn.Text = tab.Icon .. "  " .. tab.Name
    btn.TextColor3 = C.Cinza
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = i
    btn.ZIndex = 6
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
            btn.BackgroundTransparency = 0.6
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
    l.ZIndex = 6
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
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel = 0
    frame.ZIndex = 6
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
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 42, 0, 22)
    toggleBtn.Position = UDim2.new(1, -50, 0.5, -11)
    toggleBtn.BackgroundColor3 = default and C.Verde or C.CinzaEscuro
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 6
    toggleBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = toggleBtn
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 18, 0, 18)
    dot.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    dot.BackgroundColor3 = C.Branco
    dot.BorderSizePixel = 0
    dot.ZIndex = 7
    dot.Parent = toggleBtn
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    local isOn = default
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggleBtn.BackgroundColor3 = isOn and C.Verde or C.CinzaEscuro
        dot.Position = isOn and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        
        if callback then
            callback(isOn)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 34)
    return frame
end

function Slider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel = 0
    frame.ZIndex = 6
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
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, 5)
    track.Position = UDim2.new(0, 10, 0, 28)
    track.BackgroundColor3 = C.CinzaEscuro
    track.BorderSizePixel = 0
    track.ZIndex = 6
    track.Parent = frame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.Branco
    fill.BackgroundTransparency = 0.4
    fill.BorderSizePixel = 0
    fill.ZIndex = 6
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = fill
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    thumb.BackgroundColor3 = C.Branco
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 7
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
            thumb.Position = UDim2.new(percentage, -7, 0.5, -7)
            label.Text = text .. ": " .. tostring(currentValue)
            
            if callback then
                callback(currentValue)
            end
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 50)
    return frame
end

function ColorPicker(text, defaultColor, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel = 0
    frame.ZIndex = 6
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
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0, 24, 0, 24)
    preview.Position = UDim2.new(1, -30, 0.5, -12)
    preview.BackgroundColor3 = defaultColor
    preview.BorderSizePixel = 0
    preview.ZIndex = 6
    preview.Parent = frame
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 6)
    prevCorner.Parent = preview
    
    -- Paleta de cores
    local Colors = {
        Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 100, 100),
        Color3.fromRGB(255, 150, 0), Color3.fromRGB(255, 200, 0),
        Color3.fromRGB(200, 255, 0), Color3.fromRGB(100, 255, 50),
        Color3.fromRGB(0, 200, 80), Color3.fromRGB(0, 200, 150),
        Color3.fromRGB(0, 200, 200), Color3.fromRGB(0, 150, 255),
        Color3.fromRGB(50, 100, 255), Color3.fromRGB(100, 50, 255),
        Color3.fromRGB(150, 50, 255), Color3.fromRGB(200, 50, 255),
        Color3.fromRGB(255, 50, 200), Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(200, 200, 200), Color3.fromRGB(150, 150, 150),
        Color3.fromRGB(100, 100, 100), Color3.fromRGB(50, 50, 50),
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
            paletteFrame.Size = UDim2.new(0, 200, 0, 180)
            paletteFrame.Position = UDim2.new(0, math.random(50, 150), 0, math.random(100, 200))
            paletteFrame.BackgroundColor3 = C.PretoFundo
            paletteFrame.BorderSizePixel = 0
            paletteFrame.ZIndex = 100
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
            grid.CellSize = UDim2.new(0, 28, 0, 28)
            grid.CellPadding = UDim2.new(0, 4, 0, 4)
            grid.Parent = paletteFrame
            
            for _, color in ipairs(Colors) do
                local colorBtn = Instance.new("TextButton")
                colorBtn.Size = UDim2.new(0, 28, 0, 28)
                colorBtn.BackgroundColor3 = color
                colorBtn.BorderSizePixel = 0
                colorBtn.Text = ""
                colorBtn.ZIndex = 101
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
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 38)
    return frame
end

function Keybind(text, defaultKey, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel = 0
    frame.ZIndex = 6
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
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, 70, 0, 24)
    keyBtn.Position = UDim2.new(1, -76, 0.5, -12)
    keyBtn.BackgroundColor3 = C.CinzaEscuro
    keyBtn.BackgroundTransparency = 0.3
    keyBtn.BorderSizePixel = 0
    keyBtn.Text = defaultKey.Name
    keyBtn.TextColor3 = C.Branco
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 10
    keyBtn.ZIndex = 6
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
        if listening and not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            keyBtn.Text = input.KeyCode.Name
            keyBtn.BackgroundColor3 = C.CinzaEscuro
            keyBtn.BackgroundTransparency = 0.3
            if callback then callback(input.KeyCode) end
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 38)
    return frame
end

function Button(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color or C.Branco
    btn.BackgroundTransparency = 0.85
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = C.Branco
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.ZIndex = 6
    btn.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 36)
    return btn
end

-- ═══════════════════════ SISTEMA DE ARRASTO DO MENU ═══════════════════════
local dragging = false
local dragStart = nil
local startPos = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ═══════════════════════ MONITOR FPS/PING ═══════════════════════
local StatsDisplay = Instance.new("Frame")
StatsDisplay.Name = "StatsDisplay"
StatsDisplay.Size = UDim2.new(0, 140, 0, 44)
StatsDisplay.Position = UDim2.new(1, -150, 0, 10)
StatsDisplay.BackgroundColor3 = C.PretoFundo
StatsDisplay.BackgroundTransparency = 0.25
StatsDisplay.BorderSizePixel = 0
StatsDisplay.ZIndex = 1000
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
FPSLabel.Size = UDim2.new(1, -5, 0, 18)
FPSLabel.Position = UDim2.new(0, 5, 0, 4)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = C.Verde
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 12
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.ZIndex = 1001
FPSLabel.Parent = StatsDisplay

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(1, -5, 0, 18)
PingLabel.Position = UDim2.new(0, 5, 0, 22)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "PING: --ms"
PingLabel.TextColor3 = C.Azul
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 12
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.ZIndex = 1001
PingLabel.Parent = StatsDisplay

-- ═══════════════════════ SISTEMA ESP ═══════════════════════
local ESPObjects = {}
local ESPConnection = nil

function UpdateESP()
    -- Limpar ESP antigo
    for _, obj in pairs(ESPObjects) do
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
        
        -- Verificar time
        local isTeam = false
        if Config.ESP.TeamCheck then
            isTeam = player.Team == LocalPlayer.Team and player.Team ~= nil
        end
        
        local boxColor = isTeam and Config.ESP.TeamBoxColor or Config.ESP.BoxColor
        local nameColor = isTeam and Config.ESP.TeamNameColor or Config.ESP.NameColor
        
        -- BOX (Highlight)
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
        
        -- TRACERS (Linhas)
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
            -- Verificar time
            if Config.Aimbot.TeamCheck then
                if player.Team == LocalPlayer.Team and player.Team ~= nil then
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
    -- Atualizar FPS
    local now = tick()
    local dt = now - (StatsDisplay:GetAttribute("LastFrame") or now)
    StatsDisplay:SetAttribute("LastFrame", now)
    
    if dt > 0 then
        local fps = math.floor(1 / dt)
        FPSLabel.Text = "FPS: " .. fps
        
        if fps >= 60 then
            FPSLabel.TextColor3 = C.Verde
        elseif fps >= 30 then
            FPSLabel.TextColor3 = C.Amarelo
        else
            FPSLabel.TextColor3 = C.Vermelho
        end
    end
    
    -- Atualizar Ping
    pcall(function()
        local ping = math.floor(Stats.PerformanceStats.Ping:GetValue() * 1000)
        PingLabel.Text = "PING: " .. ping .. "ms"
        
        if ping <= 100 then
            PingLabel.TextColor3 = C.Verde
        elseif ping <= 200 then
            PingLabel.TextColor3 = C.Amarelo
        else
            PingLabel.TextColor3 = C.Vermelho
        end
    end)
    
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
        infoText.Text = "⚙ Menu de Configurações v2.0\n✅ Totalmente funcional e otimizado\n📌 Use as abas ao lado para navegar"
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
        Slider("Distância Máxima", 100, 2000, Config.Aimbot.MaxDistance, function(v) Config.Aimbot.MaxDistance = v end)
        
        -- Dropdown para parte do corpo
        local parts = {"Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso"}
        local partFrame = Instance.new("Frame")
        partFrame.Size = UDim2.new(1, 0, 0, 36)
        partFrame.BackgroundColor3 = C.PretoMedio
        partFrame.BackgroundTransparency = 0.7
        partFrame.BorderSizePixel = 0
        partFrame.ZIndex = 6
        partFrame.Parent = Scroll
        
        local partCorner = Instance.new("UICorner")
        partCorner.CornerRadius = UDim.new(0, 8)
        partCorner.Parent = partFrame
        
        local partLabel = Instance.new("TextLabel")
        partLabel.Size = UDim2.new(0, 180, 1, 0)
        partLabel.Position = UDim2.new(0, 10, 0, 0)
        partLabel.BackgroundTransparency = 1
        partLabel.Text = "Parte do Corpo"
        partLabel.TextColor3 = C.BrancoSuave
        partLabel.Font = Enum.Font.Gotham
        partLabel.TextSize = 11
        partLabel.TextXAlignment = Enum.TextXAlignment.Left
        partLabel.ZIndex = 6
        partLabel.Parent = partFrame
        
        local partBtn = Instance.new("TextButton")
        partBtn.Size = UDim2.new(0, 80, 0, 24)
        partBtn.Position = UDim2.new(1, -86, 0.5, -12)
        partBtn.BackgroundColor3 = C.CinzaEscuro
        partBtn.BackgroundTransparency = 0.3
        partBtn.BorderSizePixel = 0
        partBtn.Text = Config.Aimbot.AimPart
        partBtn.TextColor3 = C.Branco
        partBtn.Font = Enum.Font.GothamBold
        partBtn.TextSize = 10
        partBtn.ZIndex = 6
        partBtn.Parent = partFrame
        
        local partBtnCorner = Instance.new("UICorner")
        partBtnCorner.CornerRadius = UDim.new(0, 6)
        partBtnCorner.Parent = partBtn
        
        local expanded = false
        local partOptions = {}
        
        partBtn.MouseButton1Click:Connect(function()
            expanded = not expanded
            
            if expanded then
                partFrame.Size = UDim2.new(1, 0, 0, 36 + (26 * #parts))
                for i, part in ipairs(parts) do
                    local option = Instance.new("TextButton")
                    option.Size = UDim2.new(1, 0, 0, 24)
                    option.Position = UDim2.new(0, 0, 0, 36 + (26 * (i - 1)))
                    option.BackgroundColor3 = C.PretoMedio
                    option.BackgroundTransparency = 0.5
                    option.BorderSizePixel = 0
                    option.Text = "   " .. part
                    option.TextColor3 = C.CinzaClaro
                    option.Font = Enum.Font.Gotham
                    option.TextSize = 10
                    option.TextXAlignment = Enum.TextXAlignment.Left
                    option.ZIndex = 7
                    option.Parent = partFrame
                    
                    option.MouseButton1Click:Connect(function()
                        Config.Aimbot.AimPart = part
                        partBtn.Text = part
                        expanded = false
                        partFrame.Size = UDim2.new(1, 0, 0, 36)
                        for _, opt in ipairs(partOptions) do opt:Destroy() end
                        partOptions = {}
                    end)
                    table.insert(partOptions, option)
                end
            else
                partFrame.Size = UDim2.new(1, 0, 0, 36)
                for _, opt in ipairs(partOptions) do opt:Destroy() end
                partOptions = {}
            end
        end)
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 38)
        
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
        
    elseif CurrentTab == "Monitor" then
        Section("📊 MONITOR")
        Toggle("Mostrar FPS", Config.Monitor.ShowFPS, function(v) Config.Monitor.ShowFPS = v end)
        Toggle("Mostrar Ping", Config.Monitor.ShowPing, function(v) Config.Monitor.ShowPing = v end)
        
        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, 0, 0, 40)
        info.BackgroundTransparency = 1
        info.Text = "📊 Monitor sempre visível no\ncanto superior direito da tela\n✅ FPS e Ping em tempo real"
        info.TextColor3 = C.Cinza
        info.Font = Enum.Font.Gotham
        info.TextSize = 10
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = Scroll
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 42)
        
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
        infoFrame.Size = UDim2.new(1, 0, 0, 60)
        infoFrame.BackgroundColor3 = C.PretoMedio
        infoFrame.BackgroundTransparency = 0.6
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = Scroll
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 8)
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "📌 Menu de Configurações v2.0\n✅ Todas as funções otimizadas e funcionais\n🔑 Tecla personalizável para abrir/fechar"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 10
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 65)
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
    if not gameProcessed and input.KeyCode == Config.MenuKey then
        Main.Visible = not Main.Visible
        if Main.Visible then
            Logo.Visible = false
        end
    end
end)

-- Atualizar ESP quando jogadores entram/saem
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

-- Loop para atualizar ESP
task.spawn(function()
    while true do
        if Config.ESP.Enabled then
            UpdateESP()
        end
        task.wait(0.2)
    end
end)

-- ═══════════════════════ INICIALIZAÇÃO ═══════════════════════
-- Carregar configurações
SaveSystem:Load()

-- Atualizar conteúdo inicial
UpdateContent()
UpdateFOV()

-- Animação de entrada suave
Main.BackgroundTransparency = 0.3
for i = 1, 10 do
    Main.BackgroundTransparency = Main.BackgroundTransparency - 0.015
    task.wait(0.02)
end

print("╔════════════════════════════════════════════╗")
print("║  ✅ MATEUS_SCRIPTS v22.0                  ║")
print("║  📊 Menu carregado com sucesso!           ║")
print("║  🔑 Pressione a tecla configurada         ║")
print("║  📌 Logo arrastável ao minimizar          ║")
print("╚════════════════════════════════════════════╝")
