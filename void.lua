
-- https://github.com/ShockerLL22/spts-classic // created by @sky4zprm (dc)

local ReplicatedStorage = Services.ReplicatedStorage
local RemoteEvent = ReplicatedStorage.RemoteEvent
local RemoteFunction = ReplicatedStorage.RemoteFunction
local RunService = Services.RunService
local UserInputService = Services.UserInputService
local TeleportService = Services.TeleportService
local HttpService = Services.HttpService 
local TweenService = Services.TweenService
local Lighting = Services.Lighting
local Stats = Services.Stats
local StarterGui = Services.StarterGui
local VirtualUser = Services.VirtualUser
local Workspace = Services.Workspace
local CoreGui = Services.CoreGui
local Players = Services.Players
local LocalPlayer = Players.LocalPlayer
local PrivateStats = LocalPlayer.PrivateStats
local PlayerGui = LocalPlayer.PlayerGui
local ScreenGui = PlayerGui.ScreenGui
local Camera = Workspace.CurrentCamera
local Storage = Workspace.Storage
local PlaceId = game.PlaceId
local JobId = game.JobId
RemoteEvent:FireServer({"ResetCharacter"})
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

if getgenv().AntiAfkExecuted then 
    getgenv().AntiAfkExecuted = false
end

getgenv().AntiAfkExecuted = true

local virtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
end)
PlayerGui.IntroGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    PlayerGui.IntroGui.Enabled = false
end)

Lighting.Blur:GetPropertyChangedSignal("Enabled"):Connect(function()
    Lighting.Blur.Enabled = false
end)

ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    ScreenGui.Enabled = true
end)

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/fluent-plus.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/savemanager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/interfacemanager.lua"))()
local Window = Fluent:CreateWindow({
	Title = "spts : classic",
	SubTitle = "-- https://github.com/ShockerLL22/spts-classic",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 470),
	Acrylic = true,
	Theme = "Bloody",
	MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
	Main = Window:AddTab({Title = "Main", Icon = "home"}),
	FistStrength = Window:AddTab({Title = "Fist Strength", Icon = "hand"}),
	PhysicPower = Window:AddTab({Title = "Physic Power", Icon = "wifi"}),
	BodyToughness = Window:AddTab({Title = "Body Toughness", Icon = "shield-check"}),
    SpeedJump = Window:AddTab({Title = "Speed & Jump Power", Icon = "rocket"}),
    AutoKill = Window:AddTab({Title = "Auto Kill", Icon = "skull"}),
    Exploits = Window:AddTab({Title = "Fun & Exploits", Icon = "bomb"}),
    Quests = Window:AddTab({Title = "Auto Quest", Icon = "file-question"}),
    Webhook = Window:AddTab({Title = "Webhook", Icon = "webhook"}),
	Settings = Window:AddTab({Title = "Visuals", Icon = "sun-moon"}),
    Settings2 = Window:AddTab({Title = "Settings", Icon = "settings"})
}
local Options = Fluent.Options
Fluent:Notify({Title = "Module", Content = "The script has been loaded.", Duration = 3})
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local lastPos
local themeOptions = {
		"Dark",
		"Darker",
		"Light",
		"Balloon",
		"SoftCream",
		"Aqua", 
		"Amethyst",
		"Rose",
		"Midnight",
		"Forest",
		"Sunset", 
		"Ocean",
		"Emerald",
		"Sapphire",
		"Cloud",
		"Grape",
        "Bloody"
	}
local ThemeDropdown = Tabs.Settings2:AddDropdown("ThemeSelector", {
	Title = "UI Theme",
	Values = themeOptions,
	Multi = false,
	Default = themeOptions[1],
    Description = "crazy colors for the ui"
})
ThemeDropdown:OnChanged(function(selected)
	Fluent:SetTheme(selected)
	print("Theme changed to:", selected)
end)
local AntiLagToggle = Tabs.Main:AddToggle("AntiLagToggle", {
    Title = "Anti Lag",
    Default = false,
    Description = "Enables performance optimizations by disabling unnecessary effects."
})
local originalProperties = {}

