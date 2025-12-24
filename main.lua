-- [[ LoreTCS - PENALTY GOD MODE (MAGNETIC KICK) - RAYFIELD EDITION ]] --

-- 1. CARREGANDO INTERFACE PREMIUM
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LoreTCS Penalty ⚽",
   LoadingTitle = "Injetando Magnetic Kick...",
   LoadingSubtitle = "by LoreTcs",
   ConfigurationSaving = { Enabled = false }
})

-- VARIAVEIS
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local savedGoalPos = nil
local magnetEnabled = false

-- 2. BUSCA A BOLA
local function FindTPS()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name == "TPS" or v.Name == "Ball") then
            return v
        end
    end
    return nil
end

-- 3. LÓGICA DO CHUTE MAGNÉTICO (HEARTBEAT)
RunService.Heartbeat:Connect(function()
    if magnetEnabled and savedGoalPos then
        local ball = FindTPS()
        -- Só ativa se a bola estiver se movendo (você ou alguém chutou)
        if ball and ball.Velocity.Magnitude > 2 then
            local direction = (savedGoalPos - ball.Position).Unit
            -- Aplica uma força certeira pro gol
            ball.Velocity = direction * 120 
        end
    end
end)

-- 4. ABAS DO MENU
local TabMain = Window:CreateTab("⚽ Penalty", 4483345998)
local Section = TabMain:CreateSection("Funções Magnéticas")

TabMain:CreateButton({
   Name = "1. Marcar Posição do Gol",
   Info = "Fique dentro do gol e clique aqui para salvar a mira do ímã",
   Callback = function()
       savedGoalPos = player.Character.HumanoidRootPart.Position
       Rayfield:Notify({
          Title = "Mira Salva!",
          Content = "O chute agora vai ser atraído para cá, rlk!",
          Duration = 3,
          Image = 4483345998,
       })
   end,
})

TabMain:CreateToggle({
   Name = "Chute Magnético (AimBot)",
   Info = "Faz a bola curvar direto pro gol quando você chuta",
   CurrentValue = false,
   Callback = function(Value)
       magnetEnabled = Value
       local status = Value and "Ativado" or "Desativado"
       Rayfield:Notify({Title = "Magneto", Content = "Chute Magnético: " .. status, Duration = 2})
   end,
})

local TabProt = Window:CreateTab("🛡️ Proteção", 4483345998)

TabProt:CreateButton({
   Name = "Bloquear Kick do Servidor",
   Info = "Evita que o jogo te expulse por suspeita de hack",
   Callback = function()
       hookfunction(player.Kick, newcclosure(function() return nil end))
       Rayfield:Notify({Title = "Protegido", Content = "Sistema de Kick desativado, man!", Duration = 5})
   end,
})

-- NOTIFICAÇÃO DE ENTRADA
Rayfield:Notify({
   Title = "Executado!",
   Content = "Penalty Hub carregado na relíquia!",
   Duration = 5,
   Image = 4483345998,
})
