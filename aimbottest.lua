--// Cache

local loadstring, getgenv, setclipboard, tablefind, UserInputService = loadstring, getgenv, setclipboard, table.find, game:GetService("UserInputService")

--// Loaded check

if Aimbot then
    return
end

--// Environment

getgenv().Aimbot = {}

--// Load Modules (Local or trusted source required)

-- Note: Replace with local paths or trusted URLs to Aimbot.lua and Wall Hack.lua
-- Example: "file://path/to/Aimbot.lua" or a trusted server URL
loadstring(game:HttpGet("path/to/local/Aimbot.lua"))()
loadstring(game:HttpGet("path/to/local/Wall Hack.lua"))()

--// Variables

local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local AimbotModule, WallHack = getgenv().Aimbot.Aimbot, getgenv().Aimbot.WallHack
local Parts = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}
local Fonts = {"UI", "System", "Plex", "Monospace"}
local TracersType = {"Bottom", "Center", "Mouse"}

--// Frame

Library.UnloadCallback = function()
    if AimbotModule and AimbotModule.Functions then
        AimbotModule.Functions:Exit()
    end
    if WallHack and WallHack.Functions then
        WallHack.Functions:Exit()
    end
    getgenv().Aimbot = nil
end

local MainFrame = Library:CreateWindow({
    Name = "Aimbot",
    Themeable = {
        Image = "",
        Info = "Aimbot Interface",
        Credit = false
    },
    Background = "",
    Theme = [[
    {
        "__Designer.Colors.topGradient": "FFC107",
        "__Designer.Colors.section": "000000",
        "__Designer.Colors.hoveredOptionBottom": "FFA000",
        "__Designer.Background.ImageAssetID": "",
        "__Designer.Colors.selectedOption": "FFB300",
        "__Designer.Colors.unselectedOption": "212121",
        "__Designer.Files.WorkspaceFile": "Aimbot",
        "__Designer.Colors.unhoveredOptionTop": "FFCA28",
        "__Designer.Colors.outerBorder": "000000",
        "__Designer.Background.ImageColor": "FFC107",
        "__Designer.Colors.tabText": "FFFFFF",
        "__Designer.Colors.elementBorder": "000000",
        "__Designer.Background.ImageTransparency": 100,
        "__Designer.Colors.background": "212121",
        "__Designer.Colors.innerBorder": "424242",
        "__Designer.Colors.bottomGradient": "FFA000",
        "__Designer.Colors.sectionBackground": "000000",
        "__Designer.Colors.hoveredOptionTop": "FFCA28",
        "__Designer.Colors.otherElementText": "FFFFFF",
        "__Designer.Colors.main": "FFC107",
        "__Designer.Colors.elementText": "FFFFFF",
        "__Designer.Colors.unhoveredOptionBottom": "424242",
        "__Designer.Background.UseBackgroundImage": false
    }
    ]]
})

--// CSS for Animations (if supported by the UI library)

local AnimationCSS = [[
    <style>
        /* Window fade-in animation */
        .window {
            animation: fadeIn 0.5s ease-in-out;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: scale(0.95); }
            100% { opacity: 1; transform: scale(1); }
        }
        /* Button hover animation */
        .button {
            transition: background-color 0.3s ease, transform 0.2s ease;
            border-radius: 4px;
        }
        .button:hover {
            background-color: #FFCA28 !important;
            transform: scale(1.05);
        }
        /* Slider transition */
        .slider {
            transition: all 0.3s ease;
        }
        /* Tab hover animation */
        .tab {
            transition: background-color 0.3s ease, color 0.3s ease;
            border-radius: 4px;
        }
        .tab:hover {
            background-color: #424242 !important;
            color: #FFC107 !important;
        }
        /* Section styling */
        .section {
            border-radius: 6px;
            padding: 10px;
        }
    </style>
]]

-- Check if the library supports CSS injection
if Library.InjectCSS then
    Library:InjectCSS(AnimationCSS)
end

--// Tabs

local AimbotTab = MainFrame:CreateTab({
    Name = "Aimbot"
})

local VisualsTab = MainFrame:CreateTab({
    Name = "Visuals"
})

local CrosshairTab = MainFrame:CreateTab({
    Name = "Crosshair"
})

local FunctionsTab = MainFrame:CreateTab({
    Name = "Functions"
})