AntiLagToggle:OnChanged(function(isOn)
    if isOn then
        if game.Lighting and not originalProperties.Lighting then
            originalProperties.Lighting = {
                GlobalShadows = game.Lighting.GlobalShadows,
                FogEnd = game.Lighting.FogEnd,
                Ambient = game.Lighting.Ambient,
            }
        end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                if originalProperties[obj] == nil then
                    originalProperties[obj] = { Enabled = obj.Enabled }
                end
                obj.Enabled = false
            end
            if obj:IsA("MeshPart") then
                if originalProperties[obj] == nil then
                    originalProperties[obj] = { Color = obj.Color, CastShadow = obj.CastShadow }
                end
                obj.Color = Color3.new(0.5, 0.5, 0.5)
                obj.CastShadow = false
            elseif obj:IsA("BasePart") then
                if originalProperties[obj] == nil then
                    originalProperties[obj] = { CastShadow = obj.CastShadow }
                end
                obj.CastShadow = false
            end
        end
        if game.Lighting then
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 9e9
            game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        end
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            local orig = originalProperties[obj]
            if orig then
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                    if orig.Enabled ~= nil then
                        obj.Enabled = orig.Enabled
                    end
                end
                if obj:IsA("MeshPart") then
                    if orig.Color then
                        obj.Color = orig.Color
                    end
                    if orig.CastShadow ~= nil then
                        obj.CastShadow = orig.CastShadow
                    end
                elseif obj:IsA("BasePart") then
                    if orig.CastShadow ~= nil then
                        obj.CastShadow = orig.CastShadow
                    end
                end
            end
        end
        if game.Lighting and originalProperties.Lighting then
            game.Lighting.GlobalShadows = originalProperties.Lighting.GlobalShadows
            game.Lighting.FogEnd = originalProperties.Lighting.FogEnd
            game.Lighting.Ambient = originalProperties.Lighting.Ambient
        end
        originalProperties = {}
    end
end)
local modeOptions = {"No Area Physic Farm", "With Fly", "First Area 1M", "Second Area 1B", "Third Area 1T", "Final Area 1QA"}
local commandMapping = {
	["No Area Physic Farm"] = "+PP1",
	["With Fly"] = "+PP2",
	["First Area 1M"] = "+PP3",
	["Second Area 1B"] = "+PP4",
	["Third Area 1T"]= "+PP5",
	["Final Area 1QA"] = "+PP6"
}
local areaLocations = {
	["First Area 1M"] = Vector3.new(-2530, 5486, -535),
	["Second Area 1B"] = Vector3.new(-2561, 5501, -444),
	["Third Area 1T"] = Vector3.new(-2583, 5517, -502),
	["Final Area 1QA"] = Vector3.new(-2553, 5413, -490)
}
local PhysicModeDropdown = Tabs.PhysicPower:AddDropdown("PhysicMode", {
	Title = "Physic Power Area",
	Values = modeOptions,
	Multi = false,
	Default = modeOptions[1]
})
PhysicModeDropdown:SetValue(modeOptions[1])
PhysicModeDropdown:OnChanged(function(selected)
	print("Physic Mode changed:", selected)
end)

local FarmPSToggle = Tabs.PhysicPower:AddToggle("FarmPSToggle", {
	Title = "Farm Physic Power [ 1.4x ]",
	Default = false,
	Description = "Farming Physic Power, Faster Than Usual Legit Farming."
})
FarmPSToggle:OnChanged(function(isOn)
    if isOn then
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
        if not remote then return end

        local selectedMode = PhysicModeDropdown.Value
        local command = commandMapping[selectedMode] or "+PP1"

        task.spawn(function()
            while FarmPSToggle.Value do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and areaLocations[selectedMode] then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(areaLocations[selectedMode])
                end
                local args = { [1] = { [1] = command } }
                remote:FireServer(unpack(args))
                local invisArgs = { [1] = { [1] = "Skill_Invisible", [2] = "Start" } }
                remote:FireServer(unpack(invisArgs))
                task.wait(0.0000001)
            end
        end)

        task.spawn(function()
            while FarmPSToggle.Value do
                local tool = player.Backpack:FindFirstChild("Meditate") or player.Character:FindFirstChild("Meditate")
                if tool then
                    if tool.Parent == player.Backpack then
                        tool.Parent = player.Character
                    else
                        tool.Parent = player.Backpack
                    end
                end
                task.wait(0.009)
            end
        end)
    end
end)

local AutoRespawnToggle = Tabs.Main:AddToggle("AutoRespawnToggle", {
    Title = "Auto Respawn [ 35% Health ]",
    Default = false,
    Description = "Auto Respawns when 35% health or lower."
})
AutoRespawnToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            while AutoRespawnToggle.Value do
                local character = player.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.MaxHealth > 0 and humanoid.Health <= (humanoid.MaxHealth * 0.35) then
                        local args = { [1] = { [1] = "Respawn" } }
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                    end
                end
                task.wait(0.45)
            end
        end)
    end
end)

