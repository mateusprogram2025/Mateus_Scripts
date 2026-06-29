--[[
    ╔═══════════════════════════════════════════════════════╗
    ║   MATEUS_SCRIPTS v22.0 - VERSÃO OTIMIZADA            ║
    ║  • Salvamento Funcional • Visual Limpo               ║
    ║  • Branco/Preto com Transparência                    ║
    ║  • Código Otimizado • Sem Erros                      ║
    ╚═══════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

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
        Names = true,
        HealthBar = true,
        Distance = true,
        TeamCheck = true,
        MaxDistance = 1500,
    },
    
    Aimbot = {
        Enabled = false,
        FOV = 130,
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
    },
    
    Monitor = {
        Enabled = true,
        ShowFPS = true,
        ShowPing = true,
    }
}

-- ═══════════════════════ SISTEMA DE SALVAMENTO ═══════════════════════
local SaveSystem = {
    Data = {},
    FileName = "MateusConfig_" .. LocalPlayer.UserId .. ".json"
}

function SaveSystem:Load()
    local success, data = pcall(function()
        return readfile(self.FileName)
    end)
    
    if success and data then
        local decoded = HttpService:JSONDecode(data)
        if decoded then
            self.Data = decoded
            -- Aplicar configurações salvas
            for key, value in pairs(self.Data) do
                if Config[key] ~= nil then
                    if type(value) == "table" and type(Config[key]) == "table" then
                        for subKey, subValue in pairs(value) do
                            if Config[key][subKey] ~= nil then
                                Config[key][subKey] = subValue
                            end
                        end
                    else
                        Config[key] = value
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
    
    for key, value in pairs(Config) do
        if type(value) ~= "function" then
            dataToSave[key] = value
        end
    end
    
    local success = pcall(function()
        writefile(self.FileName, HttpService:JSONEncode(dataToSave))
    end)
    
    return success
end

function SaveSystem:Reset()
    -- Resetar para padrão
    Config.ESP.Enabled = false
    Config.Aimbot.Enabled = false
    Config.Visuals.FullBright = false
    Config.Monitor.Enabled = true
    self:Save()
end

-- ═══════════════════════ GUI PRINCIPAL ═══════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MateusScripts"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════ MENU PRINCIPAL ═══════════════════════
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 400)
Main.Position = UDim2.new(0.5, -250, 0.5, -200)
Main.BackgroundColor3 = C.PretoFundo
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Main.Visible = true
Main.ZIndex = 1000
Main.Parent = ScreenGui

-- Cantos arredondados
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

-- Borda sutil
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1
MainStroke.Color = C.Branco
MainStroke.Transparency = 0.8
MainStroke.Parent = Main

-- ═══════════════════════ HEADER ═══════════════════════
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = C.PretoClaro
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0
Header.ZIndex = 6
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 0, 22)
Title.Position = UDim2.new(0, 15, 0, 5)
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
SubTitle.Position = UDim2.new(0, 15, 0, 26)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Menu Profissional • Otimizado"
SubTitle.TextColor3 = C.Cinza
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 7
SubTitle.Parent = Header

-- Botão Minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 10)
MinBtn.BackgroundColor3 = C.CinzaEscuro
MinBtn.BackgroundTransparency = 0.3
MinBtn.BorderSizePixel = 0
MinBtn.Text = "─"
MinBtn.TextColor3 = C.Branco
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.ZIndex = 7
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinBtn

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 10)
CloseBtn.BackgroundColor3 = C.Vermelho
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.Branco
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.ZIndex = 7
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- ═══════════════════════ SIDEBAR ═══════════════════════
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -55)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = C.PretoClaro
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

-- ═══════════════════════ CONTEÚDO ═══════════════════════
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -120, 1, -55)
Content.Position = UDim2.new(0, 115, 0, 50)
Content.BackgroundColor3 = C.PretoMedio
Content.BackgroundTransparency = 0.4
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = Content

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = C.Branco
Scroll.ScrollBarImageTransparency = 0.7
Scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
Scroll.ZIndex = 6
Scroll.Parent = Content

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
    {Name = "Monitor", Icon = "📊"},
    {Name = "Config", Icon = "⚙"},
}

local CurrentTab = "Geral"
local TabButtons = {}

-- Criar botões de abas
local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 3)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

-- Espaçamento inicial
local SidePad = Instance.new("Frame")
SidePad.Size = UDim2.new(1, 0, 0, 5)
SidePad.BackgroundTransparency = 1
SidePad.LayoutOrder = 0
SidePad.Parent = Sidebar

for i, tab in ipairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 30)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = C.PretoMedio
    btn.BackgroundTransparency = 0.5
    btn.BorderSizePixel = 0
    btn.Text = tab.Icon .. " " .. tab.Name
    btn.TextColor3 = C.Cinza
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = i
    btn.ZIndex = 6
    btn.Parent = Sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
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
            btn.BackgroundTransparency = 0.8
            btn.TextColor3 = C.Branco
        else
            btn.BackgroundColor3 = C.PretoMedio
            btn.BackgroundTransparency = 0.5
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
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.Branco
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 6
    l.Parent = Scroll
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0, 18)
    line.BackgroundColor3 = C.Branco
    line.BackgroundTransparency = 0.8
    line.BorderSizePixel = 0
    line.Parent = l
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 22)
    return l
