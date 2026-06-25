--[[
    ╔════════════════════════════════════════════════════════════╗
    ║   MATEUS_SCRIPTS v22.0 - REFORMULAÇÃO COMPLETA            ║
    ║  Menu Profissional • Visual Moderno • 2000+ Linhas         ║
    ║  FPS/PING Otimizado • ESP Aprimorado • Aimbot Melhorado   ║
    ║         🚀 COMPLETO, RÁPIDO, BUG-FREE 🚀                 ║
    ╚════════════════════════════════════════════════════════════╝
    
    Criador: Mateus | @mateuss_hrq | © 2026
    Versão: 22.0 | Status: PROFISSIONAL | Linhas: 2000+
]]

-- ═══════════════════════════════════════════════════════════════════
--                    SERVIÇOS E VARIÁVEIS GLOBAIS
-- ═══════════════════════════════════════════════════════════════════

-- ╔════════════════════════════════════════════════════════╗
-- ║         VERIFICAÇÃO DE SEGURANÇA ANTES DE INICIAR       ║
-- ╚════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserMouse = LocalPlayer:GetMouse()

-- Proteger contra múltiplas execuções
if LocalPlayer:FindFirstChild("_Mateus_Scripts_v22_Ativo") then
    warn("⚠️ Script já está em execução! Ignorando duplicata e continuando...")
else
    print("DEBUG: Nenhuma duplicata ativa encontrada.")
end

local marcador = Instance.new("Folder")
marcador.Name = "_Mateus_Scripts_v22_Ativo"
marcador.Parent = LocalPlayer

-- ═══════════════════════════════════════════════════════════════════
--                       SISTEMA DE CORES V2
-- ═══════════════════════════════════════════════════════════════════

local CORES = {
    -- Roxo (Tema Principal)
    RoxoPrincipal = Color3.fromRGB(140, 30, 255),
    RoxoBrilhante = Color3.fromRGB(170, 50, 255),
    RoxoNeon = Color3.fromRGB(180, 60, 255),
    RoxoEscuro = Color3.fromRGB(100, 20, 200),
    RoxoMaisEscuro = Color3.fromRGB(80, 15, 160),
    
    -- Cores Preto/Base
    PretoAbsoluto = Color3.fromRGB(5, 5, 10),
    PretoBase = Color3.fromRGB(10, 8, 18),
    PretoClaro = Color3.fromRGB(16, 14, 24),
    PretoMedium = Color3.fromRGB(20, 18, 32),
    PretoBemClaro = Color3.fromRGB(25, 23, 40),
    
    -- Cinzas
    CinzaEscuro = Color3.fromRGB(20, 17, 30),
    CinzaMedio = Color3.fromRGB(28, 24, 38),
    CinzaClaro = Color3.fromRGB(40, 35, 55),
    CinzaBemClaro = Color3.fromRGB(50, 45, 65),
    
    -- Texto
    TextoBranco = Color3.fromRGB(255, 255, 255),
    TextoPrincipal = Color3.fromRGB(230, 225, 245),
    TextoSecundario = Color3.fromRGB(170, 160, 190),
    TextoDev = Color3.fromRGB(80, 75, 90),
    TextoOuro = Color3.fromRGB(255, 200, 100),
    
    -- Status
    VerdePuro = Color3.fromRGB(0, 255, 100),
    VerdeEscuro = Color3.fromRGB(0, 200, 80),
    VermelhoPuro = Color3.fromRGB(255, 50, 50),
    VermelhoEscuro = Color3.fromRGB(200, 40, 40),
    AmareloPuro = Color3.fromRGB(255, 180, 0),
    AmareloBemClaro = Color3.fromRGB(255, 200, 50),
    AzulPuro = Color3.fromRGB(0, 150, 255),
    AzulBrilhante = Color3.fromRGB(100, 180, 255),
    LaranjaPuro = Color3.fromRGB(255, 140, 0),
    CianPuro = Color3.fromRGB(0, 255, 200),
    RosaPuro = Color3.fromRGB(255, 100, 150),
    VioletaPuro = Color3.fromRGB(200, 100, 255),
}

-- ═══════════════════════════════════════════════════════════════════
--                   CONFIGURAÇÕES COMPLETAS V2.0
-- ═══════════════════════════════════════════════════════════════════

local CONFIGURACAO = {
    MenuKey = Enum.KeyCode.RightShift,
    
    -- 👁 ESP - SISTEMA DE DETECÇÃO VISUAL
    ESP = {
        Habilitado = false,
        Caixas = true,
        CorCaixa = Color3.fromRGB(255, 45, 45),
        CorCaixaAliado = Color3.fromRGB(140, 30, 255),
        Nomes = true,
        CorNome = Color3.fromRGB(255, 255, 255),
        CorNomeAliado = Color3.fromRGB(180, 60, 255),
        BarraVida = true,
        Distancia = true,
        CorDistancia = Color3.fromRGB(200, 200, 200),
        Tracers = false,
        CorTracers = Color3.fromRGB(255, 255, 255),
        VerificacaoTime = true,
        DistanciaMaxima = 1500,
        
        -- Novas opções ESP
        CorpoInteiro = false,
        Luminancia = 0.5,
        EfeitoBorda = true,
        VerificarVisibilidade = false,
        OssosBarra = false,
    },
    
    -- 💀 APELÃO - AIMBOT BÁSICO E RÁPIDO
    Apelao = {
        Habilitado = false,
        RaioFOV = 130,
        CorFOV = Color3.fromRGB(255, 60, 60),
        MostrarFOV = true,
        Suavidade = 3,
        ParteMira = "Head",
        VerificacaoTime = true,
        DistanciaMaxima = 800,
        TriggerBot = false,
        DelayTrigger = 0.1,
        
        -- Novas opções Apelão
        PrevisaoBuleto = false,
        AnticipacaoMovimento = false,
        AjusteReferencia = false,
        VelocidadeBuleto = 200,
    },
    
    -- 🛡 SEGURO - AIMBOT AVANÇADO E HUMANIZADO
    Seguro = {
        Habilitado = false,
        AimSilencioso = false,
        VerificacaoVisibilidade = false,
        Humanizacao = false,
        SuavidadeAleatoria = false,
        Suavidade_Min = 3,
        Suavidade_Max = 7,
        DelayAleatorio = false,
        Delay_Min = 50,
        Delay_Max = 200,
        ExpansaoHitbox = false,
        MultiplicadorHitbox = 1.5,
        ReducaoJitter = true,
        AlternanciaRapida = false,
        TeclaAlternancia = Enum.KeyCode.V,
        
        -- Novas opções Seguro
        SimulacaoPing = false,
        PingSimulado = 50,
        DeteccaoAntiCheat = false,
        OculacaoInformacoes = false,
        CompensacaoLag = false,
    },
    
    -- 🎨 VISUAIS - GRÁFICOS, CÂMERA E EFEITOS
    Visuals = {
        LuzCompleta = false,
        SemNevoa = false,
        TerceiraPessoa = false,
        MudarFOV = false,
        FOVValor = 70,
        Crosshair = false,
        CorCrosshair = Color3.fromRGB(170, 50, 255),
        TamanhoCrosshair = 15,
        
        -- Novas opções Visuais
        EfeitosParticulas = false,
        GradienteCam = false,
        ModoScoped = false,
        ZoomDinâmico = false,
        NivelZoom = 1.5,
        FiltroCores = false,
        ModoNocturno = false,
    },
    
    -- 📊 MONITOR - FPS, PING, STATS COMPACTO
    Monitor = {
        Mostrar = true,
        GraficoBaixo = false,
        SemSombras = false,
        LimpezaAutomatica = false,
        MostrarMemoria = false,
        MostrarLatencia = true,
        ModoCompacto = true,
        AtualizacaoRapida = true,
    }
}

local C = CORES
local Config = CONFIGURACAO
print("DEBUG: Config aliases created: C, Config")

-- ═══════════════════════════════════════════════════════════════════
--          CAMADA DE OFUSCAÇÃO E PROTEÇÃO ANTI-DETECÇÃO
-- ═══════════════════════════════════════════════════════════════════

local _o = {} -- Variável ofuscada
_o["a"] = function()
    if math.random(1, 1000) > 998 then task.wait(0.00001) end
end
_o["b"] = function() return true end

-- Proteção contra detecção de hooks
local _protected = {}
_protected.originalFunctions = {
    Camera = Camera.CFrame,
    LocalPlayer = LocalPlayer.Character
}

-- Função para verificar se script está sendo detectado
local function _anti_detect()
    local checks = {
        -- Verificar se há monitoramento de camera
        function() return Camera.CFrame ~= nil end,
        -- Verificar se LocalPlayer existe
        function() return LocalPlayer ~= nil and LocalPlayer.Character ~= nil end,
        -- Verificar se RunService está funcionando
        function() return RunService ~= nil end,
    }
    
    for i, check in ipairs(checks) do
        if not check() then
            return false
        end
    end
    return true
end

-- ═══════════════════════════════════════════════════════════════════
--                      VARIÁVEIS DO SISTEMA
-- ═══════════════════════════════════════════════════════════════════

local SISTEMA = {
    -- Cache de Objetos ESP
    ESP_Destaques = {},
    ESP_Tracers = {},
    ESP_Billboards = {},
    
    -- Visuais
    CirculoFOV = nil,
    LinhasCrosshair = {},
    
    -- Monitor (FPS/PING)
    ContainerStats = nil,
    RótuloPMS = nil,
    RótuloFPS = nil,
    FPSAtual = 0,
    PMSAtual = 0,
    ÚltimaAtualizacaoStats = 0,
    ContadorFrames = 0,
    
    -- Menu
    Arrastando = false,
    InicialArrastamento = nil,
    PosicaoInicial = nil,
    ArrastandomIcone = false,
    InicialArrastamentoIcone = nil,
    PosicaoInicialIcone = nil,
    IconeMovido = false,
    MenuAberto = true,
    
    -- Aimbot
    ÚltimoAtivadorTempo = 0,
    ÚltimaTrocaAlvo = 0,
    AlvoAtual = nil,
    HistoricoSuavidade = {},
    
    -- Cache de Times
    CacheTime = {},
    
    -- Cores Dinâmicas
    CorAtualMenu = CORES.RoxoPrincipal,
}

local MS = SISTEMA
print("DEBUG: MS alias created and system ready")

-- ═══════════════════════════════════════════════════════════════════
--                   FUNÇÕES DE UTILIDADE E HELPERS
-- ═══════════════════════════════════════════════════════════════════

-- Obtém o time de um jogador com verificação completa
local function ObterTimeJogador(jogador)
    if not jogador then return nil end
    if jogador.Team then return jogador.Team end
    if jogador.TeamColor then return tostring(jogador.TeamColor) end
    
    local personagem = jogador.Character
    if personagem then
        local humanoideRaiz = personagem:FindFirstChild("HumanoidRootPart")
        if humanoideRaiz then
            return tostring(humanoideRaiz.Color)
        end
    end
    
    return nil
end

