local x = {}

function x.Init()
	local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

	local function Delivery(toolname)
		cd = true
		local house = game.Players.LocalPlayer.Character[toolname].House.Value
		task.wait()
		for _, x in pairs(game:GetService("Workspace").Houses:GetChildren()) do
			if x.Address.Value == toolname then
				for _, v in pairs(x:GetDescendants()) do
					if v.Name == "GivePizza" then
						task.wait(1)
						local last = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
						task.wait(0.8)
						game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last
						repeat task.wait(0.2) until not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
						cd = false
					end
				end
			end
		end
	end

	local function PickUpAndDelivery()
		for _, v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Tool") then
				if cd == false then
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 1)
					task.wait(1)
					Delivery(v.Name)
				end
			end
		end
	end

	local Window = Library.CreateLib("Work at Pizza Place (Made by John)", "Synapse")

	local Tab = Window:NewTab("Main")

	local Section = Tab:NewSection("Delivery")

	Section:NewButton("Delivery 1", "Delivery 1 pizza (or soda)", function()
		PickUpAndDelivery()
	end)

	getgenv().Toggled1 = false

	local toggle = Section:NewToggle("Auto Delivery", "Info", (state)
		getgenv().Toggled1 = state
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		task.wait(0.2)
		if getgenv().Toggled1 then
			toggle:UpdateToggle("Toggle On")
			PickUpAndDelivery()
		else
			toggle:UpdateToggle("Toggle Off")
		end
	end)
end
return x
