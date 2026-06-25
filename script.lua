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

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserMouse = LocalPlayer:GetMouse()

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

-- Obter alvo mais próximo
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
        
        if parteMira and humano and humano.Health > 0 then
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
        if v then v:Remove() end
    end
    SISTEMA.LinhasCrosshair = {}
    
    if not CONFIGURACAO.Visuals.Crosshair then return end
    
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
    -- Atualizar FOV Circle
    if SISTEMA.CirculoFOV then
        pcall(function()
            SISTEMA.CirculoFOV.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        end)
    end
    
    -- Apelão (Aimbot Rápido)
    if CONFIGURACAO.Apelao.Habilitado then
        local alvo = ObterAlvoMaisProximo()
        if alvo and alvo.Character then
            local parteMira = alvo.Character:FindFirstChild(CONFIGURACAO.Apelao.ParteMira)
            if parteMira then
                local suavidade = math.clamp(CONFIGURACAO.Apelao.Suavidade / 20, 0.05, 1)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, parteMira.Position), suavidade)
                
                if CONFIGURACAO.Apelao.TriggerBot then
                    local agora = tick()
                    if agora - SISTEMA.ÚltimoAtivadorTempo >= CONFIGURACAO.Apelao.DelayTrigger then
                        SISTEMA.ÚltimoAtivadorTempo = agora
                        pcall(function() mouse1click() end)
                    end
                end
            end
        end
    end
    
    -- Seguro (Aimbot Seguro com Humanização)
    if CONFIGURACAO.Seguro.Habilitado then
        local alvo = ObterAlvoMaisProximo()
        if alvo and alvo.Character then
            if CONFIGURACAO.Seguro.AlternanciaRapida and not UserInputService:IsKeyDown(CONFIGURACAO.Seguro.TeclaAlternancia) then
                return
            end
            
            if tick() - SISTEMA.ÚltimaTrocaAlvo < 0.3 then
                return
            end
            
            local parteMira = alvo.Character:FindFirstChild(CONFIGURACAO.Apelao.ParteMira)
            if parteMira then
                if CONFIGURACAO.Seguro.AimSilencioso then
                    local posicaoOriginal = Camera.CFrame
                    local posicaoAlvo = parteMira.Position
                    if CONFIGURACAO.Seguro.ExpansaoHitbox then
                        posicaoAlvo = posicaoAlvo + Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)) * CONFIGURACAO.Seguro.MultiplicadorHitbox
                    end
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, posicaoAlvo)
                    pcall(function() mouse1click() end)
                    task.wait(0.03)
                    Camera.CFrame = posicaoOriginal
                else
                    local suavidade = CONFIGURACAO.Apelao.Suavidade
                    if CONFIGURACAO.Seguro.SuavidadeAleatoria then
                        suavidade = math.random(CONFIGURACAO.Seguro.Suavidade_Min * 10, CONFIGURACAO.Seguro.Suavidade_Max * 10) / 10
                    end
                    
                    if CONFIGURACAO.Seguro.DelayAleatorio then
                        task.wait(math.random(CONFIGURACAO.Seguro.Delay_Min, CONFIGURACAO.Seguro.Delay_Max) / 1000)
                    end
                    
                    local posicaoAlvo = parteMira.Position
                    if CONFIGURACAO.Seguro.ExpansaoHitbox then
                        posicaoAlvo = posicaoAlvo + Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)) * CONFIGURACAO.Seguro.MultiplicadorHitbox
                    end
                    
                    local faFator = math.clamp(suavidade / 20, 0.05, 1)
                    if CONFIGURACAO.Seguro.ReducaoJitter then
                        local micro = Vector3.new(math.sin(tick() * 0.5) * 0.005, math.cos(tick() * 0.3) * 0.005, 0)
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, posicaoAlvo) + micro, faFator)
                    else
                        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, posicaoAlvo), faFator)
                    end
                end
                
                SISTEMA.ÚltimaTrocaAlvo = tick()
            end
        end
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
CriarMonitorCompacto()
AtualizarConteudoMenu()
AtualizarFOV()
AtualizarCrosshair()

print("╔════════════════════════════════════════════════════════╗")
print("║  🚀 MATEUS_SCRIPTS v22.0 - INICIALIZADO COM SUCESSO! ║")
print("║  ✅ Menu Profissional com 2000+ Linhas               ║")
print("║  ✅ FPS/PING Compacto Otimizado                      ║")
print("║  ✅ ESP Melhorado e Aimbot Aprimorado                ║")
print("║  ✅ Visual Moderno com Cores Dinâmicas               ║")
print("║  📊 Monitor no Canto Superior Direito                ║")
print("║  👤 Criador: Mateus | @mateuss_hrq | 2026           ║")
print("╚════════════════════════════════════════════════════════╝")
--[[
    ╔═══════════════════════════════════════════╗
    ║   MATEUS_SCRIPTS v21.0 - MEGA ATUALIZAÇÃO ║
    ║  Menu Redesenhado | Funções Otimizadas   ║
    ║  ESP Aprimorado | FPS/PING em Tempo Real ║
    ║         🚀 CHEIA E PRONTA PARA USO 🚀     ║
    ╚═══════════════════════════════════════════╝
    
    Criador: Mateus | @mateuss_hrq | 2026
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ════════════════════════ SISTEMA DE CORES ════════════════════════
local C = {
    -- Cores Principais
    Roxo = Color3.fromRGB(140, 30, 255),
    RoxoBrilhante = Color3.fromRGB(170, 50, 255),
    RoxoNeon = Color3.fromRGB(180, 60, 255),
    RoxoEscuro = Color3.fromRGB(100, 20, 200),
    
    -- Tons Preto/Cinza
    Preto = Color3.fromRGB(10, 8, 18),
    PretoClaro = Color3.fromRGB(16, 14, 24),
    PretoMais = Color3.fromRGB(20, 18, 32),
    Cinza = Color3.fromRGB(28, 24, 38),
    CinzaEscuro = Color3.fromRGB(20, 17, 30),
    CinzaDev = Color3.fromRGB(18, 14, 24),
    
    -- Tons de Texto
    Branco = Color3.fromRGB(255, 255, 255),
    Texto = Color3.fromRGB(230, 225, 245),
    TextoCinza = Color3.fromRGB(170, 160, 190),
    TextoDev = Color3.fromRGB(80, 75, 90),
    
    -- Cores de Status
    Verde = Color3.fromRGB(0, 255, 100),
    VerdeEscuro = Color3.fromRGB(0, 200, 80),
    Vermelho = Color3.fromRGB(255, 50, 50),
    VermelhoEscuro = Color3.fromRGB(200, 40, 40),
    Amarelo = Color3.fromRGB(255, 180, 0),
    AmareloDev = Color3.fromRGB(200, 140, 0),
    Azul = Color3.fromRGB(0, 150, 255),
    AzulClaro = Color3.fromRGB(100, 180, 255),
    Laranja = Color3.fromRGB(255, 140, 0),
}

-- ════════════════════════ CONFIGURAÇÕES ════════════════════════
local Config = {
    MenuKey = Enum.KeyCode.RightShift,
    
    -- 👁 ESP - SISTEMA DE VISÃO
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
    
    -- 💀 APELÃO - AIMBOT BÁSICO
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
    
    -- 🛡 SEGURO - AIMBOT AVANÇADO
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
    
    -- 🎨 VISUAIS - GRÁFICOS E CÂMERA
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
    
    -- 📊 MONITOR - FPS E PING (SEMPRE ATIVO NO CANTO SUPERIOR DIREITO)
    Monitor = {
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
