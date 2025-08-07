local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local ACCESS_KEY = "flamingoflower"

-- Key UI setup
local gui = Instance.new("ScreenGui")
gui.Name = "KeyPromptGui"
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0, 440, 0, 300)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

Instance.new("UIStroke", frame).Color = Color3.fromRGB(0, 150, 230)

local title = Instance.new("TextLabel", frame)
title.AnchorPoint = Vector2.new(0.5, 0)
title.Position = UDim2.new(0.5, 0, 0, 20)
title.Size = UDim2.new(0.8, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.new(1,1,1)
title.Text = "Enter Access Key"
title.TextXAlignment = Enum.TextXAlignment.Center

local inputBox = Instance.new("TextBox", frame)
inputBox.AnchorPoint = Vector2.new(0.5, 0)
inputBox.Position = UDim2.new(0.5, 0, 0, 100)
inputBox.Size = UDim2.new(0.75, 0, 0, 40)
inputBox.BackgroundColor3 = Color3.fromRGB(30,30,60)
inputBox.ClearTextOnFocus = true
inputBox.PlaceholderText = "Key from Discord"
inputBox.Font = Enum.Font.Gotham
tinput = nil
inputBox.TextSize = 20
inputBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0,8)

local checkButton = Instance.new("TextButton", frame)
checkButton.AnchorPoint = Vector2.new(0.5, 0)
checkButton.Position = UDim2.new(0.5, 0, 0, 160)
checkButton.Size = UDim2.new(0.5, 0, 0, 48)
checkButton.BackgroundColor3 = Color3.fromRGB(0,150,230)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 22
checkButton.TextColor3 = Color3.new(1,1,1)
checkButton.Text = "Check Key"
Instance.new("UICorner", checkButton).CornerRadius = UDim.new(0,12)
local function loadMain()
    gui:Destroy()
    -- https://github.com/ShockerLL22/spts-classic // created by @sky4zprm (dc)
    local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/fluent-plus.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/savemanager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShockerLL22/fluentbackxd/refs/heads/main/interfacemanager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "💥SPTS Classic Official Script",
        SubTitle = "-- https://discord.com/invite/ZA5XnRdPx3",
        TabWidth = 160,
        Size = UDim2.fromOffset(480, 400),
        Acrylic = true,
        Theme = "Ocean",
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
end
checkButton.MouseButton1Click:Connect(function()
    local entered = inputBox.Text:lower():gsub("%s+", "")
    if entered == ACCESS_KEY then
        StarterGui:SetCore("SendNotification", { Title = "✔️ Access Granted", Text = "Loading...", Duration = 2 })
        loadMain()
    else
        StarterGui:SetCore("SendNotification", { Title = "❌ Invalid Key", Text = "Key not recognized.", Duration = 2 })
    end
end)

