--🎯 Aimbot em Desenvolvimento!
--🚀 Em breve estará GRÁTIS para vocês!
--🔗 Mais informações no nosso Discord: https://discord.gg/dsEjcjTmtP

--[[
Painel Universal Avançado para Roblox (PC & Mobile)

EM    TESTE
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Detecta tipo de dispositivo
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Cores do tema: Amarelo e Preto
local corPrimaria = Color3.fromRGB(255, 255, 0)  -- Amarelo
local corSecundaria = Color3.fromRGB(0, 0, 0)    -- Preto
local corFundo = Color3.fromRGB(30, 30, 30)      -- Cinza escuro para fundo
local corTexto = Color3.fromRGB(255, 255, 255)   -- Branco para texto
local corInativo = Color3.fromRGB(100, 100, 100) -- Cinza para inativo

-- Funções utilitárias
local function createCorner(obj, rad)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, rad)
    c.Parent = obj
end

local function createGradient(obj, color1, color2)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    }
    g.Rotation = 90
    g.Parent = obj
end

local function animarTween(obj, props, tempo, estilo)
    TweenService:Create(obj, TweenInfo.new(tempo or 0.3, estilo or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Sistema de Key
local gui = Instance.new("ScreenGui")
gui.Name = "PainelUniversalAvancado"
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0.8, 0, 0.3, 0)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.BackgroundColor3 = corFundo
keyFrame.Visible = true
createCorner(keyFrame, 16)
createGradient(keyFrame, corPrimaria, corSecundaria)

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0.3, 0)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Digite a Key para Liberar o Painel"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 24
keyTitle.TextColor3 = corTexto

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0.2, 0)
keyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
keyBox.BackgroundColor3 = corSecundaria
keyBox.Text = ""
keyBox.Font = Enum.Font.GothamBold
keyBox.PlaceholderText = "Insira a key aqui..."
keyBox.TextColor3 = corPrimaria
keyBox.TextSize = 20
createCorner(keyBox, 10)

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
keyBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
keyBtn.BackgroundColor3 = corPrimaria
keyBtn.Text = "Liberar Painel"
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextColor3 = corTexto
keyBtn.TextSize = 20
createCorner(keyBtn, 10)

local keyWarn = Instance.new("TextLabel", keyFrame)
keyWarn.Size = UDim2.new(1, 0, 0.1, 0)
keyWarn.Position = UDim2.new(0, 0, 0.9, 0)
keyWarn.BackgroundTransparency = 1
keyWarn.Text = ""
keyWarn.Font = Enum.Font.Gotham
keyWarn.TextColor3 = Color3.fromRGB(255, 80, 80)
keyWarn.TextSize = 16

local function showWarn(msg)
    keyWarn.Text = msg
end

local painelLiberado = false

keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "DODIDEIYUCHEATS" then
        painelLiberado = true
        animarTween(keyFrame, {Transparency = 1}, 0.5)
        keyFrame.Visible = false
    else
        showWarn("Key incorreta! Tente novamente.")
    end
end)

keyBox.FocusLost:Connect(function()
    keyWarn.Text = ""
end)

-- Espera key antes de liberar painel
while not painelLiberado do
    RunService.RenderStepped:Wait()
end

