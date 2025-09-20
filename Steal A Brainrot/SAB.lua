	----------------------------------------[[ Others ]]----------------------------------------
	
	local g = game
	local w = workspace
	local Plots = w:WaitForChild("Plots")
	local Players = g:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UserName = LocalPlayer.Name
	local DisplayName = LocalPlayer.DisplayName
	local UserId = LocalPlayer.UserId
	local ReplicatedStorage = g:GetService("ReplicatedStorage")
	local CoreGui = g:GetService("CoreGui")
	local Lighting = g:GetService("Lighting")
	local TweenService = g:GetService("TweenService")
	local RunService = g:GetService("RunService")
	local UIS = g:GetService("UserInputService")
	local StarterGui = g:GetService("StarterGui")
	local StarterPack = g:GetService("StarterPack")
	local Teams = g:GetService("Teams")
	local SoundService = g:GetService("SoundService")
	local Debris = g:GetService("Debris")
	local TeleportService = g:GetService("TeleportService")
	local HttpService = g:GetService("HttpService")
	local MarketService = g:GetService("MarketplaceService")
	local CollectionService = g:GetService("CollectionService")
	local LocalizationService = g:GetService("LocalizationService")
	local PathfindingService = g:GetService("PathfindingService")
	local PhysicsService = g:GetService("PhysicsService")
	local StarterPlayer = g:GetService("StarterPlayer")
	local ChatService = g:GetService("Chat")
	local UserSettings = g:GetService("UserSettings")
	local GuiService = g:GetService("GuiService")
	local PlaceId = g.PlaceId
	local JobId = g.JobId
	local GameName = MarketService:GetProductInfo(PlaceId).Name
	local mkfd = makefolder
	local mkfl = makefile
	local ifl = isfile
	local ifd = isfolder
	local wtfl = writefile
	local rdfl = readfile
	local ldstg = loadstring
	local Heartbeat = RunService.Heartbeat
	local RenderStepped = RunService.RenderStepped
	local Stepped = RunService.Stepped
	local PlayerName = UserName or "Unknown Player"
	local RootFolder = "Someone Hub" 
	local MainFolder = "Main"
	local GameName = "Steal A Brainrot" 
	local FilePrefix = "Someone Settings"
	local FirstFolderPath = RootFolder .. "/" .. MainFolder
	local SecondFolderPath = FirstFolderPath .. "/" .. GameName
	local SaveFile = SecondFolderPath .. "/" .. FilePrefix .. " - " .. PlayerName .. ".json"
	
	local S = {
		-- Server --
		
		-- Main --
		
		-- Steal --
		
		-- Player --
		
		-- Visual --
		["Select Font"] = "FredokaOne",
		["Font Size"] = 15,
		-- Misc --
		
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
	local redzlib = ldstg(game:HttpGet("https://raw.githubusercontent.com/agenext/Libraries/refs/heads/main/redz%20Library/redzlib.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/agenext/Games/refs/heads/main/Steal%20A%20Brainrot/Module.txt"))()
	----------------------------------------[[ Universal Functions ]]----------------------------------------
	
	function GetLocalPlot()
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
	
	----------------------------------------[[ Server ]]----------------------------------------
	
	----------------------------------------[[ Main ]]----------------------------------------
	
	----------------------------------------[[ Steal ]]----------------------------------------
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	spawn(function()
		PlayersList = {}
		for _, player in Players:GetPlayers() do
			if player ~= LocalPlayer then
				table.insert(PlayersList, player.Name)
			end
		end
	end)
	
	function UpdatePlayersList()
		PlayersList = {}
		for _, player in Players:GetPlayers() do
			if player ~= LocalPlayer then
				table.insert(PlayersList, player.Name)
			end
		end
		PlayersListDrop:Set(PlayersList)
	end
	
	function CheckAlly(user)
		if typeof(_G.SelectFriends) == "string" and _G.SelectFriends == user then
			return true
		elseif typeof(_G.SelectFriends) == "table" then
			for _, name in pairs(_G.SelectFriends) do
				if name == user then
					return true
				end
			end
		end
		return false
	end
	
	task.spawn(function()
		while task.wait() do
			if _G.AimbotNearest then
				local MinDist, Target, TargetHead = math.huge, nil, nil
				local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				if Character then
					local Head = Character:FindFirstChild("Head")
					local Humanoid = Character:FindFirstChildOfClass("Humanoid")
					if Head and Humanoid and Humanoid.Health > 0 then
						for _, Player in Players:GetPlayers() do
							if Player ~= LocalPlayer and not CheckAlly(Player.Name) then
								local TargetChar = Player.Character
								if TargetChar then
									local TH = TargetChar:FindFirstChild("Head")
									local THum = TargetChar:FindFirstChildOfClass("Humanoid")
									if TH and THum and THum.Health > 0 then
										local Dist = (Head.Position - TH.Position).Magnitude
										if Dist < MinDist then
											MinDist = Dist
											Target = Player
											TargetHead = TH
										end
									end
								end
							end
						end
						if Target and TargetHead then
							local Mouse = require(ReplicatedStorage.Packages.PlayerMouse)
							Mouse.Hit = TargetHead.CFrame
							Mouse.Target = TargetHead
						end
					end
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			if _G.AimbotOnStealing then
				local MinDist, Target, TargetHead = math.huge, nil, nil
				local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				if Character then
					local Head = Character:FindFirstChild("Head")
					local Humanoid = Character:FindFirstChildOfClass("Humanoid")
					if Head and Humanoid and Humanoid.Health > 0 then
						for _, Player in Players:GetPlayers() do
							if Player:GetAttribute("Stearling") and Player ~= LocalPlayer and not CheckAlly(Player.Name) then
								local TargetChar = Player.Character
								if TargetChar then
									local TH = TargetChar:FindFirstChild("Head")
									local THum = TargetChar:FindFirstChildOfClass("Humanoid")
									if TH and THum and THum.Health > 0 then
										local Dist = (Head.Position - TH.Position).Magnitude
										if Dist < MinDist then
											MinDist = Dist
											Target = Player
											TargetHead = TH
										end
									end
								end
							end
						end
						if Target and TargetHead then
							local Mouse = require(ReplicatedStorage.Packages.PlayerMouse)
							Mouse.Hit = TargetHead.CFrame
							Mouse.Target = TargetHead
						end
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
						Name.Font = (_G.SelectFont or S["Select Font"])
						Name.TextSize = (_G.FontSize or S["Font Size"])
						Name.RichText = true
						Name.Text = Text
						Name.Size = UDim2.new(1, 0, 1, 0)
						Name.BackgroundTransparency = 1
						Name.TextStrokeTransparency = 0
						Name.AutoLocalize = true
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
				local Timer = 0
				if BillBase.Visible == true then
					Timer = BillBase.Text:match("%d+")
				end
				local Num = tonumber(Timer)
				local BaseText = (Num and Num < 1) and Translate("Unlocked") or (Timer or "???")
				local BaseColor = "rgb(0, 255, 0)"
				if plot == GetLocalPlot() then
					BaseColor = "rgb(255, 0, 0)"
					BaseText = Translate('Your Base').."\n" ..((Num and Num < 1) and Translate("Unlocked") or (Timer or "???"))
				end
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
					Name.Font = (_G.SelectFont or S["Select Font"])
					Name.TextSize = (_G.FontSize or S["Font Size"])
					Name.RichText = true
					Name.Text = Text
					Name.Size = UDim2.new(1, 0, 1, 0)
					Name.BackgroundTransparency = 1
					Name.TextStrokeTransparency = 0
					Name.TextWrapped = true
					Name.AutoLocalize = true
				else
					Main["ESP Base Time"].Label.Text = Text
				end
			end
		end
	end
	
	function Calc(letter, number)
	    return Letters[letter] and number * Letters[letter] or number
	end
	
	local BestBillboard
	
	function EspBestBrainrot()
	    local LocalChar = LocalPlayer.Character
	    if not LocalChar then return end
	    local Plots = w:FindFirstChild("Plots")
	    if not Plots then return end
	    if not _G.ESPBestBrainrot then
	        if BestBillboard and BestBillboard.Parent then
	            BestBillboard:Destroy()
	        end
	        BestBillboard = nil
	        return
	    end
	    local GlobalMaxValue = 0
	    local GlobalPodium, GlobalText = nil, ""
	    for _, plot in pairs(Plots:GetChildren()) do
	        if plot ~= GetLocalPlot() then
	            local AnimalPodiums = plot:FindFirstChild("AnimalPodiums")
	            if not AnimalPodiums then continue end
	            for _, podium in pairs(AnimalPodiums:GetChildren()) do
	                local Base = podium:FindFirstChild("Base")
	                local Spawn = Base and Base:FindFirstChild("Spawn")
	                local Attachment = Spawn and Spawn:FindFirstChild("Attachment")
	                local AnimalOverhead = Attachment and Attachment:FindFirstChild("AnimalOverhead")
	                if not AnimalOverhead then continue end
	                local Mutation = AnimalOverhead:FindFirstChild("Mutation") and AnimalOverhead.Mutation.Visible and AnimalOverhead.Mutation.Text
	                local NameText = AnimalOverhead:FindFirstChild("DisplayName") and AnimalOverhead.DisplayName.Text
	                local RarityLabel = AnimalOverhead:FindFirstChild("Rarity")
	                local Rarity = RarityLabel and RarityLabel.Text
	                local GenerationText = AnimalOverhead:FindFirstChild("Generation") and AnimalOverhead.Generation.Visible and AnimalOverhead.Generation.Text
	                local RarityColor = (RarityLabel and RarityLabel:FindFirstChildOfClass("UIGradient") and RarityLabel:FindFirstChildOfClass("UIGradient").Color.Keypoints[1].Value) or (RarityLabel and RarityLabel.TextColor3) or Color3.fromRGB(255,255,255)
	                local MutationColor = (Mutation and AnimalOverhead:FindFirstChild("Mutation"):FindFirstChildOfClass("UIGradient") and AnimalOverhead.Mutation:FindFirstChildOfClass("UIGradient").Color.Keypoints[1].Value) or (Mutation and AnimalOverhead:FindFirstChild("Mutation").TextColor3) or Color3.fromRGB(255,255,255)
	                if GenerationText then
	                    local numStr, letter = GenerationText:match("%$(%d+%.?%d*)([KMB]?)")
	                    local num = tonumber(numStr)
	                    if num then
	                        local value = Calc(letter, num)
	                        if value > GlobalMaxValue then
	                            GlobalMaxValue = value
	                            GlobalPodium = podium
	                            if Mutation then
	                                GlobalText = ("<font color=\"rgb(%d,%d,%d)\">%s</font>\n"):format(MutationColor.R*255,MutationColor.G*255,MutationColor.B*255,Mutation)..NameText.."\n"..("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(RarityColor.R*255,RarityColor.G*255,RarityColor.B*255,Translate(Rarity)).."\n".."<font color=\"rgb(255,247,0)\">"..GenerationText.."</font>"
	                            else
	                                GlobalText = NameText.."\n"..("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(RarityColor.R*255,RarityColor.G*255,RarityColor.B*255,Translate(Rarity)).."\n".."<font color=\"rgb(0,185,0)\">"..GenerationText.."</font>"
	                            end
	                        end
	                    end
	                end
	            end
	        end
	    end
	    if GlobalPodium then
	        local Label
	        if not BestBillboard or not BestBillboard.Parent then
	            if BestBillboard then BestBillboard:Destroy() end
	            BestBillboard = Instance.new("BillboardGui", GlobalPodium)
	            BestBillboard.Name = "ESP Best Brainrot"
	            BestBillboard.Size = UDim2.new(0,240,0,40)
	            BestBillboard.Adornee = GlobalPodium
	            BestBillboard.AlwaysOnTop = true
	            BestBillboard.StudsOffset = Vector3.new(0,2,0)
	            Label = Instance.new("TextLabel", BestBillboard)
	            Label.Name = "Label"
	            Label.Font = (_G.SelectFont or S["Select Font"])
	            Label.TextSize = (_G.FontSize or S["Font Size"])
	            Label.RichText = true
	            Label.TextColor3 = Color3.fromRGB(255,255,255)
	            Label.Size = UDim2.new(1,0,1,0)
	            Label.BackgroundTransparency = 1
	            Label.TextStrokeTransparency = 0
	            Label.AutoLocalize = true
	        else
	            Label = BestBillboard:FindFirstChild("Label")
	            BestBillboard.Adornee = GlobalPodium
	        end
	        if Label then Label.Text = GlobalText end
	    elseif BestBillboard and BestBillboard.Parent then
	        BestBillboard:Destroy()
	        BestBillboard = nil
	    end
	end
	
	function EspBestBrainrotInTheIndex()
	    local LocalChar = LocalPlayer.Character
	    if not LocalChar then return end
	    local LocalHead = LocalChar:FindFirstChild("Head")
	    if not LocalHead then return end
	    local Plots = w:FindFirstChild("Plots")
	    if not Plots then return end
	    if not _G.ESPBestBrainrotInTheIndex then
	        for _, bill in pairs(Plots:GetDescendants()) do
	            if bill:IsA("BillboardGui") and bill.Name == "ESP Best Brainrot In The Index" then
	                bill:Destroy()
	            end
	        end
	        return
	    end
	    local MaxBrainrotValue = 0
	    local MaxPodium, MaxText = nil, ""
	    for _, plot in pairs(Plots:GetChildren()) do
	        if plot ~= GetLocalPlot() then
	            local AnimalPodiums = plot:FindFirstChild("AnimalPodiums")
	            if not AnimalPodiums then continue end
	            for _, podium in pairs(AnimalPodiums:GetChildren()) do
	                local Base = podium:FindFirstChild("Base")
	                if not Base then continue end
	                local Spawn = Base:FindFirstChild("Spawn")
	                if not Spawn then continue end
	                local Attachment = Spawn:FindFirstChild("Attachment")
	                if not Attachment then continue end
	                local AnimalOverhead = Attachment:FindFirstChild("AnimalOverhead")
	                if not AnimalOverhead then continue end
	                local NameText = AnimalOverhead:FindFirstChild("DisplayName") and AnimalOverhead.DisplayName.Text
	                if NameText then
	                    local brainrotValue = BrainrotsIndex[NameText] or 0
	                    if brainrotValue > MaxBrainrotValue then
	                        MaxBrainrotValue = brainrotValue
	                        MaxPodium = podium
	                        MaxText = string.format(
	                            "<font color='rgb(255,255,0)'>%s</font> <font color='rgb(150, 150, 150)'>[Index: %d]</font>",
	                            NameText, brainrotValue
	                        )
	                    end
	                end
	            end
	        end
	    end
	    if MaxPodium then
	        if not MaxPodium:FindFirstChild("ESP Best Brainrot In The Index") then
	            local Bill = Instance.new("BillboardGui", MaxPodium)
	            Bill.Name = "ESP Best Brainrot In The Index"
	            Bill.Size = UDim2.new(0, 240, 0, 40)
	            Bill.Adornee = MaxPodium
	            Bill.AlwaysOnTop = true
	            Bill.StudsOffset = Vector3.new(0, 2, 0)
	            local Label = Instance.new("TextLabel", Bill)
	            Label.Name = "Label"
	            Label.Font = (_G.SelectFont or S["Select Font"])
	            Label.TextSize = (_G.FontSize or S["Font Size"])
	            Label.RichText = true
	            Label.TextColor3 = Color3.fromRGB(255, 255, 0)
	            Label.Text = MaxText
	            Label.Size = UDim2.new(1, 0, 1, 0)
	            Label.BackgroundTransparency = 1
	            Label.TextStrokeTransparency = 0
	            Label.AutoLocalize = true
	        else
	            MaxPodium["ESP Best Brainrot In The Index"].Label.Text = MaxText
	        end
	    end
	end
	
	task.spawn(function()
		while task.wait(0.1) do
			EspPlayers()
			EspBaseTimes()
			EspBestBrainrot()
			EspBestBrainrotInTheIndex()
		end
	end)
	
	----------------------------------------[[ Misc ]]----------------------------------------
	
	----------------------------------------[[ Window ]]----------------------------------------
	
	ldstg(game:HttpGet("https://raw.githubusercontent.com/agenext/Libraries/refs/heads/main/Random%20Icons/RandomIcon.txt"))()
	local Window = redzlib:MakeWindow({
	Title = "Someone Hub | Steal A Brainrot",
	SubTitle = "By Someone",
	SaveFolder = "Someone Hub.json"
	})
	
	Window:AddMinimizeButton({
	Button = { Image = "rbxassetid://80677412933527", BackgroundTransparency = 0 },
	Corner = { CornerRadius = UDim.new(0, 6) }
	})
	
	local Social = Window:MakeTab({Title = "Social Media", Icon = RandomIcon("Social Media")})
	local Main = Window:MakeTab({Title = "Main", Icon = RandomIcon("Main")})
	local Steal = Window:MakeTab({Title = "Steal", Icon = RandomIcon("Steal")})
	local Player = Window:MakeTab({Title = "Player", Icon = RandomIcon("Player")})
	local Visual = Window:MakeTab({Title = "Visual", Icon = RandomIcon("Visual")})
	local Misc = Window:MakeTab({Title = "Miscellaneous", Icon = RandomIcon("Miscelânea")})
	
	----------------------------------------[[ Social ]]----------------------------------------
	
	Social : AddDiscordInvite({
	Title = "Someone Hub",
	Description = "Script Community",
	Logo = "rbxassetid://80677412933527",
	Invite = "dsc.gg/discord",
	})
	
	----------------------------------------[[ Main ]]----------------------------------------
	
	Main : AddSection({"Base", RandomIcon("Base")})
	
	----------------------------------------[[ Steal ]]----------------------------------------
	
	Steal : AddSection({"Steal", RandomIcon("Steal")})
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	Player : AddSection({"Player", RandomIcon("Local Player")})
	
	Player : AddSection({"Aimbot", RandomIcon("Aimbot")})
	
	Player : AddButton({
    Title = "Update Players List",
    Description = "",
    Callback = function()
    UpdatePlayersList()
    end})
    
    PlayersListDrop = Player : AddDropdown({
	Title = "Select Friends",
	Description = "",
	Options = PlayersList,
	Default = S["Select Friends"],
	Multi = false,
	Callback = function(Value)
	_G.SelectFriends = Value
	S["Select Friends"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Aimbot Nearest",
	Description = "",
	Default = S["Aimbot Nearest"],
	Callback = function(Value)
	_G.AimbotNearest = Value
	S["Aimbot Nearest"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Aimbot On Who's Stealing",
	Description = "",
	Default = S["Aimbot On Who's Stealing"],
	Callback = function(Value)
	_G.AimbotOnStealing = Value
	S["Aimbot On Who's Stealing"] = Value
	SS()
	end})
	
	----------------------------------------[[ Visual ]]----------------------------------------
	
	Visual : AddSection({"Extra Sensory Perception", RandomIcon("Extra Sensory Perception")})
	
	Visual : AddSlider({
    Title = "Font Size",
    Description = "",
    Min = 8,
    Max = 24,
    Increase = 0.5,
    Default = S["Font Size"],
    Callback = function(Value)
    _G.FontSize = Value
    S["Font Size"] = Value
    SS()
    end})
    
    Visual : AddDropdown({
	Title = "Select Font",
	Description = "",
	Options = FontList,
	Default = S["Select Font"],
	Multi = false,
	Callback = function(Value)
	_G.SelectFont = Value
	S["Select Font"] = Value
	SS()
	end})
	
	Visual : AddToggle({
    Title = "ESP Players",
    Description = "",
    Default = S["ESP Players"],
    Callback = function(Value)
    _G.ESPPlayers = Value
    S["ESP Players"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Base Time",
    Description = "",
    Default = S["ESP Base Time"],
    Callback = function(Value)
    _G.ESPBaseTime = Value
    S["ESP Base Time"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Best Brainrot",
    Description = "",
    Default = S["ESP Best Brainrot"],
    Callback = function(Value)
    _G.ESPBestBrainrot = Value
    S["ESP Best Brainrot"] = Value
	SS()
    end})
    
	Visual : AddToggle({
	Title = "ESP Best Brainrot In The Index",
	Description = "",
	Default = S["ESP Best Brainrot In The Index"],
	Callback = function(Value)
	_G.ESPBestBrainrotInTheIndex = Value
	S["ESP Best Brainrot In The Index"] = Value
	SS()
	end})
	
	----------------------------------------[[ Misc ]]----------------------------------------
	
	Misc : AddSection({"More FPS", RandomIcon("More FPS")})
	
	Misc : AddButton({
    Title = "Unlock FPS",
    Description = "",
    Callback = function()
	if not _G.UnlockedFPS then
	    setfpscap(9e9)
	    for i, v in game:GetDescendants() do
	        if v:IsA("BasePart") then
	            v.Material = "Plastic"
	            v.Reflectance = 0
	            v.CastShadow = false
	            --v.Transparency = 0
	            v.Size = Vector3.new(v.Size.X, v.Size.Y, v.Size.Z)
	        elseif v:IsA("Decal") or v:IsA("Texture") then
	            v.Transparency = 1
	        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
	            v.Enabled = false
	        elseif v:IsA("MeshPart") then
	            v.MeshId = ""
	        end
	    end
	    Lighting.GlobalShadows = false
	    Lighting.FogEnd = 9e9
	    Lighting.Brightness = 5
	    Lighting.OutdoorAmbient = Color3.new(1,1,1)
	    Lighting.ShadowSoftness = 0
	    _G.UnlockedFPS = true
	end
    end})
    