local fsOptions = {"No Area", "Rock Area", "Crystal Area", "Blue God Star", "Green God Star", "Red God Star"}
local fsMapping = {
	["No Area"] = "+FS1",
	["Rock Area"] = "+FS2",
	["Crystal Area"] = "+FS3",
	["Blue God Star"] = "+FS4",
	["Green God Star"] = "+FS5",
	["Red God Star"] = "+FS6"
}
local tpMapping = {
	["Blue God Star"] = Vector3.new(1177, 4789, -2297),
	["Green God Star"] = Vector3.new(1378, 9274, 1647),
	["Red God Star"] = Vector3.new(-366, 15735, -11)
}
local fsDropdown = Tabs.FistStrength:AddDropdown("FistStrengthArea", {
	Title = "Fist Strength Area",
	Values = fsOptions,
	Multi = false,
	Default = fsOptions[1]
})
local FarmFSToggle = Tabs.FistStrength:AddToggle("FarmFSToggle", {
	Title = "Farm Fist Strength [ 1.2x ]",
	Default = false,
	Description = "Farms Fist Strength, 1.2x Faster Than Usual Legit Farming."
})
FarmFSToggle:OnChanged(function(isOn)
	if isOn then
		local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
		task.spawn(function()
			while FarmFSToggle.Value do
				local selectedFS = fsDropdown.Value
				local command = fsMapping[selectedFS]
				if command then
					local args = { [1] = { [1] = command } }
					remote:FireServer(unpack(args))
				end
				if tpMapping[selectedFS] and game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
					local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = CFrame.new(tpMapping[selectedFS])
					end
				end
				task.wait()
			end
		end)
	end
end)
local btOptions = {"No Area Farming", "Ice Bath", "Fire Bath", "IceBerg", "Tornado", "Volcano", "Hell Fire Pit", "Green Acid Pool", "Red Acid Pool"}
local btLocations = {
	["Ice Bath"] = Vector3.new(364, 250, -446),
	["Fire Bath"] = Vector3.new(355, 264, -493),
	["IceBerg"] = Vector3.new(1638, 259, 2248),
	["Tornado"] = Vector3.new(-2300, 977, 1075),
	["Volcano"] = Vector3.new(-1981, 714, -1921),
	["Hell Fire Pit"] = Vector3.new(-246, 287, 984),
	["Green Acid Pool"] = Vector3.new(-269, 281, 988),
	["Red Acid Pool"] = Vector3.new(-269, 282, 1007)
}
local btDropdown = Tabs.BodyToughness:AddDropdown("BTLocation", {
	Title = "Body Toughness Area",
	Values = btOptions,
	Multi = false,
	Default = btOptions[1]
})

local FarmBTToggle = Tabs.BodyToughness:AddToggle("FarmBTToggle", {
	Title = "Farm Body Toughness [ 1.0x ]",
	Default = false,
    Description = "Farming Body Toughness, can be very fast if used correctly."
})

FarmBTToggle:OnChanged(function(isOn)
	if isOn then
		task.spawn(function()
			while FarmBTToggle.Value do
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local selectedBT = btDropdown.Value
					if selectedBT == "No Area Farming" then
						local args = { { "+BT1" } }
						game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
					else
						local loc = btLocations[selectedBT]
						if loc then
							player.Character.HumanoidRootPart.CFrame = CFrame.new(loc)
						end
					end
				end
				task.wait()
			end
		end)
	end
end)
local DeathGrindingToggle = Tabs.BodyToughness:AddToggle("DeathGrindingToggle", {
	Title = "BodyToughness Death Farming",
	Default = false,
	Description = "turn on auto respawn in order to be effective. this autofarm is heavily reccomended to use. its the fastest, and most powerful."
})
DeathGrindingToggle:OnChanged(function(isOn)
	if isOn then
		task.spawn(function()
			while DeathGrindingToggle.Value do
				local bt = player.PrivateStats.BodyToughness.Value
				if bt >= 5 and bt < 500 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Ice Bath"])
					end
				elseif bt >= 500 and bt < 5000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Fire Bath"])
					end
				elseif bt >= 5000 and bt < 50000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["IceBerg"])
					end
				elseif bt >= 50000 and bt < 500000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Tornado"])
					end
				elseif bt >= 500000 and bt < 50000000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Volcano"])
					end
				elseif bt >= 50000000 and bt < 5000000000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Hell Fire Pit"])
					end
				elseif bt >= 5000000000 and bt < 500000000000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Green Acid Pool"])
					end
				elseif bt >= 500000000000 then
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(btLocations["Red Acid Pool"])
					end
				end
				task.wait()
			end
		end)
	end
end)
local FarmJFToggle = Tabs.SpeedJump:AddToggle("FarmJFToggle", {
    Title = "Farm Jump Force",
    Default = false,
    Description = "Farms Jump Force with 100 tons, without actually having the requirement."
})

FarmJFToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
            while FarmJFToggle.Value do
                local args1 = { [1] = { [1] = "+JF5" } }
                remote:FireServer(unpack(args1))
                local args2 = { [1] = { [1] = "Weight", [2] = "Weight4" } }
                remote:FireServer(unpack(args2))
                task.wait()
            end
        end)
    end
end)

local FarmMSToggle = Tabs.SpeedJump:AddToggle("FarmMSToggle", {
    Title = "Farm Movement Speed ",
    Default = false,
    Description = "Farms Movement Speed with 100 tons, without actually having the requirement."
})

FarmMSToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
            while FarmMSToggle.Value do
                local args1 = { [1] = { [1] = "+MS5" } }
                remote:FireServer(unpack(args1))
                local args2 = { [1] = { [1] = "Weight", [2] = "Weight4" } }
                remote:FireServer(unpack(args2))
                task.wait()
            end
        end)
    end
end)
local function arraysEqual(a, b)
    if #a ~= #b then return false end
    for i = 1, #a do
        if a[i] ~= b[i] then return false end
    end
    return true
end
local SoulAttackDropdown = Tabs.PhysicPower:AddDropdown("SoulAttackDropdown", {
    Title = "Players",
    Values = {},
    Multi = false,
    Default = ""
})
local previousSoulNames = {}
local function updateSoulAttackDropdown()
    local players = game:GetService("Players"):GetPlayers()
    local names = {}
    for _, plr in ipairs(players) do
        table.insert(names, plr.Name)
    end
    table.sort(names)
    table.sort(previousSoulNames)
    if arraysEqual(names, previousSoulNames) then
        return
    end
    previousSoulNames = names
    local currentSelection = SoulAttackDropdown.Value
    SoulAttackDropdown:SetValues(names)
    if table.find(names, currentSelection) then
        SoulAttackDropdown:SetValue(currentSelection)
    else
        if #names > 0 then
            SoulAttackDropdown:SetValue(names[1])
        end
    end
end
updateSoulAttackDropdown()
Tabs.PhysicPower:AddButton({
    Title = "Refresh Players",
    Description = "Click to refresh the players list for Soul Attack.",
    Callback = function()
        updateSoulAttackDropdown()
        Fluent:Notify({Title = "Players Updated", Content = "Soul Attack players list has been refreshed.", Duration = 2})
    end
})
local SoulAttackToggle = Tabs.PhysicPower:AddToggle("SoulAttackToggle", {
    Title = "Auto Soul Attack (B)",
    Default = false,
    Description = "Soul Attacking a person with b move."
})
SoulAttackToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            while SoulAttackToggle.Value do
                local targetName = SoulAttackDropdown.Value
                local targetPlayer = game:GetService("Players"):WaitForChild(targetName)
                local localPlayer = game:GetService("Players").LocalPlayer

                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") and
                   localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
                   
                    local targetHumanoid = targetPlayer.Character.Humanoid
                    local localHumanoid = localPlayer.Character.Humanoid

                    if targetHumanoid.Health > 0 and localHumanoid.Health > 0 then
                        if targetPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            localPlayer.Character.HumanoidRootPart.CFrame =
                                targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                        end
                        local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
                        local argsStart = { [1] = { [1] = "Skill_SoulAttack_Start", [2] = targetPlayer } }
                        remote:FireServer(unpack(argsStart))
                        local argsEnd = { [1] = { [1] = "Skill_SoulAttack_End" } }
                        remote:FireServer(unpack(argsEnd))
                    end
                end

                task.wait(0.1)
            end
        end)
    end
end)
local PunchPlayerDropdown = Tabs.FistStrength:AddDropdown("PunchPlayers", {
	Title = "Players",
	Values = {},
	Multi = false,
	Default = ""
})
local previousPunchNames = {}

local function updatePunchPlayerDropdown()
	local players = game:GetService("Players"):GetPlayers()
	local names = {}
	for _, plr in ipairs(players) do
		table.insert(names, plr.Name)
	end
	table.sort(names)
	table.sort(previousPunchNames)
	if arraysEqual(names, previousPunchNames) then
		return
	end
	previousPunchNames = names
	local currentSelection = PunchPlayerDropdown.Value
	PunchPlayerDropdown:SetValues(names)
	if table.find(names, currentSelection) then
		PunchPlayerDropdown:SetValue(currentSelection)
	else
		if #names > 0 then
			PunchPlayerDropdown:SetValue(names[1])
		end
	end
end

updatePunchPlayerDropdown()
Tabs.FistStrength:AddButton({
	Title = "Refresh Players",
	Description = "Click to refresh the players list for Auto Punch.",
	Callback = function()
		updatePunchPlayerDropdown()
		Fluent:Notify({Title = "Players Updated", Content = "Auto Punch players list has been refreshed.", Duration = 2})
	end
})

local AutoPunchToggle = Tabs.FistStrength:AddToggle("AutoPunchToggle", {
	Title = "Auto Punch (C)",
	Default = false,
    Description = "Kills automatically a person with a Punch C move."
})
AutoPunchToggle:OnChanged(function(isOn)
	if isOn then
		task.spawn(function()
			while AutoPunchToggle.Value do
				local targetName = PunchPlayerDropdown.Value
				local targetPlayer = game:GetService("Players"):WaitForChild(targetName)
				if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					targetPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
					local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
					local args = { [1] = { [1] = "Skill_Punch", [2] = "Right" } }
					remote:FireServer(unpack(args))
				end
				task.wait(0.01)
			end
		end)
	end
end)
local function formatStat(n)
    n = tonumber(n) or 0
    local absVal = math.abs(n)
    if absVal < 1e3 then
        return tostring(n)
    elseif absVal < 1e6 then
        return string.format("%.2fK", n/1e3)
    elseif absVal < 1e9 then
        return string.format("%.2fM", n/1e6)
    elseif absVal < 1e12 then
        return string.format("%.2fB", n/1e9)
    elseif absVal < 1e15 then
        return string.format("%.2fT", n/1e12)
    elseif absVal < 1e18 then
        return string.format("%.2fQa", n/1e15)
    else
        return string.format("%.2fQi", n/1e18)
    end
