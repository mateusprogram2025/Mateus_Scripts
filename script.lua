-- TESTE MÍNIMO - Mateus_Scripts
print("🔵 INICIANDO TESTE...")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("✅ Serviços carregados")
print("👤 Jogador:", LocalPlayer.Name)

-- Criar GUI simples
local gui = Instance.new("ScreenGui")
gui.Name = "Mateus_Teste"
gui.Parent = PlayerGui
print("✅ ScreenGui criado")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
frame.Parent = gui
print("✅ Frame criado")

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "✅ MATEUS_SCRIPTS - TESTE OK!"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame
print("✅ Título criado")

print("✅✅✅ TESTE CONCLUÍDO - Se você vê um quadrado roxo com texto verde, a base funciona!")