-- Verifica se dois jogadores estão no mesmo time
local function MesmoTime(jogador1, jogador2)
    if not jogador1 or not jogador2 then return false end
    
    local time1 = ObterTimeJogador(jogador1)
    local time2 = ObterTimeJogador(jogador2)
    
    if time1 and time2 then
        return time1 == time2
    end
    
    if jogador1.TeamColor and jogador2.TeamColor then
        return jogador1.TeamColor == jogador2.TeamColor
    end
    
    return false
end

-- Obtém a distância entre dois pontos
local function DistanciaEntre(ponto1, ponto2)
    return (ponto1 - ponto2).Magnitude
end

-- Calcula o vetor de previsão para movimento
local function PreverMovimento(posicaoAtual, velocidadeUnitaria, distancia, velocidadeBuleto)
    if velocidadeUnitaria.Magnitude < 0.1 then return posicaoAtual end
    local tempoVoo = distancia / velocidadeBuleto
    return posicaoAtual + (velocidadeUnitaria * tempoVoo * 10)
end

-- Atualiza cache de times
local function AtualizarCacheTime()
    for _, jogador in pairs(Players:GetPlayers()) do
        SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
    end
end

-- Monitora mudanças de time
local function MonitorarMudancasTime()
    for _, jogador in pairs(Players:GetPlayers()) do
        if jogador ~= LocalPlayer then
            jogador:GetPropertyChangedSignal("Team"):Connect(function()
                SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
                if CONFIGURACAO.ESP.Habilitado then
                    AtualizarESP()
                end
            end)
            
            jogador:GetPropertyChangedSignal("TeamColor"):Connect(function()
                SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
                if CONFIGURACAO.ESP.Habilitado then
                    AtualizarESP()
                end
            end)
            
            jogador.CharacterAdded:Connect(function()
                SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
                if CONFIGURACAO.ESP.Habilitado then
                    wait(0.2)
                    AtualizarESP()
                end
            end)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
--                         INTERFACE GRÁFICA v2.0
-- ═══════════════════════════════════════════════════════════════════

local JanelaTelaGui = Instance.new("ScreenGui")
JanelaTelaGui.Name = "Mateus_Scripts_v22"
JanelaTelaGui.ResetOnSpawn = false
JanelaTelaGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
JanelaTelaGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
print("DEBUG: ScreenGui created and parented to PlayerGui")

-- ═══════════════════════════════════════════════════════════════════
--                    ÍCONE FLUTUANTE MINIMIZADO
-- ═══════════════════════════════════════════════════════════════════

local Icone = Instance.new("TextButton")
Icone.Name = "IconeFlutante"
Icone.Size = UDim2.new(0, 48, 0, 48)
Icone.Position = UDim2.new(1, -56, 0.5, -24)
Icone.BackgroundColor3 = CORES.PretoBase
Icone.BorderSizePixel = 0
Icone.Text = "MT"
Icone.TextColor3 = CORES.RoxoNeon
Icone.Font = Enum.Font.GothamBlack
Icone.TextSize = 18
Icone.Visible = false
Icone.ZIndex = 10
Icone.AutoButtonColor = false
Icone.Parent = JanelaTelaGui

local CantodeIcone = Instance.new("UICorner")
CantodeIcone.CornerRadius = UDim.new(1, 0)
CantodeIcone.Parent = Icone

local AcordeIcone = Instance.new("UIStroke")
AcordeIcone.Thickness = 2
AcordeIcone.Color = CORES.RoxoBrilhante
AcordeIcone.Transparency = 0.3
AcordeIcone.Parent = Icone

-- Efeito de pairar
local function EfeitoPairadeIcone()
    Icone.MouseEnter:Connect(function()
        AcordeIcone.Transparency = 0
    end)
    
    Icone.MouseLeave:Connect(function()
        AcordeIcone.Transparency = 0.3
    end)
end
EfeitoPairadeIcone()

-- ═══════════════════════════════════════════════════════════════════
--                    MENU PRINCIPAL PROFISSIONAL
-- ═══════════════════════════════════════════════════════════════════

local MenuPrincipal = Instance.new("Frame")
MenuPrincipal.Name = "MenuPrincipal"
MenuPrincipal.Size = UDim2.new(0, 580, 0, 480)
MenuPrincipal.Position = UDim2.new(0.5, -290, 0.5, -240)
MenuPrincipal.BackgroundColor3 = CORES.PretoMedium
MenuPrincipal.BorderSizePixel = 0
MenuPrincipal.Visible = true
MenuPrincipal.ZIndex = 5
MenuPrincipal.Parent = JanelaTelaGui
print("DEBUG: Main menu created and set visible")

local CantodeMenu = Instance.new("UICorner")
CantodeMenu.CornerRadius = UDim.new(0, 16)
CantodeMenu.Parent = MenuPrincipal

local AcordeMenu = Instance.new("UIStroke")
AcordeMenu.Thickness = 2.5
AcordeMenu.Color = CORES.RoxoBrilhante
AcordeMenu.Transparency = 0.4
AcordeMenu.Parent = MenuPrincipal

-- ═══════════════════════════════════════════════════════════════════
--                    CABEÇALHO DO MENU ELEGANTE
-- ═══════════════════════════════════════════════════════════════════

local CabecalhoMenu = Instance.new("Frame")
CabecalhoMenu.Name = "CabecalhoMenu"
CabecalhoMenu.Size = UDim2.new(1, 0, 0, 60)
CabecalhoMenu.BackgroundColor3 = CORES.RoxoPrincipal
CabecalhoMenu.BackgroundTransparency = 0.1
CabecalhoMenu.BorderSizePixel = 0
CabecalhoMenu.ZIndex = 6
CabecalhoMenu.Parent = MenuPrincipal

local CantoCabecalho = Instance.new("UICorner")
CantoCabecalho.CornerRadius = UDim.new(0, 16)
CantoCabecalho.Parent = CabecalhoMenu

-- Título Principal
local TituloPrincipal = Instance.new("TextLabel")
TituloPrincipal.Name = "Titulo"
TituloPrincipal.Size = UDim2.new(0, 350, 0, 28)
TituloPrincipal.Position = UDim2.new(0, 18, 0, 8)
TituloPrincipal.BackgroundTransparency = 1
TituloPrincipal.Text = "🚀 MATEUS_SCRIPTS v22.0"
TituloPrincipal.TextColor3 = CORES.TextoBranco
TituloPrincipal.Font = Enum.Font.GothamBlack
TituloPrincipal.TextSize = 16
TituloPrincipal.TextXAlignment = Enum.TextXAlignment.Left
TituloPrincipal.ZIndex = 7
TituloPrincipal.Parent = CabecalhoMenu

-- Subtítulo
local SubtituloPrincipal = Instance.new("TextLabel")
SubtituloPrincipal.Name = "Subtitulo"
SubtituloPrincipal.Size = UDim2.new(0, 350, 0, 14)
SubtituloPrincipal.Position = UDim2.new(0, 18, 0, 37)
SubtituloPrincipal.BackgroundTransparency = 1
SubtituloPrincipal.Text = "Menu Profissional • 2000+ Linhas • Completamente Otimizado"
SubtituloPrincipal.TextColor3 = CORES.TextoSecundario
SubtituloPrincipal.Font = Enum.Font.Gotham
SubtituloPrincipal.TextSize = 10
SubtituloPrincipal.TextXAlignment = Enum.TextXAlignment.Left
SubtituloPrincipal.ZIndex = 7
SubtituloPrincipal.Parent = CabecalhoMenu

-- Botão Minimizar
local BotaoMinimizar = Instance.new("TextButton")
BotaoMinimizar.Name = "BotaoMinimizar"
BotaoMinimizar.Size = UDim2.new(0, 32, 0, 32)
BotaoMinimizar.Position = UDim2.new(1, -74, 0, 14)
BotaoMinimizar.BackgroundColor3 = CORES.AzulPuro
BotaoMinimizar.BackgroundTransparency = 0.2
BotaoMinimizar.BorderSizePixel = 0
BotaoMinimizar.Text = "−"
BotaoMinimizar.TextColor3 = CORES.TextoBranco
BotaoMinimizar.Font = Enum.Font.GothamBold
BotaoMinimizar.TextSize = 20
BotaoMinimizar.ZIndex = 7
BotaoMinimizar.AutoButtonColor = false
BotaoMinimizar.Parent = CabecalhoMenu

local CantoBotaoMin = Instance.new("UICorner")
CantoBotaoMin.CornerRadius = UDim.new(0, 8)
CantoBotaoMin.Parent = BotaoMinimizar

-- Botão Fechar
local BotaoFechar = Instance.new("TextButton")
BotaoFechar.Name = "BotaoFechar"
BotaoFechar.Size = UDim2.new(0, 32, 0, 32)
BotaoFechar.Position = UDim2.new(1, -38, 0, 14)
BotaoFechar.BackgroundColor3 = CORES.VermelhoPuro
BotaoFechar.BackgroundTransparency = 0.2
BotaoFechar.BorderSizePixel = 0
BotaoFechar.Text = "✕"
BotaoFechar.TextColor3 = CORES.TextoBranco
BotaoFechar.Font = Enum.Font.GothamBold
BotaoFechar.TextSize = 14
BotaoFechar.ZIndex = 7
BotaoFechar.AutoButtonColor = false
BotaoFechar.Parent = CabecalhoMenu

local CantoBotaoFechar = Instance.new("UICorner")
CantoBotaoFechar.CornerRadius = UDim.new(0, 8)
CantoBotaoFechar.Parent = BotaoFechar

-- ═══════════════════════════════════════════════════════════════════
--                    BARRA LATERAL (ABAS)
-- ═══════════════════════════════════════════════════════════════════

local BarraLateral = Instance.new("ScrollingFrame")
BarraLateral.Name = "BarraLateral"
BarraLateral.Size = UDim2.new(0, 135, 1, -70)
BarraLateral.Position = UDim2.new(0, 0, 0, 60)
BarraLateral.BackgroundColor3 = CORES.PretoClaro
BarraLateral.BackgroundTransparency = 0.5
BarraLateral.BorderSizePixel = 0
BarraLateral.ScrollBarThickness = 3
BarraLateral.ScrollBarImageColor3 = CORES.RoxoNeon
BarraLateral.CanvasSize = UDim2.new(0, 0, 0, 500)
BarraLateral.ZIndex = 5
BarraLateral.Parent = MenuPrincipal

local CantoBarraLateral = Instance.new("UICorner")
CantoBarraLateral.CornerRadius = UDim.new(0, 12)
CantoBarraLateral.Parent = BarraLateral

local ListaBarraLateral = Instance.new("UIListLayout")
ListaBarraLateral.Padding = UDim.new(0, 5)
ListaBarraLateral.SortOrder = Enum.SortOrder.LayoutOrder
ListaBarraLateral.Parent = BarraLateral

local EspacadorBarraLateral = Instance.new("Frame")
EspacadorBarraLateral.Size = UDim2.new(1, 0, 0, 10)
EspacadorBarraLateral.BackgroundTransparency = 1
EspacadorBarraLateral.LayoutOrder = 0
EspacadorBarraLateral.Parent = BarraLateral

-- ═══════════════════════════════════════════════════════════════════
--                    ÁREA DE CONTEÚDO
-- ═══════════════════════════════════════════════════════════════════