-- Painel Responsivo PC/Mobile
local main, optionsFrame, toggleBtn, aimbotToggleBtn
local function setupPC()
    -- Painel PC
    main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 420, 0, 620)
    main.Position = UDim2.new(0.5, -210, 0.5, -310)
    main.BackgroundColor3 = corFundo
    main.BorderSizePixel = 0
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Active = true
    main.Draggable = true
    main.Transparency = 0
    createCorner(main, 20)
    createGradient(main, corPrimaria, corSecundaria)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 54)
    title.Text = "Painel Universal Avançado [PC]"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 32
    title.TextColor3 = corTexto
    title.BackgroundTransparency = 1

    optionsFrame = Instance.new("ScrollingFrame", main)
    optionsFrame.Size = UDim2.new(1, -24, 1, -80)
    optionsFrame.Position = UDim2.new(0, 12, 0, 68)
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)  -- Aumentado para mais opções
    optionsFrame.ScrollBarThickness = 6
    optionsFrame.BorderSizePixel = 0

    toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 68, 0, 36)
    toggleBtn.Position = UDim2.new(1, -84, 1, -52)
    toggleBtn.AnchorPoint = Vector2.new(0, 1)
    toggleBtn.BackgroundColor3 = corPrimaria
    toggleBtn.Text = "Painel"
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 22
    toggleBtn.TextColor3 = corTexto
    toggleBtn.ZIndex = 20
    createCorner(toggleBtn, 12)
    main.Visible = false

    toggleBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        if main.Visible then
            animarTween(main, {Transparency = 0, Position = UDim2.new(0.5, -main.Size.X.Offset/2, 0.5, -main.Size.Y.Offset/2)})
        else
            animarTween(main, {Transparency = 1})
        end
    end)
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.P then
            toggleBtn.MouseButton1Click:Invoke()
        end
    end)

    -- Botão para ativar/desativar Aimbot diretamente
    aimbotToggleBtn = Instance.new("TextButton", gui)
    aimbotToggleBtn.Size = UDim2.new(0, 68, 0, 36)
    aimbotToggleBtn.Position = UDim2.new(1, -84, 1, -92)
    aimbotToggleBtn.AnchorPoint = Vector2.new(0, 1)
    aimbotToggleBtn.BackgroundColor3 = corPrimaria
    aimbotToggleBtn.Text = "Aimbot Off"
    aimbotToggleBtn.Font = Enum.Font.GothamBold
    aimbotToggleBtn.TextSize = 22
    aimbotToggleBtn.TextColor3 = corTexto
    aimbotToggleBtn.ZIndex = 20
    createCorner(aimbotToggleBtn, 12)

    aimbotToggleBtn.MouseButton1Click:Connect(function()
        _G.Aimbot = not _G.Aimbot
        aimbotToggleBtn.Text = _G.Aimbot and "Aimbot On" or "Aimbot Off"
        aimbotToggleBtn.BackgroundColor3 = _G.Aimbot and corPrimaria or corInativo
    end)
end

local function setupMobile()
    -- Painel Mobile (side panel)
    main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0.95, 0, 0.95, 0)  -- Ajustado para telas mobile
    main.Position = UDim2.new(1, 0, 0.025, 0)  -- Começa fora da tela para animação slide
    main.BackgroundColor3 = corFundo
    main.AnchorPoint = Vector2.new(1, 0)
    main.BorderSizePixel = 0
    main.Active = true
    main.Visible = true
    main.Transparency = 0
    createCorner(main, 28)
    createGradient(main, corPrimaria, corSecundaria)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 56)
    title.Text = "Painel Universal Avançado [Mobile]"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 28
    title.TextColor3 = corTexto
    title.BackgroundTransparency = 1

    optionsFrame = Instance.new("ScrollingFrame", main)
    optionsFrame.Size = UDim2.new(1, -24, 1, -80)
    optionsFrame.Position = UDim2.new(0, 12, 0, 68)
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.CanvasSize = UDim2.new(0, 0, 0, 2500)  -- Aumentado para mais opções
    optionsFrame.ScrollBarThickness = 12
    optionsFrame.BorderSizePixel = 0

    toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0.2, 0, 0.1, 0)
    toggleBtn.Position = UDim2.new(0.8, 0, 0.9, 0)
    toggleBtn.AnchorPoint = Vector2.new(0, 1)
    toggleBtn.BackgroundColor3 = corPrimaria
    toggleBtn.Text = "Abrir"
    toggleBtn.Font = Enum.Font.GothamBlack
    toggleBtn.TextSize = 30
    toggleBtn.TextColor3 = corTexto
    toggleBtn.ZIndex = 20
    createCorner(toggleBtn, 18)

    toggleBtn.MouseButton1Click:Connect(function()
        if main.Position.X.Scale == 1 then
            animarTween(main, {Position = UDim2.new(0.05, 0, 0.025, 0)})  -- Slide in
            toggleBtn.Text = "Fechar"
        else
            animarTween(main, {Position = UDim2.new(1, 0, 0.025, 0)})  -- Slide out
            toggleBtn.Text = "Abrir"
        end
    end)

    -- Botão para ativar/desativar Aimbot diretamente
    aimbotToggleBtn = Instance.new("TextButton", gui)
    aimbotToggleBtn.Size = UDim2.new(0.2, 0, 0.1, 0)
    aimbotToggleBtn.Position = UDim2.new(0.8, 0, 0.8, 0)
    aimbotToggleBtn.AnchorPoint = Vector2.new(0, 1)
    aimbotToggleBtn.BackgroundColor3 = corPrimaria
    aimbotToggleBtn.Text = "Aimbot Off"
    aimbotToggleBtn.Font = Enum.Font.GothamBold
    aimbotToggleBtn.TextSize = 30
    aimbotToggleBtn.TextColor3 = corTexto
    aimbotToggleBtn.ZIndex = 20
    createCorner(aimbotToggleBtn, 18)

    aimbotToggleBtn.MouseButton1Click:Connect(function()
        _G.Aimbot = not _G.Aimbot
        aimbotToggleBtn.Text = _G.Aimbot and "Aimbot On" or "Aimbot Off"
        aimbotToggleBtn.BackgroundColor3 = _G.Aimbot and corPrimaria or corInativo
    end)
