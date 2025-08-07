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
}
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
Window:SelectTab(1)
Fluent:Notify({Title = "spts : classic", Content = "!", Duration = 2})
SaveManager:Load("main")
SaveManager:LoadAutoloadConfig()