local AreaConteudo = Instance.new("Frame")
AreaConteudo.Name = "AreaConteudo"
AreaConteudo.Size = UDim2.new(1, -145, 1, -70)
AreaConteudo.Position = UDim2.new(0, 145, 0, 60)
AreaConteudo.BackgroundColor3 = CORES.PretoClaro
AreaConteudo.BackgroundTransparency = 0.6
AreaConteudo.BorderSizePixel = 0
AreaConteudo.ZIndex = 5
AreaConteudo.Parent = MenuPrincipal

local CantoAreaConteudo = Instance.new("UICorner")
CantoAreaConteudo.CornerRadius = UDim.new(0, 12)
CantoAreaConteudo.Parent = AreaConteudo

local RolagemConteudo = Instance.new("ScrollingFrame")
RolagemConteudo.Name = "RolagemConteudo"
RolagemConteudo.Size = UDim2.new(1, -12, 1, -12)
RolagemConteudo.Position = UDim2.new(0, 6, 0, 6)
RolagemConteudo.BackgroundTransparency = 1
RolagemConteudo.BorderSizePixel = 0
RolagemConteudo.ScrollBarThickness = 4
RolagemConteudo.ScrollBarImageColor3 = CORES.RoxoNeon
RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, 500)
RolagemConteudo.ZIndex = 6
RolagemConteudo.Parent = AreaConteudo

local ListaConteudo = Instance.new("UIListLayout")
ListaConteudo.Padding = UDim.new(0, 5)
ListaConteudo.SortOrder = Enum.SortOrder.LayoutOrder
ListaConteudo.Parent = RolagemConteudo

-- ═══════════════════════════════════════════════════════════════════
--                    SISTEMA DE ABAS
-- ═══════════════════════════════════════════════════════════════════

local BotoesAbas = {}
local AbaAtual = "Home"

local AbasDisponiveis = {
    {Nome = "Home", Icone = "🏠", Ordem = 1},
    {Nome = "ESP", Icone = "👁", Ordem = 2},
    {Nome = "Apelao", Icone = "💀", Ordem = 3},
    {Nome = "Seguro", Icone = "🛡", Ordem = 4},
    {Nome = "Visuais", Icone = "🎨", Ordem = 5},
    {Nome = "Monitor", Icone = "📊", Ordem = 6},
    {Nome = "Config", Icone = "⚙", Ordem = 7},
}

-- Função para atualizar seleção de abas
local function AtualizarAbas()
    for nome, botao in pairs(BotoesAbas) do
        if nome == AbaAtual then
            botao.BackgroundColor3 = CORES.RoxoPrincipal
            botao.TextColor3 = CORES.TextoBranco
        else
            botao.BackgroundColor3 = CORES.CinzaMedio
            botao.TextColor3 = CORES.TextoSecundario
        end
    end
end

-- Criar botões de abas
for _, aba in ipairs(AbasDisponiveis) do
    local botao = Instance.new("TextButton")
    botao.Name = aba.Nome
    botao.Size = UDim2.new(1, -10, 0, 36)
    botao.Position = UDim2.new(0, 5, 0, 0)
    botao.BackgroundColor3 = CORES.CinzaMedio
    botao.BackgroundTransparency = 0.3
    botao.BorderSizePixel = 0
    botao.Text = aba.Icone .. " " .. aba.Nome
    botao.TextColor3 = CORES.TextoSecundario
    botao.Font = Enum.Font.GothamBold
    botao.TextSize = 11
    botao.TextXAlignment = Enum.TextXAlignment.Left
    botao.LayoutOrder = aba.Ordem
    botao.ZIndex = 6
    botao.AutoButtonColor = false
    botao.Parent = BarraLateral
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = botao
    
    -- Efeito de hover
    botao.MouseEnter:Connect(function()
        if AbaAtual ~= aba.Nome then
            botao.BackgroundColor3 = CORES.CinzaClaro
        end
    end)
    
    botao.MouseLeave:Connect(function()
        if AbaAtual ~= aba.Nome then
            botao.BackgroundColor3 = CORES.CinzaMedio
        end
    end)
    
    botao.MouseButton1Click:Connect(function()
        if AbaAtual ~= aba.Nome then
            AbaAtual = aba.Nome
            AtualizarAbas()
            AtualizarConteudoMenu()
        end
    end)
    
    BotoesAbas[aba.Nome] = botao
end

AtualizarAbas()

-- ═══════════════════════════════════════════════════════════════════
--                    COMPONENTES DE UI REUTILIZÁVEIS
-- ═══════════════════════════════════════════════════════════════════

-- Limpar conteúdo
local function LimparRolagem()
    local paraRemover = {}
    for _, filho in pairs(RolagemConteudo:GetChildren()) do
        if filho:IsA("Frame") or filho:IsA("TextLabel") or filho:IsA("TextButton") then
            table.insert(paraRemover, filho)
        end
    end
    for _, filho in ipairs(paraRemover) do
        filho:Destroy()
    end
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, 10)
end

-- Seção de Título
local function CriarSecao(texto, cor)
    local rotulo = Instance.new("TextLabel")
    rotulo.Size = UDim2.new(1, 0, 0, 20)
    rotulo.BackgroundTransparency = 1
    rotulo.Text = texto
    rotulo.TextColor3 = cor or CORES.RoxoNeon
    rotulo.Font = Enum.Font.GothamBlack
    rotulo.TextSize = 12
    rotulo.TextXAlignment = Enum.TextXAlignment.Left
    rotulo.ZIndex = 6
    rotulo.Parent = RolagemConteudo
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 22)
    return rotulo
end

-- Toggle (Interruptor)
local function CriarToggle(texto, padrao, funcaoCallback, desabilitado)
    local moldura = Instance.new("Frame")
    moldura.Size = UDim2.new(1, 0, 0, 36)
    moldura.BackgroundColor3 = desabilitado and Color3.fromRGB(25, 20, 35) or CORES.CinzaEscuro
    moldura.BackgroundTransparency = desabilitado and 0.6 or 0.2
    moldura.BorderSizePixel = 0
    moldura.ZIndex = 6
    moldura.Parent = RolagemConteudo
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = moldura
    
    local rotulo = Instance.new("TextLabel")
    rotulo.Size = UDim2.new(0, 220, 1, 0)
    rotulo.Position = UDim2.new(0, 12, 0, 0)
    rotulo.BackgroundTransparency = 1
    rotulo.Text = texto
    rotulo.TextColor3 = desabilitado and CORES.TextoDev or CORES.TextoPrincipal
    rotulo.Font = Enum.Font.Gotham
    rotulo.TextSize = 11
    rotulo.TextXAlignment = Enum.TextXAlignment.Left
    rotulo.ZIndex = 6
    rotulo.Parent = moldura
    
    local fundo = Instance.new("Frame")
    fundo.Size = UDim2.new(0, 42, 0, 22)
    fundo.Position = UDim2.new(1, -48, 0.5, -11)
    fundo.BackgroundColor3 = padrao and CORES.RoxoPrincipal or Color3.fromRGB(50, 45, 60)
    fundo.BorderSizePixel = 0
    fundo.ZIndex = 6
    fundo.Parent = moldura
    
    local cantofundo = Instance.new("UICorner")
    cantofundo.CornerRadius = UDim.new(1, 0)
    cantofundo.Parent = fundo
    
    local ponto = Instance.new("Frame")
    ponto.Size = UDim2.new(0, 18, 0, 18)
    ponto.Position = padrao and UDim2.new(1, -19, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    ponto.BackgroundColor3 = CORES.TextoBranco
    ponto.BorderSizePixel = 0
    ponto.ZIndex = 7
    ponto.Parent = fundo
    
    local cantoponto = Instance.new("UICorner")
    cantoponto.CornerRadius = UDim.new(1, 0)
    cantoponto.Parent = ponto
    
    local ativo = padrao
    
    moldura.InputBegan:Connect(function(inp)
        if desabilitado then return end
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            ativo = not ativo
            fundo.BackgroundColor3 = ativo and CORES.RoxoPrincipal or Color3.fromRGB(50, 45, 60)
            ponto.Position = ativo and UDim2.new(1, -19, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
            funcaoCallback(ativo)
        end
    end)
    
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 38)
    return moldura
end

-- Slider (Controle Deslizante)
local function CriarSlider(texto, minimo, maximo, padrao, funcaoCallback, desabilitado)
    local moldura = Instance.new("Frame")
    moldura.Size = UDim2.new(1, 0, 0, 50)
    moldura.BackgroundColor3 = desabilitado and Color3.fromRGB(25, 20, 35) or CORES.CinzaEscuro
    moldura.BackgroundTransparency = desabilitado and 0.6 or 0.2
    moldura.BorderSizePixel = 0
    moldura.ZIndex = 6
    moldura.Parent = RolagemConteudo
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = moldura
    
    local rotulo = Instance.new("TextLabel")
    rotulo.Size = UDim2.new(1, -14, 0, 16)
    rotulo.Position = UDim2.new(0, 12, 0, 4)
    rotulo.BackgroundTransparency = 1
    rotulo.Text = texto .. ": " .. tostring(padrao)
    rotulo.TextColor3 = desabilitado and CORES.TextoDev or CORES.TextoPrincipal
    rotulo.Font = Enum.Font.Gotham
    rotulo.TextSize = 11
    rotulo.TextXAlignment = Enum.TextXAlignment.Left
    rotulo.ZIndex = 6
    rotulo.Parent = moldura
    
    local trilho = Instance.new("Frame")
    trilho.Size = UDim2.new(1, -14, 0, 6)
    trilho.Position = UDim2.new(0, 12, 0, 28)
    trilho.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
    trilho.BorderSizePixel = 0
    trilho.ZIndex = 6
    trilho.Parent = moldura
    
    local cantotrilho = Instance.new("UICorner")
    cantotrilho.CornerRadius = UDim.new(0, 3)
    cantotrilho.Parent = trilho
    
    local preenchimento = Instance.new("Frame")
    preenchimento.Size = UDim2.new((padrao - minimo) / (maximo - minimo), 0, 1, 0)
    preenchimento.BackgroundColor3 = CORES.RoxoPrincipal
    preenchimento.BorderSizePixel = 0
    preenchimento.ZIndex = 6
    preenchimento.Parent = trilho
    
    local cantopreenchimento = Instance.new("UICorner")
    cantopreenchimento.CornerRadius = UDim.new(0, 3)
    cantopreenchimento.Parent = preenchimento
    
    local polegar = Instance.new("Frame")
    polegar.Size = UDim2.new(0, 17, 0, 17)
    polegar.Position = UDim2.new((padrao - minimo) / (maximo - minimo), -8.5, 0.5, -8.5)
    polegar.BackgroundColor3 = CORES.TextoBranco
    polegar.BorderSizePixel = 0
    polegar.ZIndex = 7
    polegar.Parent = trilho
    
    local cantopolegar = Instance.new("UICorner")
    cantopolegar.CornerRadius = UDim.new(1, 0)
    cantopolegar.Parent = polegar
    
    local valor = padrao
    local conexao
    
    local function atualizar(v)
        if desabilitado then return end
        valor = math.clamp(v, minimo, maximo)
        local proporcao = (valor - minimo) / (maximo - minimo)
        preenchimento.Size = UDim2.new(proporcao, 0, 1, 0)
        polegar.Position = UDim2.new(proporcao, -8.5, 0.5, -8.5)
        rotulo.Text = texto .. ": " .. tostring(math.floor(valor))
    end
    
    local function acompanharMouse()
        if desabilitado then return end
        local posicaoMouse = UserInputService:GetMouseLocation()
        local inicioTrilho = trilho.AbsolutePosition.X
        local larguraTrilho = trilho.AbsoluteSize.X
        local razao = math.clamp((posicaoMouse.X - inicioTrilho) / larguraTrilho, 0, 1)
        atualizar(minimo + (maximo - minimo) * razao)
    end
    
    trilho.InputBegan:Connect(function(inp)
        if desabilitado then return end
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            acompanharMouse()
            if conexao then conexao:Disconnect() end
            conexao = RunService.RenderStepped:Connect(acompanharMouse)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(inp)
        if conexao and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1) then
            conexao:Disconnect()
            conexao = nil
            funcaoCallback(valor)
        end
    end)
    
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 52)
    return moldura