end

if isMobile then
    setupMobile()
else
    setupPC()
end

-- Funções de UI com animações
local function addCategory(txt, ypos)
    local l = Instance.new("TextLabel", optionsFrame)
    l.Size = UDim2.new(1, 0, 0, 30)
    l.Position = UDim2.new(0, 0, 0, ypos)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.Font = Enum.Font.GothamBold
    l.TextColor3 = corPrimaria
    l.TextSize = (isMobile and 24) or 20
    return l
end

local function addToggle(name, ypos, default, ptName)
    local btn = Instance.new("TextButton", optionsFrame)
    btn.Name = name
    btn.Size = UDim2.new(0.46, 0, 0, 36)
    btn.Position = UDim2.new(0.02 + ((isMobile and 0.02) or 0), 0, 0, ypos)
    btn.BackgroundColor3 = default and corPrimaria or corFundo
    btn.Text = (ptName or name) .. (default and " ✓" or " ✗")
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = default and corTexto or corInativo
    btn.TextSize = (isMobile and 18) or 16
    btn.BorderSizePixel = 0
    createCorner(btn, (isMobile and 18) or 10)
    btn.MouseEnter:Connect(function()
        animarTween(btn, {BackgroundColor3 = corPrimaria:Lerp(Color3.new(1,1,1), 0.1)})
    end)
    btn.MouseLeave:Connect(function()
        animarTween(btn, {BackgroundColor3 = _G[name] and corPrimaria or corFundo})
    end)
    btn.MouseButton1Click:Connect(function()
        _G[name] = not _G[name]
        btn.Text = (ptName or name) .. (_G[name] and " ✓" or " ✗")
        btn.BackgroundColor3 = _G[name] and corPrimaria or corFundo
        btn.TextColor3 = _G[name] and corTexto or corInativo
    end)
    _G[name] = default
end

local function addSlider(name, ypos, min, max, default, ptName)
    local f = Instance.new("Frame", optionsFrame)
    f.Size = UDim2.new(0.96, 0, 0, 36)
    f.Position = UDim2.new(0.02, 0, 0, ypos)
    f.BackgroundTransparency = 1

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = (ptName or name) .. ": " .. default
    l.Font = Enum.Font.Gotham
    l.TextColor3 = corPrimaria
    l.TextSize = (isMobile and 16) or 15

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.new(0.5, 0, 1, 0)
    box.Position = UDim2.new(0.5, 0, 0, 0)
    box.BackgroundColor3 = corFundo
    box.Text = tostring(default)
    box.Font = Enum.Font.Gotham
    box.TextColor3 = corPrimaria
    box.TextSize = (isMobile and 16) or 15
    createCorner(box, (isMobile and 10) or 8)

    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val and val >= min and val <= max then
            _G[name] = val
            l.Text = (ptName or name) .. ": " .. val
        else
            box.Text = tostring(_G[name])
        end
    end)
    _G[name] = default