end
local webhookUrl = ""
local WebhookInput = Tabs.Webhook:AddInput("WebhookUrl", {
	Title = "Webhook URL",
	Default = "",
	Description = "discord feature"
})
WebhookInput:OnChanged(function(val)
	webhookUrl = val
end)

local WebhookToggle = Tabs.Webhook:AddToggle("WebhookToggle", {
	Title = "Enable Webhook",
	Default = false,
	Description = "If enabled, sends an embed with your stats (Alive Time, Body Toughness, Fist Strength, Physic Power, Tokens) every minute."
})
WebhookToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            local colors = {
                0x1ABC9C, 0x2ECC71, 0x3498DB, 0x9B59B6, 0x34495E,
                0x16A085, 0x27AE60, 0x2980B9, 0x8E44AD, 0x2C3E50,
                0xF1C40F, 0xE67E22, 0xE74C3C, 0xECF0F1, 0x95A5A6,
                0xF39C12, 0xD35400, 0xC0392B, 0xBDC3C7, 0x7F8C8D
            }
            while WebhookToggle.Value do
                if webhookUrl and webhookUrl ~= "" then
                    local stats = player.PrivateStats
                    local randomColor = colors[math.random(#colors)]
                    local data = {
                        ["content"] = "",
                        ["embeds"] = {{
                            ["title"] = player.Name .. " - Stats Update",
                            ["description"] = "Here is the latest update on your stats.",
                            ["color"] = randomColor,
                            ["fields"] = {
                                {["name"] = "Alive Time :hourglass:", ["value"] = tostring(stats.AliveTime.Value), ["inline"] = true},
                                {["name"] = "Body Toughness :heart: :man_lifting_weights:", ["value"] = formatStat(stats.BodyToughness.Value), ["inline"] = true},
                                {["name"] = "Fist Strength :muscle:", ["value"] = formatStat(stats.FistStrength.Value), ["inline"] = true},
                                {["name"] = "Psychic Power :brain:", ["value"] = formatStat(stats.PsychicPower.Value), ["inline"] = true},
                                {["name"] = "Tokens :skull:", ["value"] = tostring(stats.Token.Value), ["inline"] = true},
                            },
                            ["footer"] = {
                                ["text"] = "Player: " .. player.Name,
                            },
                            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                        }},
                    }
                    local jsonData = game:GetService("HttpService"):JSONEncode(data)
                    local headers = {["Content-Type"] = "application/json"}
                    local requestData = {
                        Url = webhookUrl,
                        Method = "POST",
                        Headers = headers,
                        Body = jsonData
                    }
                    if request then
                        request(requestData)
                    elseif http_request then
                        http_request(requestData)
                    elseif syn and syn.request then
                        syn.request(requestData)
                    else
                        warn("No valid HTTP request function available.")
                    end
                end
                task.wait(60)
            end
        end)
    end
end)
local dailyQuests = {
    {"DLQ", "JF", "Claim"},
    {"DLQ", "FS", "Claim"},
    {"DLQ", "PP", "Claim"},
    {"DLQ", "MS", "Claim"},
    {"DLQ", "BT", "Claim"}
}

local weeklyQuests = {
    {"WLQ", "FS1", "Claim"},
    {"WLQ", "BT1", "Claim"},
    {"WLQ", "PP1", "Claim"},
    {"WLQ", "FS2", "Claim"},
    {"WLQ", "BT2", "Claim"},
    {"WLQ", "PP2", "Claim"},
    {"WLQ", "FS3", "Claim"},
    {"WLQ", "BT3", "Claim"},
    {"WLQ", "FS4", "Claim"},
    {"WLQ", "BT4", "Claim"},
    {"WLQ", "PP3", "Claim"},
    {"WLQ", "PP4", "Claim"}
}

local AutoClaimToggle = Tabs.Quests:AddToggle("AutoClaimToggle", {
    Title = "Auto Claim Quests",
    Default = false,
    Description = "Automatically claim Daily and Weekly Quests."
})

AutoClaimToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            while AutoClaimToggle.Value do
                for _, quest in ipairs(dailyQuests) do
                    local args = { quest }
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                    task.wait(0.5)  
                end
                for _, quest in ipairs(weeklyQuests) do
                    local args = { quest }
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                    task.wait(0.5)
                end
                task.wait(1)  
            end
        end)
    end