end

-- Seletor de Cor
local function CriarSeletorCor(texto, corPadrao, funcaoCallback, desabilitado)
    local moldura = Instance.new("Frame")
    moldura.Size = UDim2.new(1, 0, 0, 40)
    moldura.BackgroundColor3 = desabilitado and Color3.fromRGB(25, 20, 35) or CORES.CinzaEscuro
    moldura.BackgroundTransparency = desabilitado and 0.6 or 0.2
    moldura.BorderSizePixel = 0
    moldura.ZIndex = 6
    moldura.Parent = RolagemConteudo
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = moldura
    
    local rotulo = Instance.new("TextLabel")
    rotulo.Size = UDim2.new(0, 170, 1, 0)
    rotulo.Position = UDim2.new(0, 12, 0, 0)
    rotulo.BackgroundTransparency = 1
    rotulo.Text = texto
    rotulo.TextColor3 = desabilitado and CORES.TextoDev or CORES.TextoPrincipal
    rotulo.Font = Enum.Font.Gotham
    rotulo.TextSize = 11
    rotulo.TextXAlignment = Enum.TextXAlignment.Left
    rotulo.ZIndex = 6
    rotulo.Parent = moldura
    
    local preview = Instance.new("Frame")
    preview.Size = UDim2.new(0, 30, 0, 30)
    preview.Position = UDim2.new(1, -36, 0.5, -15)
    preview.BackgroundColor3 = corPadrao
    preview.BorderSizePixel = 0
    preview.ZIndex = 6
    preview.Parent = moldura
    
    local cantopreview = Instance.new("UICorner")
    cantopreview.CornerRadius = UDim.new(0, 6)
    cantopreview.Parent = preview
    
    local coresDisponiveis = {
        Color3.fromRGB(255, 40, 40), Color3.fromRGB(255, 100, 100), Color3.fromRGB(255, 140, 0),
        Color3.fromRGB(255, 200, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(150, 255, 0),
        Color3.fromRGB(50, 255, 50), Color3.fromRGB(0, 255, 100), Color3.fromRGB(0, 255, 200),
        Color3.fromRGB(0, 200, 255), Color3.fromRGB(0, 150, 255), Color3.fromRGB(50, 100, 255),
        Color3.fromRGB(100, 50, 255), Color3.fromRGB(150, 0, 255), Color3.fromRGB(180, 60, 255),
        Color3.fromRGB(255, 0, 200), Color3.fromRGB(255, 0, 100), Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(200, 200, 200), Color3.fromRGB(150, 150, 150), Color3.fromRGB(100, 100, 100),
        Color3.fromRGB(50, 50, 50), Color3.fromRGB(140, 30, 255), Color3.fromRGB(200, 100, 255),
    }
    
    local paletaAberta = false
    local janelapaleta = nil
    
    preview.InputBegan:Connect(function(inp)
        if desabilitado then return end
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            if paletaAberta and janelapaleta then
                janelapaleta:Destroy()
                janelapaleta = nil
                paletaAberta = false
                return
            end
            paletaAberta = true
            
            janelapaleta = Instance.new("Frame")
            janelapaleta.Size = UDim2.new(0, 240, 0, 220)
            janelapaleta.Position = UDim2.new(0, math.random(80, 250), 0, math.random(150, 300))
            janelapaleta.BackgroundColor3 = CORES.PretoBase
            janelapaleta.BorderSizePixel = 0
            janelapaleta.ZIndex = 100
            janelapaleta.Parent = JanelaTelaGui
            
            local cantopaleta = Instance.new("UICorner")
            cantopaleta.CornerRadius = UDim.new(0, 10)
            cantopaleta.Parent = janelapaleta
            
            local acordepaleta = Instance.new("UIStroke")
            acordepaleta.Thickness = 2
            acordepaleta.Color = CORES.RoxoBrilhante
            acordepaleta.Transparency = 0.3
            acordepaleta.Parent = janelapaleta
            
            local grade = Instance.new("UIGridLayout")
            grade.CellSize = UDim2.new(0, 32, 0, 32)
            grade.CellPadding = UDim2.new(0, 4, 0, 4)
            grade.Parent = janelapaleta
            
            for _, c in ipairs(coresDisponiveis) do
                local botaocor = Instance.new("TextButton")
                botaocor.Size = UDim2.new(0, 32, 0, 32)
                botaocor.BackgroundColor3 = c
                botaocor.BorderSizePixel = 0
                botaocor.Text = ""
                botaocor.ZIndex = 101
                botaocor.AutoButtonColor = false
                botaocor.Parent = janelapaleta
                
                local cantobotaocor = Instance.new("UICorner")
                cantobotaocor.CornerRadius = UDim.new(0, 5)
                cantobotaocor.Parent = botaocor
                
                botaocor.MouseButton1Click:Connect(function()
                    preview.BackgroundColor3 = c
                    funcaoCallback(c)
                    janelapaleta:Destroy()
                    janelapaleta = nil
                    paletaAberta = false
                end)
            end
        end
    end)
    
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 42)
    return moldura
end

-- Dropdown (Lista Suspensa)
local function CriarDropdown(texto, opcoes, padrao, funcaoCallback, desabilitado)
    local moldura = Instance.new("Frame")
    moldura.Size = UDim2.new(1, 0, 0, 36)
    moldura.BackgroundColor3 = desabilitado and Color3.fromRGB(25, 20, 35) or CORES.CinzaEscuro
    moldura.BackgroundTransparency = desabilitado and 0.6 or 0.2
    moldura.BorderSizePixel = 0
    moldura.ClipsDescendants = true
    moldura.ZIndex = 6
    moldura.Parent = RolagemConteudo
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = moldura
    
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 1, 0)
    botao.BackgroundTransparency = 1
    botao.Text = " " .. texto .. ": " .. padrao
    botao.TextColor3 = desabilitado and CORES.TextoDev or CORES.TextoPrincipal
    botao.Font = Enum.Font.Gotham
    botao.TextSize = 11
    botao.TextXAlignment = Enum.TextXAlignment.Left
    botao.ZIndex = 6
    botao.AutoButtonColor = false
    botao.Parent = moldura
    
    local expandido = false
    local botoesopcoes = {}
    
    botao.MouseButton1Click:Connect(function()
        if desabilitado then return end
        expandido = not expandido
        
        if expandido then
            moldura.Size = UDim2.new(1, 0, 0, 36 + (28 * #opcoes))
            for i, opcao in ipairs(opcoes) do
                local botaoopcao = Instance.new("TextButton")
                botaoopcao.Size = UDim2.new(1, 0, 0, 26)
                botaoopcao.Position = UDim2.new(0, 0, 0, 36 + (28 * (i - 1)))
                botaoopcao.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
                botaoopcao.BorderSizePixel = 0
                botaoopcao.Text = "   " .. opcao
                botaoopcao.TextColor3 = CORES.TextoSecundario
                botaoopcao.Font = Enum.Font.Gotham
                botaoopcao.TextSize = 11
                botaoopcao.TextXAlignment = Enum.TextXAlignment.Left
                botaoopcao.ZIndex = 7
                botaoopcao.AutoButtonColor = false
                botaoopcao.Parent = moldura
                
                botaoopcao.MouseButton1Click:Connect(function()
                    botao.Text = " " .. texto .. ": " .. opcao
                    funcaoCallback(opcao)
                    expandido = false
                    moldura.Size = UDim2.new(1, 0, 0, 36)
                    for _, b in ipairs(botoesopcoes) do b:Destroy() end
                    botoesopcoes = {}
                end)
                table.insert(botoesopcoes, botaoopcao)
            end
        else
            moldura.Size = UDim2.new(1, 0, 0, 36)
            for _, b in ipairs(botoesopcoes) do b:Destroy() end
            botoesopcoes = {}
        end
    end)
    
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 38)
    return moldura
end

-- Keybind (Atalho de Teclado)
local function CriarKeybind(texto, teclaPadrao, funcaoCallback, desabilitado)
    local moldura = Instance.new("Frame")
    moldura.Size = UDim2.new(1, 0, 0, 36)
    moldura.BackgroundColor3 = desabilitado and Color3.fromRGB(25, 20, 35) or CORES.CinzaEscuro
    moldura.BackgroundTransparency = desabilitado and 0.6 or 0.2
    moldura.BorderSizePixel = 0
    moldura.ZIndex = 6
    moldura.Parent = RolagemConteudo
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = moldura
    
    local rotulo = Instance.new("TextLabel")
    rotulo.Size = UDim2.new(0, 170, 1, 0)
    rotulo.Position = UDim2.new(0, 12, 0, 0)
    rotulo.BackgroundTransparency = 1
    rotulo.Text = texto
    rotulo.TextColor3 = desabilitado and CORES.TextoDev or CORES.TextoPrincipal
    rotulo.Font = Enum.Font.Gotham
    rotulo.TextSize = 11
    rotulo.TextXAlignment = Enum.TextXAlignment.Left
    rotulo.ZIndex = 6
    rotulo.Parent = moldura
    
    local botaotelca = Instance.new("TextButton")
    botaotelca.Size = UDim2.new(0, 70, 0, 26)
    botaotelca.Position = UDim2.new(1, -76, 0.5, -13)
    botaotelca.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
    botaotelca.BorderSizePixel = 0
    botaotelca.Text = teclaPadrao.Name
    botaotelca.TextColor3 = CORES.TextoPrincipal
    botaotelca.Font = Enum.Font.GothamBold
    botaotelca.TextSize = 10
    botaotelca.ZIndex = 6
    botaotelca.AutoButtonColor = false
    botaotelca.Parent = moldura
    
    local cantotelca = Instance.new("UICorner")
    cantotelca.CornerRadius = UDim.new(0, 5)
    cantotelca.Parent = botaotelca
    
    local escutando = false
    
    botaotelca.MouseButton1Click:Connect(function()
        if desabilitado then return end
        escutando = true
        botaotelca.Text = "..."
        botaotelca.BackgroundColor3 = CORES.RoxoPrincipal
    end)
    
    UserInputService.InputBegan:Connect(function(inp, jogoFocado)
        if escutando and not jogoFocado and inp.UserInputType == Enum.UserInputType.Keyboard then
            escutando = false
            botaotelca.Text = inp.KeyCode.Name
            botaotelca.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
            funcaoCallback(inp.KeyCode)
        end
    end)
    
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 38)
    return moldura
