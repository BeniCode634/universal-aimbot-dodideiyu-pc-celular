--[[

    Aimbot por Team TEST © CC0 1.0 Universal (2025)

    https://github.com/TeamTEST/Aimbot

]]

--// Cache
local loadstring, getgenv, setclipboard, tablefind, UserInputService, TweenService, RunService, Players, Camera = loadstring, getgenv, setclipboard, table.find, game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService"), game:GetService("Players"), workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Loaded check
if Aimbot or AimbotV2Loaded then
    return
end

--// Environment
getgenv().Aimbot = {}

--// Cores do tema
local corPrimaria = Color3.fromRGB(255, 255, 0)  -- Amarelo
local corSecundaria = Color3.fromRGB(0, 0, 0)    -- Preto
local corFundo = Color3.fromRGB(30, 30, 30)      -- Cinza escuro
local corTexto = Color3.fromRGB(255, 255, 255)   -- Branco
local corInativo = Color3.fromRGB(100, 100, 100) -- Cinza inativo

--// Funções utilitárias
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

--// Load Modules
loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamTEST/Aimbot/main/Modules/Aimbot.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamTEST/Aimbot/main/Modules/Wall%20Hack.lua"))()

--// Variables
local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)() -- Pepsi's UI Library
local AimbotModule, WallHack = getgenv().Aimbot.Aimbot, getgenv().Aimbot.WallHack
local Parts = {"Cabeça", "HumanoidRootPart", "Torso", "Braço Esquerdo", "Braço Direito", "Perna Esquerda", "Perna Direita", "Mão Esquerda", "Mão Direita", "Antebraço Esquerdo", "Antebraço Direito", "Braço Superior Esquerdo", "Braço Superior Direito", "Pé Esquerdo", "Canela Esquerda", "Torso Superior", "Coxa Esquerda", "Pé Direito", "Canela Direita", "Torso Inferior", "Coxa Direita"}
local Fonts = {"UI", "System", "Plex", "Monospace"}
local TracersType = {"Inferior", "Centro", "Mouse"}

--// Sistema de Key
local gui = Instance.new("ScreenGui")
gui.Name = "Aimbot"
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Sem suporte para Mobile
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    local notifyFrame = Instance.new("Frame", gui)
    notifyFrame.Size = UDim2.new(0.6, 0, 0.2, 0)
    notifyFrame.Position = UDim2.new(0.2, 0, 0.4, 0)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    notifyFrame.BorderSizePixel = 0
    createCorner(notifyFrame, 10)
    
    local notifyText = Instance.new("TextLabel", notifyFrame)
    notifyText.Size = UDim2.new(1, 0, 1, 0)
    notifyText.BackgroundTransparency = 1
    notifyText.Text = "Não temos suporte para mobile. O script será removido."
    notifyText.Font = Enum.Font.GothamBold
    notifyText.TextSize = 24
    notifyText.TextColor3 = corTexto
    notifyText.TextWrapped = true
    
    wait(3)
    gui:Destroy()
    return
end

local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 340, 0, 180)
keyFrame.Position = UDim2.new(0.5, -170, 0.5, -90)
keyFrame.BackgroundColor3 = corFundo
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Visible = true
createCorner(keyFrame, 16)
createGradient(keyFrame, corPrimaria, corSecundaria)

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0, 44)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Digite a Key para Liberar"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 24
keyTitle.TextColor3 = corTexto

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 46)
keyBox.Position = UDim2.new(0.1, 0, 0.55, -23)
keyBox.BackgroundColor3 = corSecundaria
keyBox.Text = ""
keyBox.Font = Enum.Font.GothamBold
keyBox.PlaceholderText = "Insira a key..."
keyBox.TextColor3 = corPrimaria
keyBox.TextSize = 20
createCorner(keyBox, 10)

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.8, 0, 0, 38)
keyBtn.Position = UDim2.new(0.1, 0, 1, -48)
keyBtn.BackgroundColor3 = corPrimaria
keyBtn.Text = "Liberar Painel"
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextColor3 = corTexto
keyBtn.TextSize = 20
createCorner(keyBtn, 10)

local keyWarn = Instance.new("TextLabel", keyFrame)
keyWarn.Size = UDim2.new(1, 0, 0, 28)
keyWarn.Position = UDim2.new(0, 0, 1, -80)
keyWarn.BackgroundTransparency = 1
keyWarn.Text = ""
keyWarn.Font = Enum.Font.Gotham
keyWarn.TextColor3 = Color3.fromRGB(255, 80, 80)
keyWarn.TextSize = 16

