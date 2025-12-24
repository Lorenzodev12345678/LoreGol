-- [[ LoreTCS - PENALTY GOD MODE (MAGNETIC KICK) ]]
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Lorenzodev12345678/LoreTcs/refs/heads/main/main.lua"))()

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local savedGoalPos = nil
local magnetEnabled = false

-- [[ BUSCA A BOLA ]]
local function FindTPS()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name == "TPS" or v.Name == "Ball") then
            return v
        end
    end
    return nil
end

-- [[ LÓGICA DO CHUTE MAGNÉTICO ]]
RunService.Heartbeat:Connect(function()
    if magnetEnabled and savedGoalPos then
        local ball = FindTPS()
        -- Só ativa se a bola estiver se movendo (você ou alguém chutou)
        if ball and ball.Velocity.Magnitude > 2 then
            local direction = (savedGoalPos - ball.Position).Unit
            -- Aplica uma força suave mas certeira pro gol
            ball.Velocity = direction * 120 -- Velocidade do chute "perfeito"
        end
    end
end)

-- [[ INTERFACE ]]
if pgui:FindFirstChild("LorePenalty_Hub") then pgui:FindFirstChild("LorePenalty_Hub"):Destroy() end
local sg = Instance.new("ScreenGui", pgui)
sg.Name = "LorePenalty_Hub"

local MainFrame = Instance.new("Frame", sg)
MainFrame.Size = UDim2.new(0, 250, 0, 220)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true; MainFrame.Draggable = true; Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 100)

local function AddBtn(text, pos, col, fn)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = pos; b.Text = text
    b.BackgroundColor3 = col; b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() fn(b) end)
end

-- 1. MARCAR ONDE É O GOL
AddBtn("1. MARCAR GOL AQUI", UDim2.new(0.05, 0, 0.1, 0), Color3.fromRGB(30, 30, 30), function(btn)
    savedGoalPos = player.Character.HumanoidRootPart.Position
    btn.Text = "POSIÇÃO SALVA! rlk"
    task.wait(1)
    btn.Text = "1. MARCAR GOL AQUI"
end)

-- 2. ATIVAR O PÊNALTI INFALÍVEL
AddBtn("PÊNALTI: OFF", UDim2.new(0.05, 0, 0.4, 0), Color3.fromRGB(200, 0, 0), function(btn)
    magnetEnabled = not magnetEnabled
    btn.Text = magnetEnabled and "PÊNALTI: ATIVADO" or "PÊNALTI: OFF"
    btn.BackgroundColor3 = magnetEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(200, 0, 0)
end)

-- 3. ANTI-KICK
AddBtn("DESATIVAR KICK (PROTEÇÃO)", UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(80, 80, 80), function(btn)
    hookfunction(player.Kick, newcclosure(function() return nil end))
    btn.Text = "KICK BLOQUEADO! rbx"
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end)