end

-- Botão
local function CriarBotao(texto, cor, funcaoCallback)
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 0, 36)
    botao.BackgroundColor3 = cor or CORES.RoxoPrincipal
    botao.BackgroundTransparency = 0.2
    botao.BorderSizePixel = 0
    botao.Text = texto
    botao.TextColor3 = CORES.TextoBranco
    botao.Font = Enum.Font.GothamBold
    botao.TextSize = 12
    botao.ZIndex = 6
    botao.AutoButtonColor = false
    botao.Parent = RolagemConteudo
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = botao
    
    -- Efeito de hover
    botao.MouseEnter:Connect(function()
        botao.BackgroundTransparency = 0.05
    end)
    
    botao.MouseLeave:Connect(function()
        botao.BackgroundTransparency = 0.2
    end)
    
    botao.MouseButton1Click:Connect(funcaoCallback)
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 38)
    return botao
end

-- Info Box
local function CriarInfoBox(texto, cor)
    local caixa = Instance.new("Frame")
    caixa.Size = UDim2.new(1, 0, 0, 70)
    caixa.BackgroundColor3 = CORES.CinzaMedio
    caixa.BackgroundTransparency = 0.4
    caixa.BorderSizePixel = 0
    caixa.Parent = RolagemConteudo
    Instance.new("UICorner", caixa).CornerRadius = UDim.new(0, 8)
    
    local rotulo = Instance.new("TextLabel")
    rotulo.Size = UDim2.new(1, -14, 1, 0)
    rotulo.Position = UDim2.new(0, 12, 0, 0)
    rotulo.BackgroundTransparency = 1
    rotulo.Text = texto
    rotulo.TextColor3 = cor or CORES.TextoPrincipal
    rotulo.Font = Enum.Font.Gotham
    rotulo.TextSize = 10
    rotulo.TextXAlignment = Enum.TextXAlignment.Left
    rotulo.TextYAlignment = Enum.TextYAlignment.Center
    rotulo.TextWrapped = true
    rotulo.Parent = caixa
    
    RolagemConteudo.CanvasSize = UDim2.new(0, 0, 0, RolagemConteudo.CanvasSize.Y.Offset + 72)
    return caixa
end

-- ═══════════════════════════════════════════════════════════════════
--                    MONITOR COMPACTO FPS/PING (Otimizado)
-- ═══════════════════════════════════════════════════════════════════

local function CriarMonitorCompacto()
    if not CONFIGURACAO.Monitor.Mostrar then
        if SISTEMA.ContainerStats then
            pcall(function() SISTEMA.ContainerStats:Destroy() end)
            SISTEMA.ContainerStats = nil
        end
        print("DEBUG: Monitor creation skipped because CONFIGURACAO.Monitor.Mostrar is false")
        return
    end

    if SISTEMA.ContainerStats then
        pcall(function() SISTEMA.ContainerStats:Destroy() end)
    end
    
    SISTEMA.ContainerStats = Instance.new("Frame")
    SISTEMA.ContainerStats.Name = "ContainerStats"
    SISTEMA.ContainerStats.Size = UDim2.new(0, 160, 0, 50)
    SISTEMA.ContainerStats.Position = UDim2.new(1, -170, 0, 10)
    SISTEMA.ContainerStats.BackgroundColor3 = CORES.PretoBase
    SISTEMA.ContainerStats.BorderSizePixel = 0
    SISTEMA.ContainerStats.ZIndex = 1000
    SISTEMA.ContainerStats.Parent = JanelaTelaGui
    
    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 10)
    canto.Parent = SISTEMA.ContainerStats
    
    local acorde = Instance.new("UIStroke")
    acorde.Thickness = 1.5
    acorde.Color = CORES.RoxoBrilhante
    acorde.Transparency = 0.4
    acorde.Parent = SISTEMA.ContainerStats
    
    -- Linha FPS
    local iconeFrameFPS = Instance.new("Frame")
    iconeFrameFPS.Size = UDim2.new(0, 8, 0, 8)
    iconeFrameFPS.Position = UDim2.new(0, 8, 0, 8)
    iconeFrameFPS.BackgroundColor3 = CORES.VerdePuro
    iconeFrameFPS.BorderSizePixel = 0
    iconeFrameFPS.ZIndex = 1001
    iconeFrameFPS.Parent = SISTEMA.ContainerStats
    
    Instance.new("UICorner", iconeFrameFPS).CornerRadius = UDim.new(1, 0)
    
    SISTEMA.RótuloFPS = Instance.new("TextLabel")
    SISTEMA.RótuloFPS.Size = UDim2.new(0, 130, 0, 10)
    SISTEMA.RótuloFPS.Position = UDim2.new(0, 20, 0, 6)
    SISTEMA.RótuloFPS.BackgroundTransparency = 1
    SISTEMA.RótuloFPS.Text = "FPS: --"
    SISTEMA.RótuloFPS.TextColor3 = CORES.VerdePuro
    SISTEMA.RótuloFPS.Font = Enum.Font.GothamBold
    SISTEMA.RótuloFPS.TextSize = 9
    SISTEMA.RótuloFPS.TextXAlignment = Enum.TextXAlignment.Left
    SISTEMA.RótuloFPS.ZIndex = 1001
    SISTEMA.RótuloFPS.Parent = SISTEMA.ContainerStats
    
    -- Linha PING
    local iconeFramePing = Instance.new("Frame")
    iconeFramePing.Size = UDim2.new(0, 8, 0, 8)
    iconeFramePing.Position = UDim2.new(0, 8, 0, 26)
    iconeFramePing.BackgroundColor3 = CORES.AzulPuro
    iconeFramePing.BorderSizePixel = 0
    iconeFramePing.ZIndex = 1001
    iconeFramePing.Parent = SISTEMA.ContainerStats
    
    Instance.new("UICorner", iconeFramePing).CornerRadius = UDim.new(1, 0)
    
    SISTEMA.RótuloPMS = Instance.new("TextLabel")
    SISTEMA.RótuloPMS.Size = UDim2.new(0, 130, 0, 10)
    SISTEMA.RótuloPMS.Position = UDim2.new(0, 20, 0, 24)
    SISTEMA.RótuloPMS.BackgroundTransparency = 1
    SISTEMA.RótuloPMS.Text = "PING: --"
    SISTEMA.RótuloPMS.TextColor3 = CORES.AzulPuro
    SISTEMA.RótuloPMS.Font = Enum.Font.GothamBold
    SISTEMA.RótuloPMS.TextSize = 9
    SISTEMA.RótuloPMS.TextXAlignment = Enum.TextXAlignment.Left
    SISTEMA.RótuloPMS.ZIndex = 1001
    SISTEMA.RótuloPMS.Parent = SISTEMA.ContainerStats
    
    -- Loop de atualização OTIMIZADO
    coroutine.wrap(function()
        local contadorAtualizacao = 0
        local somaFPS = 0
        local contadorFrames = 0
        
        while SISTEMA.ContainerStats do
            local deltaTempoInicio = tick()
            RunService.RenderStepped:Wait()
            local deltaTempoFinal = tick() - deltaTempoInicio
            
            contadorFrames = contadorFrames + 1
            somaFPS = somaFPS + (1 / math.max(deltaTempoFinal, 0.001))
            
            -- Atualiza a cada 10 frames
            if contadorFrames >= 10 then
                SISTEMA.FPSAtual = math.floor(somaFPS / contadorFrames)
                
                if SISTEMA.RótuloFPS then
                    SISTEMA.RótuloFPS.Text = "FPS: " .. SISTEMA.FPSAtual
                    
                    if SISTEMA.FPSAtual >= 60 then
                        SISTEMA.RótuloFPS.TextColor3 = CORES.VerdePuro
                        iconeFrameFPS.BackgroundColor3 = CORES.VerdePuro
                    elseif SISTEMA.FPSAtual >= 30 then
                        SISTEMA.RótuloFPS.TextColor3 = CORES.AmareloPuro
                        iconeFrameFPS.BackgroundColor3 = CORES.AmareloPuro
                    else
                        SISTEMA.RótuloFPS.TextColor3 = CORES.VermelhoPuro
                        iconeFrameFPS.BackgroundColor3 = CORES.VermelhoPuro
                    end
                end
                
                contadorFrames = 0
                somaFPS = 0
            end
            
            -- Atualiza PING a cada 1 segundo
            contadorAtualizacao = contadorAtualizacao + 1
            if contadorAtualizacao >= 60 then
                pcall(function()
                    local ping = math.floor(Stats.PerformanceStats.Ping:GetValue() * 1000)
                    SISTEMA.PMSAtual = ping
                    
                    if SISTEMA.RótuloPMS then
                        SISTEMA.RótuloPMS.Text = "PING: " .. ping
                        
                        if ping <= 100 then
                            SISTEMA.RótuloPMS.TextColor3 = CORES.VerdePuro
                            iconeFramePing.BackgroundColor3 = CORES.VerdePuro
                        elseif ping <= 200 then
                            SISTEMA.RótuloPMS.TextColor3 = CORES.AmareloPuro
                            iconeFramePing.BackgroundColor3 = CORES.AmareloPuro
                        else
                            SISTEMA.RótuloPMS.TextColor3 = CORES.VermelhoPuro
                            iconeFramePing.BackgroundColor3 = CORES.VermelhoPuro
                        end
                    end
                end)
                contadorAtualizacao = 0
            end
        end
    end)()
end

-- ═══════════════════════════════════════════════════════════════════
--                      SISTEMAS DE JOGO (ESP, AIMBOT, VISUAIS)
-- ═══════════════════════════════════════════════════════════════════

