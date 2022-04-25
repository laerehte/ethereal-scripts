--[[
        Script Name: Shuudan! Infinite Stamina
        Game Link: https://www.roblox.com/games/8713885400/Shuudan-BLUE-LOCK-DEMO-BUGGY
        Last Update: 4/25/2022
--]]

local UIS = game:GetService("UserInputService")
local Player = game:GetService("Players").LocalPlayer
local Root = Player.Character:WaitForChild("HumanoidRootPart")
local Original_Stamina = Root.BarInformation.Stamina.Meter.Size
local Meter = Root.BarInformation.Stamina.Meter

for i,v in pairs(getgc(true)) do
	if type(v) == "function" and getfenv(v).script and getfenv(v).script == Player.Backpack.LocalClient1 then
		for i2, v2 in pairs(debug.getupvalues(v)) do
			if type(v2) == "number" then
				debug.setupvalue(v, i2, math.huge)
			end
		end
	end
end

Meter.Changed:Connect(function()
	Meter.Size = Original_Stamina
end)
