-- https://github.com/ShockerLL22/spts-classic // created by @sky4zprm (dc)
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/fluent-plus.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/savemanager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/interfacemanager.lua"))()

local Window = Fluent:CreateWindow({
	Title = "💥SPTS Classic [ Undetected ]",
	SubTitle = "-- https://github.com/ShockerLL22/spts-classic",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 470),
	Acrylic = true,
	Theme = "Bloody",
	MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
	Main = Window:AddTab({Title = "Main", Icon = "home"}),
	Farming = Window:AddTab({Title = "Farming", Icon = "flame"})
}

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
Window:SelectTab(1)

Fluent:Notify({Title = "spts : classic", Content = "!", Duration = 2})

SaveManager:Load("main")
SaveManager:LoadAutoloadConfig()

local AutoFarmFist = false
local AutoFarmBT = false
local AutoFarmPhys = false
local lastTeleportPos = nil
local lastBTTeleportPos = nil
local lastPhysTeleportPos = nil

Tabs.Farming:AddToggle("AutoFarmFist", {
	Title = "Auto Farm Fist Strength",
	Default = false,
	Callback = function(state)
		AutoFarmFist = state
	end
})
local AntiAFK = false

Tabs.Main:AddToggle("AntiAFK", {
    Title = "Anti AFK",
    Default = false,
    Callback = function(state)
        AntiAFK = state
    end
})

task.spawn(function()
    local vu = game:GetService("VirtualUser")
    local player = game:GetService("Players").LocalPlayer

    player.Idled:Connect(function()
        if AntiAFK then
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end
    end)

    while true do
        task.wait(0.5)
        if AntiAFK then
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end
    end
end)

Tabs.Farming:AddToggle("AutoFarmBT", {
	Title = "Auto Farm Body Toughness",
	Default = false,
	Callback = function(state)
		AutoFarmBT = state
	end
})

Tabs.Farming:AddToggle("AutoFarmPhys", {
	Title = "Auto Farm Physic Power",
	Default = false,
	Callback = function(state)
		AutoFarmPhys = state
	end
})

local function parseValue(str)
	str = str:gsub(",", ""):upper()
	local multipliers = {
		K = 1e3,
		M = 1e6,
		B = 1e9,
		T = 1e12,
		QA = 1e15,
	}
	local mult = 1
	for suffix, mul in pairs(multipliers) do
		if str:find(suffix) then
			mult = mul
			str = str:gsub(suffix, "")
			break
		end
	end
	local num = tonumber(str) or 0
	return num * mult
end

local function getFistLocation(strength)
	if strength >= 1e13 then
		return Vector3.new(-345, 15726, 9)
	elseif strength >= 1e11 then
		return Vector3.new(1381, 9274, 1651)
	elseif strength >= 1e9 then
		return Vector3.new(1176, 4789, -2292)
	elseif strength >= 10000 then
		return Vector3.new(-2277, 1943, 1053)
	elseif strength >= 0 then
		return Vector3.new(408, 270, 970)
	end
	return nil
end

local function getBTLocation(strength)
	if strength >= 3.8e13 then
		return Vector3.new(-276, 280, 1013)
	elseif strength >= 3.8e11 then
		return Vector3.new(-270, 281, 989)
	elseif strength >= 3.8e9 then
		return Vector3.new(-245, 287, 974)
	elseif strength >= 3.8e7 then
		return Vector3.new(-2005, 713, -1901)
	elseif strength >= 3.8e6 then
		return Vector3.new(-2300, 975, 1063)
	elseif strength >= 380000 then
		return Vector3.new(1629, 260, 2245)
	elseif strength >= 38000 then
		return Vector3.new(356, 264, -490)
	elseif strength >= 380 then
		return Vector3.new(368, 250, -444)
	end
	return nil
end

local function getPhysLocation(strength)
	if strength >= 1e15 then -- QA
		return Vector3.new(-2547, 5412, -493)
	elseif strength >= 1e12 then -- T
		return Vector3.new(-2580, 5516, -503)
	elseif strength >= 1e9 then -- B
		return Vector3.new(-2561, 5501, -436)
	elseif strength >= 1e6 then -- M (1M or above)
		return Vector3.new(-2530, 5486, -527)
	end
	return nil