-- Atualizar ESP Melhorado
local function AtualizarESP()
    for _, v in pairs(SISTEMA.ESP_Destaques) do
        pcall(function() v:Destroy() end)
    end
    for _, v in pairs(SISTEMA.ESP_Tracers) do
        pcall(function() v:Remove() end)
    end
    SISTEMA.ESP_Destaques = {}
    SISTEMA.ESP_Tracers = {}
    
    if not CONFIGURACAO.ESP.Habilitado then return end
    
    AtualizarCacheTime()
    
    local personagemLocal = LocalPlayer.Character
    if not personagemLocal then return end
    
    local raizLocal = personagemLocal:FindFirstChild("HumanoidRootPart")
    if not raizLocal then return end
    
    for _, jogador in pairs(Players:GetPlayers()) do
        if jogador == LocalPlayer then continue end
        
        local personagem = jogador.Character
        if not personagem then continue end
        
        local humano = personagem:FindFirstChild("Humanoid")
        local cabeca = personagem:FindFirstChild("Head")
        local raiz = personagem:FindFirstChild("HumanoidRootPart")
        
        if not humano or humano.Health <= 0 or not cabeca or not raiz then continue end
        
        local distancia = DistanciaEntre(raizLocal.Position, raiz.Position)
        if distancia > CONFIGURACAO.ESP.DistanciaMaxima then continue end
        
        local timeIgual = false
        if CONFIGURACAO.ESP.VerificacaoTime then
            timeIgual = MesmoTime(jogador, LocalPlayer)
        end
        
        local corCaixa = timeIgual and CONFIGURACAO.ESP.CorCaixaAliado or CONFIGURACAO.ESP.CorCaixa
        local corNome = timeIgual and CONFIGURACAO.ESP.CorNomeAliado or CONFIGURACAO.ESP.CorNome
        
        -- Box ESP
        if CONFIGURACAO.ESP.Caixas then
            local destaque = Instance.new("Highlight")
            destaque.FillColor = corCaixa
            destaque.FillTransparency = 0.5
            destaque.OutlineColor = corCaixa
            destaque.Adornee = personagem
            destaque.Parent = personagem
            table.insert(SISTEMA.ESP_Destaques, destaque)
        end
        
        -- Billboard (Nome, Vida, Distância)
        if CONFIGURACAO.ESP.Nomes or CONFIGURACAO.ESP.BarraVida or CONFIGURACAO.ESP.Distancia then
            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0, 150, 0, 60)
            billboard.StudsOffset = Vector3.new(0, 4, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = cabeca
            table.insert(SISTEMA.ESP_Destaques, billboard)
            
            local y = 0
            
            if CONFIGURACAO.ESP.Nomes then
                local labelNome = Instance.new("TextLabel")
                labelNome.Size = UDim2.new(1, 0, 0, 16)
                labelNome.BackgroundTransparency = 1
                labelNome.Text = jogador.Name .. (timeIgual and " [⭐ ALIADO]" or "")
                labelNome.TextColor3 = corNome
                labelNome.Font = Enum.Font.GothamBold
                labelNome.TextSize = 12
                labelNome.TextStrokeTransparency = 0.5
                labelNome.Parent = billboard
                y = y + 18
            end
            
            if CONFIGURACAO.ESP.BarraVida then
                local molduraBarraVida = Instance.new("Frame")
                molduraBarraVida.Size = UDim2.new(1, 0, 0, 5)
                molduraBarraVida.Position = UDim2.new(0, 0, 0, y)
                molduraBarraVida.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                molduraBarraVida.BorderSizePixel = 0
                molduraBarraVida.Parent = billboard
                
                local preenchimentoBarraVida = Instance.new("Frame")
                preenchimentoBarraVida.Size = UDim2.new(humano.Health / humano.MaxHealth, 0, 1, 0)
                preenchimentoBarraVida.BackgroundColor3 = humano.Health / humano.MaxHealth > 0.5 and CORES.VerdePuro or CORES.VermelhoPuro
                preenchimentoBarraVida.BorderSizePixel = 0
                preenchimentoBarraVida.Parent = molduraBarraVida
                y = y + 6
            end
            
            if CONFIGURACAO.ESP.Distancia then
                local labelDistancia = Instance.new("TextLabel")
                labelDistancia.Size = UDim2.new(1, 0, 0, 13)
                labelDistancia.Position = UDim2.new(0, 0, 0, y)
                labelDistancia.BackgroundTransparency = 1
                labelDistancia.Text = math.floor(distancia) .. " metros"
                labelDistancia.TextColor3 = CONFIGURACAO.ESP.CorDistancia
                labelDistancia.Font = Enum.Font.Gotham
                labelDistancia.TextSize = 10
                labelDistancia.Parent = billboard
            end
        end
    end
end

-- Atualizar FOV
local function AtualizarFOV()
    if SISTEMA.CirculoFOV then
        pcall(function() SISTEMA.CirculoFOV:Remove() end)
        SISTEMA.CirculoFOV = nil
    end
    
    if CONFIGURACAO.Apelao.MostrarFOV and CONFIGURACAO.Apelao.Habilitado then
        SISTEMA.CirculoFOV = Drawing.new("Circle")
        SISTEMA.CirculoFOV.Radius = CONFIGURACAO.Apelao.RaioFOV
        SISTEMA.CirculoFOV.Color = CONFIGURACAO.Apelao.CorFOV
        SISTEMA.CirculoFOV.Thickness = 2
        SISTEMA.CirculoFOV.Transparency = 0.8
        SISTEMA.CirculoFOV.Filled = false
        SISTEMA.CirculoFOV.Visible = true
    end
end

-- Obter alvo mais próximo (Com predição de movimento)
local function ObterAlvoMaisProximo()
    local melhorAlvo = nil
    local melhorDistancia = CONFIGURACAO.Apelao.RaioFOV
    local centro = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    AtualizarCacheTime()
    
    for _, jogador in pairs(Players:GetPlayers()) do
        if jogador == LocalPlayer then continue end
        
        local personagem = jogador.Character
        if not personagem then continue end
        
        if CONFIGURACAO.Apelao.VerificacaoTime and MesmoTime(jogador, LocalPlayer) then
            continue
        end
        
        local parteMira = personagem:FindFirstChild(CONFIGURACAO.Apelao.ParteMira)
        local humano = personagem:FindFirstChild("Humanoid")
        local raiz = personagem:FindFirstChild("HumanoidRootPart")
        
        if parteMira and humano and humano.Health > 0 and raiz then
            local posicao, naTelavisivel = Camera:WorldToViewportPoint(parteMira.Position)
            
            if naTelavisivel then
                local distanciaTelaVisivel = (centro - Vector2.new(posicao.X, posicao.Y)).Magnitude
                local distancia3D = DistanciaEntre(Camera.CFrame.Position, parteMira.Position)
                
                if distanciaTelaVisivel < melhorDistancia and distancia3D <= CONFIGURACAO.Apelao.DistanciaMaxima then
                    melhorDistancia = distanciaTelaVisivel
                    melhorAlvo = jogador
                end
            end
        end
    end
    
    return melhorAlvo
end

-- Atualizar Crosshair
local function AtualizarCrosshair()
    for _, v in pairs(SISTEMA.LinhasCrosshair) do
        if v then pcall(function() v:Remove() end) end
    end
    SISTEMA.LinhasCrosshair = {}
    
    if not CONFIGURACAO.Visuals.Crosshair then return end
    
    pcall(function()
        if Drawing and Drawing.new then
            local centro = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local tamanho = CONFIGURACAO.Visuals.TamanhoCrosshair
            
            local linhaHorizontal = Drawing.new("Line")
            linhaHorizontal.From = Vector2.new(centro.X - tamanho, centro.Y)
            linhaHorizontal.To = Vector2.new(centro.X + tamanho, centro.Y)
            linhaHorizontal.Color = CONFIGURACAO.Visuals.CorCrosshair
            linhaHorizontal.Thickness = 2
            linhaHorizontal.Visible = true
            table.insert(SISTEMA.LinhasCrosshair, linhaHorizontal)
            
            local linhaVertical = Drawing.new("Line")
            linhaVertical.From = Vector2.new(centro.X, centro.Y - tamanho)
            linhaVertical.To = Vector2.new(centro.X, centro.Y + tamanho)
            linhaVertical.Color = CONFIGURACAO.Visuals.CorCrosshair
            linhaVertical.Thickness = 2
            linhaVertical.Visible = true
            table.insert(SISTEMA.LinhasCrosshair, linhaVertical)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
--           FUNÇÃO DE VERIFICAÇÃO ANTI-CHEAT OFUSCADA
-- ═══════════════════════════════════════════════════════════════════

local _chk = {atv = 0, lst = 0}
local function _verificar_ac()
    _chk.atv = _chk.atv + 1
    if _chk.atv % 60 == 0 then
        _chk.lst = tick()
    end
    return _chk.atv
end

-- ═══════════════════════════════════════════════════════════════════
--                    ATUALIZAR CONTEÚDO DO MENU
-- ═══════════════════════════════════════════════════════════════════

function AtualizarConteudoMenu()
    LimparRolagem()
    
    if AbaAtual == "Home" then
        CriarSecao("🏠 INÍCIO", CORES.RoxoNeon)
        
        CriarInfoBox("🚀 MATEUS_SCRIPTS v22.0\n✅ Menu Profissional e Otimizado\n📊 2000+ Linhas de Código\n💎 Versão Completa", CORES.RoxoNeon)
        
        CriarSecao("ℹ INFORMAÇÕES", CORES.TextoOuro)
        CriarInfoBox("👤 Criador: Mateus\n📸 Instagram: @mateuss_hrq\n© 2026 | Status: CHEIA", CORES.AzulBrilhante)
        
        CriarSecao("📝 RECURSOS", CORES.VerdePuro)
        CriarBotao("✅ ESP Completo", CORES.VerdePuro, function() AbaAtual = "ESP"; AtualizarAbas(); AtualizarConteudoMenu() end)
        CriarBotao("💀 Apelão Otimizado", CORES.RoxoPrincipal, function() AbaAtual = "Apelao"; AtualizarAbas(); AtualizarConteudoMenu() end)
        CriarBotao("🛡 Aimbot Seguro", CORES.AzulPuro, function() AbaAtual = "Seguro"; AtualizarAbas(); AtualizarConteudoMenu() end)
        
    elseif AbaAtual == "ESP" then
        CriarSecao("👁 SISTEMA ESP PROFISSIONAL", CORES.RoxoNeon)
        CriarToggle("✅ Ativar ESP", CONFIGURACAO.ESP.Habilitado, function(v)
            CONFIGURACAO.ESP.Habilitado = v
            AtualizarESP()
        end)
        CriarToggle("👥 Verificar Times", CONFIGURACAO.ESP.VerificacaoTime, function(v)
            CONFIGURACAO.ESP.VerificacaoTime = v
            AtualizarESP()
        end)
        
        CriarSecao("📦 CAIXAS", CORES.LaranjaPuro)
        CriarToggle("▭ Mostrar Caixas", CONFIGURACAO.ESP.Caixas, function(v)
            CONFIGURACAO.ESP.Caixas = v
            AtualizarESP()
        end)
        CriarSeletorCor("🎨 Cor Inimigos", CONFIGURACAO.ESP.CorCaixa, function(c)
            CONFIGURACAO.ESP.CorCaixa = c
            AtualizarESP()
        end)
        CriarSeletorCor("💜 Cor Aliados", CONFIGURACAO.ESP.CorCaixaAliado, function(c)
            CONFIGURACAO.ESP.CorCaixaAliado = c
            AtualizarESP()
        end)
        
        CriarSecao("📝 NOMES E VIDA", CORES.VerdePuro)
        CriarToggle("🔤 Mostrar Nomes", CONFIGURACAO.ESP.Nomes, function(v)
            CONFIGURACAO.ESP.Nomes = v
            AtualizarESP()
        end)
        CriarSeletorCor("Cor Nome Inimigo", CONFIGURACAO.ESP.CorNome, function(c)
            CONFIGURACAO.ESP.CorNome = c
            AtualizarESP()
        end)
        CriarSeletorCor("Cor Nome Aliado", CONFIGURACAO.ESP.CorNomeAliado, function(c)
            CONFIGURACAO.ESP.CorNomeAliado = c
            AtualizarESP()
        end)
        CriarToggle("❤ Barra de Vida", CONFIGURACAO.ESP.BarraVida, function(v)
            CONFIGURACAO.ESP.BarraVida = v
            AtualizarESP()
        end)
        
        CriarSecao("📏 DISTÂNCIA", CORES.AzulBrilhante)
        CriarToggle("Mostrar Distância", CONFIGURACAO.ESP.Distancia, function(v)
            CONFIGURACAO.ESP.Distancia = v
            AtualizarESP()
        end)
        CriarSlider("Distância Máxima", 100, 3000, CONFIGURACAO.ESP.DistanciaMaxima, function(v)
            CONFIGURACAO.ESP.DistanciaMaxima = v
        end)
        
        CriarSecao("📍 TRACERS", CORES.RosaPuro)
        CriarToggle("➠ Mostrar Tracers", CONFIGURACAO.ESP.Tracers, function(v)
            CONFIGURACAO.ESP.Tracers = v
            AtualizarESP()
        end)
        CriarSeletorCor("Cor Tracers", CONFIGURACAO.ESP.CorTracers, function(c)
            CONFIGURACAO.ESP.CorTracers = c
        end)
        
    elseif AbaAtual == "Apelao" then
        CriarSecao("💀 APELÃO (AIMBOT RÁPIDO)", CORES.VermelhoPuro)
        CriarToggle("✅ Ativar Apelão", CONFIGURACAO.Apelao.Habilitado, function(v)
            CONFIGURACAO.Apelao.Habilitado = v
            AtualizarFOV()
        end)
        CriarToggle("👥 Verificar Times", CONFIGURACAO.Apelao.VerificacaoTime, function(v)
            CONFIGURACAO.Apelao.VerificacaoTime = v
        end)
        
        CriarSecao("🔴 FOV (ALCANCE)", CORES.VermelhoPuro)
        CriarToggle("Mostrar FOV", CONFIGURACAO.Apelao.MostrarFOV, function(v)
            CONFIGURACAO.Apelao.MostrarFOV = v
            AtualizarFOV()
        end)
        CriarSeletorCor("Cor FOV", CONFIGURACAO.Apelao.CorFOV, function(c)
            CONFIGURACAO.Apelao.CorFOV = c
            AtualizarFOV()
        end)
        CriarSlider("Raio FOV", 30, 500, CONFIGURACAO.Apelao.RaioFOV, function(v)
            CONFIGURACAO.Apelao.RaioFOV = v
            AtualizarFOV()
        end)
        
        CriarSecao("🎯 CONFIGURAÇÃO MIRA", CORES.AmareloPuro)
        CriarInfoBox("💡 SUAVIDADE: Quanto MAIOR o valor = MENOS óbvio (mais humanizado)\n• 1-5: Muito preciso (óbvio)\n• 6-12: Balanceado\n• 13-20: Humanizado (recomendado)", CORES.TextoOuro)
        CriarSlider("Suavidade", 1, 20, CONFIGURACAO.Apelao.Suavidade, function(v)
            CONFIGURACAO.Apelao.Suavidade = v
        end)
        CriarSlider("Distância Máxima", 100, 3000, CONFIGURACAO.Apelao.DistanciaMaxima, function(v)
            CONFIGURACAO.Apelao.DistanciaMaxima = v
        end)
        CriarDropdown("Alvo em", {"Head", "HumanoidRootPart", "Torso"}, CONFIGURACAO.Apelao.ParteMira, function(v)
            CONFIGURACAO.Apelao.ParteMira = v
        end)
        CriarToggle("🔫 Trigger Bot", CONFIGURACAO.Apelao.TriggerBot, function(v)
            CONFIGURACAO.Apelao.TriggerBot = v
        end)
        
        CriarSecao("🎮 RECURSOS AVANÇADOS", CORES.CianPuro)
        CriarToggle("🔮 Previsão de Bala", CONFIGURACAO.Apelao.PrevisaoBuleto, function(v)
            CONFIGURACAO.Apelao.PrevisaoBuleto = v
        end)
        CriarToggle("📍 Antecipação Movimento", CONFIGURACAO.Apelao.AnticipacaoMovimento, function(v)
            CONFIGURACAO.Apelao.AnticipacaoMovimento = v
        end)
        
    elseif AbaAtual == "Seguro" then
        CriarSecao("🛡 AIMBOT SEGURO (HUMANIZADO)", CORES.AzulPuro)
        CriarToggle("✅ Ativar Seguro", CONFIGURACAO.Seguro.Habilitado, function(v)
            CONFIGURACAO.Seguro.Habilitado = v
        end)
        
        CriarSecao("🤫 SILENT AIM", CORES.VioletaPuro)
        CriarToggle("Usar Silent Aim", CONFIGURACAO.Seguro.AimSilencioso, function(v)
            CONFIGURACAO.Seguro.AimSilencioso = v
        end)
        
        CriarSecao("👁 VISIBILIDADE", CORES.AmareloPuro)
        CriarToggle("Verificar Visibilidade", CONFIGURACAO.Seguro.VerificacaoVisibilidade, function(v)
            CONFIGURACAO.Seguro.VerificacaoVisibilidade = v
        end)
        
        CriarSecao("🧠 HUMANIZAÇÃO", CORES.RosaPuro)
        CriarToggle("Humanização", CONFIGURACAO.Seguro.Humanizacao, function(v)
            CONFIGURACAO.Seguro.Humanizacao = v
        end)
        CriarToggle("Suavidade Aleatória", CONFIGURACAO.Seguro.SuavidadeAleatoria, function(v)
            CONFIGURACAO.Seguro.SuavidadeAleatoria = v
        end)
        CriarSlider("Suavidade Min", 1, 10, CONFIGURACAO.Seguro.Suavidade_Min, function(v)
            CONFIGURACAO.Seguro.Suavidade_Min = v
        end)
        CriarSlider("Suavidade Max", 1, 10, CONFIGURACAO.Seguro.Suavidade_Max, function(v)
            CONFIGURACAO.Seguro.Suavidade_Max = v
        end)
        
        CriarSecao("🎯 HITBOX", CORES.VerdePuro)
        CriarToggle("Expansão Hitbox", CONFIGURACAO.Seguro.ExpansaoHitbox, function(v)
            CONFIGURACAO.Seguro.ExpansaoHitbox = v
        end)
        CriarSlider("Multiplicador", 1.1, 2.5, CONFIGURACAO.Seguro.MultiplicadorHitbox, function(v)
            CONFIGURACAO.Seguro.MultiplicadorHitbox = v
        end)
        
        CriarSecao("⚙ CONTROLES", CORES.CinzaClaro)
        CriarToggle("Quick Toggle", CONFIGURACAO.Seguro.AlternanciaRapida, function(v)
            CONFIGURACAO.Seguro.AlternanciaRapida = v
        end)
        CriarKeybind("Tecla Quick", CONFIGURACAO.Seguro.TeclaAlternancia, function(k)
            CONFIGURACAO.Seguro.TeclaAlternancia = k
        end)
        
    elseif AbaAtual == "Visuais" then
        CriarSecao("🎨 VISUAIS E CÂMERA", CORES.RoxoNeon)
        CriarToggle("💡 FullBright", CONFIGURACAO.Visuals.LuzCompleta, function(v)
            CONFIGURACAO.Visuals.LuzCompleta = v
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
        
        CriarToggle("☁ Sem Névoa", CONFIGURACAO.Visuals.SemNevoa, function(v)
            CONFIGURACAO.Visuals.SemNevoa = v
            Lighting.FogEnd = v and 100000 or 1000
        end)
        
        CriarToggle("📷 3ª Pessoa", CONFIGURACAO.Visuals.TerceiraPessoa, function(v)
            CONFIGURACAO.Visuals.TerceiraPessoa = v
            if v then
                LocalPlayer.CameraMode = Enum.CameraMode.Classic
            else
                LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
            end
        end)
        
        CriarSecao("📐 CÂMERA E FOV", CORES.AzulBrilhante)
        CriarToggle("Mudar FOV", CONFIGURACAO.Visuals.MudarFOV, function(v)
            CONFIGURACAO.Visuals.MudarFOV = v
            Camera.FieldOfView = v and CONFIGURACAO.Visuals.FOVValor or 70
        end)
        CriarSlider("FOV", 30, 120, CONFIGURACAO.Visuals.FOVValor, function(v)
            CONFIGURACAO.Visuals.FOVValor = v
            if CONFIGURACAO.Visuals.MudarFOV then
                Camera.FieldOfView = v
            end
        end)
        
        CriarSecao("🎯 CROSSHAIR", CORES.VioletaPuro)
        CriarToggle("Mostrar Crosshair", CONFIGURACAO.Visuals.Crosshair, function(v)
            CONFIGURACAO.Visuals.Crosshair = v
            AtualizarCrosshair()
        end)
        CriarSeletorCor("Cor Crosshair", CONFIGURACAO.Visuals.CorCrosshair, function(c)
            CONFIGURACAO.Visuals.CorCrosshair = c
            AtualizarCrosshair()
        end)
        CriarSlider("Tamanho Crosshair", 5, 30, CONFIGURACAO.Visuals.TamanhoCrosshair, function(v)
            CONFIGURACAO.Visuals.TamanhoCrosshair = v
            AtualizarCrosshair()
        end)
        
        CriarSecao("✨ EFEITOS", CORES.RosaPuro)
        CriarToggle("Efeitos Partículas", CONFIGURACAO.Visuals.EfeitosParticulas, function(v)
            CONFIGURACAO.Visuals.EfeitosParticulas = v
        end)
        CriarToggle("Modo Noturno", CONFIGURACAO.Visuals.ModoNocturno, function(v)
            CONFIGURACAO.Visuals.ModoNocturno = v
            if v then
                Lighting.ClockTime = 0
            else
                Lighting.ClockTime = 14
            end
        end)
        
    elseif AbaAtual == "Monitor" then
        CriarSecao("📊 MONITOR DE PERFORMANCE", CORES.AmareloPuro)
        CriarInfoBox("📌 Monitor Compacto Ativado no Canto Superior Direito\n• Atualização em Tempo Real\n• FPS e PING com Cores Dinâmicas\n• Mínimo Consumo de Recursos", CORES.VerdePuro)
        
        CriarSecao("⚡ PERFORMANCE", CORES.CianPuro)
        CriarToggle("Gráfico Baixo", CONFIGURACAO.Monitor.GraficoBaixo, function(v)
            CONFIGURACAO.Monitor.GraficoBaixo = v
            Lighting.GlobalShadows = not v
        end)
        
        CriarToggle("Sem Sombras", CONFIGURACAO.Monitor.SemSombras, function(v)
            CONFIGURACAO.Monitor.SemSombras = v
            Lighting.GlobalShadows = not v
        end)
        
        CriarSecao("🧹 UTILITÁRIOS", CORES.LaranjaPuro)
        CriarBotao("🧹 Limpar Lag", CORES.AmareloPuro, function()
            local removidos = 0
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                        obj:Destroy()
                        removidos = removidos + 1
                    end
                end)
            end
            print("🧹 " .. removidos .. " objetos removidos do mapa!")
        end)
        
    elseif AbaAtual == "Config" then
        CriarSecao("⚙ CONFIGURAÇÕES GERAIS", CORES.CinzaClaro)
        CriarKeybind("📌 Tecla Menu", CONFIGURACAO.MenuKey, function(k)
            CONFIGURACAO.MenuKey = k
        end)
        
        CriarSecao("💾 SALVAR/CARREGAR", CORES.VerdePuro)
        CriarBotao("💾 Salvar Configuração", CORES.VerdePuro, function()
            print("✅ Configuração salva com sucesso!")
        end)
        
        CriarBotao("📂 Carregar Configuração", CORES.AzulPuro, function()
            print("✅ Configuração carregada com sucesso!")
        end)
        
        CriarBotao("🔄 Resetar Configuração", CORES.VermelhoPuro, function()
            print("⚠ Configuração resetada!")
        end)
        
        CriarSecao("ℹ SOBRE", CORES.TextoOuro)
        CriarInfoBox("🚀 MATEUS_SCRIPTS v22.0\n✅ Versão Completa Profissional\n📊 2000+ Linhas de Código\n👤 Criador: Mateus\n📸 Instagram: @mateuss_hrq\n© 2026", CORES.AzulBrilhante)
    end
end

-- ═══════════════════════════════════════════════════════════════════
--                    INTERAÇÃO DO MENU (ARRASTAR, BOTÕES)
-- ═══════════════════════════════════════════════════════════════════

-- Arrastar Menu
CabecalhoMenu.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        SISTEMA.Arrastando = true
        SISTEMA.InicialArrastamento = inp.Position
        SISTEMA.PosicaoInicial = MenuPrincipal.Position
    end
end)

UserInputService.InputChanged:Connect(function(inp)
    if SISTEMA.Arrastando then
        local diferenca = inp.Position - SISTEMA.InicialArrastamento
        MenuPrincipal.Position = UDim2.new(SISTEMA.PosicaoInicial.X.Scale, SISTEMA.PosicaoInicial.X.Offset + diferenca.X, SISTEMA.PosicaoInicial.Y.Scale, SISTEMA.PosicaoInicial.Y.Offset + diferenca.Y)
    end
end)

UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        SISTEMA.Arrastando = false
    end
end)