end)
Tabs.Exploits:AddButton({
    Title = "GodMode Exploit",
    Description = "Activate Godmode for the player using rider forcefield.",
    Callback = function()
        local VirtualInputManager = game:GetService("VirtualInputManager")
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        local shield = humanoidRootPart:FindFirstChild("GameModeShield")
        local shield2 = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart:FindFirstChild("GameModeShield")

        if not (character:FindFirstChild("ForceField") or shield) then
            if humanoidRootPart then
                humanoidRootPart.CFrame = CFrame.new(160, 249, 1234)
            end

            task.wait(2.5)

            VirtualInputManager:SendMouseButtonEvent(1322, 166, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(1322, 166, 0, false, game, 0)

            task.wait(1.7)

            camera.CameraType = Enum.CameraType.Custom
            camera.CFrame = CFrame.new(character.Head.Position + Vector3.new(0, 5, -10), player.Character.Head.Position)

            local function enableTPWalk()
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                    while true do
                        task.wait(0.01)
                        if humanoid.MoveDirection.Magnitude > 0 then
                            humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoid.MoveDirection * 2
                        end
                    end
                end
            end

            enableTPWalk()
        end
    end
})
local RainbowRankToggle = Tabs.Exploits:AddToggle("RainbowRankToggle", {
    Title = "Rainbow Rank",
    Default = false,
    Description = "Do I really need an explanation?"
})

RainbowRankToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            while RainbowRankToggle.Value do
                for rank = 1, 10 do
                    if not RainbowRankToggle.Value then break end
                    local args = {
                        [1] = {
                            [1] = "ChangeRankEmblem",
                            [2] = rank
                        }
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

local AutoReconnectToggle = Tabs.Main:AddToggle("AutoReconnectToggle", {
    Title = "Auto Reconnect",
    Default = false,
    Description = "Automatically reconnects when error messages appear. does not work for private servers."
})

local errorConnection

AutoReconnectToggle:OnChanged(function(isOn)
    if isOn then
        if not errorConnection then
            errorConnection = GuiService.ErrorMessageChanged:Connect(function(errorMessage)
                if errorMessage and errorMessage ~= "" then
                    print("Error detected: " .. errorMessage)
                    wait(0.1)  
                    TeleportService:Teleport(game.PlaceId, player)
                end
            end)
        end
    else
        if errorConnection then
            errorConnection:Disconnect()
            errorConnection = nil
        end
    end
end)
Tabs.Main:AddButton({
    Title = "Save Config",
    Description = "Save your current settings for the next server change session.",
    Callback = function()
        Window:Dialog({
            Title = "Save Confirmation",
            Content = "Do you want to save your current config?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        SaveManager:Save("main")
                        Fluent:Notify({
                            Title = "Config Saved",
                            Content = "Your settings have been saved successfully.",
                            Duration = 3
                        })
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        Fluent:Notify({
                            Title = "Action Cancelled",
                            Content = "Save operation was cancelled.",
                            Duration = 3
                        })
                    end
                }
            }
        })
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function abbreviateNumber(num)
	local abbreviations = {"", "K", "M", "B", "T", "Qa", "Qi"}
	local index = 1
	while num >= 1000 and index < #abbreviations do
		num = num / 1000
		index = index + 1
	end
	return string.format("%.2f%s", num, abbreviations[index])
end

local function compareStat(localValue, remoteValue)
	if remoteValue == 0 or localValue == 0 then
		return "N/A", "#FFFFFF"
	end
	local ratio, color
	if localValue > remoteValue then
		ratio = localValue / remoteValue
		color = "#00FF00"
	elseif localValue < remoteValue then
		ratio = remoteValue / localValue
		color = "#FF0000"
	else
		ratio = 1
		color = "#FFFFFF"
	end
	return string.format("x%.2f", ratio), color
end

local function updateESPForPlayer(player)
	if not player.Character then return end
	local head = player.Character:FindFirstChild("Head")
	if not head then return end
	local esp = player.Character:FindFirstChild("ESP")
	if not esp then
		esp = Instance.new("BillboardGui")
		esp.Name = "ESP"
		esp.Adornee = head
		esp.Size = UDim2.new(8, 0, 3, 0)
		esp.StudsOffset = Vector3.new(0, 4, 0)
		esp.AlwaysOnTop = true
		local label = Instance.new("TextLabel")
		label.Name = "StatsLabel"
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.TextScaled = true
		label.TextSize = 30
		label.RichText = true
		label.Parent = esp
		esp.Parent = player.Character
	end
	local label = esp:FindFirstChild("StatsLabel")
	if not label then return end
	local pStats = player:FindFirstChild("PrivateStats")
	local lStats = LocalPlayer:FindFirstChild("PrivateStats")
	if not (pStats and lStats) then return end
	local pPsychic = pStats:FindFirstChild("PsychicPower")
	local pFist = pStats:FindFirstChild("FistStrength")
	local pBody = pStats:FindFirstChild("BodyToughness")
	local lPsychic = lStats:FindFirstChild("PsychicPower")
	local lFist = lStats:FindFirstChild("FistStrength")
	local lBody = lStats:FindFirstChild("BodyToughness")
	if not (pPsychic and pFist and pBody and lPsychic and lFist and lBody) then return end
	local ppMulti, ppColor = compareStat(lPsychic.Value, pPsychic.Value)
	local fsMulti, fsColor = compareStat(lFist.Value, pFist.Value)
	local btMulti, btColor = compareStat(lBody.Value, pBody.Value)
	local ppValue = abbreviateNumber(pPsychic.Value)
	local fsValue = abbreviateNumber(pFist.Value)
	local btValue = abbreviateNumber(pBody.Value)
	local statsText = string.format(
		"%s\nPP: %s (<font color='%s'>%s</font>)\nFS: %s (<font color='%s'>%s</font>)\nBT: %s (<font color='%s'>%s</font>)",
		player.Name,
		ppValue, ppColor, ppMulti,
		fsValue, fsColor, fsMulti,
		btValue, btColor, btMulti
	)
	label.Text = statsText
end

local ESPToggle = Tabs.Settings:AddToggle("ESPToggle", {
	Title = "True Identity",
	Default = true,
	Description = "Display ESP for player stats with comparison, showing their true identity."
})
ESPToggle:OnChanged(function(isOn)
	if not isOn then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("ESP") then
				player.Character.ESP:Destroy()
			end
		end
	end
end)

RunService.Heartbeat:Connect(function()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if ESPToggle.Value then
				updateESPForPlayer(player)
			elseif player.Character and player.Character:FindFirstChild("ESP") then
				player.Character.ESP:Destroy()
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if player.Character and player.Character:FindFirstChild("ESP") then
		player.Character.ESP:Destroy()
	end
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if character:FindFirstChild("ESP") then
			character.ESP:Destroy()
		end
	end)
end)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local function getNameTextLabel()
    if localPlayer.Character then
        local head = localPlayer.Character:FindFirstChild("Head")
        if head then
            local nameBbGui = head:FindFirstChild("NameBbGui")
            if nameBbGui then
                return nameBbGui:FindFirstChild("NameTxt")
            end
        end
    end
    return nil
end
local RainbowToggle = Tabs.Settings:AddToggle("RainbowToggle", {
    Title = "Rainbow Name",
    Default = false,
    Description = "rainbow name for your username;)"
})
RainbowToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            local hue = 0
            while RainbowToggle.Value do
                local textLabel = getNameTextLabel()
                if textLabel then
                    hue = (hue + 0.01) % 1
                    textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
                end
                task.wait(0.1)
            end
        end)
    else
        local textLabel = getNameTextLabel()
        if textLabel then
            textLabel.TextColor3 = Color3.new(1, 1, 1)  
        end
    end