end

local function addDropdown(name, ypos, values, default, ptName, ptValues)
    local f = Instance.new("Frame", optionsFrame)
    f.Size = UDim2.new(0.96, 0, 0, 36)
    f.Position = UDim2.new(0.02, 0, 0, ypos)
    f.BackgroundTransparency = 1

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = (ptName or name) .. ": " .. (ptValues and ptValues[table.find(values, default)] or default)
    l.Font = Enum.Font.Gotham
    l.TextColor3 = corPrimaria
    l.TextSize = (isMobile and 16) or 15

    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    btn.Position = UDim2.new(0.5, 0, 0, 0)
    btn.BackgroundColor3 = corFundo
    btn.Text = ptValues and ptValues[table.find(values, default)] or default
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = corPrimaria
    btn.TextSize = (isMobile and 16) or 15
    createCorner(btn, (isMobile and 10) or 8)

    local idx = table.find(values, default) or 1
    btn.MouseButton1Click:Connect(function()
        idx = idx % #values + 1
        local val = values[idx]
        _G[name] = val
        l.Text = (ptName or name) .. ": " .. (ptValues and ptValues[idx] or val)
        btn.Text = ptValues and ptValues[idx] or val
    end)
    _G[name] = default
end

-- Opções do Painel (mais opções adicionadas)
local y = 8
addCategory("Visual", y)
y = y + 32
addToggle("ESP", y, true, "ESP")
addToggle("Wallhack", y+40, true, "Wallhack")
addDropdown("ESPMode", y+80, {"Box","Skeleton","Tracers","Corner","HealthBar","Name","Distance"}, "Box", "Modo ESP", {"Caixa","Esqueleto","Traçadores","Cantos","Barra de Vida","Nome","Distância"})
addToggle("Chams", y+120, false, "Chams")
addToggle("Snaplines", y+160, false, "Linhas de Snap")
addToggle("Radar", y+200, false, "Radar")
addSlider("ESPColorR", y+240, 0,255,255, "Cor ESP R")
addSlider("ESPColorG", y+280, 0,255,255, "Cor ESP G")
addSlider("ESPColorB", y+320, 0,255,0, "Cor ESP B")
addSlider("ESPTransparency", y+360, 0,1,0.6, "Transparência ESP")
addToggle("ShowNames", y+400, true, "Mostrar Nomes")
addToggle("ShowDistance", y+440, false, "Mostrar Distância")
addToggle("ShowHealth", y+480, true, "Mostrar Saúde")

y = y + 520
addCategory("Aimbot", y)
y = y + 32
addToggle("Aimbot", y, false, "Aimbot")
addToggle("Aimlock", y+40, false, "Aimlock")
addToggle("AimAssist", y+80, false, "Assistência de Mira")
addDropdown("AimbotMode", y+120, {"Silent","Legit","Rage","Sticky","Flick"}, "Legit", "Modo Aimbot", {"Silencioso","Legítimo","Rage","Colante","Flick"})
addDropdown("TargetPriority", y+160, {"Nearest","LowestHP","TeamOnly","VisibleOnly"}, "Nearest", "Prioridade Alvo", {"Mais Próximo","Menor HP","Apenas Time","Apenas Visível"})
addSlider("AimbotStrength", y+200, 1,100,35, "Força Aimbot")
addSlider("AimbotFOV", y+240, 20,500,120, "FOV Aimbot")
addSlider("AimbotSmooth", y+280, 1,100,40, "Suavidade Aimbot")
addSlider("AimbotPrediction", y+320, 0,100,0, "Predição Aimbot")
addToggle("ShowFOV", y+360, false, "Mostrar FOV")
addSlider("AimAssistSpeed", y+400, 1,100,40, "Velocidade Assist")
addDropdown("HitPart", y+440, {"Head","Torso","Arms","Legs"}, "Head", "Parte Alvo", {"Cabeça","Torso","Braços","Pernas"})
addToggle("VisibilityCheck", y+480, true, "Verificação Visibilidade")
addToggle("AutoShoot", y+520, false, "Tiro Automático")
addToggle("Triggerbot", y+560, false, "Triggerbot")
addSlider("AntiRecoil", y+600, 0,100,50, "Anti-Recoil")