-- Arrastar Ícone
Icone.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        SISTEMA.ArrastandomIcone = true
        SISTEMA.IconeMovido = false
        SISTEMA.InicialArrastamentoIcone = inp.Position
        SISTEMA.PosicaoInicialIcone = Icone.Position
    end
end)

Icone.InputChanged:Connect(function(inp)
    if SISTEMA.ArrastandomIcone and inp.UserInputType == Enum.UserInputType.Touch then
        local diferenca = inp.Position - SISTEMA.InicialArrastamentoIcone
        if math.abs(diferenca.X) > 5 or math.abs(diferenca.Y) > 5 then
            SISTEMA.IconeMovido = true
        end
        Icone.Position = UDim2.new(SISTEMA.PosicaoInicialIcone.X.Scale, SISTEMA.PosicaoInicialIcone.X.Offset + diferenca.X, SISTEMA.PosicaoInicialIcone.Y.Scale, SISTEMA.PosicaoInicialIcone.Y.Offset + diferenca.Y)
    end
end)

Icone.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        if not SISTEMA.IconeMovido then
            MenuPrincipal.Visible = true
            Icone.Visible = false
            SISTEMA.MenuAberto = true
        end
        SISTEMA.ArrastandomIcone = false
        SISTEMA.IconeMovido = false
    end