--// Aimbot Sections

local Values = AimbotTab:CreateSection({
    Name = "Values"
})

local Checks = AimbotTab:CreateSection({
    Name = "Checks"
})

local ThirdPerson = AimbotTab:CreateSection({
    Name = "Third Person"
})

local FOV_Values = AimbotTab:CreateSection({
    Name = "Field Of View",
    Side = "Right"
})

local FOV_Appearance = AimbotTab:CreateSection({
    Name = "FOV Circle Appearance",
    Side = "Right"
})

--// Visuals Sections

local WallHackChecks = VisualsTab:CreateSection({
    Name = "Checks"
})

local ESPSettings = VisualsTab:CreateSection({
    Name = "ESP Settings"
})

local BoxesSettings = VisualsTab:CreateSection({
    Name = "Boxes Settings"
})

local ChamsSettings = VisualsTab:CreateSection({
    Name = "Chams Settings"
})

local TracersSettings = VisualsTab:CreateSection({
    Name = "Tracers Settings",
    Side = "Right"
})

local HeadDotsSettings = VisualsTab:CreateSection({
    Name = "Head Dots Settings",
    Side = "Right"
})

local HealthBarSettings = VisualsTab:CreateSection({
    Name = "Health Bar Settings",
    Side = "Right"
})

--// Crosshair Sections

local CrosshairSettings = CrosshairTab:CreateSection({
    Name = "Settings"
})

local CrosshairSettings_CenterDot = CrosshairTab:CreateSection({
    Name = "Center Dot Settings",
    Side = "Right"
})

--// Functions Sections

local FunctionsSection = FunctionsTab:CreateSection({
    Name = "Functions"
})

--// Aimbot Values

Values:AddToggle({
    Name = "Enabled",
    Value = AimbotModule.Settings.Enabled,
    Callback = function(New, Old)
        AimbotModule.Settings.Enabled = New
    end
}).Default = AimbotModule.Settings.Enabled

Values:AddToggle({
    Name = "Toggle",
    Value = AimbotModule.Settings.Toggle,
    Callback = function(New, Old)
        AimbotModule.Settings.Toggle = New
    end
}).Default = AimbotModule.Settings.Toggle

AimbotModule.Settings.LockPart = Parts[1]
Values:AddDropdown({
    Name = "Lock Part",
    Value = Parts[1],
    Callback = function(New, Old)
        AimbotModule.Settings.LockPart = New
    end,
    List = Parts,
    Nothing = "Head"
}).Default = Parts[1]

Values:AddTextbox({
    Name = "Hotkey",
    Value = AimbotModule.Settings.TriggerKey,
    Callback = function(New, Old)
        AimbotModule.Settings.TriggerKey = New
    end
}).Default = AimbotModule.Settings.TriggerKey