end

task.spawn(function()
	local player = game:GetService("Players").LocalPlayer
	while true do
		task.wait(0.1)
		if AutoFarmFist or AutoFarmBT or AutoFarmPhys then
			local backpack = player:FindFirstChild("Backpack")
			local character = player.Character

			if AutoFarmFist and backpack then
				local tool = backpack:FindFirstChild("Fist Training")
				if tool then
					pcall(function()
						tool.Parent = character
					end)
				end
			end
			if AutoFarmBT and backpack then
				local tool = backpack:FindFirstChild("Push Up")
				if tool then
					pcall(function()
						tool.Parent = character
					end)
				end
			end
			if AutoFarmPhys and backpack then
				local tool = backpack:FindFirstChild("Meditate")
				if tool then
					pcall(function()
						tool.Parent = character
					end)
				end
			end

			if character then
				if AutoFarmFist then
					local tool = character:FindFirstChild("Fist Training")
					if tool and tool:IsA("Tool") then
						pcall(function()
							tool:Activate()
						end)
					end
				end
				if AutoFarmBT then
					local tool = character:FindFirstChild("Push Up")
					if tool and tool:IsA("Tool") then
						pcall(function()
							tool:Activate()
						end)
					end
				end
				if AutoFarmPhys then
					local tool = character:FindFirstChild("Meditate")
					if tool and tool:IsA("Tool") then
						pcall(function()
							tool:Activate()
						end)
					end
				end
			end

			local gui = player:FindFirstChild("PlayerGui")
			if gui then
				local screen = gui:FindFirstChild("ScreenGui")
				if screen then
					local menu = screen:FindFirstChild("MenuFrame")
					if menu then
						local info = menu:FindFirstChild("InfoFrame")
						if info then
							if AutoFarmFist then
								local fstxt = info:FindFirstChild("FSTxt")
								if fstxt and fstxt:IsA("TextLabel") then
									local val = fstxt.Text:match("Fist Strength%s*:%s*(.+)")
									if val then
										local strength = parseValue(val)
										local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
										if root then
											local targetPos = getFistLocation(strength)
											if targetPos then
												if (not lastTeleportPos) or (lastTeleportPos - targetPos).Magnitude > 1 or (root.Position - targetPos).Magnitude > 5 then
													root.CFrame = CFrame.new(targetPos)
													lastTeleportPos = targetPos
												end
											end
										end
									end
								end
							end
							if AutoFarmBT then
								local bttxt = info:FindFirstChild("BTTxt")
								if bttxt and bttxt:IsA("TextLabel") then
									local val = bttxt.Text:match("Body Toughness%s*:%s*(.+)")
									if val then
										local strength = parseValue(val)
										local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
										if root then
											local targetPos = getBTLocation(strength)
											if targetPos then
												if (not lastBTTeleportPos) or (lastBTTeleportPos - targetPos).Magnitude > 1 or (root.Position - targetPos).Magnitude > 5 then
													root.CFrame = CFrame.new(targetPos)
													lastBTTeleportPos = targetPos
												end
											end
										end
									end
								end
							end
							if AutoFarmPhys then
								local pptxt = info:FindFirstChild("PPTxt")
								if pptxt and pptxt:IsA("TextLabel") then
									local val = pptxt.Text:match("Physic Power%s*:%s*(.+)")
									if val then
										local strength = parseValue(val)
										if strength >= 1e6 then -- only tp if 1M or above
											local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
											if root then
												local targetPos = getPhysLocation(strength)
												if targetPos then
													if (not lastPhysTeleportPos) or (lastPhysTeleportPos - targetPos).Magnitude > 1 or (root.Position - targetPos).Magnitude > 5 then
														root.CFrame = CFrame.new(targetPos)
														lastPhysTeleportPos = targetPos
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		else
			task.wait(1)
		end
	end
end)