end

function Toggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.ZIndex = 6
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 40, 0, 20)
    toggleBtn.Position = UDim2.new(1, -46, 0.5, -10)
    toggleBtn.BackgroundColor3 = default and C.Verde or C.CinzaEscuro
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 6
    toggleBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = toggleBtn
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 16, 0, 16)
    dot.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
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
        dot.Position = isOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        
        if callback then
            callback(isOn)
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 32)
    return frame
end

function Slider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = C.PretoMedio
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.ZIndex = 6
    frame.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 15)
    label.Position = UDim2.new(0, 8, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = C.BrancoSuave
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -16, 0, 4)
    track.Position = UDim2.new(0, 8, 0, 28)
    track.BackgroundColor3 = C.CinzaEscuro
    track.BorderSizePixel = 0
    track.ZIndex = 6
    track.Parent = frame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 2)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.Branco
    fill.BackgroundTransparency = 0.3
    fill.BorderSizePixel = 0
    fill.ZIndex = 6
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = fill
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6)
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
            thumb.Position = UDim2.new(percentage, -6, 0.5, -6)
            label.Text = text .. ": " .. tostring(currentValue)
            
            if callback then
                callback(currentValue)
            end
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 47)
    return frame
end

function Button(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = color or C.Branco
    btn.BackgroundTransparency = 0.8
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = C.Branco
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.ZIndex = 6
    btn.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 34)
    return btn
end

-- ═══════════════════════ SISTEMA DE ARRASTO ═══════════════════════
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
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement) then
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
StatsDisplay.Size = UDim2.new(0, 130, 0, 40)
StatsDisplay.Position = UDim2.new(1, -140, 0, 10)
StatsDisplay.BackgroundColor3 = C.PretoFundo
StatsDisplay.BackgroundTransparency = 0.3
StatsDisplay.BorderSizePixel = 0
StatsDisplay.ZIndex = 1000
StatsDisplay.Parent = ScreenGui

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 8)
StatsCorner.Parent = StatsDisplay

local StatsStroke = Instance.new("UIStroke")
StatsStroke.Thickness = 1
StatsStroke.Color = C.Branco
StatsStroke.Transparency = 0.9
StatsStroke.Parent = StatsDisplay

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(1, -5, 0, 16)
FPSLabel.Position = UDim2.new(0, 5, 0, 5)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = C.Verde
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 11
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.ZIndex = 1001
FPSLabel.Parent = StatsDisplay

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(1, -5, 0, 16)
PingLabel.Position = UDim2.new(0, 5, 0, 21)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "PING: --ms"
PingLabel.TextColor3 = C.Azul
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 11
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
        
        -- Criar BillboardGui
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 150, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.LightInfluence = 0
        billboard.Parent = head
        table.insert(ESPObjects, billboard)
        
        local yOffset = 0
        
        if Config.ESP.Names then
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0, 16)
            nameLabel.Position = UDim2.new(0, 0, 0, yOffset)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = C.Branco
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 12
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.Parent = billboard
            yOffset = yOffset + 17
        end
        
        if Config.ESP.HealthBar then
            local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            
            local barBg = Instance.new("Frame")
            barBg.Size = UDim2.new(1, 0, 0, 4)
            barBg.Position = UDim2.new(0, 0, 0, yOffset)
            barBg.BackgroundColor3 = C.CinzaEscuro
            barBg.BorderSizePixel = 0
            barBg.Parent = billboard
            
            local barFill = Instance.new("Frame")
            barFill.Size = UDim2.new(healthPercent, 0, 1, 0)
            barFill.BackgroundColor3 = healthPercent > 0.5 and C.Verde or (healthPercent > 0.25 and C.Amarelo or C.Vermelho)
            barFill.BorderSizePixel = 0
            barFill.Parent = barBg
            
            yOffset = yOffset + 6
        end
        
        if Config.ESP.Distance then
            local distLabel = Instance.new("TextLabel")
            distLabel.Size = UDim2.new(1, 0, 0, 14)
            distLabel.Position = UDim2.new(0, 0, 0, yOffset)
            distLabel.BackgroundTransparency = 1
            distLabel.Text = math.floor(dist) .. "m"
            distLabel.TextColor3 = C.CinzaClaro
            distLabel.Font = Enum.Font.Gotham
            distLabel.TextSize = 10
            distLabel.Parent = billboard
        end
    end
end

