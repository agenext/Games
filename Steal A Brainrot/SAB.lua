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
		-- Player --
		["Select Jump Power"] = 150,
		["Aimbot Players Who Are Stealing"] = true,
		-- Visual --
		["Select Font"] = "FredokaOne",
		["Font Size"] = 10,
		-- Find --
		["Select Rarity"] = "Secret",
		["Select Money"] = "500K/s",
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
	
	----------------------------------------[[ Tables ]]----------------------------------------
	
	local FontList = {
		"FredokaOne",	
	}
	
	local RarityList = {
		"Common",
		"Rare",
		"Epic",
		"Legendary",
		"Mythic",
		"Brianrot God",
		"Secret"
	}
	local MoneyList = {
		"10K/s",
		"25K/s",
		"50K/s",
		"75K/s",
		"100K/s",
		"150K/s",
		"250K/s",
		"500K/s",
		"750K/s",
		"1M/s",
		"2.5M/s",
		"5M/s",
		"10M/s",
	}
	
	local NotGuns = {
		["Grapple Hook"] = true,
	}
	
	local DevFriends = {
		["lucasviniciussoa"] = true,
		["lucasviniciussoa2"] = true,
		["raquimi5"] = true,
		["clarencio_1653"] = true,
	}
	
	Letters = {
	    ["K"] = 1e3,
	    ["M"] = 1e6,
	    ["B"] = 1e9,
	}
	
	local BrainrotsIndex = {
	    ["Noobini Pizzanini"] = 1,
	    ["Lirilì Larilà"] = 2,
	    ["Tim Cheese"] = 3,
	    ["Fluriflura"] = 4,
	    ["Talpa Di Fero"] = 5,
	    ["Svinina Bombardino"] = 6,
	    ["Raccooni Jandelini"] = 7,
	    ["Pipi Kiwi"] = 8,
	    ["Pipi Corni"] = 9,
	    ["Trippi Troppi"] = 10,
	    ["Tung Tung Tung Sahur"] = 11,
	    ["Gangster Footera"] = 12,
	    ["Bandito Bobritto"] = 13,
	    ["Boneca Ambalabu"] = 14,
	    ["Cacto Hipopotamo"] = 15,
	    ["Ta Ta Ta Ta Sahur"] = 16,
	    ["Tric Trac Baraboom"] = 17,
	    ["Pipi Avocado"] = 18,
	    ["Cappuccino Assassino"] = 19,
	    ["Brr Brr Patapim"] = 20,
	    ["Avocadini Antilopini"] = 21,
	    ["Trulimero Trulicina"] = 22,
	    ["Bambini Crostini"] = 23,
	    ["Bananita Dolphinita"] = 24,
	    ["Perochello Lemonchello"] = 25,
	    ["Brri Brri Bicus Dicus Bombicus"] = 26,
	    ["Avocadini Guffo"] = 27,
	    ["Ti Ti Ti Sahur"] = 28,
	    ["Salamino Penguino"] = 29,
	    ["Penguino Cocosino"] = 30,
	    ["Burbaloni Loliloli"] = 31,
	    ["Chimpanzini Bananini"] = 32,
	    ["Ballerina Cappuccina"] = 33,
	    ["Chef Crabracadabra"] = 34,
	    ["Lionel Cactuseli"] = 35,
	    ["Glorbo Fruttodrillo"] = 36,
	    ["Quivioli Ameleonni"] = 37,
	    ["Blueberrinni Octopusini"] = 38,
	    ["Pipi Potato"] = 39,
	    ["Strawberrelli Flamingelli"] = 40,
	    ["Cocosini Mama"] = 41,
	    ["Pandaccini Bananini"] = 42,
	    ["Pi Pi Watermelon"] = 43,
	    ["Sigma Boy"] = 44,
	    ["Frigo Camelo"] = 45,
	    ["Orangutini Ananassini"] = 46,
	    ["Rhino Toasterino"] = 47,
	    ["Bombardiro Crocodilo"] = 48,
	    ["Spioniro Golubiro"] = 49,
	    ["Bombombini Gusini"] = 50,
	    ["Zibra Zubra Zibralini"] = 51,
	    ["Tigrilini Watermelini"] = 52,
	    ["Avocadorilla"] = 53,
	    ["Cavallo Virtuoso"] = 54,
	    ["Gorillo Watermelondrillo"] = 55,
	    ["Tob Tobi Tobi"] = 56,
	    ["Lerulerulerule"] = 57,
	    ["Ganganzelli Trulala"] = 58,
	    ["Te Te Te Sahur"] = 59,
	    ["Tracoducotulu Delapeladustuz"] = 60,
	    ["Carloo"] = 61,
	    ["Carrotini Brainini"] = 62,
	    ["Cocofanto Elefanto"] = 63,
	    ["Gattatino Nyanino"] = 64,
	    ["Girafa Celestre"] = 65,
	    ["Tralalero Tralala"] = 66,
	    ["Matteo"] = 67,
	    ["Los Crocodillitos"] = 68,
	    ["Tigroligre Frutonni"] = 69,
	    ["Odin Din Din Dun"] = 70,
	    ["Alessio"] = 71,
	    ["Tralalita Tralala"] = 72,
	    ["Unclito Samito"] = 73,
	    ["Tipi Topi Taco"] = 74,
	    ["Tukanno Bananno"] = 75,
	    ["Orcalero Orcala"] = 76,
	    ["Trenostruzzo Turbo 3000"] = 77,
	    ["Espresso Signora"] = 78,
	    ["Urubini Flamenguini"] = 79,
	    ["Trippi Troppi Troppa Trippa"] = 80,
	    ["Ballerino Lololo"] = 81,
	    ["Bulbito Bandito Traktorito"] = 82,
	    ["Pakrahmatmamat"] = 83,
	    ["Los Tungtungtungcitos"] = 84,
	    ["Piccione Macchina"] = 85,
	    ["Brr es Teh Patipum"] = 86,
	    ["Los Bombinitos"] = 87,
	    ["Cacasito Satalito"] = 88,
	    ["Los Orcalitos"] = 89,
	    ["Tartaruga Cisterna"] = 90,
	    ["Crabbo Limonetta"] = 91,
	    ["Mastodontico Telepiedone"] = 92,
	    ["Bombardini Tortinii"] = 93,
	    ["La Vacca Saturno Saturnita"] = 94,
	    ["Blackhole Goat"] = 95,
	    ["Bisonte Giuppitere"] = 96,
	    ["Agarrini la Palini"] = 97,
	    ["Los Spyderinis"] = 98,
	    ["Los Matteos"] = 99,
	    ["Sammyni Spyderini"] = 100,
	    ["Karkerkar Kurkur"] = 101,
	    ["Los Tralaleritos"] = 102,
	    ["Guerriro Digitale"] = 103,
	    ["Torrtuginni Dragonfrutini"] = 104,
	    ["Las Tralaleritas"] = 105,
	    ["Dul Dul Dul"] = 106,
	    ["Job Job Job Sahur"] = 107,
	    ["Las Vaquitas Saturnitas"] = 108,
	    ["Graipuss Medussi"] = 109,
	    ["Nooo My Hotspot"] = 110,
	    ["Pot Hotspot"] = 111,
	    ["Chicleteira Bicicleteira"] = 112,
	    ["La Grande Combinasion"] = 113,
	    ["Los Combinasionas"] = 114,
	    ["Nuclearo Dinossauro"] = 115,
	    ["Los Hotspotsitos"] = 116,
	    ["Esok Sekolah"] = 117,
	    ["Ketupat Kepat"] = 118,
	    ["La Supreme Combinasion"] = 119,
	    ["Ketchuru and Musturu"] = 120,
	    ["Garama and Madundung"] = 121,
	    ["Spaghetti Tualetti"] = 122,
	    ["Dragon Cannelloni"] = 123,
	    ["Strawberry Elephant"] = 124,
	}
	
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
	
	function Hop()
		local PlaceID = Id
		local AllIDs = {}
		local foundAnything = ""
		local actualHour = (os.date("!*t")).hour
		local Deleted = false
		function TPReturner()
			local Site
			if foundAnything == "" then
				Site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"))
			else
				Site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
			end
			local ID = ""
			if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
				foundAnything = Site.nextPageCursor
			end
			local num = 0
			for i, v in pairs(Site.data) do
				local Possible = true
				ID = tostring(v.id)
				if tonumber(v.maxPlayers) > tonumber(v.playing) then
					for _, Existing in pairs(AllIDs) do
						if num ~= 0 then
							if ID == tostring(Existing) then
								Possible = false
							end
						elseif tonumber(actualHour) ~= tonumber(Existing) then
							local delFile = pcall(function()
								AllIDs = {}
								table.insert(AllIDs, actualHour)
							end)
						end
						num = num + 1
					end
					if Possible == true then
						table.insert(AllIDs, ID)
						wait()
						pcall(function()
							wait()
							TeleportService:TeleportToPlaceInstance(PlaceID, ID, LocalPlayer)
						end)
						wait()
					end
				end
			end
		end
		function Teleport()
			while wait() do
				pcall(function()
					TPReturner()
					if foundAnything ~= "" then
						TPReturner()
					end
				end)
			end
		end
		Teleport()
	end
	
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local oldNamecall = mt.__namecall	
	mt.__namecall = newcclosure(function(self, ...)
	    if getnamecallmethod():lower() == "kick" then
	        return
	    end
	    return oldNamecall(self, ...)
	end)
	setreadonly(mt, true)

	----------------------------------------[[ Player ]]----------------------------------------
	
	task.spawn(function()
		while task.wait() do
			local char = LocalPlayer.Character
			if not char then continue end
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if not humanoid then continue end
			if humanoid.Health <= 0 then continue end
			if _G.ChangeJumpPower then
				humanoid.UseJumpPower = true
				humanoid.JumpPower = _G.SelectJumpPower
			else
				humanoid.UseJumpPower = false
				humanoid.JumpPower = 50
			end
		end
	end)
	
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
						MouseModule.Hit = CFrame.new(ClosestHRP.Position)
						MouseModule.Target = ClosestHRP
					end
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			if _G.AimbotPlayersWhenStealing then
				local MouseModule = require(game:GetService("ReplicatedStorage").Packages.PlayerMouse)
				local LocalHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
				if LocalHRP then
					local ClosestHRP, ClosestDistance = nil, math.huge
					for _, Player in ipairs(Players:GetPlayers()) do
						local HRP = Player.Character and Player.Character:FindFirstChild("Head")
						if Player ~= LocalPlayer and HRP and not IsSafe(Player.Name) then
							if Player:GetAttribute("Stealing") == true then
								local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
								if Tool and not NotGuns[Tool.Name] then
									local Distance = (LocalHRP.Position - HRP.Position).Magnitude
									if Distance < ClosestDistance then
										ClosestDistance, ClosestHRP = Distance, HRP
									end
								end
							end
						end
					end
					if ClosestHRP then
						MouseModule.Hit = CFrame.new(ClosestHRP.Position)
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
					Name.Font = (_G.SelectFont or S["Select Font"])
					Name.TextSize = (_G.FontSize or S["Font Size"])
					Name.RichText = true
					Name.Text = Text
					Name.Size = UDim2.new(1, 0, 1, 0)
					Name.BackgroundTransparency = 1
					Name.TextStrokeTransparency = 0
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
	
	local CurrentBillboardPodium = nil
	
	function EspBestBrainrot()
	    local LocalChar = LocalPlayer.Character
	    if not LocalChar then return end
	    local Plots = w:FindFirstChild("Plots")
	    if not Plots then return end
	    if not _G.ESPBestBrainrot then
	        for _, bill in pairs(Plots:GetDescendants()) do
	            if bill:IsA("BillboardGui") and bill.Name == "ESP Best Brainrot" then
	                bill:Destroy()
	            end
	        end
	        CurrentBillboardPodium = nil
	        return
	    end
	    local MaxGenerationValue = 0
	    local MaxPodium, MaxText = nil, ""
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
	                        if value > MaxGenerationValue then
	                            MaxGenerationValue = value
	                            MaxPodium = podium
	                            if Mutation then
	                                MaxText = ("<font color=\"rgb(%d,%d,%d)\">%s</font>\n"):format(MutationColor.R*255, MutationColor.G*255, MutationColor.B*255, Mutation)..NameText.."\n"..("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(RarityColor.R*255, RarityColor.G*255, RarityColor.B*255, Rarity).."\n".."<font color=\"rgb(255, 247, 0)\">"..GenerationText.."</font>"
	                            else
	                                MaxText = NameText.."\n"..("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(RarityColor.R*255, RarityColor.G*255, RarityColor.B*255, Rarity).."\n".."<font color=\"rgb(0,185,0)\">"..GenerationText.."</font>"
	                            end
	                        end
	                    end
	                end
	            end
	        end
	    end
	    if MaxPodium then
	        if CurrentBillboardPodium and CurrentBillboardPodium ~= MaxPodium then
	            local oldBill = CurrentBillboardPodium:FindFirstChild("ESP Best Brainrot")
	            if oldBill then oldBill:Destroy() end
	        end
	        local Bill = MaxPodium:FindFirstChild("ESP Best Brainrot")
	        local Label
	        if not Bill then
	            Bill = Instance.new("BillboardGui", MaxPodium)
	            Bill.Name = "ESP Best Brainrot"
	            Bill.Size = UDim2.new(0, 240, 0, 40)
	            Bill.Adornee = MaxPodium
	            Bill.AlwaysOnTop = true
	            Bill.StudsOffset = Vector3.new(0, 2, 0)
	            Label = Instance.new("TextLabel", Bill)
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
	            Label = Bill:FindFirstChild("Label")
	        end
	        if Label then Label.Text = MaxText end
	        CurrentBillboardPodium = MaxPodium
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
	    for _, plot in pairs(Plots:GetChildren()) do
	        if plot ~= GetLocalPlot() then
	            local AnimalPodiums = plot:FindFirstChild("AnimalPodiums")
	            if not AnimalPodiums then continue end
	            local MaxBrainrotValue = 0
	            local MaxPodium, MaxText = nil, ""
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
	                        MaxText = string.format("<font color='rgb(255,255,0)'>%s</font>", NameText)
	                    end
	                end
	            end
	            if MaxPodium then
	                if not MaxPodium:FindFirstChild("ESP Best Brainrot In The Index") then
	                    local Bill = Instance.new("BillboardGui", MaxPodium)
	                    Bill.Name = "ESP Best Brainrot In The Index"
	                    Bill.Size = UDim2.new(0, 280, 0, 40)
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
	    end
	end

	task.spawn(function()
		while task.wait(0.3) do
			EspPlayers()
			EspBaseTimes()
			EspBestBrainrot()
			EspBestBrainrotInTheIndex()
		end
	end)
	
	----------------------------------------[[ Find ]]----------------------------------------
	
	task.spawn(function()
		while task.wait() do
			if _G.FindBrianrotRarity then
				local shouldHop = true
				local Plots = w:FindFirstChild("Plots")
				if Plots then
					for _, plot in pairs(Plots:GetChildren()) do
						if plot ~= GetLocalPlot() then
							local AnimalPodiums = plot:FindFirstChild("AnimalPodiums")
							if AnimalPodiums then
								for _, podium in pairs(AnimalPodiums:GetChildren()) do
									local Base = podium:FindFirstChild("Base")
									if Base then
										local Spawn = Base:FindFirstChild("Spawn")
										if Spawn then
											local Attachment = Spawn:FindFirstChild("Attachment")
											if Attachment then
												local AnimalOverhead = Attachment:FindFirstChild("AnimalOverhead")
												if AnimalOverhead then
													local RarityLabel = AnimalOverhead:FindFirstChild("Rarity")
													if RarityLabel and RarityLabel.Text == _G.SelectRarity then
														shouldHop = false
														break
													end
												end
											end
										end
									end
								end
							end
						end
						if not shouldHop then break end
					end
				end
				if shouldHop then
					Hop()
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			if _G.FindBrianrotMoney and _G.SelectMoney then
				local hopAllowed = true
				local selNumStr, selLetter = _G.SelectMoney:match("(%d+%.?%d*)([KMB]?)")
				local selValue = Calc(selLetter, tonumber(selNumStr) or 0)
				local allPlots = w:FindFirstChild("Plots")
				if allPlots then
					for _, plotItem in pairs(allPlots:GetChildren()) do
						if plotItem ~= GetLocalPlot() then
							local podiums = plotItem:FindFirstChild("AnimalPodiums")
							if podiums then
								for _, pod in pairs(podiums:GetChildren()) do
									local basePart = pod:FindFirstChild("Base")
									if basePart then
										local spawnPoint = basePart:FindFirstChild("Spawn")
										if spawnPoint then
											local attach = spawnPoint:FindFirstChild("Attachment")
											if attach then
												local overhead = attach:FindFirstChild("AnimalOverhead")
												if overhead then
													local genText = overhead:FindFirstChild("Generation") and overhead.Generation.Visible and overhead.Generation.Text
													if genText then
														local numStr, letter = genText:match("%$(%d+%.?%d*)([KMB]?)")
														if numStr then
															local value = Calc(letter, tonumber(numStr))
															if value >= selValue then
																hopAllowed = false
																break
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
						if not hopAllowed then break end
					end
				end
				if hopAllowed then
					Hop()
				end
			end
		end
	end)
	----------------------------------------[[ Misc ]]----------------------------------------
	
	_G.HasOptimizated = false
	function Optimize()
		if _G.HasOptimizated then return end
		for _, part in pairs(game:GetDescendants()) do
			if part:IsA("BasePart") and part.Material ~= Enum.Material.Plastic then
				part.Material = Enum.Material.Plastic
			end
		end
		_G.HasOptimizated = true
	end
	
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
	local Find = Window:MakeTab({Title = "Find", Icon = RandomIcon("Find")})
	local Misc = Window:MakeTab({Title = "Misc", Icon = RandomIcon("Misc")})
	
	----------------------------------------[[ Social ]]----------------------------------------
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	Player : AddSection("Local Player")
	
	Player : AddSlider({
    Title = "Select Jump Power",
    Description = "Select Jump Power",
    Min = 50,
    Max = 200,
    Increase = 5,
    Default = S["Select Jump Power"],
    Callback = function(Value)
    _G.SelectJumpPower = Value
    S["Select Jump Power"] = Value
    SS()
    end})
    
	Player : AddToggle({
    Title = "Change Jump Power",
    Description = "Changes Jump Power To Selected",
    Default = S["Change Jump Power"],
    Callback = function(Value)
    _G.ChangeJumpPower = Value
    S["Change Jump Power"] = Value
	SS()
    end})
    
    Player : AddToggle({
    Title = "Intangible",
    Description = "Makes the Player Totally Intangible",
    Default = S["Intangible"],
    Callback = function(Value)
    _G.Intangible = Value
    S["Intangible"] = Value
	SS()
    end})
    
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
    _G.AimbotPlayers = Value
    S["Aimbot Players"] = Value
	SS()
    end})
    
    Player : AddToggle({
    Title = "Aimbot Players Who Are Stealing",
    Description = "Only Hit Players Who Are Stealing",
    Default = S["Aimbot Players Who Are Stealing"],
    Callback = function(Value)
    _G.AimbotPlayersWhenStealing = Value
    S["Aimbot Players Who Are Stealing"] = Value
	SS()
    end})
    
	----------------------------------------[[ Visual ]]----------------------------------------
	Visual : AddSection("ESP Settings")
	
	Visual : AddDropdown({
	Title = "Select Font",
	Description = "Choose The Font That Will Be Used In The ESPs",
	Options = FontList,
	Default = S["Select Font"],
	Multi = false,
	Callback = function(Value)
	_G.SelectFont = Value
	S["Select Font"] = Value
	SS()
	end})
	
	Visual : AddSlider({
    Title = "Font Size",
    Description = "Font Size To Be Used",
    Min = 8,
    Max = 24,
    Increase = 1,
    Default = S["Font Size"],
    Callback = function(Value)
    _G.FontSize = Value
    S["Font Size"] = Value
    SS()
    end})
	
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
    
    Visual : AddToggle({
    Title = "ESP Best Brainrot In The Index",
    Description = "Shows Brainrot According To His Index",
    Default = S["ESP Best Brainrot  In The Index"],
    Callback = function(Value)
    _G.ESPBestBrainrotInTheIndex = Value
    S["ESP Best Brainrot  In The Index"] = Value
	SS()
    end})
    
    ----------------------------------------[[ Find ]]----------------------------------------
    
    Find : AddSection("Rarity")
    
    Find : AddDropdown({
	Title = "Select Rarity",
	Description = "Select Desired Rarity",
	Options = RarityList,
	Default = S["Select Rarity"],
	MultiSelect = false,
	Callback = function(Value)
	_G.SelectRarity = Value
	S["Select Rarity"] = Value
	SS()
	end})
	
	Find : AddToggle({
    Title = "Find Brianrot",
    Description = "Server Change Until You Reach A Server With Brianrot Of Desired Rarity",
    Default = S["Find Brianrot Rarity"],
    Callback = function(Value)
    _G.FindBrianrotRarity = Value
    S["Find Brianrot Rarity"] = Value
	SS()
    end})
    
    
    Find : AddSection("Money")
    
    Find : AddDropdown({
	Title = "Select Money",
	Description = "Select The Value That Brianrot Should Generate",
	Options = MoneyList,
	Default = S["Select Money"],
	Multi = false,
	Callback = function(Value)
	_G.SelectMoney = Value
	S["Select Money"] = Value
	SS()
	end})
    
    Find : AddToggle({
    Title = "Find Brianrot",
    Description = "Finds A Brianrot That Generates The Same Or More Than The Selected Value",
    Default = S["Find Brianrot Money"],
    Callback = function(Value)
    _G.FindBrianrotMoney = Value
    S["Find Brianrot Money"] = Value
	SS()
    end})
    
    Find : AddSection("Server")
    
    Find : AddButton({
    Title = "Copy Job Id",
    Description = "Copy Server ID",
    Callback = function()
    setclipboard(JobId)
    end})
    
    Find : AddButton({
    Title = "Server Hop",
    Description = "Change Server",
    Callback = function()
    Hop()
    end})
    
    Find : AddTextBox({
    Title = "Paste Job Id",
    Description = "Paste The Job Here",
    PlaceholderText = "Paste Here",
    Callback = function(Value)
    _G.PasteJobId = Value
    end})
    
    Find : AddButton({
    Title = "Join Id",
    Description = "Enter The Id Server",
    Callback = function()
    TeleportService:TeleportToPlaceInstance(Id, _G.PasteJobId, LocalPlayer)
    end})
    
    Find : AddButton({
    Title = "Join Chilli Hub Server",
    Description = "Login To Get Server IDs with Brianrots",
    Callback = function()
    
    end})
    
    ----------------------------------------[[ Misc ]]----------------------------------------
    
    Misc : AddSection("Optimizations")
    
    Misc : AddButton({
    Title = "Optimize",
    Description = "Transforms All Materials Into Plastic",
    Callback = function()
    Optimize()
    end})
    