Values:AddSlider({
    Name = "Sensitivity",
    Value = AimbotModule.Settings.Sensitivity,
    Callback = function(New, Old)
        AimbotModule.Settings.Sensitivity = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = AimbotModule.Settings.Sensitivity

--// Aimbot Checks

Checks:AddToggle({
    Name = "Team Check",
    Value = AimbotModule.Settings.TeamCheck,
    Callback = function(New, Old)
        AimbotModule.Settings.TeamCheck = New
    end
}).Default = AimbotModule.Settings.TeamCheck

Checks:AddToggle({
    Name = "Wall Check",
    Value = AimbotModule.Settings.WallCheck,
    Callback = function(New, Old)
        AimbotModule.Settings.WallCheck = New
    end
}).Default = AimbotModule.Settings.WallCheck

Checks:AddToggle({
    Name = "Alive Check",
    Value = AimbotModule.Settings.AliveCheck,
    Callback = function(New, Old)
        AimbotModule.Settings.AliveCheck = New
    end
}).Default = AimbotModule.Settings.AliveCheck

--// Aimbot ThirdPerson

ThirdPerson:AddToggle({
    Name = "Enable Third Person",
    Value = AimbotModule.Settings.ThirdPerson,
    Callback = function(New, Old)
        AimbotModule.Settings.ThirdPerson = New
    end
}).Default = AimbotModule.Settings.ThirdPerson

ThirdPerson:AddSlider({
    Name = "Sensitivity",
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
    Name = "Enabled",
    Value = AimbotModule.FOVSettings.Enabled,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Enabled = New
    end
}).Default = AimbotModule.FOVSettings.Enabled

FOV_Values:AddToggle({
    Name = "Visible",
    Value = AimbotModule.FOVSettings.Visible,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Visible = New
    end
}).Default = AimbotModule.FOVSettings.Visible

FOV_Values:AddSlider({
    Name = "Amount",
    Value = AimbotModule.FOVSettings.Amount,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Amount = New
    end,
    Min = 10,
    Max = 300
}).Default = AimbotModule.FOVSettings.Amount

--// FOV Settings Appearance

FOV_Appearance:AddToggle({
    Name = "Filled",
    Value = AimbotModule.FOVSettings.Filled,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Filled = New
    end
}).Default = AimbotModule.FOVSettings.Filled

FOV_Appearance:AddSlider({
    Name = "Transparency",
    Value = AimbotModule.FOVSettings.Transparency,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimal = 1
}).Default = AimbotModule.FOVSettings.Transparency

FOV_Appearance:AddSlider({
    Name = "Sides",
    Value = AimbotModule.FOVSettings.Sides,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Sides = New
    end,
    Min = 3,
    Max = 60
}).Default = AimbotModule.FOVSettings.Sides

FOV_Appearance:AddSlider({
    Name = "Thickness",
    Value = AimbotModule.FOVSettings.Thickness,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Thickness = New
    end,
    Min = 1,
    Max = 50
}).Default = AimbotModule.FOVSettings.Thickness

FOV_Appearance:AddColorpicker({
    Name = "Color",
    Value = AimbotModule.FOVSettings.Color,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.Color = New
    end
}).Default = AimbotModule.FOVSettings.Color

FOV_Appearance:AddColorpicker({
    Name = "Locked Color",
    Value = AimbotModule.FOVSettings.LockedColor,
    Callback = function(New, Old)
        AimbotModule.FOVSettings.LockedColor = New
    end
}).Default = AimbotModule.FOVSettings.LockedColor

--// Wall Hack Settings

WallHackChecks:AddToggle({
    Name = "Enabled",
    Value = WallHack.Settings.Enabled,
    Callback = function(New, Old)
        WallHack.Settings.Enabled = New
    end
}).Default = WallHack.Settings.Enabled

WallHackChecks:AddToggle({
    Name = "Team Check",
    Value = WallHack.Settings.TeamCheck,
    Callback = function(New, Old)
        WallHack.Settings.TeamCheck = New
    end
}).Default = WallHack.Settings.TeamCheck

WallHackChecks:AddToggle({
    Name = "Alive Check",
    Value = WallHack.Settings.AliveCheck,
    Callback = function(New, Old)
        WallHack.Settings.AliveCheck = New
    end
}).Default = WallHack.Settings.AliveCheck

--// Visuals Settings

ESPSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Visuals.ESPSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.Enabled = New
    end
}).Default = WallHack.Visuals.ESPSettings.Enabled

ESPSettings:AddToggle({
    Name = "Outline",
    Value = WallHack.Visuals.ESPSettings.Outline,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.Outline = New
    end
}).Default = WallHack.Visuals.ESPSettings.Outline

ESPSettings:AddToggle({
    Name = "Display Distance",
    Value = WallHack.Visuals.ESPSettings.DisplayDistance,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.DisplayDistance = New
    end
}).Default = WallHack.Visuals.ESPSettings.DisplayDistance

ESPSettings:AddToggle({
    Name = "Display Health",
    Value = WallHack.Visuals.ESPSettings.DisplayHealth,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.DisplayHealth = New
    end
}).Default = WallHack.Visuals.ESPSettings.DisplayHealth

ESPSettings:AddToggle({
    Name = "Display Name",
    Value = WallHack.Visuals.ESPSettings.DisplayName,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.DisplayName = New
    end
}).Default = WallHack.Visuals.ESPSettings.DisplayName

ESPSettings:AddSlider({
    Name = "Offset",
    Value = WallHack.Visuals.ESPSettings.Offset,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.Offset = New
    end,
    Min = -30,
    Max = 30
}).Default = WallHack.Visuals.ESPSettings.Offset

ESPSettings:AddColorpicker({
    Name = "Text Color",
    Value = WallHack.Visuals.ESPSettings.TextColor,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextColor = New
    end
}).Default = WallHack.Visuals.ESPSettings.TextColor