-- ═══════════════════════ AIMBOT ═══════════════════════
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
        infoText.Text = "⚙ Menu de Configurações\nVersão 2.0 • Totalmente funcional\nUse as abas ao lado para navegar"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 11
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 65)
        
        Section("🔑 ATALHOS")
        local keyInfo = Instance.new("TextLabel")
        keyInfo.Size = UDim2.new(1, 0, 0, 40)
        keyInfo.BackgroundTransparency = 1
        keyInfo.Text = "Pressione RightShift para abrir/fechar o menu\nArraste o cabeçalho para mover"
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
                    pcall(function() obj:Destroy() end)
                end
                ESPObjects = {}
            end
        end)
        
        Section("📦 OPÇÕES")
        Toggle("Mostrar Nomes", Config.ESP.Names, function(v) Config.ESP.Names = v end)
        Toggle("Barra de Vida", Config.ESP.HealthBar, function(v) Config.ESP.HealthBar = v end)
        Toggle("Mostrar Distância", Config.ESP.Distance, function(v) Config.ESP.Distance = v end)
        Toggle("Detectar Times", Config.ESP.TeamCheck, function(v) Config.ESP.TeamCheck = v end)
        
        Section("📏 DISTÂNCIA")
        Slider("Distância Máxima", 100, 3000, Config.ESP.MaxDistance, function(v) Config.ESP.MaxDistance = v end)
        
    elseif CurrentTab == "Aimbot" then
        Section("🎯 AIMBOT")
        Toggle("Ativar Aimbot", Config.Aimbot.Enabled, function(v) Config.Aimbot.Enabled = v end)
        Toggle("Detectar Times", Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
        
        Section("🔴 CONFIGURAÇÕES")
        Slider("Raio de Alcance (FOV)", 30, 500, Config.Aimbot.FOV, function(v) Config.Aimbot.FOV = v end)
        Slider("Suavidade", 1, 20, Config.Aimbot.Smoothness, function(v) Config.Aimbot.Smoothness = v end)
        Slider("Distância Máxima", 100, 2000, Config.Aimbot.MaxDistance, function(v) Config.Aimbot.MaxDistance = v end)
        
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
        
        Toggle("Mudar FOV da Câmera", Config.Visuals.FOVChanger, function(v)
            Config.Visuals.FOVChanger = v
            Camera.FieldOfView = v and Config.Visuals.FOVValue or 70
        end)
        
        Slider("Valor do FOV", 30, 120, Config.Visuals.FOVValue, function(v)
            Config.Visuals.FOVValue = v
            if Config.Visuals.FOVChanger then
                Camera.FieldOfView = v
            end
        end)
        
    elseif CurrentTab == "Monitor" then
        Section("📊 MONITOR")
        Toggle("Mostrar FPS", Config.Monitor.ShowFPS, function(v) Config.Monitor.ShowFPS = v end)
        Toggle("Mostrar Ping", Config.Monitor.ShowPing, function(v) Config.Monitor.ShowPing = v end)
        
        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, 0, 0, 30)
        info.BackgroundTransparency = 1
        info.Text = "📊 Monitor sempre visível no\ncanto superior direito da tela"
        info.TextColor3 = C.Cinza
        info.Font = Enum.Font.Gotham
        info.TextSize = 10
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = Scroll
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 32)
        
    elseif CurrentTab == "Config" then
        Section("⚙ CONFIGURAÇÕES")
        
        Button("💾 Salvar Configurações", C.Verde, function()
            local success = SaveSystem:Save()
            if success then
                print("✅ Configurações salvas com sucesso!")
            end
        end)
        
        Button("📂 Carregar Configurações", C.Azul, function()
            local success = SaveSystem:Load()
            if success then
                print("✅ Configurações carregadas!")
                UpdateContent()
            end
        end)
        
        Button("🔄 Resetar para Padrão", C.Vermelho, function()
            SaveSystem:Reset()
            print("🔄 Configurações resetadas!")
            UpdateContent()
        end)
        
        Section("ℹ INFORMAÇÕES")
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, 0, 0, 50)
        infoFrame.BackgroundColor3 = C.PretoMedio
        infoFrame.BackgroundTransparency = 0.6
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = Scroll
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 6)
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "📌 Menu de Configurações v2.0\n✅ Todas as funções otimizadas e funcionais"
        infoText.TextColor3 = C.BrancoSuave
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 10
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.TextYAlignment = Enum.TextYAlignment.Center
        infoText.Parent = infoFrame
        
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.CanvasSize.Y.Offset + 55)
    end
end

-- ═══════════════════════ EVENTOS ═══════════════════════

-- Botões do header
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tecla para abrir/fechar
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Config.MenuKey then
        Main.Visible = not Main.Visible
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

-- Animação de entrada
Main.BackgroundTransparency = 0.3
for i = 1, 5 do
    Main.BackgroundTransparency = Main.BackgroundTransparency - 0.04
    task.wait(0.02)
end

print("✅ Menu de Configurações carregado com sucesso!")
print("📊 Monitor FPS/PING ativo no canto superior direito")
print("🔑 Pressione RightShift para abrir/fechar")