y = y + 640
addCategory("Movimento", y)
y = y + 32
addToggle("SpeedHack", y, false, "Hack de Velocidade")
addSlider("SpeedValue", y+40, 16,100,20, "Valor Velocidade")
addToggle("Fly", y+80, false, "Voar")
addSlider("FlySpeed", y+120, 1,100,50, "Velocidade Voo")
addToggle("NoClip", y+160, false, "NoClip")

y = y + 200
addCategory("Miscelânea", y)
y = y + 32
addToggle("GodMode", y, false, "Modo Deus")
addToggle("InfiniteJump", y+40, false, "Pulo Infinito")
addToggle("AutoFarm", y+80, false, "Farm Automático")

-- ESP/Visual melhorado
local function drawESP(player)
    if player == LocalPlayer or not player.Character then return end
    for _, v in pairs(player.Character:GetChildren()) do
        if v:IsA("BasePart") then
            if not v:FindFirstChild("EspBox") and (_G.ESP or _G.Wallhack) then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "EspBox"
                box.Size = v.Size + Vector3.new(0.2, 0.2, 0.2)
                box.Color3 = Color3.fromRGB(_G.ESPColorR or 255, _G.ESPColorG or 255, _G.ESPColorB or 0)
                box.Transparency = _G.ESPTransparency or 0.6
                box.Adornee = v
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Parent = v
            elseif v:FindFirstChild("EspBox") then
                local box = v.EspBox
                box.Color3 = Color3.fromRGB(_G.ESPColorR or 255, _G.ESPColorG or 255, _G.ESPColorB or 0)
                box.Transparency = _G.ESPTransparency or 0.6
                box.Visible = _G.ESP or _G.Wallhack
            end
        end
    end
    -- Adicionais: Nome, Distância, Saúde
    if _G.ShowNames and player.Character:FindFirstChild("Head") then
        -- Implementar billboard para nome (simples, pode expandir)
    end
end

local function removeESP(player)
    if not player.Character then return end
    for _, v in pairs(player.Character:GetChildren()) do
        if v:IsA("BasePart") and v:FindFirstChild("EspBox") then
            v.EspBox:Destroy()
        end
    end
end

-- Aimbot melhorado
local function isVisible(target)
    if not _G.VisibilityCheck then return true end
    local origin = Camera.CFrame.Position
    local dest = target.Character[_G.HitPart or "Head"].Position
    local ray = Ray.new(origin, (dest - origin).Unit * (dest - origin).Magnitude)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    return hit and hit:IsDescendantOf(target.Character)
end

local function getTarget()
    local mouse = UserInputService:GetMouseLocation()
    local targets = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(_G.HitPart or "Head") then
            local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character[_G.HitPart or "Head"].Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mouse).Magnitude
                if dist < (_G.AimbotFOV or 120) and isVisible(player) then
                    table.insert(targets, {player=player, dist=dist, health=(player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 100)})
                end
            end
        end
    end
    if #targets == 0 then return nil end
    if _G.TargetPriority == "Nearest" then
        table.sort(targets, function(a,b) return a.dist < b.dist end)
    elseif _G.TargetPriority == "LowestHP" then
        table.sort(targets, function(a,b) return a.health < b.health end)
    end
    return targets[1] and targets[1].player
end

local aiming = false
local aimlocked = false