local painelLiberado = false

keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "DODIDEIYUCHEATS" then
        painelLiberado = true
        animarTween(keyFrame, {Transparency = 1}, 0.5)
        keyFrame.Visible = false
    else
        keyWarn.Text = "Key incorreta! Tente novamente."
    end
end)

keyBox.FocusLost:Connect(function()
    keyWarn.Text = ""
end)

while not painelLiberado do
    RunService.RenderStepped:Wait()
end

--// Frame
Library.UnloadCallback = function()
    AimbotModule.Functions:Exit()
    WallHack.Functions:Exit()
    getgenv().Aimbot = nil
end

local MainFrame = Library:CreateWindow({
    Name = "Aimbot por Team TEST",
    Themeable = {
        Image = "7059346386",
        Info = "Feito por Team TEST",
        Credit = false
    },
    Background = "",
    Theme = [[{"__Designer.Colors.topGradient":"FFC107","__Designer.Colors.section":"FFB300","__Designer.Colors.hoveredOptionBottom":"FFCA28","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"FFCA28","__Designer.Colors.unselectedOption":"212121","__Designer.Files.WorkspaceFile":"Aimbot","__Designer.Colors.unhoveredOptionTop":"FFC107","__Designer.Colors.outerBorder":"000000","__Designer.Background.ImageColor":"FFB300","__Designer.Colors.tabText":"FFFFFF","__Designer.Colors.elementBorder":"000000","__Designer.Background.ImageTransparency":100,"__Designer.Colors.background":"1E1E1E","__Designer.Colors.innerBorder":"424242","__Designer.Colors.bottomGradient":"212121","__Designer.Colors.sectionBackground":"1E1E1E","__Designer.Colors.hoveredOptionTop":"FFCA28","__Designer.Colors.otherElementText":"FFFFFF","__Designer.Colors.main":"FFB300","__Designer.Colors.elementText":"FFFFFF"}]]
})

--// Tabs
local AimbotTab = MainFrame:CreateTab({
    Name = "Aimbot"
})

local VisualsTab = MainFrame:CreateTab({
    Name = "Visuais"
})

local CrosshairTab = MainFrame:CreateTab({
    Name = "Mira"
})

local FunctionsTab = MainFrame:CreateTab({
    Name = "Funções"
})

local MovementTab = MainFrame:CreateTab({
    Name = "Movimento"
})

--// Aimbot Sections
local AimbotValues = AimbotTab:CreateSection({
    Name = "Valores"
})

local AimbotChecks = AimbotTab:CreateSection({
    Name = "Checagens"
})

local ThirdPerson = AimbotTab:CreateSection({
    Name = "Terceira Pessoa"
})

local FOV_Values = AimbotTab:CreateSection({
    Name = "Campo de Visão",
    Side = "Right"
})

local FOV_Appearance = AimbotTab:CreateSection({
    Name = "Aparência do FOV",
    Side = "Right"
})

--// Visuals Sections
local WallHackChecks = VisualsTab:CreateSection({
    Name = "Checagens"
})

local ESPSettings = VisualsTab:CreateSection({
    Name = "Configurações ESP"
})

local BoxesSettings = VisualsTab:CreateSection({
    Name = "Configurações de Caixas"
})

local ChamsSettings = VisualsTab:CreateSection({
    Name = "Configurações de Chams"
})

local TracersSettings = VisualsTab:CreateSection({
    Name = "Configurações de Traçadores",
    Side = "Right"
})

local HeadDotsSettings = VisualsTab:CreateSection({
    Name = "Configurações de Pontos na Cabeça",
    Side = "Right"
})

local HealthBarSettings = VisualsTab:CreateSection({
    Name = "Configurações da Barra de Vida",
    Side = "Right"
})

--// Crosshair Sections
local CrosshairSettings = CrosshairTab:CreateSection({
    Name = "Configurações"
})

local CrosshairSettings_CenterDot = CrosshairTab:CreateSection({
    Name = "Configurações do Ponto Central",
    Side = "Right"
})

--// Functions Sections
local FunctionsSection = FunctionsTab:CreateSection({
    Name = "Funções"
})

--// Movement Sections
local MovementSettings = MovementTab:CreateSection({
    Name = "Configurações de Movimento"
})

--// Aimbot Values
AimbotValues:AddToggle({
    Name = "Ativado",
    Value = AimbotModule.Settings.Enabled,
    Callback = function(New, Old)
        AimbotModule.Settings.Enabled = New
    end
}).Default = AimbotModule.Settings.Enabled

AimbotValues:AddToggle({
    Name = "Alternar",
    Value = AimbotModule.Settings.Toggle,
    Callback = function(New, Old)
        AimbotModule.Settings.Toggle = New
    end
}).Default = AimbotModule.Settings.Toggle

AimbotModule.Settings.LockPart = Parts[1]
AimbotValues:AddDropdown({
    Name = "Parte de Mira",
    Value = Parts[1],
    Callback = function(New, Old)
        AimbotModule.Settings.LockPart = New
    end,
    List = Parts,
    Nothing = "Cabeça"
}).Default = Parts[1]

AimbotValues:AddTextbox({
    Name = "Tecla de Ativação",
    Value = AimbotModule.Settings.TriggerKey,
    Callback = function(New, Old)
        AimbotModule.Settings.TriggerKey = New
    end
}).Default = AimbotModule.Settings.TriggerKey

AimbotValues:AddSlider({
    Name = "Sensibilidade",
    Value = AimbotModule.Settings.Sensitivity,
    Callback = function(New, Old)
        AimbotModule.Settings.Sensitivity = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = AimbotModule.Settings.Sensitivity

--// Aimbot Checks
AimbotChecks:AddToggle({
    Name = "Checar Time",
    Value = AimbotModule.Settings.TeamCheck,
    Callback = function(New, Old)
        AimbotModule.Settings.TeamCheck = New
    end
}).Default = AimbotModule.Settings.TeamCheck

AimbotChecks:AddToggle({
    Name = "Checar Parede",
    Value = AimbotModule.Settings.WallCheck,
    Callback = function(New, Old)
        AimbotModule.Settings.WallCheck = New
    end
}).Default = AimbotModule.Settings.WallCheck

AimbotChecks:AddToggle({
    Name = "Checar Vida",
    Value = AimbotModule.Settings.AliveCheck,
    Callback = function(New, Old)
        AimbotModule.Settings.AliveCheck = New
    end
}).Default = AimbotModule.Settings.AliveCheck

--// Aimbot ThirdPerson
ThirdPerson:AddToggle({
    Name = "Ativar Terceira Pessoa",
    Value = AimbotModule.Settings.ThirdPerson,
    Callback = function(New, Old)
        AimbotModule.Settings.ThirdPerson = New
    end
}).Default = AimbotModule.Settings.ThirdPerson

ThirdPerson:AddSlider({
    Name = "Sensibilidade em Terceira Pessoa",
    Value = AimbotModule.Settings.ThirdPersonSensitivity,
    Callback = function(New, Old)
        AimbotModule.Settings.ThirdPersonSensitivity = New
    end,
    Min = 0.1,
    Max = 5,
    Decimals = 1
}).Default = AimbotModule.Settings.ThirdPersonSensitivity

--// FOV Settings Values
FOV_Values:AddToggle({
    Name = "Ativado",
    Value = AimbotModule.FOVSettings.Enabled,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Enabled = New
    end
}).Default = AimbotModule.FOVSettings.Enabled

FOV_Values:AddToggle({
    Name = "Visível",
    Value = AimbotModule.FOVSettings.Visible,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Visible = New
    end
}).Default = AimbotModule.FOVSettings.Visible

FOV_Values:AddSlider({
    Name = "Tamanho",
    Value = AimbotModule.FOVSettings.Amount,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Amount = New
    end,
    Min = 10,
    Max = 300
}).Default = AimbotModule.FOVSettings.Amount

--// FOV Settings Appearance
FOV_Appearance:AddToggle({
    Name = "Preenchido",
    Value = AimbotModule.FOVSettings.Filled,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Filled = New
    end
}).Default = AimbotModule.FOVSettings.Filled

FOV_Appearance:AddSlider({
    Name = "Transparência",
    Value = AimbotModule.FOVSettings.Transparency,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 1
}).Default = AimbotModule.FOVSettings.Transparency

FOV_Appearance:AddSlider({
    Name = "Lados",
    Value = AimbotModule.FOVSettings.Sides,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Sides = New
    end,
    Min = 3,
    Max = 60
}).Default = AimbotModule.FOVSettings.Sides

FOV_Appearance:AddSlider({
    Name = "Espessura",
    Value = AimbotModule.FOVSettings.Thickness,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Thickness = New
    end,
    Min = 1,
    Max = 50
}).Default = AimbotModule.FOVSettings.Thickness

FOV_Appearance:AddColorpicker({
    Name = "Cor",
    Value = AimbotModule.FOVSettings.Color,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Color = New
    end
}).Default = AimbotModule.FOVSettings.Color

FOV_Appearance:AddColorpicker({
    Name = "Cor de Lock",
    Value = AimbotModule.FOVSettings.LockedColor,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.LockedColor = New
    end
}).Default = AimbotModule.FOVSettings.LockedColor

--// Wall Hack Settings
WallHackChecks:AddToggle({
    Name = "Ativado",
    Value = WallHack.Settings.Enabled,
    Callback = function(New, Old)
        WallHack.Settings.Enabled = New
    end
}).Default = WallHack.Settings.Enabled

WallHackChecks:AddToggle({
    Name = "Checar Time",
    Value = WallHack.Settings.TeamCheck,
    Callback = function(New, Old)
        WallHack.Settings.TeamCheck = New
    end
}).Default = WallHack.Settings.TeamCheck

WallHackChecks:AddToggle({
    Name = "Checar Vida",
    Value = WallHack.Settings.AliveCheck,
    Callback = function(New, Old)
        WallHack.Settings.AliveCheck = New
    end
}).Default = WallHack.Settings.AliveCheck

--// Visuals Settings
ESPSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Visuals.ESPSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.Enabled = New
    end
}).Default = WallHack.Visuals.ESPSettings.Enabled

ESPSettings:AddToggle({
    Name = "Contorno",
    Value = WallHack.Visuals.ESPSettings.Outline,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.Outline = New
    end
}).Default = WallHack.Visuals.ESPSettings.Outline

ESPSettings:AddToggle({
    Name = "Exibir Distância",
    Value = WallHack.Visuals.ESPSettings.DisplayDistance,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.DisplayDistance = New
    end
}).Default = WallHack.Visuals.ESPSettings.DisplayDistance

ESPSettings:AddToggle({
    Name = "Exibir Vida",
    Value = WallHack.Visuals.ESPSettings.DisplayHealth,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.DisplayHealth = New
    end
}).Default = WallHack.Visuals.ESPSettings.DisplayHealth

ESPSettings:AddToggle({
    Name = "Exibir Nome",
    Value = WallHack.Visuals.ESPSettings.DisplayName,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.DisplayName = New
    end
}).Default = WallHack.Visuals.ESPSettings.DisplayName

ESPSettings:AddSlider({
    Name = "Deslocamento",
    Value = WallHack.Visuals.ESPSettings.Offset,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.Offset = New
    end,
    Min = -30,
    Max = 30
}).Default = WallHack.Visuals.ESPSettings.Offset

ESPSettings:AddColorpicker({
    Name = "Cor do Texto",
    Value = WallHack.Visuals.ESPSettings.TextColor,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextColor = New
    end
}).Default = WallHack.Visuals.ESPSettings.TextColor

ESPSettings:AddColorpicker({
    Name = "Cor do Contorno",
    Value = WallHack.Visuals.ESPSettings.OutlineColor,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.OutlineColor = New
    end
}).Default = WallHack.Visuals.ESPSettings.OutlineColor

ESPSettings:AddSlider({
    Name = "Transparência do Texto",
    Value = WallHack.Visuals.ESPSettings.TextTransparency,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextTransparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.ESPSettings.TextTransparency

ESPSettings:AddSlider({
    Name = "Tamanho do Texto",
    Value = WallHack.Visuals.ESPSettings.TextSize,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextSize = New
    end,
    Min = 8,
    Max = 24
}).Default = WallHack.Visuals.ESPSettings.TextSize

ESPSettings:AddDropdown({
    Name = "Fonte do Texto",
    Value = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1],
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextFont = Drawing.Fonts[New]
    end,
    List = Fonts,
    Nothing = "UI"
}).Default = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1]

BoxesSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Visuals.BoxSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Enabled = New
    end
}).Default = WallHack.Visuals.BoxSettings.Enabled

BoxesSettings:AddSlider({
    Name = "Transparência",
    Value = WallHack.Visuals.BoxSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.BoxSettings.Transparency

BoxesSettings:AddSlider({
    Name = "Espessura",
    Value = WallHack.Visuals.BoxSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.BoxSettings.Thickness

BoxesSettings:AddSlider({
    Name = "Aumento de Escala (3D)",
    Value = WallHack.Visuals.BoxSettings.Increase,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Increase = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.BoxSettings.Increase

BoxesSettings:AddColorpicker({
    Name = "Cor",
    Value = WallHack.Visuals.BoxSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Color = New
    end
}).Default = WallHack.Visuals.BoxSettings.Color

BoxesSettings:AddDropdown({
    Name = "Tipo",
    Value = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D",
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Type = New == "3D" and 1 or 2
    end,
    List = {"3D", "2D"},
    Nothing = "3D"
}).Default = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D"

BoxesSettings:AddToggle({
    Name = "Preenchido (Quadrado 2D)",
    Value = WallHack.Visuals.BoxSettings.Filled,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Filled = New
    end
}).Default = WallHack.Visuals.BoxSettings.Filled

ChamsSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Visuals.ChamsSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Enabled = New
    end
}).Default = WallHack.Visuals.ChamsSettings.Enabled

ChamsSettings:AddToggle({
    Name = "Preenchido",
    Value = WallHack.Visuals.ChamsSettings.Filled,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Filled = New
    end
}).Default = WallHack.Visuals.ChamsSettings.Filled

ChamsSettings:AddToggle({
    Name = "Corpo Inteiro (R15)",
    Value = WallHack.Visuals.ChamsSettings.EntireBody,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.EntireBody = New
    end
}).Default = WallHack.Visuals.ChamsSettings.EntireBody

ChamsSettings:AddSlider({
    Name = "Transparência",
    Value = WallHack.Visuals.ChamsSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.ChamsSettings.Transparency

ChamsSettings:AddSlider({
    Name = "Espessura",
    Value = WallHack.Visuals.ChamsSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Thickness = New
    end,
    Min = 0,
    Max = 3
}).Default = WallHack.Visuals.ChamsSettings.Thickness

ChamsSettings:AddColorpicker({
    Name = "Cor",
    Value = WallHack.Visuals.ChamsSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Color = New
    end
}).Default = WallHack.Visuals.ChamsSettings.Color

TracersSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Visuals.TracersSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Enabled = New
    end
}).Default = WallHack.Visuals.TracersSettings.Enabled

TracersSettings:AddSlider({
    Name = "Transparência",
    Value = WallHack.Visuals.TracersSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.TracersSettings.Transparency

TracersSettings:AddSlider({
    Name = "Espessura",
    Value = WallHack.Visuals.TracersSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.TracersSettings.Thickness

TracersSettings:AddColorpicker({
    Name = "Cor",
    Value = WallHack.Visuals.TracersSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Color = New
    end
}).Default = WallHack.Visuals.TracersSettings.Color

TracersSettings:AddDropdown({
    Name = "Origem",
    Value = TracersType[WallHack.Visuals.TracersSettings.Type],
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Type = tablefind(TracersType, New)
    end,
    List = TracersType,
    Nothing = "Inferior"
}).Default = Fonts[WallHack.Visuals.TracersSettings.Type + 1]

HeadDotsSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Visuals.HeadDotSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Enabled = New
    end
}).Default = WallHack.Visuals.HeadDotSettings.Enabled

HeadDotsSettings:AddToggle({
    Name = "Preenchido",
    Value = WallHack.Visuals.HeadDotSettings.Filled,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Filled = New
    end
}).Default = WallHack.Visuals.HeadDotSettings.Filled

HeadDotsSettings:AddSlider({
    Name = "Transparência",
    Value = WallHack.Visuals.HeadDotSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.HeadDotSettings.Transparency

HeadDotsSettings:AddSlider({
    Name = "Espessura",
    Value = WallHack.Visuals.HeadDotSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.HeadDotSettings.Thickness

HeadDotsSettings:AddSlider({
    Name = "Lados",
    Value = WallHack.Visuals.HeadDotSettings.Sides,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Sides = New
    end,
    Min = 3,
    Max = 60
}).Default = WallHack.Visuals.HeadDotSettings.Sides

HeadDotsSettings:AddColorpicker({
    Name = "Cor",
    Value = WallHack.Visuals.HeadDotSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Color = New
    end
}).Default = WallHack.Visuals.HeadDotSettings.Color

HealthBarSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Visuals.HealthBarSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Enabled = New
    end
}).Default = WallHack.Visuals.HealthBarSettings.Enabled

HealthBarSettings:AddDropdown({
    Name = "Posição",
    Value = WallHack.Visuals.HealthBarSettings.Type == 1 and "Superior" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Inferior" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Esquerda" or "Direita",
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Type = New == "Superior" and 1 or New == "Inferior" and 2 or New == "Esquerda" and 3 or 4
    end,
    List = {"Superior", "Inferior", "Esquerda", "Direita"},
    Nothing = "Esquerda"
}).Default = WallHack.Visuals.HealthBarSettings.Type == 1 and "Superior" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Inferior" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Esquerda" or "Direita"

HealthBarSettings:AddSlider({
    Name = "Transparência",
    Value = WallHack.Visuals.HealthBarSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.HealthBarSettings.Transparency

HealthBarSettings:AddSlider({
    Name = "Tamanho",
    Value = WallHack.Visuals.HealthBarSettings.Size,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Size = New
    end,
    Min = 2,
    Max = 10
}).Default = WallHack.Visuals.HealthBarSettings.Size

HealthBarSettings:AddSlider({
    Name = "Azul",
    Value = WallHack.Visuals.HealthBarSettings.Blue,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Blue = New
    end,
    Min = 0,
    Max = 255
}).Default = WallHack.Visuals.HealthBarSettings.Blue

HealthBarSettings:AddSlider({
    Name = "Deslocamento",
    Value = WallHack.Visuals.HealthBarSettings.Offset,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Offset = New
    end,
    Min = -30,
    Max = 30
}).Default = WallHack.Visuals.HealthBarSettings.Offset

HealthBarSettings:AddColorpicker({
    Name = "Cor do Contorno",
    Value = WallHack.Visuals.HealthBarSettings.OutlineColor,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.OutlineColor = New
    end
}).Default = WallHack.Visuals.HealthBarSettings.OutlineColor

--// Crosshair Settings
CrosshairSettings:AddToggle({
    Name = "Cursor do Mouse",
    Value = UserInputService.MouseIconEnabled,
    Callback = function(New, Old)
        UserInputService.MouseIconEnabled = New
    end
}).Default = UserInputService.MouseIconEnabled

CrosshairSettings:AddToggle({
    Name = "Ativado",
    Value = WallHack.Crosshair.Settings.Enabled,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Enabled = New
    end
}).Default = WallHack.Crosshair.Settings.Enabled

CrosshairSettings:AddColorpicker({
    Name = "Cor",
    Value = WallHack.Crosshair.Settings.Color,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Color = New
    end
}).Default = WallHack.Crosshair.Settings.Color

CrosshairSettings:AddSlider({
    Name = "Transparência",
    Value = WallHack.Crosshair.Settings.Transparency,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Crosshair.Settings.Transparency

CrosshairSettings:AddSlider({
    Name = "Tamanho",
    Value = WallHack.Crosshair.Settings.Size,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Size = New
    end,
    Min = 8,
    Max = 24
}).Default = WallHack.Crosshair.Settings.Size

CrosshairSettings:AddSlider({
    Name = "Espessura",
    Value = WallHack.Crosshair.Settings.Thickness,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Crosshair.Settings.Thickness

CrosshairSettings:AddSlider({
    Name = "Tamanho do Espaço",
    Value = WallHack.Crosshair.Settings.GapSize,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.GapSize = New
    end,
    Min = 0,
    Max = 20
}).Default = WallHack.Crosshair.Settings.GapSize

CrosshairSettings:AddSlider({
    Name = "Rotação (Graus)",
    Value = WallHack.Crosshair.Settings.Rotation,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Rotation = New
    end,
    Min = -180,
    Max = 180
}).Default = WallHack.Crosshair.Settings.Rotation

CrosshairSettings:AddDropdown({
    Name = "Posição",
    Value = WallHack.Crosshair.Settings.Type == 1 and "Mouse" or "Centro",
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Type = New == "Mouse" and 1 or 2
    end,
    List = {"Mouse", "Centro"},
    Nothing = "Mouse"
}).Default = WallHack.Crosshair.Settings.Type == 1 and "Mouse" or "Centro"

CrosshairSettings_CenterDot:AddToggle({
    Name = "Ponto Central",
    Value = WallHack.Crosshair.Settings.CenterDot,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDot = New
    end
}).Default = WallHack.Crosshair.Settings.CenterDot

CrosshairSettings_CenterDot:AddColorpicker({
    Name = "Cor do Ponto Central",
    Value = WallHack.Crosshair.Settings.CenterDotColor,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotColor = New
    end
}).Default = WallHack.Crosshair.Settings.CenterDotColor

CrosshairSettings_CenterDot:AddSlider({
    Name = "Tamanho do Ponto Central",
    Value = WallHack.Crosshair.Settings.CenterDotSize,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotSize = New
    end,
    Min = 1,
    Max = 6
}).Default = WallHack.Crosshair.Settings.CenterDotSize

CrosshairSettings_CenterDot:AddSlider({
    Name = "Transparência do Ponto Central",
    Value = WallHack.Crosshair.Settings.CenterDotTransparency,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotTransparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Crosshair.Settings.CenterDotTransparency

CrosshairSettings_CenterDot:AddToggle({
    Name = "Ponto Central Preenchido",
    Value = WallHack.Crosshair.Settings.CenterDotFilled,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotFilled = New
    end
}).Default = WallHack.Crosshair.Settings.CenterDotFilled

--// Movement Settings
MovementSettings:AddToggle({
    Name = "Hack de Velocidade",
    Value = false,
    Callback = function(New, Old)
        _G.SpeedHack = New
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = New and (_G.SpeedValue or 20) or 16
        end
    end
}).Default = false

MovementSettings:AddSlider({
    Name = "Velocidade",
    Value = 20,
    Callback = function(New, Old)
        _G.SpeedValue = New
        if _G.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = New
        end
    end,
    Min = 16,
    Max = 200,
    Decimals = 1
}).Default = 20

MovementSettings:AddToggle({
    Name = "Voar",
    Value = false,
    Callback = function(New, Old)
        _G.Fly = New
    end
}).Default = false

MovementSettings:AddSlider({
    Name = "Velocidade de Voo",
    Value = 50,
    Callback = function(New, Old)
        _G.FlySpeed = New
    end,
    Min = 1,
    Max = 200,
    Decimals = 1
}).Default = 50

MovementSettings:AddToggle({
    Name = "NoClip",
    Value = false,
    Callback = function(New, Old)
        _G.NoClip = New
    end
}).Default = false

MovementSettings:AddToggle({
    Name = "Pulo Infinito",
    Value = false,
    Callback = function(New, Old)
        _G.InfiniteJump = New
    end
}).Default = false

--// Functions / Functions
FunctionsSection:AddButton({
    Name = "Redefinir Configurações",
    Callback = function()
        AimbotModule.Functions:ResetSettings()
        WallHack.Functions:ResetSettings()
        Library.ResetAll()
    end
})

FunctionsSection:AddButton({
    Name = "Reiniciar",
    Callback = function()
        AimbotModule.Functions:Restart()
        WallHack.Functions:Restart()
    end
})

FunctionsSection:AddButton({
    Name = "Sair",
    Callback = Library.Unload,
})

FunctionsSection:AddButton({
    Name = "Copiar Página do Script",
    Callback = function()
        setclipboard("https://github.com/TeamTEST/Aimbot")
    end
})

--// Loop para funcionalidades de movimento
RunService.RenderStepped:Connect(function()
    if _G.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local velocity = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            velocity = velocity + Camera.CFrame.LookVector * (_G.FlySpeed or 50)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            velocity = velocity - Camera.CFrame.LookVector * (_G.FlySpeed or 50)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            velocity = velocity - Camera.CFrame.RightVector * (_G.FlySpeed or 50)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            velocity = velocity + Camera.CFrame.RightVector * (_G.FlySpeed or 50)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + Vector3.new(0, _G.FlySpeed or 50, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            velocity = velocity - Vector3.new(0, _G.FlySpeed or 50, 0)
        end
        hrp.Velocity = velocity
    end
    if _G.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not _G.NoClip
            end
        end
    end
    if _G.InfiniteJump and UserInputService:IsKeyDown(Enum.KeyCode.Space) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

--// Ajuste de layout para diferentes resoluções
local function ajustaPainel()
    local w = math.clamp(Camera.ViewportSize.X * 0.35, 400, 700)
    local h = math.clamp(Camera.ViewportSize.Y * 0.75, 600, 1000)
    MainFrame.Size = UDim2.new(0, w, 0, h)
    MainFrame.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(ajustaPainel)
ajustaPainel()

--// Fim do Script