ESPSettings:AddColorpicker({
    Name = "Outline Color",
    Value = WallHack.Visuals.ESPSettings.OutlineColor,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.OutlineColor = New
    end
}).Default = WallHack.Visuals.ESPSettings.OutlineColor

ESPSettings:AddSlider({
    Name = "Text Transparency",
    Value = WallHack.Visuals.ESPSettings.TextTransparency,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextTransparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.ESPSettings.TextTransparency

ESPSettings:AddSlider({
    Name = "Text Size",
    Value = WallHack.Visuals.ESPSettings.TextSize,
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextSize = New
    end,
    Min = 8,
    Max = 24
}).Default = WallHack.Visuals.ESPSettings.TextSize

ESPSettings:AddDropdown({
    Name = "Text Font",
    Value = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1] or "UI",
    Callback = function(New, Old)
        WallHack.Visuals.ESPSettings.TextFont = tablefind(Fonts, New) - 1
    end,
    List = Fonts,
    Nothing = "UI"
}).Default = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1] or "UI"

BoxesSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Visuals.BoxSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Enabled = New
    end
}).Default = WallHack.Visuals.BoxSettings.Enabled

BoxesSettings:AddSlider({
    Name = "Transparency",
    Value = WallHack.Visuals.BoxSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.BoxSettings.Transparency

BoxesSettings:AddSlider({
    Name = "Thickness",
    Value = WallHack.Visuals.BoxSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.BoxSettings.Thickness

BoxesSettings:AddSlider({
    Name = "Scale Increase (For 3D)",
    Value = WallHack.Visuals.BoxSettings.Increase,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Increase = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.BoxSettings.Increase

BoxesSettings:AddColorpicker({
    Name = "Color",
    Value = WallHack.Visuals.BoxSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Color = New
    end
}).Default = WallHack.Visuals.BoxSettings.Color

BoxesSettings:AddDropdown({
    Name = "Type",
    Value = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D",
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Type = New == "3D" and 1 or 2
    end,
    List = {"3D", "2D"},
    Nothing = "3D"
}).Default = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D"

BoxesSettings:AddToggle({
    Name = "Filled (2D Square)",
    Value = WallHack.Visuals.BoxSettings.Filled,
    Callback = function(New, Old)
        WallHack.Visuals.BoxSettings.Filled = New
    end
}).Default = WallHack.Visuals.BoxSettings.Filled

ChamsSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Visuals.ChamsSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Enabled = New
    end
}).Default = WallHack.Visuals.ChamsSettings.Enabled

ChamsSettings:AddToggle({
    Name = "Filled",
    Value = WallHack.Visuals.ChamsSettings.Filled,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Filled = New
    end
}).Default = WallHack.Visuals.ChamsSettings.Filled

ChamsSettings:AddToggle({
    Name = "Entire Body (For R15 Rigs)",
    Value = WallHack.Visuals.ChamsSettings.EntireBody,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.EntireBody = New
    end
}).Default = WallHack.Visuals.ChamsSettings.EntireBody

ChamsSettings:AddSlider({
    Name = "Transparency",
    Value = WallHack.Visuals.ChamsSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.ChamsSettings.Transparency

ChamsSettings:AddSlider({
    Name = "Thickness",
    Value = WallHack.Visuals.ChamsSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Thickness = New
    end,
    Min = 0,
    Max = 3
}).Default = WallHack.Visuals.ChamsSettings.Thickness

ChamsSettings:AddColorpicker({
    Name = "Color",
    Value = WallHack.Visuals.ChamsSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.ChamsSettings.Color = New
    end
}).Default = WallHack.Visuals.ChamsSettings.Color

TracersSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Visuals.TracersSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Enabled = New
    end
}).Default = WallHack.Visuals.TracersSettings.Enabled

TracersSettings:AddSlider({
    Name = "Transparency",
    Value = WallHack.Visuals.TracersSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.TracersSettings.Transparency

TracersSettings:AddSlider({
    Name = "Thickness",
    Value = WallHack.Visuals.TracersSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.TracersSettings.Thickness

TracersSettings:AddColorpicker({
    Name = "Color",
    Value = WallHack.Visuals.TracersSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Color = New
    end
}).Default = WallHack.Visuals.TracersSettings.Color

TracersSettings:AddDropdown({
    Name = "Start From",
    Value = TracersType[WallHack.Visuals.TracersSettings.Type] or "Bottom",
    Callback = function(New, Old)
        WallHack.Visuals.TracersSettings.Type = tablefind(TracersType, New)
    end,
    List = TracersType,
    Nothing = "Bottom"
}).Default = TracersType[WallHack.Visuals.TracersSettings.Type] or "Bottom"

HeadDotsSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Visuals.HeadDotSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Enabled = New
    end
}).Default = WallHack.Visuals.HeadDotSettings.Enabled

HeadDotsSettings:AddToggle({
    Name = "Filled",
    Value = WallHack.Visuals.HeadDotSettings.Filled,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Filled = New
    end
}).Default = WallHack.Visuals.HeadDotSettings.Filled

HeadDotsSettings:AddSlider({
    Name = "Transparency",
    Value = WallHack.Visuals.HeadDotSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.HeadDotSettings.Transparency

HeadDotsSettings:AddSlider({
    Name = "Thickness",
    Value = WallHack.Visuals.HeadDotSettings.Thickness,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Visuals.HeadDotSettings.Thickness

HeadDotsSettings:AddSlider({
    Name = "Sides",
    Value = WallHack.Visuals.HeadDotSettings.Sides,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Sides = New
    end,
    Min = 3,
    Max = 60
}).Default = WallHack.Visuals.HeadDotSettings.Sides

HeadDotsSettings:AddColorpicker({
    Name = "Color",
    Value = WallHack.Visuals.HeadDotSettings.Color,
    Callback = function(New, Old)
        WallHack.Visuals.HeadDotSettings.Color = New
    end
}).Default = WallHack.Visuals.HeadDotSettings.Color

HealthBarSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Visuals.HealthBarSettings.Enabled,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Enabled = New
    end
}).Default = WallHack.Visuals.HealthBarSettings.Enabled

HealthBarSettings:AddDropdown({
    Name = "Position",
    Value = WallHack.Visuals.HealthBarSettings.Type == 1 and "Top" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Bottom" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Left" or "Right",
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Type = New == "Top" and 1 or New == "Bottom" and 2 or New == "Left" and 3 or 4
    end,
    List = {"Top", "Bottom", "Left", "Right"},
    Nothing = "Left"
}).Default = WallHack.Visuals.HealthBarSettings.Type == 1 and "Top" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Bottom" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Left" or "Right"

HealthBarSettings:AddSlider({
    Name = "Transparency",
    Value = WallHack.Visuals.HealthBarSettings.Transparency,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Visuals.HealthBarSettings.Transparency

HealthBarSettings:AddSlider({
    Name = "Size",
    Value = WallHack.Visuals.HealthBarSettings.Size,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Size = New
    end,
    Min = 2,
    Max = 10
}).Default = WallHack.Visuals.HealthBarSettings.Size

HealthBarSettings:AddSlider({
    Name = "Blue",
    Value = WallHack.Visuals.HealthBarSettings.Blue,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Blue = New
    end,
    Min = 0,
    Max = 255
}).Default = WallHack.Visuals.HealthBarSettings.Blue

HealthBarSettings:AddSlider({
    Name = "Offset",
    Value = WallHack.Visuals.HealthBarSettings.Offset,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.Offset = New
    end,
    Min = -30,
    Max = 30
}).Default = WallHack.Visuals.HealthBarSettings.Offset

HealthBarSettings:AddColorpicker({
    Name = "Outline Color",
    Value = WallHack.Visuals.HealthBarSettings.OutlineColor,
    Callback = function(New, Old)
        WallHack.Visuals.HealthBarSettings.OutlineColor = New
    end
}).Default = WallHack.Visuals.HealthBarSettings.OutlineColor

--// Crosshair Settings

CrosshairSettings:AddToggle({
    Name = "Mouse Cursor",
    Value = UserInputService.MouseIconEnabled,
    Callback = function(New, Old)
        UserInputService.MouseIconEnabled = New
    end
}).Default = UserInputService.MouseIconEnabled

CrosshairSettings:AddToggle({
    Name = "Enabled",
    Value = WallHack.Crosshair.Settings.Enabled,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Enabled = New
    end
}).Default = WallHack.Crosshair.Settings.Enabled

CrosshairSettings:AddColorpicker({
    Name = "Color",
    Value = WallHack.Crosshair.Settings.Color,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Color = New
    end
}).Default = WallHack.Crosshair.Settings.Color

CrosshairSettings:AddSlider({
    Name = "Transparency",
    Value = WallHack.Crosshair.Settings.Transparency,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Transparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Crosshair.Settings.Transparency

CrosshairSettings:AddSlider({
    Name = "Size",
    Value = WallHack.Crosshair.Settings.Size,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Size = New
    end,
    Min = 8,
    Max = 24
}).Default = WallHack.Crosshair.Settings.Size

CrosshairSettings:AddSlider({
    Name = "Thickness",
    Value = WallHack.Crosshair.Settings.Thickness,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Thickness = New
    end,
    Min = 1,
    Max = 5
}).Default = WallHack.Crosshair.Settings.Thickness

CrosshairSettings:AddSlider({
    Name = "Gap Size",
    Value = WallHack.Crosshair.Settings.GapSize,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.GapSize = New
    end,
    Min = 0,
    Max = 20
}).Default = WallHack.Crosshair.Settings.GapSize

CrosshairSettings:AddSlider({
    Name = "Rotation (Degrees)",
    Value = WallHack.Crosshair.Settings.Rotation,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Rotation = New
    end,
    Min = -180,
    Max = 180
}).Default = WallHack.Crosshair.Settings.Rotation

CrosshairSettings:AddDropdown({
    Name = "Position",
    Value = WallHack.Crosshair.Settings.Type == 1 and "Mouse" or "Center",
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.Type = New == "Mouse" and 1 or 2
    end,
    List = {"Mouse", "Center"},
    Nothing = "Mouse"
}).Default = WallHack.Crosshair.Settings.Type == 1 and "Mouse" or "Center"

CrosshairSettings_CenterDot:AddToggle({
    Name = "Center Dot",
    Value = WallHack.Crosshair.Settings.CenterDot,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDot = New
    end
}).Default = WallHack.Crosshair.Settings.CenterDot

CrosshairSettings_CenterDot:AddColorpicker({
    Name = "Center Dot Color",
    Value = WallHack.Crosshair.Settings.CenterDotColor,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotColor = New
    end
}).Default = WallHack.Crosshair.Settings.CenterDotColor

CrosshairSettings_CenterDot:AddSlider({
    Name = "Center Dot Size",
    Value = WallHack.Crosshair.Settings.CenterDotSize,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotSize = New
    end,
    Min = 1,
    Max = 6
}).Default = WallHack.Crosshair.Settings.CenterDotSize

CrosshairSettings_CenterDot:AddSlider({
    Name = "Center Dot Transparency",
    Value = WallHack.Crosshair.Settings.CenterDotTransparency,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotTransparency = New
    end,
    Min = 0,
    Max = 1,
    Decimals = 2
}).Default = WallHack.Crosshair.Settings.CenterDotTransparency

CrosshairSettings_CenterDot:AddToggle({
    Name = "Center Dot Filled",
    Value = WallHack.Crosshair.Settings.CenterDotFilled,
    Callback = function(New, Old)
        WallHack.Crosshair.Settings.CenterDotFilled = New
    end
}).Default = WallHack.Crosshair.Settings.CenterDotFilled

--// Functions / Functions

FunctionsSection:AddButton({
    Name = "Reset Settings",
    Callback = function()
        if AimbotModule.Functions then
            AimbotModule.Functions:ResetSettings()
        end
        if WallHack.Functions then
            WallHack.Functions:ResetSettings()
        end
        Library.ResetAll()
    end
})

FunctionsSection:AddButton({
    Name = "Restart",
    Callback = function()
        if AimbotModule.Functions then
            AimbotModule.Functions:Restart()
        end
        if WallHack.Functions then
            WallHack.Functions:Restart()
        end
    end
})

FunctionsSection:AddButton({
    Name = "Exit",
    Callback = Library.Unload
})

--// Error Handling for Exploit Compatibility

local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("Error in function call: " .. tostring(result))
    end
    return result
end

--// Initialize

safeCall(function()
    if Library.Notify then
        Library:Notify("Aimbot loaded successfully!", 3)
    end
end)
