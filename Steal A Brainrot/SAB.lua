	----------------------------------------[[ Others ]]----------------------------------------
	local g = game
	local Id = g.PlaceId
	local JobId = g.JobId	
	local w = workspace	
	local Players = g:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UserName = LocalPlayer.Name
	local DisplayName = LocalPlayer.DisplayName
	local UserId = LocalPlayer.UserId	
	local CoreGui = g:GetService("CoreGui")	
	local Lighting = g:GetService("Lighting")
	local ReplicatedStorage = g:GetService("ReplicatedStorage")
	local CollectionService = g:GetService("CollectionService")
	local HttpService = g:GetService("HttpService")
	local MarketService = g:GetService("MarketplaceService")
	local GameName = MarketService:GetProductInfo(Id).Name	
	local RunService = g:GetService("RunService")	
	local TeleportService = g:GetService("TeleportService")
	local TweenService = g:GetService("TweenService")
	local UIS = g:GetService("UserInputService")
	local StarterGui = g:GetService("StarterGui")
	local StarterPack = g:GetService("StarterPack")
	local Teams = g:GetService("Teams")
	local SoundService = g:GetService("SoundService")
	local Debris = g:GetService("Debris")
	local mkfd = makefolder
	local mkfl = makefile
	local ifl = isfile
	local ifd = isfolder
	local wtfl = writefile
	local rdfl = readfile
	local ldstg = loadstring
	local PlayerName = UserName or "Unknown Player"
	local RootFolder = "Someone Hub" 
	local MainFolder = "Main"
	local GameName = "Steal A Brainrot" 
	local FilePrefix = "Someone Settings"
	local FirstFolderPath = RootFolder .. "/" .. MainFolder
	local SecondFolderPath = FirstFolderPath .. "/" .. GameName
	local SaveFile = SecondFolderPath .. "/" .. FilePrefix .. " - " .. PlayerName .. ".json"
	
	local S = {
		
	}
	
	function EncryptData(data)
		local encrypted = HttpService:JSONEncode(data)
		return encrypted
	end
	function DecryptData(data)
		local decrypted = HttpService:JSONDecode(data)
		return decrypted
	end
	function SS()
		task.spawn(function()
			local dataEncrypted = EncryptData(S)
			if wtfl and mkfd then
				if not ifd(RootFolder) then mkfd(RootFolder) end
				if not ifd(FirstFolderPath) then mkfd(FirstFolderPath) end
				if not ifd(SecondFolderPath) then mkfd(SecondFolderPath) end
				wtfl(SaveFile, dataEncrypted)
			else
				warn("Your Executor Does Not Support Saving Files.")
			end
		end)
	end	
	function LoadSettings()
		if ifl and rdfl and ifl(SaveFile) then
			local successRead, dataEncrypted = pcall(rdfl, SaveFile)
			if successRead then
				local successDecode, dataDecoded = pcall(DecryptData, dataEncrypted)
				if successDecode then
					for k, v in pairs(dataDecoded) do
						S[k] = v
					end
				else
					warn("Error Decoding Data.")
				end
			else
				warn("Error Reading Settings File.")
			end
		else
			if not (ifl and rdfl) then
				warn("Your Executor Does Not Support Reading Files.")
			end
			SS()
		end
	end
	LoadSettings()
	
	----------------------------------------[[ Universal Functions ]]----------------------------------------
	
	function GetLocalPlot()
		local Plots = w:FindFirstChild("Plots")
		if not Plots then return end
		for _, plot in pairs(Plots:GetChildren()) do
			local PlotSign = plot:FindFirstChild("PlotSign")
			if PlotSign then
				local YourBase = PlotSign:FindFirstChild("YourBase")
				if YourBase and YourBase.Enabled then
					return plot
				end
			end
		end
		return nil
	end
	
	----------------------------------------[[ Player ]]----------------------------------------
	PlayersList = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(PlayersList, player.Name)
		end
	end
	
	function UpdatePlayersList()
		PlayersList = {}
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				table.insert(PlayersList, player.Name)
			end
		end
		PlayersListAimbot:Set(PlayersList)
	end
	
	local NotGuns = {
		["Grapple Hook"] = true,
	}
	
	local DevFriends = {
		["lucasviniciussoa"] = true,
		["lucasviniciussoa2"] = true,
		["raquimi5"] = true,
		["clarencio_1653"] = true,
	}
	
	local function IsSafe(PlayerName)
		if DevFriends[PlayerName] then return true end
		if typeof(_G.SafePlayersList) == "string" then
			return _G.SafePlayersList == PlayerName
		elseif typeof(_G.SafePlayersList) == "table" then
			for _, name in ipairs(_G.SafePlayersList) do
				if name == PlayerName then
					return true
				end
			end
		end	
		return false
	end
	
	task.spawn(function()
		while task.wait() do
			if _G.AimbotPlayers then
				local MouseModule = require(game:GetService("ReplicatedStorage").Packages.PlayerMouse)
				local LocalHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
				if LocalHRP then
					local ClosestHRP, ClosestDistance = nil, math.huge
					for _, Player in ipairs(Players:GetPlayers()) do
						local HRP = Player.Character and Player.Character:FindFirstChild("Head")
						if Player ~= LocalPlayer and HRP and not IsSafe(Player.Name) then
							local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
							if Tool and not NotGuns[Tool.Name] then
								local Distance = (LocalHRP.Position - HRP.Position).Magnitude
								if Distance < ClosestDistance then
									ClosestDistance, ClosestHRP = Distance, HRP
								end
							end
						end
					end
					if ClosestHRP then
						MouseModule.Target = ClosestHRP
					end
				end
			end
		end
	end)
		
	----------------------------------------[[ Visual ]]----------------------------------------
	
	function EspPlayers()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		local AllPlayers = Players:GetPlayers()
		if not _G.ESPPlayers then
			for _, player in pairs(AllPlayers) do
				if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("ESP Player") then
					player.Character.Head["ESP Player"]:Destroy()
				end
				if player.Character and player.Character:FindFirstChild("Player Highlight") then
					player.Character["Player Highlight"]:Destroy()
				end
			end
		end	
		if _G.ESPPlayers then
			for _, player in pairs(AllPlayers) do
				if player ~= LocalPlayer then
					local DispName = player.DisplayName
					local char = player.Character
					if not char then continue end
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("MeshPart") and part.Transparency == 1 then
							part.Transparency = 0
						end
					end
					local Head = char:FindFirstChild("Head")
					if not Head then continue end
					local Distance = math.floor((Head.Position - LocalHead.Position).Magnitude)
					local Text = string.format("<font color='rgb(255, 0, 0)'>%s</font> <font color='rgb(120, 120, 120)'>[ %d ]</font>", DispName, Distance)
					if not Head:FindFirstChild("ESP Player") then
						local Bill = Instance.new("BillboardGui", Head)
						Bill.Name = "ESP Player"
						Bill.Size = UDim2.new(0, 240, 0, 40)
						Bill.Adornee = Head
						Bill.AlwaysOnTop = true
						Bill.StudsOffset = Vector3.new(0, 2, 0)
						local Name = Instance.new("TextLabel", Bill)
						Name.Name = "Label"
						Name.Font = Enum.Font.FredokaOne
						Name.TextSize = 14
						Name.RichText = true
						Name.Text = Text
						Name.Size = UDim2.new(1, 0, 1, 0)
						Name.BackgroundTransparency = 1
						Name.TextStrokeTransparency = 0
						local high = Instance.new("Highlight", char)
						high.Name = "Player Highlight"
						high.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						high.FillColor = Color3.fromRGB(0, 255, 255)
						high.FillTransparency = 0
						high.OutlineColor = Color3.fromRGB(0, 0, 0)
						high.OutlineTransparency = 0					
					else
						Head["ESP Player"].Label.Text = Text
					end
				end
			end
		end
	end
	
	function EspBaseTimes()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		local Plots = w:FindFirstChild("Plots")
		if not Plots then return end
		if not _G.ESPBaseTime then
			for _, plot in pairs(Plots:GetChildren()) do
				if plot:FindFirstChild("Purchases") then
					for _, esp in pairs(plot.Purchases:GetDescendants()) do
						if esp:IsA("BillboardGui") and esp.Name == "ESP Base Time" then
							esp:Destroy()
						end
					end
				end
			end
		end
		if _G.ESPBaseTime then
			for _, plot in pairs(Plots:GetChildren()) do
				local IsEmpty = plot:FindFirstChild("PlotSign") and plot.PlotSign:FindFirstChild("SurfaceGui") and plot.PlotSign.SurfaceGui:FindFirstChild("Frame") and plot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel") and plot.PlotSign.SurfaceGui.Frame.TextLabel.Text == "Empty Base"
				if IsEmpty then continue end
				local Purch = plot:FindFirstChild("Purchases")
				if not Purch then continue end
				local PlotBlock = nil
				if #Purch:GetChildren() > 1 then
					for _, block in pairs(Purch:GetChildren()) do
						if block:FindFirstChild("Main") and block.Main.Position.Y < 0 then
							PlotBlock = block
							break
						end
					end
				else
					PlotBlock = Purch:FindFirstChild("PlotBlock")
				end
				if not PlotBlock then continue end
				local Main = PlotBlock:FindFirstChild("Main")
				if not Main then continue end
				local BillTime = Main:FindFirstChild("BillboardGui")
				if not BillTime then continue end
				local BillBase = BillTime:FindFirstChild("RemainingTime")
				if not BillBase then continue end
				local Timer = BillBase.Text:match("%d+")
				local Num = tonumber(Timer)
				local BaseText = (Num and Num < 1) and "Unlocked" or (Timer or "???")
				local BaseColor = "rgb(0, 255, 0)"
				if plot == GetLocalPlot() then BaseColor = "rgb(255, 0, 0)" end
				local Text = string.format("<font color='%s'>%s</font>", BaseColor, BaseText)
				if not Main:FindFirstChild("ESP Base Time") then
					local Bill = Instance.new("BillboardGui", Main)
					Bill.Name = "ESP Base Time"
					Bill.Size = UDim2.new(0, 240, 0, 40)
					Bill.Adornee = Main
					Bill.AlwaysOnTop = true
					Bill.StudsOffset = Vector3.new(0, 2, 0)
					local Name = Instance.new("TextLabel", Bill)
					Name.Name = "Label"
					Name.Font = Enum.Font.FredokaOne
					Name.TextSize = 16
					Name.RichText = true
					Name.Text = Text
					Name.Size = UDim2.new(1, 0, 1, 0)
					Name.BackgroundTransparency = 1
					Name.TextStrokeTransparency = 0
				else
					Main["ESP Base Time"].Label.Text = Text
				end
			end
		end
	end
	
	Letters = {
	    ["K"] = 1e3,
	    ["M"] = 1e6,
	    ["B"] = 1e9,
	}
	
	function Calc(letter, number)
	    return Letters[letter] and number * Letters[letter] or number
	end
	
	function EspBestBrainrot()
	    local LocalChar = LocalPlayer.Character
	    if not LocalChar then return end
	    local LocalHead = LocalChar:FindFirstChild("Head")
	    if not LocalHead then return end
	    local Plots = w:FindFirstChild("Plots")
	    if not Plots then return end
	    if not _G.ESPBestBrainrot then
	        for _, bill in pairs(Plots:GetDescendants()) do
	            if bill:IsA("BillboardGui") and bill.Name == "ESP Best Brainrot" then
	                bill:Destroy()
	            end
	        end
			return
	    end
	    for _, plot in pairs(Plots:GetChildren()) do
	        if plot ~= GetLocalPlot() then
		        local AnimalPodiums = plot:FindFirstChild("AnimalPodiums")
		        if not AnimalPodiums then continue end
		        local MaxGenerationValue = 0
		        local MaxPodium, MaxText, MaxRarityColor = nil, "", Color3.fromRGB(255, 255, 255)
		        for _, podium in pairs(AnimalPodiums:GetChildren()) do
		            local Base = podium:FindFirstChild("Base")
		            if not Base then continue end
		            local Spawn = Base:FindFirstChild("Spawn")
		            if not Spawn then continue end
		            local Attachment = Spawn:FindFirstChild("Attachment")
		            if not Attachment then continue end
		            local AnimalOverhead = Attachment:FindFirstChild("AnimalOverhead")
		            if not AnimalOverhead then continue end
		            local Mutation = AnimalOverhead:FindFirstChild("Mutation") and AnimalOverhead.Mutation.Visible and AnimalOverhead.Mutation.Text
		            local NameText = AnimalOverhead:FindFirstChild("DisplayName") and AnimalOverhead.DisplayName.Text
		            local RarityLabel = AnimalOverhead:FindFirstChild("Rarity")
		            local Rarity = RarityLabel and RarityLabel.Text
		            local GenerationText = AnimalOverhead:FindFirstChild("Generation") and AnimalOverhead.Generation.Visible and AnimalOverhead.Generation.Text
		            local RarityColor = Color3.fromRGB(255, 255, 255)
		            if RarityLabel then
		                local Gradient = RarityLabel:FindFirstChildOfClass("UIGradient")
		                if Gradient and Gradient.Color and Gradient.Color.Keypoints[1] then
		                    RarityColor = Gradient.Color.Keypoints[1].Value
		                else
		                    RarityColor = RarityLabel.TextColor3
		                end
		            end
		            if GenerationText then
		                local num, letter = GenerationText:match("%$(%d+%.?%d*)([KMB]?)")
		                num = tonumber(num)
		                local value = Calc(letter, num)
		                if value > MaxGenerationValue then
		                    MaxGenerationValue = value
		                    MaxPodium = podium
		                    if Mutation then
		                        MaxText = Mutation.."\n"..NameText.."\n"..("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(RarityColor.R*255, RarityColor.G*255, RarityColor.B*255, Rarity).."\n"..GenerationText
		                    else
		                        MaxText = NameText.."\n"..("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(RarityColor.R*255, RarityColor.G*255, RarityColor.B*255, Rarity).."\n"..GenerationText
		                    end
		                end
		            end
		        end
		        if MaxPodium then
		            if not MaxPodium:FindFirstChild("ESP Best Brainrot") then
		                local Bill = Instance.new("BillboardGui", MaxPodium)
		                Bill.Name = "ESP Best Brainrot"
		                Bill.Size = UDim2.new(0, 240, 0, 40)
		                Bill.Adornee = MaxPodium
		                Bill.AlwaysOnTop = true
		                Bill.StudsOffset = Vector3.new(0, 2, 0)
		                local Label = Instance.new("TextLabel", Bill)
		                Label.Name = "Label"
		                Label.Font = Enum.Font.FredokaOne
		                Label.TextSize = 16
		                Label.RichText = true
		                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
		                Label.Text = MaxText
		                Label.Size = UDim2.new(1, 0, 1, 0)
		                Label.BackgroundTransparency = 1
		                Label.TextStrokeTransparency = 0
		            else
		                MaxPodium["ESP Best Brainrot"].Label.Text = MaxText
		            end
		        end
	        end
	    end
	end
	
	task.spawn(function()
		while task.wait() do
			EspPlayers()
			EspBaseTimes()
			EspBestBrainrot()
		end
	end)
	
	----------------------------------------[[ Window ]]----------------------------------------
	
	local redzlib = ldstg(game:HttpGet("https://raw.githubusercontent.com/agenext/Libraries/refs/heads/main/redz%20Library/redzlib.lua"))()
	ldstg(game:HttpGet("https://raw.githubusercontent.com/agenext/Libraries/refs/heads/main/Random%20Icons/RandomIcon.txt"))()
	local Window = redzlib:MakeWindow({
	Title = "Someone Hub | Steal A Brainrot",
	SubTitle = "by Someone",
	SaveFolder = "Someone Hub.json"
	})
	
	Window:AddMinimizeButton({
	Button = { Image = "rbxassetid://80677412933527", BackgroundTransparency = 0 },
	Corner = { CornerRadius = UDim.new(0, 6) }
	})
	
	local Social = Window:MakeTab({Title = "Social Media", Icon = RandomIcon("Social Media")})
	local Player = Window:MakeTab({Title = "Player", Icon = RandomIcon("Player")})
	local Visual = Window:MakeTab({Title = "Visual", Icon = RandomIcon("Visual")})
	
	----------------------------------------[[ Social ]]----------------------------------------
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	Player : AddSection("Safe")
	
	Player : AddToggle({
    Title = "Ant Ragdoll",
    Description = "Prevents The Body From Losing Physical",
    Default = S["Ant Ragdoll"],
    Callback = function(Value)
    _G.AntRagdoll = Value
    S["Ant Ragdoll"] = Value
	SS()
    end})
    
	Player : AddSection("Aimbot")
	
	Player : AddButton({
    Title = "Updated Players List",
    Description = "Updates Player List",
    Callback = function()
    UpdatePlayersList()
    end})
    
	PlayersListAimbot = Player : AddDropdown({
	Title = "Select Friends",
	Description = "Create A List Of People Who Will Not Be Targeted By Aimbot",
	Options = PlayersList,
	Default = S["Safe Players List"],
	Multi = true,
	Callback = function(Value)
	_G.SafePlayersList = Value
	S["Safe Players List"] = Value
	SS()
	end})
	
	Player : AddToggle({
    Title = "Aimbot Players",
    Description = "Aim and Hit Players With Long Range Items",
    Default = S["Aimbot Players"],
    Callback = function(Value)
    _G.AimbotPlayers = Valie
    S["Aimbot Players"] = Value
	SS()
    end})
    
	----------------------------------------[[ Visual ]]----------------------------------------
	
	Visual : AddSection("Extra Sensory Perception")
	
	Visual : AddToggle({
    Title = "ESP Players",
    Description = "See Name, Distance And A Highlight About The Character",
    Default = S["ESP Players"],
    Callback = function(Value)
    _G.ESPPlayers = Value
    S["ESP Players"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Base Time",
    Description = "See The Time Of Each Base",
    Default = S["ESP Base Time"],
    Callback = function(Value)
    _G.ESPBaseTime = Value
    S["ESP Base Time"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Best Brainrot",
    Description = "See Name, Distance, Mutation, Rarity and Generation",
    Default = S["ESP Best Brainrot"],
    Callback = function(Value)
    _G.ESPBestBrainrot = Value
    S["ESP Best Brainrot"] = Value
	SS()
    end})
    
    