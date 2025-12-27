-- [[ LoreTCS - PENALTY SUPREME MODE ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LoreTCS Penalty ⚽",
   LoadingTitle = "Injetando Supreme Hub...",
   LoadingSubtitle = "by LoreTcs",
   ConfigurationSaving = { Enabled = false }
})

-- VARIAVEIS
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local savedGoalPos = nil
local magnetEnabled = false
local isStriking = false

-- 1. BUSCA A BOLA
local function FindTPS()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name == "TPS" or v.Name == "Ball") then
            return v
        end
    end
    return nil
end

-- 2. FUNÇÃO "FOI EU QUE MARQUEI" (CLAIM OWNER)
local function ClaimOwner(ball)
    local char = player.Character
    if ball and char and char:FindFirstChild("HumanoidRootPart") then
        -- Simula o toque para o jogo registrar seu ID
        firetouchinterest(ball, char.HumanoidRootPart, 0)
        task.wait(0.02)
        firetouchinterest(ball, char.HumanoidRootPart, 1)
    end
end

-- 3. SISTEMA DE MOVIMENTAÇÃO (RUNSERVICE)
local function MoverAteOGol()
    local ball = FindTPS()
    if not ball or not savedGoalPos then 
        Rayfield:Notify({Title = "Aviso", Content = "Marque o gol primeiro, rlk!", Duration = 3})
        return 
    end

    if isStriking then return end
    isStriking = true

    -- Garante que o gol seja seu antes de começar a andar
    ClaimOwner(ball)

    local conexao
    local speed = 150

    conexao = RunService.Heartbeat:Connect(function(dt)
        if not ball or not ball.Parent or not isStriking then
            if conexao then conexao:Disconnect() end
            isStriking = false
            return
        end

        local distance = (savedGoalPos - ball.Position).Magnitude
        local direction = (savedGoalPos - ball.Position).Unit

        if distance > 3 then
            -- A bola anda sozinha sem teleportar
            ball.Velocity = direction * speed
            ball.CFrame = ball.CFrame + (direction * speed * dt)
        else
            -- Gol concluído
            ball.Position = savedGoalPos
            ball.Velocity = Vector3.new(0,0,0)
            isStriking = false
            conexao:Disconnect()
            Rayfield:Notify({Title = "GOOOL!", Content = "Marcado em seu nome, man!", Duration = 2})
        end
    end)
end

-- 4. LÓGICA DO CHUTE MAGNÉTICO (PASSIVO)
RunService.Heartbeat:Connect(function()
    if magnetEnabled and savedGoalPos and not isStriking then
        local ball = FindTPS()
        if ball and ball.Velocity.Magnitude > 2 then
            local direction = (savedGoalPos - ball.Position).Unit
            ball.Velocity = direction * 130
        end
    end
end)

-- 5. ABAS DO MENU
local TabMain = Window:CreateTab("⚽ Funções", 4483345998)

TabMain:CreateButton({
   Name = "1. Marcar Posição do Gol",
   Callback = function()
       savedGoalPos = player.Character.HumanoidRootPart.Position
       Rayfield:Notify({Title = "Sucesso", Content = "Posição salva!", Duration = 2})
   end,
})

TabMain:CreateButton({
   Name = "2. Auto-Strike (Bola vai sozinha)",
   Info = "Faz a bola andar até o gol e registra você como dono",
   Callback = function()
       MoverAteOGol()
   end,
})

TabMain:CreateToggle({
   Name = "Chute Magnético (AimBot)",
   CurrentValue = false,
   Callback = function(Value)
       magnetEnabled = Value
   end,
})

local TabProt = Window:CreateTab("🛡️ Proteção", 4483345998)

TabProt:CreateButton({
   Name = "Ativar Proteção de Kick",
   Callback = function()
       hookfunction(player.Kick, newcclosure(function() return nil end))
       Rayfield:Notify({Title = "Protegido", Content = "Anti-Kick ativo!", Duration = 5})
   end,
})

Rayfield:Notify({
   Title = "LoreTCS Supreme",
   Content = "Script pronto pra dominar, rlk!",
   Duration = 5,
})