local function aimAt(target, assist)
    if not target or not target.Character or not target.Character:FindFirstChild(_G.HitPart or "Head") then return end
    local hitPos = target.Character[_G.HitPart or "Head"].Position
    local camPos = Camera.CFrame.Position
    local direction = (hitPos - camPos).Unit
    -- Predição avançada
    if _G.AimbotPrediction > 0 and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
        if hrp.Velocity.Magnitude > 0 then
            local pred = _G.AimbotPrediction / 100
            hitPos = hitPos + hrp.Velocity * pred + Vector3.new(0, _G.AntiRecoil / 100, 0)  -- Anti-recoil simples
        end
    end
    direction = (hitPos - camPos).Unit
    local strength = (_G.AimbotSmooth or (_G.AimAssistSpeed or 40)) / 100
    if _G.AimbotMode == "Silent" then
        Camera.CFrame = CFrame.new(camPos, camPos + direction)
    elseif _G.AimbotMode == "Rage" then
        Camera.CFrame = CFrame.new(camPos, camPos + direction)
        if _G.AutoShoot then
            -- Simular tiro (depende do jogo, exemplo: mouse1 down)
        end
    else
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(camPos, camPos + direction), strength)
    end
    if _G.Triggerbot and target then
        -- Ativar trigger se alvo na mira
    end
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if _G.Aimbot and input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = true
    end
    if _G.Aimlock and input.KeyCode == Enum.KeyCode.L then
        aimlocked = true
    end
end)
UserInputService.InputEnded:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then aiming = false end
    if input.KeyCode == Enum.KeyCode.L then aimlocked = false end
end)

-- FOV Circle com animação
local function drawExtras()
    if _G.ShowFOV then
        local mouse = UserInputService:GetMouseLocation()
        if not gui:FindFirstChild("FOVDraw") then
            local fov = Instance.new("Frame", gui)
            fov.Name = "FOVDraw"
            fov.AnchorPoint = Vector2.new(0.5, 0.5)
            fov.BackgroundColor3 = corPrimaria
            fov.BackgroundTransparency = 0.5
            fov.Size = UDim2.new(0, _G.AimbotFOV or 120, 0, _G.AimbotFOV or 120)
            createCorner(fov, (_G.AimbotFOV or 120)/2)
            fov.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
            fov.ZIndex = 200
        else
            local fov = gui.FOVDraw
            animarTween(fov, {Size = UDim2.new(0, _G.AimbotFOV or 120, 0, _G.AimbotFOV or 120)})
            fov.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
            fov.Visible = true
        end
    elseif gui:FindFirstChild("FOVDraw") then
        gui.FOVDraw.Visible = false
    end
end

-- Loop principal
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if _G.ESP or _G.Wallhack then
            drawESP(player)
        else
            removeESP(player)
        end
    end
    if (aiming or aimlocked or _G.AimAssist) then
        local t = getTarget()
        if t then
            aimAt(t, _G.AimAssist)
        end
    end
    drawExtras()
    -- Adicionais: SpeedHack, Fly, etc (implementar lógica)
    if _G.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.SpeedValue or 20
    end
end)

-- Dica UI
local info = Instance.new("TextLabel", main)
info.Size = UDim2.new(1, 0, 0, 36)
info.Position = UDim2.new(0, 0, 1, -36)
info.Text = isMobile and "Toque Painel para abrir/fechar" or "PC: P abre painel | Mouse2: Aimbot | L: Aimlock"
info.BackgroundTransparency = 1
info.Font = Enum.Font.GothamSemibold
info.TextColor3 = corPrimaria
info.TextSize = (isMobile and 18) or 15

-- Ajusta layout para diferentes resoluções (melhorado)
local function ajustaPainel()
    if isMobile then
        main.Size = UDim2.new(0.95, 0, 0.95, 0)
        main.Position = UDim2.new(1, 0, 0.025, 0)  -- Reset para animação
        toggleBtn.Size = UDim2.new(0.2, 0, 0.1, 0)
        aimbotToggleBtn.Size = UDim2.new(0.2, 0, 0.1, 0)
    else
        local w = math.clamp(Camera.ViewportSize.X * 0.3, 300, 600)
        local h = math.clamp(Camera.ViewportSize.Y * 0.7, 500, 900)
        main.Size = UDim2.new(0, w, 0, h)
        main.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
    end
    optionsFrame.CanvasSize = UDim2.new(0, 0, 0, y + 100)  -- Ajusta canvas dinamicamente
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(ajustaPainel)
ajustaPainel()

-- Fim do Script