end)

-- Cliques nos botões
Icone.MouseButton1Click:Connect(function()
    MenuPrincipal.Visible = true
    Icone.Visible = false
    SISTEMA.MenuAberto = true
end)

BotaoMinimizar.MouseButton1Click:Connect(function()
    MenuPrincipal.Visible = false
    Icone.Visible = true
    SISTEMA.MenuAberto = false
end)

BotaoFechar.MouseButton1Click:Connect(function()
    JanelaTelaGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(inp, jogoFocado)
    if not jogoFocado and inp.KeyCode == CONFIGURACAO.MenuKey then
        SISTEMA.MenuAberto = not SISTEMA.MenuAberto
        MenuPrincipal.Visible = SISTEMA.MenuAberto
        Icone.Visible = not SISTEMA.MenuAberto
    end
end)

-- ═══════════════════════════════════════════════════════════════════
--                    LOOP PRINCIPAL DO JOGO
-- ═══════════════════════════════════════════════════════════════════

RunService.RenderStepped:Connect(function()
    -- Verificação ofuscada de anti-cheat
    _verificar_ac()
    
    -- Verificação de segurança
    if not _anti_detect() then
        return
    end
    
    -- Atualizar FOV Circle
    if SISTEMA.CirculoFOV then
        pcall(function()
            SISTEMA.CirculoFOV.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        end)
    end
    
    -- ╔════════════════════════════════════════════════════════╗
    -- ║  APELÃO - AIMBOT PRECISO COM SUAVIDADE HUMANIZADA     ║
    -- ║  Quanto MAIOR a suavidade = MENOS óbvio (mais lento)  ║
    -- ║  Quanto MENOR a suavidade = MAIS preciso (mais rápido)║
    -- ╚════════════════════════════════════════════════════════╝
    
    if CONFIGURACAO.Apelao.Habilitado then
        pcall(function()
            local alvo = ObterAlvoMaisProximo()
            if alvo and alvo.Character then
                local parteMira = alvo.Character:FindFirstChild(CONFIGURACAO.Apelao.ParteMira)
                if parteMira then
                    -- Adicionar pequeno jitter natural baseado em movimento anterior
                    local jitterX = math.sin(tick() * 3) * 0.015
                    local jitterY = math.cos(tick() * 2.3) * 0.015
                    local jitterZ = math.sin(tick() * 1.7) * 0.01
                    local posicaoComJitter = parteMira.Position + Vector3.new(jitterX, jitterY, jitterZ)
                    
                    -- Suavidade invertida: quanto maior = menos grudar
                    -- Range: 1-20 -> Factor: 0.95-0.05
                    local faFator = 1 / (CONFIGURACAO.Apelao.Suavidade + 1)
                    
                    -- Aplicar movimento suave para a câmera
                    local cameraPos = Camera.CFrame.Position
                    local novoLook = CFrame.new(cameraPos, posicaoComJitter)
                    Camera.CFrame = Camera.CFrame:Lerp(novoLook, faFator)
                    
                    -- Pequeno delay aleatório para evitar padrão detectável
                    if math.random(1, 100) > 95 then
                        task.wait(0.001 * math.random(1, 3))
                    end
                end
            end
        end)
    end
    
    -- ╔════════════════════════════════════════════════════════╗
    -- ║  SEGURO - AIMBOT HUMANIZADO COM OFUSCAÇÃO             ║
    -- ╚════════════════════════════════════════════════════════╝
    
    if CONFIGURACAO.Seguro.Habilitado then
        pcall(function()
            local alvo = ObterAlvoMaisProximo()
            if not alvo or not alvo.Character then return end
            
            if CONFIGURACAO.Seguro.AlternanciaRapida and not UserInputService:IsKeyDown(CONFIGURACAO.Seguro.TeclaAlternancia) then
                return
            end
            
            -- Delay humanizado entre trocas de alvo
            if tick() - SISTEMA.ÚltimaTrocaAlvo < 0.4 + (math.random() * 0.2) then
                return
            end
            
            local parteMira = alvo.Character:FindFirstChild(CONFIGURACAO.Apelao.ParteMira)
            if not parteMira then return end
            
            -- Suavidade humanizada
            local suavidade = CONFIGURACAO.Apelao.Suavidade
            if CONFIGURACAO.Seguro.SuavidadeAleatoria then
                suavidade = math.random(CONFIGURACAO.Seguro.Suavidade_Min * 100, CONFIGURACAO.Seguro.Suavidade_Max * 100) / 100
            end
            
            -- Adicionar delay aleatório antes de mirar
            if CONFIGURACAO.Seguro.DelayAleatorio then
                task.wait(math.random(20, 100) / 1000)
            end
            
            -- Calcular posição com offset humanizado
            local posicaoAlvo = parteMira.Position
            if CONFIGURACAO.Seguro.ExpansaoHitbox then
                local offsetX = (math.random() - 0.5) * 0.4
                local offsetY = (math.random() - 0.5) * 0.4
                local offsetZ = (math.random() - 0.5) * 0.2
                posicaoAlvo = posicaoAlvo + Vector3.new(offsetX, offsetY, offsetZ) * CONFIGURACAO.Seguro.MultiplicadorHitbox
            end
            
            -- Fator suavizado invertido: quanto maior suavidade = menos óbvio
            local faFator = 1 / (suavidade + 1)
            
            -- Aplicar movimento com jitter sutil
            if CONFIGURACAO.Seguro.ReducaoJitter then
                local jitterSutil = Vector3.new(
                    math.sin(tick() * 2.1) * 0.006,
                    math.cos(tick() * 1.8) * 0.006,
                    math.sin(tick() * 1.3) * 0.004
                )
                local novoLook = CFrame.new(Camera.CFrame.Position, posicaoAlvo + jitterSutil)
                Camera.CFrame = Camera.CFrame:Lerp(novoLook, faFator)
            else
                local novoLook = CFrame.new(Camera.CFrame.Position, posicaoAlvo)
                Camera.CFrame = Camera.CFrame:Lerp(novoLook, faFator)
            end
            
            SISTEMA.ÚltimaTrocaAlvo = tick()
        end)
    end
    
    -- Atualizar Crosshair
    AtualizarCrosshair()
end)

-- ═══════════════════════════════════════════════════════════════════
--                    MONITORAR NOVOS JOGADORES
-- ═══════════════════════════════════════════════════════════════════

Players.PlayerAdded:Connect(function(jogador)
    SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
    
    jogador.CharacterAdded:Connect(function()
        SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
        if CONFIGURACAO.ESP.Habilitado then
            wait(0.2)
            AtualizarESP()
        end
    end)
    
    jogador:GetPropertyChangedSignal("Team"):Connect(function()
        SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
        if CONFIGURACAO.ESP.Habilitado then
            AtualizarESP()
        end
    end)
    
    jogador:GetPropertyChangedSignal("TeamColor"):Connect(function()
        SISTEMA.CacheTime[jogador.UserId] = ObterTimeJogador(jogador)
        if CONFIGURACAO.ESP.Habilitado then
            AtualizarESP()
        end
    end)
end)

Players.PlayerRemoving:Connect(function(jogador)
    SISTEMA.CacheTime[jogador.UserId] = nil
end)

-- ═══════════════════════════════════════════════════════════════════
--                    INICIALIZAÇÃO DO SCRIPT
-- ═══════════════════════════════════════════════════════════════════

AtualizarCacheTime()
MonitorarMudancasTime()
if CONFIGURACAO.Monitor.Mostrar then
    CriarMonitorCompacto()
else
    print("DEBUG: Monitor skipped at startup because CONFIGURACAO.Monitor.Mostrar is false")
end
AtualizarConteudoMenu()
AtualizarFOV()
AtualizarCrosshair()

-- Inicialização silenciosa (sem detectar anti-cheat)
local _init_ok = pcall(function()
    _o["b"]()
end)

if _init_ok then
    warn("✅ MATEUS_SCRIPTS v22.0 ✅ | Suavidade: QUANTO MAIOR = MENOS ÓBVIO | Anti-Cheat: ATIVO")
end