end)
local RainbowLaserToggle = Tabs.Settings:AddToggle("RainbowLaserToggle", {
    Title = "Rainbow Laser",
    Default = false,
    Description = "rainbow laser good good ye ye"
})

RainbowLaserToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            local hue = 0
            while RainbowLaserToggle.Value do
                local part = workspace:FindFirstChild("Part")
                if part then
                    hue = (hue + 0.01) % 1
                    part.Color = Color3.fromHSV(hue, 1, 1)
                end
                task.wait(0.0001)
            end
        end)
    else
        local part = workspace:FindFirstChild("Part")
        if part then
            part.Color = Color3.new(1, 1, 1) 
        end
    end
end)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local FinalRank = Tabs.Exploits:AddToggle("FinalRank", {
    Title = "ClientSide Final Rank",
    Default = false,
    Description = "Do I really need an explanation?"
})
FinalRank:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            while FinalRank.Value do
                local character = LocalPlayer.Character
                if character then
                    local head = character:FindFirstChild("Head")
                    if head then
                        local gui = head:FindFirstChild("RankBbGui")
                        if gui then
                            local img = gui:FindFirstChild("RankImg")
                            if img then
                                img.Image = "rbxassetid://2202378137"
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end)
local KillAllAutoPunchToggle = Tabs.AutoKill:AddToggle("KillAllAutoPunchToggle", {
	Title = "Kill All AutoPunch (C)",
	Default = false,
	Description = "Automatically punches every player whose BodyToughness is lower than your FistStrength"
})
KillAllAutoPunchToggle:OnChanged(function(isOn)
	if isOn then
		task.spawn(function()
			while KillAllAutoPunchToggle.Value do
				local players = game:GetService("Players"):GetPlayers()
				for _, targetPlayer in ipairs(players) do
					if not KillAllAutoPunchToggle.Value then break end
					if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						if targetPlayer:FindFirstChild("PrivateStats") and player:FindFirstChild("PrivateStats") then
							if targetPlayer.PrivateStats:FindFirstChild("BodyToughness") and player.PrivateStats:FindFirstChild("FistStrength") then
								if targetPlayer.PrivateStats.BodyToughness.Value < player.PrivateStats.FistStrength.Value then
									local startTime = tick()
									while tick() - startTime < 0.001 and KillAllAutoPunchToggle.Value do
										if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
											targetPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
											local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
											local args = { [1] = { [1] = "Skill_Punch", [2] = "Right" } }
											remote:FireServer(unpack(args))
										end
										task.wait(0.000001)
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end)
local KillAllAutoSoulAttackToggle = Tabs.AutoKill:AddToggle("KillAllAutoSoulAttackToggle", {
	Title = "Kill All Auto Soul Attack (B)",
	Default = false,
	Description = "Automatically soul attacks every player whose PhysicPower is lower than your PhysicPower "
})
KillAllAutoSoulAttackToggle:OnChanged(function(isOn)
    if isOn then
        task.spawn(function()
            while KillAllAutoSoulAttackToggle.Value do
                local players = game:GetService("Players"):GetPlayers()
                for _, targetPlayer in ipairs(players) do
                    if not KillAllAutoSoulAttackToggle.Value then break end
                    local localPlayer = game:GetService("Players").LocalPlayer
                    if targetPlayer ~= localPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                        if targetHumanoid and targetHumanoid.Health > 0 then
                            local targetPsychicPower = targetPlayer:FindFirstChild("PrivateStats") and targetPlayer.PrivateStats:FindFirstChild("PsychicPower")
                            local localPsychicPower = localPlayer:FindFirstChild("PrivateStats") and localPlayer.PrivateStats:FindFirstChild("PsychicPower")
                            
                            if targetPsychicPower and localPsychicPower and targetPsychicPower.Value < localPsychicPower.Value then
                                local startTime = tick()
                                while tick() - startTime < 0.5 and KillAllAutoSoulAttackToggle.Value do
                                    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                        localPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                                        local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
                                        local argsStart = { [1] = { [1] = "Skill_SoulAttack_Start", [2] = targetPlayer } }
                                        remote:FireServer(unpack(argsStart))
                                        local argsEnd = { [1] = { [1] = "Skill_SoulAttack_End" } }
                                        remote:FireServer(unpack(argsEnd))
                                    end
                                    task.wait(0.001)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
local AutoKillRStackingToggle = Tabs.AutoKill:AddToggle("AutoKillRStackingToggle", {
	Title = "Kill All R Stacking (R)",
	Default = false,
	Description = "Automatically stacks energy spheres and sends sphere punch remote"
})
AutoKillRStackingToggle:OnChanged(function(isOn)
	if isOn then
		local players = game:GetService("Players")
		local replicatedStorage = game:GetService("ReplicatedStorage")
		local storage = workspace:FindFirstChild("Storage")
		local localPlayer = players.LocalPlayer
		local localChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		local localStats = localPlayer:WaitForChild("PrivateStats")
		local localFistStrength = localStats:WaitForChild("FistStrength").Value
		if not storage then return end

		spawn(function()
			while AutoKillRStackingToggle.Value do
				replicatedStorage:WaitForChild("RemoteEvent"):FireServer({"Skill_SpherePunch", Vector3.new(0, 1e20, 0)})
				task.wait(0.05)
			end
		end)

		spawn(function()
			while AutoKillRStackingToggle.Value do
				local Targets = {}
				for _, player in ipairs(players:GetPlayers()) do
					if player ~= localPlayer then
						local char = player.Character
						if char and char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health > 0 then
							local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
							local targetStats = player:FindFirstChild("PrivateStats")
							if torso and targetStats then
								local targetBodyToughness = targetStats:FindFirstChild("BodyToughness")
								if targetBodyToughness and (targetBodyToughness.Value < localFistStrength * 1.1) then
									table.insert(Targets, player)
								end
							end
						end
					end
				end
				for _, Target in pairs(Targets) do
					task.spawn(function()
						if Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
							Target.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1e5, 0)
							for _, sphere in pairs(storage:GetChildren()) do
								if not localPlayer.Character:FindFirstChild("GodModeShield") and not localPlayer.Character:FindFirstChild("GodModeShield ") and not localPlayer.Character:FindFirstChild("ForceField") and not localPlayer.Character:FindFirstChild("SafeZoneShield") then
									task.spawn(function()
										firetouchinterest(Target.Character.HumanoidRootPart, sphere, 0)
									end)
								end
							end
						end
					end)
				end
				task.wait(0.001)
			end
		end)
	end
end)
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
Window:SelectTab(1)
Fluent:Notify({Title = "spts : classic", Content = "!", Duration = 2})
SaveManager:Load("main")
SaveManager:LoadAutoloadConfig()
