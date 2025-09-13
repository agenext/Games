	----------------------------------------[[ Others ]]----------------------------------------
	if _G.AutoExecuted then
		return 
	end
	
	local g = game
	local w = workspace
	local Map = workspace.Map
	local Enemies = w.Enemies
	local Players = g:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UserName = LocalPlayer.Name
	local DisplayName = LocalPlayer.DisplayName
	local UserId = LocalPlayer.UserId
	local ReplicatedStorage = g:GetService("ReplicatedStorage")
	local Remotes = ReplicatedStorage.Remotes
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
	local Id = g.PlaceId
	local JobId = g.JobId
	local GameName = MarketService:GetProductInfo(Id).Name
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
	local GameName = "Blox Fruits" 
	local FilePrefix = "Someone Settings"
	local FirstFolderPath = RootFolder .. "/" .. MainFolder
	local SecondFolderPath = FirstFolderPath .. "/" .. GameName
	local SaveFile = SecondFolderPath .. "/" .. FilePrefix .. " - " .. PlayerName .. ".json"
	
	local S = {
		-- Misc --
		["Select Weapon"] = "Melee",
		["Flight Speed"] = 350,
		["Bring Enemies"] = true,
		["Auto Buso"] = true,
		["Auto Attack"] = true,
		-- Farm --
		-- Quests --
		-- SeaEvents --
		-- Islands --
		-- Fishing --
		-- Fruits --
		-- Teleport --
		-- Player --
		-- Race --
		-- Shop --
		-- Visual --
		["Select Font"] = "Arimo",
		["Font Size"] = 15,
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
	local Sea1 = Id == 2753915549
	local Sea2 = Id == 4442272183
	local Sea3 = Id == 7449423635
	local redzlib = ldstg(game:HttpGet("https://raw.githubusercontent.com/agenext/Libraries/refs/heads/main/redz%20Library/redzlib.lua"))()
	
	----------------------------------------[[ Functions Universal ]]----------------------------------------
	
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/agenext/Games/refs/heads/main/Blox%20Fruits/Utils/Module.txt"))()
	
	Teams = {
		["Pirates"] = "rgb(255, 89, 89)",
		["Marines"] = "rgb(175, 221, 255)"
	}
	
	function InvokeServer(...)
		return Remotes.CommF_:InvokeServer(...)
	end
	
	function FireServer(...)
		return Remotes.CommE:FireServer(...)
	end
	
	if Sea3 then
		if Map then
			if not Map:FindFirstChild("Temple of Time") then
				local TempleClone = ReplicatedStorage.MapStash["Temple of Time"]:Clone()
				TempleClone.Parent = Map
			end
		end
	end
	
	LocalPlayer.Idled:connect(function()
		g:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), w.CurrentCamera.CFrame)
		wait(1)
		g:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), w.CurrentCamera.CFrame)
	end)
	
	function SendKey(Key, Time)
		local vim = g:GetService("VirtualInputManager")
		vim:SendKeyEvent(true, Key, false, game)
		task.wait(Time or 0.1)
		vim:SendKeyEvent(false, Key, false, game)
	end
	
	function CheckItem(itemName, itemType)
		for _, v in pairs(InvokeServer("getInventory")) do
			if type(v) == "table" and v.Type == itemType and v.Name == itemName then
				return v.Count or true
				end
			end
		return false
	end
	
	function CheckSword(name)
		return CheckItem(name, "Sword")
	end
	
	function CheckMaterial(name)
		return CheckItem(name, "Material")
	end
	
	function CheckGun(name)
		return CheckItem(name, "Gun")
	end
	
	function CheckAccessory(name)
		return CheckItem(name, "Wear")
	end
	
	function CheckScroll(name)
		return CheckItem(name, "Scroll")
	end
	
	function CheckFruit(name)
		return CheckItem(name, "Fruit")
	end
	
	local FontList = {}
	
	for _, font in pairs(Enum.Font:GetEnumItems()) do
	    table.insert(FontList, font.Name)
	end
	
	table.sort(FontList, function(a, b)
	    return a:lower() < b:lower()
	end)
	
	----------------------------------------[[ Misc ]]----------------------------------------
	
	function EquipTool(Name)
		local Backpack = LocalPlayer:WaitForChild("Backpack")
		if not Backpack then return end
		local Tool = Backpack:FindFirstChild(Name)
		if not Tool then return end 
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		if not Character then return end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then return end
		Humanoid:EquipTool(Tool)
	end
	
	task.spawn(function()
		local Backpack = LocalPlayer:WaitForChild("Backpack")
		while task.wait() do
			for _, tool in ipairs(Backpack:GetChildren()) do
				if tool:IsA("Tool") and tool.ToolTip == _G.SelectWeapon then
					SelectWeapon = tool.Name
				end
			end
		end
	end)
	
	function Tween(target)
		local char = LocalPlayer.Character
		if not char then return end
		local root = char.PrimaryPart
		if not root then return end
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then return end
		if humanoid.Sit then humanoid.Sit = false end	
		local PortalPos = {}
		function GetDistance(pos)
			return (pos - root.Position).Magnitude
		end
		
		if Sea1 then
			PortalPos = {
				Vector3.new(-4652, 872, -1754),
				Vector3.new(-7895, 5547, -380),
				Vector3.new(61164, 5, 1820),
				Vector3.new(3865, 5, -1926)
			}
		elseif Sea2 then
			PortalPos = {
				Vector3.new(923, 125, 32853),
				Vector3.new(-6509, 83, -133)
			}
		elseif Sea3 then
			PortalPos = {
				Vector3.new(3029, 2280, -7325),
				Vector3.new(28286, 14897, 103)
			}
		end
		local unlocks = InvokeServer("GetUnlockables")
		if Sea2 and unlocks.FlamingoAccess then
			table.insert(PortalPos, Vector3.new(-289, 306, 600))
			table.insert(PortalPos, Vector3.new(2284, 15, 905))
		end
	
		if Sea3 and unlocks.DefeatedIndraTrueForm then
			table.insert(PortalPos, Vector3.new(-12471, 374, -7551))
			table.insert(PortalPos, Vector3.new(5661, 1013, -335))
			table.insert(PortalPos, Vector3.new(-5074, 314, -3153))
		end
		local closestPortal = nil
		local closestDistance = GetDistance(target)
		for _, portal in pairs(PortalPos) do
			local portalDistance = (portal - target).Magnitude
			if portalDistance < closestDistance then
				closestPortal = portal
				closestDistance = portalDistance
			end
		end
		if closestPortal == Vector3.new(3029, 2280, -7325) then
			InvokeServer("requestEntrance", Vector3.new(28286, 14897, 103))
			task.wait(0.1)
			rootCFrame = CFrame.new(28609, 14896, 105)
			task.wait(0.1)
			for _ = 1, 3 do
				InvokeServer("RaceV4Progress", "TeleportBack")
			end
			task.wait(0.2)
		elseif closestPortal then
			InvokeServer("requestEntrance", closestPortal)
			task.wait()
			InvokeServer("requestEntrance", closestPortal)
		end
		if GetDistance(target) < 300 then
			root.CFrame = CFrame.new(target)
		end
		if root.Position.Y ~= target.Y then
			root.CFrame += Vector3.new(0, target.Y - root.Position.Y, 0)
		end
		while true do
			if GetDistance(target) < 2 or _G.Cancel then break end
			if humanoid.Sit then humanoid.Sit = false end
			if GetDistance(target) < 200 then
				root.CFrame = CFrame.new(target)
				break
			end
			local direction = (target - root.Position).Unit
			root.CFrame += direction * (_G.TweenSpeed or 350) * task.wait()
		end
	end
	
	function BringEnemies(Name, Pos)
		if not _G.BringEnemies then return end
		for _, Enemie in Enemies:GetChildren() do
			if Enemie.Name == Name and Enemie.PrimaryPart then
				local Humanoid = Enemie:FindFirstChildOfClass("Humanoid")
				local HRP = Enemie.PrimaryPart
				local Direction = (Pos - HRP.Position)
				if Humanoid and Humanoid.Health > 0 then
					for _, Part in Enemie:GetDescendants() do
						if Part:IsA("BasePart") and Part.CanCollide then
							Part.CanCollide = false
						end
					end
					HRP.AssemblyLinearVelocity = Direction.Unit * 200
				end
			end
		end
	end
	
	function AutoHaki()
		if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("HasBuso") then
			InvokeServer("Buso")
		end
	end

	function IsAlive(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		return humanoid and humanoid.Health > 0
	end
	
	function GetTargets()
		local enemies = w.Enemies:GetChildren()
		local targets = {}
		local origin = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not origin then return targets end
		for _, enemy in ipairs(enemies) do
			local root = enemy:FindFirstChild("HumanoidRootPart")
			if root and IsAlive(enemy) and (root.Position - origin.Position).Magnitude < 60 then
				table.insert(targets, enemy)
			end
		end
		if #targets < 2 then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character then
					local root = player.Character:FindFirstChild("HumanoidRootPart")
					if root and IsAlive(player.Character) and (root.Position - origin.Position).Magnitude < 60 then
						table.insert(targets, player.Character)
					end
				end
			end
		end
		return targets
	end
	
	function AttackNoCoolDown()
	    local player = Players.LocalPlayer
	    local character = player.Character
	    if not character then return end
	    local tool = nil
	    for _, item in ipairs(character:GetChildren()) do
	        if item:IsA("Tool") then
	            tool = item
	            break
	        end
	    end
	    if not tool then return end
	    local targets = GetTargets()
	    if #targets == 0 then return end
	    local modules = ReplicatedStorage:FindFirstChild("Modules")
	    if not modules then return end
	    local registerAttack = modules.Net:WaitForChild("RE/RegisterAttack")
	    local registerHit = modules.Net:WaitForChild("RE/RegisterHit")
	    if not registerAttack or not registerHit then return end
	    local hitList, mainTarget, closestHead = {}, nil, nil
	    for _, target in ipairs(targets) do
	        if not target:GetAttribute("IsBoat") then
	            local bodyParts = {"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}
	            local hitPart = target:FindFirstChild(bodyParts[math.random(1,#bodyParts)]) or target.PrimaryPart
	            if hitPart then
	                table.insert(hitList,{target,hitPart})
	                mainTarget = hitPart
	                closestHead = target:FindFirstChild("Head") or target.PrimaryPart
	            end
	        end
	    end
	    if not mainTarget or not closestHead then return end
	    local Mouse = require(ReplicatedStorage.Mouse)
	    Mouse.Hit = closestHead.CFrame
	    Mouse.Part = closestHead
	    if tool.ToolTip == "Melee" or tool.Name == "Ice-Ice" or tool.Name == "Light-Light" then
	        registerAttack:FireServer(0.3)
	        local playerScripts = player:FindFirstChild("PlayerScripts")
	        if not playerScripts then return end
	        local localScript = playerScripts:FindFirstChildOfClass("LocalScript")
	        while not localScript do
	            playerScripts.ChildAdded:Wait()
	            localScript = playerScripts:FindFirstChildOfClass("LocalScript")
	        end
	        local sendHitsFunc
	        if getsenv then
	            local success, env = pcall(getsenv, localScript)
	            if success and env then
	                sendHitsFunc = env._G.SendHitsToServer
	            end
	        end
	        local hasFlag, combatThread = pcall(function()
	            return (require(modules.Flags)).COMBAT_REMOTE_THREAD or false
	        end)
	        if hasFlag and (combatThread and sendHitsFunc) then
	            sendHitsFunc(mainTarget, hitList)
	        elseif hasFlag and not combatThread then
	            registerHit:FireServer(mainTarget, hitList)
	        end
	    else
	
	    end
	end

	task.spawn(function()
		while task.wait() do
			if _G.AutoBuso then
				AutoHaki()
			end
			if _G.AutoAttack then
				AttackNoCoolDown()
			end
			if _G.EnableV3 then
				FireServer ("ActivateAbility")
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			if _G.EnableV4 then
				local char = LocalPlayer.Character
				local energy = char and char:FindFirstChild("RaceEnergy")
				local transformed = char and char:FindFirstChild("RaceTransformed")
				if energy and transformed and energy.Value >= 1 and not transformed.Value then
					SendKey("Y")
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait(1) do
			if _G.SendAllies then
				for _, player in Players:GetPlayers() do
					if player ~= LocalPlayer then
						InvokeServer("InviteAlly", player.Name)
					end
				end
			end
		end
	end)
	
	----------------------------------------[[ Farm ]]----------------------------------------
	
	spawn(function()
		while wait() do
			if _G.CollectChests then
				local p = LocalPlayer
				local c = p.Character or p.CharacterAdded:Wait()
				local h = c:WaitForChild("HumanoidRootPart")
				local chests = CollectionService:GetTagged("_ChestTagged")
				local dist, nearest = math.huge, nil
				for _, chest in pairs(chests) do
					local mag = (chest.Position - h.Position).Magnitude
					if not chest:GetAttribute("IsDisabled") and mag < dist then
						dist, nearest = mag, chest
					end
				end
				if nearest then
					local pos = nearest.Position
					Tween(pos)
				end
			end
		end
	end)
	
	spawn(function()
		while wait() do
			if _G.CollectMirageChests then
				local p = LocalPlayer
				local c = p.Character or p.CharacterAdded:Wait()
				local h = c:WaitForChild("HumanoidRootPart")
				local chests = CollectionService:GetTagged("_ChestTagged")
				local dist, nearest = math.huge, nil
				for _, chest in pairs(chests) do
					if chest.Name:find("Frag") then
						local mag = (chest.Position - h.Position).Magnitude
						if not chest:GetAttribute("IsDisabled") and mag < dist then
							dist, nearest = mag, chest
						end
					end
				end
				if nearest then
					local pos = nearest.Position
					Tween(pos)
				end
			end
		end
	end)
	
	----------------------------------------[[ Quests ]]----------------------------------------
	
	task.spawn(function()
		while task.wait() do
			if _G.CollectBerries then
				local bushes = CollectionService:GetTagged("BerryBush")
				local character = LocalPlayer.Character
				local hrp = character and character:FindFirstChild("HumanoidRootPart")
				if not hrp then task.wait(1) continue end
				local closestBush = nil
				local closestDist = math.huge
				for _, bush in ipairs(bushes) do
					if next(bush:GetAttributes()) == nil then continue end
					local model = bush.Parent
					if not model then continue end
					local dist = (model:GetPivot().Position - hrp.Position).Magnitude
					if dist < closestDist then
						closestDist = dist
						closestBush = bush
					end
				end
				if not closestBush then task.wait(1) continue end
				local model = closestBush.Parent
				local distToModel = (model:GetPivot().Position - hrp.Position).Magnitude
				if distToModel > 250 then
					Tween(model:GetPivot().Position)
				end
				if not _G.CollectBerries then continue end
				local child = closestBush:FindFirstChildOfClass("Model")
				if child then
					Tween(child.WorldPivot.Position)
					for name, value in pairs(closestBush:GetAttributes()) do
						if name and value then
							ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/ClaimBerry"):InvokeServer(closestBush.Parent.Name, name)
						end
					end
				end
			end
		end
	end)
	
	----------------------------------------[[ SeaEvents ]]----------------------------------------
	
	----------------------------------------[[ Islands ]]----------------------------------------
	
	----------------------------------------[[ Fishing ]]----------------------------------------
	
	----------------------------------------[[ Teleport ]]----------------------------------------
	
	if Sea1 then
		  IslandsList = {
			"Pirate Starter",
			"Marine Starter",
			"Middle Town",
			"Jungle",
			"Pirate Village",
			"Desert",
			"Frozen Village",
			"Marine Fortress",
			"Colosseum",
			"Sky Island 1",
			"Sky Island 2",
			"Sky Island 3",
			"Prison",
			"Magma Village",
			"Underwater City",
			"Fountain City"
		  }
	elseif Sea2 then
		  IslandsList = {
			"Café",
			"Kingdom Of Rose",
			"Dark Arena",
			"Flamingo Mansion",
			"Flamingo Room",
			"Green Zone",
			"Zombie Island",
			"Two Snow Mountain",
			"Punk Hazard",
			"Cursed Ship",
			"Ice Castle",
			"Forgotten Island",
			"Ussop Island"
		  }
	elseif Sea3 then
		  IslandsList = {
			"Mansion",
			"Port Town",
			"Great Tree",
			"Castle On The Sea",
			"Hydra Island",
			"Floating Turtle",
			"Haunted Castle",
			"Ice Cream Island",
			"Peanut Island",
			"Cake Island",
			"Candy Cane Island",
			"Tiki Outpost"
		  }
	end
	
	if Sea1 then
	  IslandsPos = {
	    ["Pirate Starter"] = Vector3.new(889, 17, 1434),
	    ["Marine Starter"] = Vector3.new(-2728, 25, 2056),
	    ["Middle Town"] = Vector3.new(-688, 15, 1585),
	    ["Jungle"] = Vector3.new(-1614, 37, 146),
	    ["Pirate Village"] = Vector3.new(-1173, 45, 3837),
	    ["Desert"] = Vector3.new(0,0,0),
	    ["Frozen Village"] = Vector3.new(1298, 87, -1344),
	    ["Marine Fortress"] = Vector3.new(-4810, 21, 4359),
	    ["Colosseum"] = Vector3.new(-1535, 7, -3014),
	    ["Sky Island 1"] = Vector3.new(-4814, 718, -2551),
	    ["Sky Island 2"] = Vector3.new(-4652, 873, -1754),
	    ["Sky Island 3"] = Vector3.new(-7895, 5547, -380),
	    ["Prison"] = Vector3.new(4870, 6, 736),
	    ["Magma Village"] = Vector3.new(-5290, 9, 8349),
	    ["Underwater City"] = Vector3.new(61164, 5, 1820),
	    ["Fountain City"] = Vector3.new(0,0,0)
	  }
	elseif Sea2 then
	  IslandsPos = {
	    ["Café"] = Vector3.new(-382, 73, 290),
	    ["Kingdom Of Rose"] = Vector3.new(-11, 29, 2771),
	    ["Dark Arena"] = Vector3.new(3494, 13, -3259),
	    ["Flamingo Mansion"] = Vector3.new(-317, 331, 597),
	    ["Flamingo Room"] = Vector3.new(2285, 15, 905),
	    ["Green Zone"] = Vector3.new(-2258, 73, -2696),
	    ["Zombie Island"] = Vector3.new(-5552, 194, -776),
	    ["Two Snow Mountain"] = Vector3.new(752, 408, -5277),
	    ["Punk Hazard"] = Vector3.new(-5897, 18, -5096),
	    ["Cursed Ship"] = Vector3.new(919, 125, 32869),
	    ["Ice Castle"] = Vector3.new(5505, 40, -6178),
	    ["Forgotten Island"] = Vector3.new(-3050, 240, -10178),
	    ["Ussop Island"] = Vector3.new(4816, 8, 2863)
	  }
	elseif Sea3 then
	  IslandsPos = {
	    ["Mansion"] = Vector3.new(-12471, 374, -7551),
	    ["Port Town"] = Vector3.new(-334, 7, 5300),
	    ["Great Tree"] = Vector3.new(2681, 1682, -7190),
	    ["Castle On The Sea"] = Vector3.new(-5073, 315, -3153),
	    ["Hydra Island"] = Vector3.new(5756, 610, -282),
	    ["Floating Turtle"] = Vector3.new(-12528, 332, -8658),
	    ["Haunted Castle"] = Vector3.new(-9517, 142, 5528),
	    ["Ice Cream Island"] = Vector3.new(-902, 79, -10988),
	    ["Peanut Island"] = Vector3.new(-2062, 50, -10232),
	    ["Cake Island"] = Vector3.new(-1897, 14, -11576),
	    ["Candy Cane Island"] = Vector3.new(-1038, 10, -14076),
	    ["Tiki Outpost"] = Vector3.new(-16224, 9, 439)
	  }
	end
	
	----------------------------------------[[ Fruits ]]----------------------------------------
	
	function Store(where)
		for _, fruit in where:GetChildren() do
			if fruit.Name:find("Fruit") then
				InvokeServer("StoreFruit", fruit:GetAttribute("OriginalName"), fruit)
			end
		end
	end
	
	task.spawn(function()
		while task.wait() do
			if _G.StoreFruits then
				local Backpack = LocalPlayer:FindFirstChild("Backpack")
				local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				if Backpack then Store(Backpack) end
				if Character then Store(Character) end
				local Notifications = LocalPlayer.PlayerGui:WaitForChild("Notifications")
				for _, Child in ipairs(Notifications:GetChildren()) do
				    if Child:IsA("TextLabel") or Child:IsA("TextButton") then
				        if Child.Text == '<font color="rgb(255,102,102)">You can only store 1 of each Blox Fruit.</font>' then
				            Child:Destroy()
				        end
				    end
				end
			end
		end
	end)
	
	task.spawn(function()
		while true do
			task.wait()
			local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			if _G.CollectFruits then
				local NearestHandle, MinDist = nil, math.huge
				for _, tool in workspace:GetChildren() do
					if tool.Name:find("Fruit") then
						if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
							firetouchinterest(Character.PrimaryPart, tool.Handle, 0)
							firetouchinterest(Character.PrimaryPart, tool.Handle, 1)
						elseif tool:IsA("Model") then
							local Handle = tool:FindFirstChild("Handle")
							if Handle then
								local Dist = (Handle.Position - Character.PrimaryPart.Position).Magnitude
								if Dist < MinDist then
									MinDist = Dist
									NearestHandle = Handle
								end
							end
						end
					end
				end
				if NearestHandle then
					Tween(NearestHandle.Position)
				end
			end
		end
	end)
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	task.spawn(function()
		while task.wait() do
			local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local Humanoid = Char:FindFirstChildOfClass("Humanoid")
			if Humanoid and Humanoid.Health > 0 then
				if _G.ChangeSpeed then
					Char:SetAttribute("SpeedMultiplier", _G.SelectWalkSpeed/36)
				else
					Char:SetAttribute("SpeedMultiplier", 1)
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local Humanoid = Char:FindFirstChildOfClass("Humanoid")
			if Humanoid and Humanoid.Health > 0 then
				if _G.ChangeJump then
					Humanoid.JumpPower = _G.SelectJumpPower
				else
					Humanoid.JumpPower = 50
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local Humanoid = Char:FindFirstChildOfClass("Humanoid")
			if Humanoid and Humanoid.Health > 0 then
				if _G.ChangeDashDistance then
					Char:SetAttribute("DashLength", _G.SelectDashDistance)
					Char:SetAttribute("DashLengthAir", _G.SelectDashDistance)
				else
					Char:SetAttribute("DashLength", 1)
					Char:SetAttribute("DashLengthAir", 1)
				end
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			if Character then
				local Humanoid = Character:FindFirstChildOfClass("Humanoid")
				if Humanoid and Humanoid.Health > 0 then
					if _G.NoClip then
						for _, part in Character:GetDescendants() do
							if part:IsA("BasePart") and part.CanCollide == true then
								part.CanCollide = false
							end
						end
					else
						for _, part in Character:GetDescendants() do
							if part:IsA("BasePart") and part.CanCollide == false then
								part.CanCollide = true
							end
						end
					end
				end
			end
		end
	end)
	
	UIS.JumpRequest:Connect(function()
		if _G.InfiniteJump then
			local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			if Character then
				local Humanoid = Character:FindFirstChildOfClass("Humanoid")
				if Humanoid and Humanoid.Health > 0 then
					Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end
	end)
	
	function CheckIsAlly(Target)
	    if not Target then return false end
	    if Target:IsA("Player") and tostring(LocalPlayer.Team) == "Marines" and tostring(Target.Team) == "Marines" then
	        return true
	    end
	    if Target == LocalPlayer then
	        return true
	    end
		if CollectionService:HasTag(Target, "Ally"..LocalPlayer.Name) or CollectionService:HasTag(LocalPlayer, "Ally"..Target.Name) then
			return true
		end
	    return false
	end
	
	task.spawn(function()
		while task.wait() do
			if _G.AimbotNearest then
				local Mouse = require(ReplicatedStorage.Mouse)
				local LocalHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not LocalHRP then continue end
				local nearest, nearestDist = nil, math.huge
				if not _G.IgnoreEnemies then
					for _, npc in pairs(w.Enemies:GetChildren()) do
						local Humanoid = npc:FindFirstChild("Humanoid")
						local Head = npc:FindFirstChild("Head")
						if Humanoid and Humanoid.Health > 0 and Head then
							local dist = (Head.Position - LocalHRP.Position).Magnitude
							if dist < nearestDist then
								nearestDist = dist
								nearest = Head
							end
						end
					end
				end
				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character and not CheckIsAlly(player) then
						local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")
						local Head = player.Character:FindFirstChild("Head")
						if Humanoid and Humanoid.Health > 0 and Head then
							local dist = (Head.Position - LocalHRP.Position).Magnitude
							if dist < nearestDist then
								nearestDist = dist
								nearest = Head
							end
						end
					end
				end
				if nearest then
					Mouse.Hit = nearest.CFrame
				end
			end
		end
	end)
	
	----------------------------------------[[ Race ]]----------------------------------------
	
	----------------------------------------[[ Shop ]]----------------------------------------
	
	----------------------------------------[[ Visual ]]----------------------------------------
	
	function EspPlayers()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		local AllPlayers = Players:GetPlayers()
		if not _G.ESPPlayers then
			for _, player in pairs(AllPlayers) do
				if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("Player ESP") then
					player.Character.Head["Player ESP"]:Destroy()
				end
			end
		end
		if _G.ESPPlayers then
			for _, player in pairs(AllPlayers) do
				if player ~= LocalPlayer then
					local DispName = player.DisplayName
					local Team = tostring(player.Team)
					local TeamColor = Teams[Team]
					local char = player.Character
					if not char then return end
					local Head = char:FindFirstChild("Head")
					if not Head then return end
					local Humanoid = char:FindFirstChildOfClass("Humanoid")
					if not Humanoid then return end
					local Distance = math.floor((Head.Position - LocalHead.Position).Magnitude/5)
					local Text = string.format("<font color='%s'>%s</font> <font color='rgb(120, 120, 120)'>[%d]</font>\n<font color='rgb(0, 255, 0)'>[%d/%d]</font>", TeamColor, DispName, Distance, math.floor(Humanoid.Health), Humanoid.MaxHealth)
					if not Head:FindFirstChild("Player ESP") then
						local Bill = Instance.new("BillboardGui", Head)
	                    Bill.Name = "Player ESP"
	                    Bill.Size = UDim2.new(0, 240, 0, 40)
	                    Bill.Adornee = Head
	                    Bill.AlwaysOnTop = true
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
						Head["Player ESP"].Label.Text = Text
					end
				end
			end
		end
	end
	
	function EspFruits()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		if not _G.ESPFruits then
			for _, fruit in pairs(w:GetChildren()) do
				if fruit.Name:lower():find("fruit") then
					if fruit:FindFirstChild("Handle") and fruit.Handle:FindFirstChild("Fruit ESP") then
						fruit.Handle["Fruit ESP"]:Destroy() 
					end
				end
			end
		end
		if _G.ESPFruits then
			for _, fruit in pairs(w:GetChildren()) do
				if fruit.Name:find("Fruit") then
					local fruitModel = fruit:FindFirstChild("Fruit")
					if not fruitModel then return end 
					local Handle = fruit:FindFirstChild("Handle")
					if not Handle then return end
					local idle = fruitModel:FindFirstChild("Idle")
					local anim = fruitModel:FindFirstChild("Animation")
					local mesh = fruitModel:FindFirstChild("Fruit")
					local fruitId = idle and idle.AnimationId or anim and anim.AnimationId or mesh and mesh.MeshId
					local FruitData = FruitsData[fruitId]
					if FruitData then
						local FruitName = Translate(FruitData.Name)
						local FruitImage = FruitData.Image
						local RarityCor = RarityColor[FruitData.Rarity]
						local Distance = math.floor((Handle.Position - LocalHead.Position).Magnitude/5)
						local Text = string.format("<font color='%s'>%s</font> <font color='rgb(120, 120, 120)'>[%d]</font>", RarityCor, FruitName or "???", Distance)
						if not Handle:FindFirstChild("Fruit ESP") then
							local Bill = Instance.new("BillboardGui", Handle)
		                    Bill.Name = "Fruit ESP"
		                    Bill.Size = UDim2.new(0, 240, 0, 40)
		                    Bill.Adornee = Handle
		                    Bill.AlwaysOnTop = true
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
							local Image = Instance.new("ImageLabel", Bill)
							Image.Name = "Fruit Image"
							Image.BackgroundTransparency = 1
							Image.Size = UDim2.new(0, 65, 0, 65)
							Image.Position = UDim2.new(0, 80, 0, -50)
							Image.Image = FruitImage
						else
							Handle["Fruit ESP"].Label.Text = Text
						end
					end
				end
			end
		end
	end
	
	function EspBerries()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		local AllBushs = CollectionService:GetTagged("BerryBush")
		if #AllBushs <= 0 then return end
		for _, Bush in pairs(AllBushs) do
			local BushModel = Bush.Parent
			local BerryName = nil
			for name, value in Bush:GetAttributes() do
				if value and BerriesData[value] then
					BerryName = value
					break
				end
			end
			if not _G.ESPBerries or not BerryName then
				local Esp = BushModel:FindFirstChild("Berry ESP")
				if Esp then Esp:Destroy() end
				continue
			end
			local DispName = Translate(BerriesData[BerryName].Name)
			local BerryColor = BerriesData[BerryName].Color
			local BerryImage = BerriesData[BerryName].Image
			local BerryChild = Bush:FindFirstChildWhichIsA("Model")
			local Target = (BerryChild and BerryChild) or BushModel
			local Distance = math.floor((LocalHead.Position - Target:GetPivot().Position).Magnitude / 5)
			local Text = string.format("<font color='%s'>%s</font> <font color='rgb(120,120,120)'>[%d]</font>", BerryColor, DispName, Distance)
			local Esp = BushModel:FindFirstChild("Berry ESP")
			if not Esp then
				local Bill = Instance.new("BillboardGui", BushModel)
				Bill.Name = "Berry ESP"
				Bill.Size = UDim2.new(0, 240, 0, 40)
				Bill.AlwaysOnTop = true
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
				local Image = Instance.new("ImageLabel", Bill)
				Image.Name = "Berry Image"
				Image.BackgroundTransparency = 1
				Image.Size = UDim2.new(0, 50, 0, 50)
				Image.Position = UDim2.new(0, 95, 0, -40)
				Image.Image = BerryImage
				Esp = Bill
			else
				Esp.Label.Text = Text
			end
			if BerryChild and Distance < 250 then
				Esp.Adornee = BerryChild
			else
				Esp.Adornee = BushModel
			end
		end
	end
	
	function EspChests()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		for _, chest in CollectionService:GetTagged("_ChestTagged") do
			if not _G.ESPChests or chest:GetAttribute("IsDisabled") then
					local CPPart = chest
					local Gui = CPPart:FindFirstChild("Chest ESP")
					if CPPart and Gui then
						Gui:Destroy()
					end
			end
			if _G.ESPChests and not chest:GetAttribute("IsDisabled") then
				local ChestData = ChestsData[chest.Name]
				if not ChestData then return end
				local ChestName = Translate(ChestData.Name)
				local ChestColor = ChestData.Color
				local PPart = chest
				if not PPart then return end
				local Distance = math.floor((LocalHead.Position - PPart.Position).Magnitude/5)
				local Text = string.format("<font color='%s'>%s </font><font color='rgb(120, 120, 120)'>[%d]</font>", ChestColor, ChestName, Distance)
				if not PPart:FindFirstChild("Chest ESP") then
					local Bill = Instance.new("BillboardGui", PPart)
	                Bill.Name = "Chest ESP"
	                Bill.Size = UDim2.new(0, 240, 0, 40)
	                Bill.Adornee = PPart
	                Bill.AlwaysOnTop = true
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
					PPart["Chest ESP"].Label.Text = Text
				end
			end
		end
	end
	
	function EspIslands()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		local Locations = workspace["_WorldOrigin"].Locations:GetChildren()
		if not _G.ESPIslands then
			for _, island in pairs(Locations) do
				if island:FindFirstChild("Island ESP") then
					island["Island ESP"]:Destroy()
				end
			end
		end
		if _G.ESPIslands then
			for _, island in pairs(Locations) do
				if island.Name ~= "Sea" and not island.Name:find("LightningStrikesRegion") then
					local DispName = Translate(island.Name)
					local Distance = math.floor((LocalHead.Position - island.Position).Magnitude/5)
					local Esp = island:FindFirstChild("Island ESP")
					local Text = string.format("<font color='rgb(255, 200, 0)'>%s</font> <font color='rgb(120, 120, 120)'>[%d]</font>", DispName, Distance)
					if not Esp then
						local Bill = Instance.new("BillboardGui", island)
	                    Bill.Name = "Island ESP"
	                    Bill.Size = UDim2.new(0, 240, 0, 40)
	                    Bill.Adornee = island
	                    Bill.AlwaysOnTop = true
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
						Esp.Label.Text = Text
					end
				end
			end
		end
	end
	
	function EspFlowers()
		local LocalChar = LocalPlayer.Character
		if not LocalChar then return end
		local LocalHead = LocalChar:FindFirstChild("Head")
		if not LocalHead then return end
		if not _G.ESPFlowers then 
			for _, flower in pairs(w:GetChildren()) do
				if flower:IsA("Part") and flower:FindFirstChild("Flower ESP") then
					flower["Flower ESP"]:Destroy()
				end
			end
		end
		if _G.ESPFlowers then 
			for _, flower in pairs(w:GetChildren()) do
				if flower:IsA("Part") and FlowersData[flower.Name] then
					local Name = Translate(FlowersData[flower.Name].Name)
					local FlowerColor = FlowersData[flower.Name].Color
					local Distance = math.floor((LocalHead.Position - flower.Position).Magnitude/5)
					local Esp = flower:FindFirstChild("Flower ESP")
					local Text = string.format("<font color='%s'>%s</font> <font color='rgb(120, 120, 120)'>[%d]</font>", FlowerColor, Name, Distance)
					if not Esp then
						local Bill = Instance.new("BillboardGui", flower)
	                    Bill.Name = "Flower ESP"
	                    Bill.Size = UDim2.new(0, 240, 0, 40)
	                    Bill.Adornee = flower
	                    Bill.AlwaysOnTop = true
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
						Esp.Label.Text = Text
					end
				end
			end
		end
	end
	
	task.spawn(function()
		while task.wait(0.1) do
			EspPlayers()
			EspFruits()
			EspBerries()
			EspChests()
			EspIslands()
			EspFlowers()
		end
	end)
	
	local randomState = Random.new()
	local tblTween = {TweenInfo.new(0.1, Enum.EasingStyle.Back), TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In)}
	local lastPos = Vector3.new(0,0,0)
	
	task.spawn(function()
		while true do
			task.wait(0.1)
			if _G.IceWalk then
				local character = game.Players.LocalPlayer.Character
				local hrp = character and character:FindFirstChild("HumanoidRootPart")
				if hrp then
					if (hrp.Position - lastPos).Magnitude > 0.1 then
						lastPos = hrp.Position
						if (workspace.CurrentCamera.CFrame.Position - hrp.Position).Magnitude <= 300 then
							local WalkPlace = ReplicatedStorage.Effect.Container.Ice1.Waterwalk.ice:Clone()
							local cf = CFrame.new(hrp.Position.X, -3.8, hrp.Position.Z) * CFrame.Angles(0, randomState:NextNumber(0, math.pi), 0)
							WalkPlace.CFrame = cf
							local baseSize = WalkPlace.Size * 1.15
							WalkPlace.Size = baseSize / 2 * randomState:NextNumber(1, 2)
							WalkPlace.Parent = workspace
							TweenService:Create(WalkPlace, tblTween[1], {Size = baseSize}):Play()
							for _, v in pairs(WalkPlace:GetDescendants()) do
								if v:IsA("ParticleEmitter") then
									v:Emit(v:GetAttribute("EmitCount") * 0.5)
								end
							end
							--Sound:Play("Ice_walk", WalkPlace.CFrame)
							task.delay(0.75, function()
								local tweenShrink = TweenService:Create(WalkPlace, tblTween[2], {Size = Vector3.new(0, 0, 0)})
								tweenShrink.Completed:Connect(function()
									WalkPlace.Transparency = 1
								end)
								tweenShrink:Play()
								task.wait(0.5)
								WalkPlace:Destroy()
							end)
						end
					end
				end
			else
				task.wait(0.5)
			end
		end
	end)
	
	----------------------------------------[[ Window ]]----------------------------------------
	ldstg(game:HttpGet("https://raw.githubusercontent.com/agenext/Libraries/refs/heads/main/Random%20Icons/RandomIcon.txt"))()
	local Window = redzlib:MakeWindow({
	Title = "Someone Hub | Blox Fruits",
	SubTitle = "By Someone",
	SaveFolder = "Someone Hub.json"
	})
	
	Window:AddMinimizeButton({
	Button = { Image = "rbxassetid://80677412933527", BackgroundTransparency = 0 },
	Corner = { CornerRadius = UDim.new(0, 6) }
	})
	
	local Social = Window:MakeTab({Title = "Social Media", Icon = RandomIcon("Social Media")})
	local Farm = Window:MakeTab({Title = "Farm", Icon = RandomIcon("Farm")})
	local Quests = Window:MakeTab({Title = "Quests/Items", Icon = RandomIcon("Quests/Items")})
	local SeaEvents = Window:MakeTab({Title = "Sea Events", Icon = RandomIcon("Sea Events")})
	local Islands = Window:MakeTab({Title = "Islands", Icon = RandomIcon("Islands")})
	local Fishing = Window:MakeTab({Title = "Fishing", Icon = RandomIcon("Fishing")})
	local Teleport = Window:MakeTab({Title = "Teleport", Icon = RandomIcon("Teleport")})
	local Fruits = Window:MakeTab({Title = "Fruits/Raid", Icon = RandomIcon("Fruits/Raid")})
	local Player = Window:MakeTab({Title = "Player", Icon = RandomIcon("Player")})
	local Race = Window:MakeTab({Title = "Race", Icon = RandomIcon("Race")})
	local Shop = Window:MakeTab({Title = "Shop", Icon = RandomIcon("Shop")})
	local Visual = Window:MakeTab({Title = "Visual", Icon = RandomIcon("Visual")})
	local Misc = Window:MakeTab({Title = "Miscellaneous", Icon = RandomIcon("Miscellaneous")})
	
	----------------------------------------[[ Social ]]----------------------------------------
	
	----------------------------------------[[ Misc ]]----------------------------------------
	
	Misc : AddSection("Main Settings")
	
	Misc : AddDropdown({
	Title = "Select Weapon",
	Description = "Select The Tool Tip Of The Weapon To Be Used",
	Options = {"Melee", "Sword", "Gun", "Blox Fruits"},
	Default = S["Select Weapon"],
	Multi = false,
	Callback = function(Value)
	_G.SelectWeapon = Value
	S["Select Weapon"] = Value
	SS()
	end})
	
	Misc : AddSlider({
    Title = "Flight Speed",
    Description = "Flight Speed",
    Min = 50,
    Max = 350,
    Increase = 5,
    Default = S["Flight Speed"],
    Callback = function(Value)
    _G.TweenSpeed = Value
    S["Flight Speed"] = Value
    SS()
    end})
    
    Misc : AddToggle({
	Title = "Bring Enemies",
	Description = "Bring Enemies To Make Farming Easier",
	Default = S["Bring Enemies"],
	Callback = function(Value)
	_G.BringEnemies = Value
	S["Bring Enemies"] = Value
	SS()
	end})
    
	Misc : AddToggle({
	Title = "Auto Buso",
	Description = "Enables Buso Haki",
	Default = S["Auto Buso"],
	Callback = function(Value)
	_G.AutoBuso = Value
	S["Auto Buso"] = Value
	SS()
	end})
	
	Misc : AddToggle({
	Title = "Auto Attack",
	Description = "Automatically Attacks Nearby Players And Enemies",
	Default = S["Auto Attack"],
	Callback = function(Value)
	_G.AutoAttack = Value
	S["Auto Attack"] = Value
	SS()
	end})
	
	Misc : AddSection("Race")
	
	Misc : AddToggle({
	Title = "Enable V3",
	Description = "Enable Race V3 Automatically",
	Default = S["Enable V3"],
	Callback = function(Value)
	_G.EnableV3 = Value
	S["Enable V3"] = Value
	SS()
	end})
	
	Misc : AddToggle({
	Title = "Enable V4",
	Description = "Activates Transformation When It Charges",
	Default = S["Enable V4"],
	Callback = function(Value)
	_G.EnableV4 = Value
	S["Enable V4"] = Value
	SS()
	end})
	
	Misc : AddSection("Codes")
	
	Misc : AddButton({
    Title = "Redeem Codes",
    Description = "Redeem Codes To Get Rewards",
    Callback = function()
    for _, code in Codes do
	    Remotes.Redeem:InvokeServer(code)
    end
    end})
    
    Misc : AddSection("Menus")
    
    Misc : AddButton({
    Title = "Open Normal Fruit Shop",
    Description = "Open Normal Fruit Shop",
    Callback = function()
    require(LocalPlayer.PlayerGui.Main.FruitShopAndDealer.Controller):Open()
    end})
    
    Misc : AddButton({
    Title = "Open Advanced Fruit Shop",
    Description = "Open Advanced Fruit Shop",
    Callback = function()
    require(LocalPlayer.PlayerGui.Main.FruitShopAndDealer.Controller):Open("AdvancedFruitDealer")
    end})
    
    Misc : AddButton({
    Title = "Open Menu Titles",
    Description = "Open Menu Titles",
    Callback = function()
    LocalPlayer.PlayerGui.Main.Titles.Visible = true
    end})
    
    Misc : AddSection("More FPS")
    
    Misc : AddToggle({
	Title = "Disable Notifications",
	Description = "Remove Notifications From Screen",
	Default = S["Disable Notifications"],
	Callback = function(Value)
	LocalPlayer.PlayerGui.Notifications.Enabled = not Value
	ReplicatedStorage.Assets.GUI.DamageCounter.Enabled = not Value
	S["Disable Notifications"] = Value
	SS()
	end})
	
	Misc : AddSection("Miscellaneous Settings")
	
	Misc : AddToggle({
	Title = "Send Allies",
	Description = "Send And Accept Ally To Players",
	Default = S["Send Allies"],
	Callback = function(Value)
	_G.SendAllies = Value
	S["Send Allies"] = Value
	SS()
	end})
	
	----------------------------------------[[ Farm ]]----------------------------------------
	
	Farm : AddSection("Chests")
	
	Farm : AddToggle({
	Title = "Collect Chests",
	Description = "Collect All Chests Across The Map",
	Default = S["Collect Chests"],
	Callback = function(Value)
	_G.CollectChests = Value
	S["Collect Chests"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Collect Mirage Chests",
	Description = "Collect Only Chests That Are Fragments",
	Default = S["Collect Mirage Chests"],
	Callback = function(Value)
	_G.CollectMirageChests = Value
	S["Collect Mirage Chests"] = Value
	SS()
	end})
	
	----------------------------------------[[ Quests ]]----------------------------------------
	
	Quests : AddSection("Berries")
	
	Quests:AddToggle({
	Title = "Collect Berries",
	Description = "Collect Berries Around The Map",
	Default = S["Collect Berries"],
	Callback = function(Value)
	_G.CollectBerries = Value
	S["Collect Berries"] = Value
	SS()
	end})
	
	----------------------------------------[[ SeaEvents ]]----------------------------------------
	
	----------------------------------------[[ Islands ]]----------------------------------------
	
	----------------------------------------[[ Fishing ]]----------------------------------------
	
	----------------------------------------[[ Teleport ]]----------------------------------------
	
	Teleport : AddSection("Seas")
	
	Teleport : AddButton({
	Title = "Go To The First Sea",
	Description = "Go To The First Sea",
	Callback = function()
	InvokeServer("TravelMain")
	end})
	
	Teleport : AddButton({
	Title = "Go To The Second Sea",
	Description = "Go To The Second Sea",
	Callback = function()
	InvokeServer("TravelDressrosa")
	end})
	
	Teleport : AddButton({
	Title = "Go To The Third Sea",
	Description = "Go To The Third Sea",
	Callback = function()
	InvokeServer("TravelZou")
	end})
	
	Teleport : AddSection("Islands")
	
	Teleport : AddDropdown({
	Title = "Select Island",
	Description = "Select The Island You Want To Go To",
	Options = IslandsList,
	Default = "...",
	Multi = false,
	Callback = function(Value)
	_G.SelectIsland = Value
	end})
	
	Teleport : AddButton({
    Title = "Go To The Island",
    Description = "Go To The Selected Island",
    Callback = function()
    Tween(IslandsPos[_G.SelectIsland])
    end})
	
	----------------------------------------[[ Fruits ]]----------------------------------------
	
	Fruits : AddSection("Fruits")
	
	Fruits : AddToggle({
	Title = "Random Fruits",
	Description = "Buy Random Fruits At Zioles",
	Default = S["Random Fruits"],
	Callback = function(Value)
	_G.RandomFruits = Value
	S["Random Fruits"] = Value
	SS()
	end})
	
	Fruits : AddToggle({
	Title = "Collect Fruits",
	Description = "Collect Fruits Around The Map",
	Default = S["Collect Fruits"],
	Callback = function(Value)
	_G.CollectFruits = Value
	S["Collect Fruits"] = Value
	SS()
	end})
	
	Fruits : AddToggle({
	Title = "Store Fruits",
	Description = "Automatically Stores Fruits",
	Default = S["Store Fruits"],
	Callback = function(Value)
	_G.StoreFruits = Value
	S["Store Fruits"] = Value
	SS()
	end})
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	Player : AddSection("Local Player")
	
	Player : AddSlider({
    Title = "Select Walk Speed",
    Description = "Select Walking Speed To Change",
    Min = 10,
    Max = 300,
    Increase = 10,
    Default = S["Select Walk Speed"],
    Callback = function(Value)
    _G.SelectWalkSpeed = Value
    S["Select Walk Speed"] = Value
    SS()
    end})
    
    Player : AddToggle({
	Title = "Change Speed",
	Description = "Change Walking Speed To Selected",
	Default = S["Change Speed"],
	Callback = function(Value)
	_G.ChangeSpeed = Value
	S["Change Speed"] = Value
	SS()
	end})
	
	Player : AddSlider({
    Title = "Select Jump Power",
    Description = "Select Jump Power To Change",
    Min = 50,
    Max = 500,
    Increase = 50,
    Default = S["Select Jump Power"],
    Callback = function(Value)
    _G.SelectJumpPower = Value
    S["Select Jump Power"] = Value
    SS()
    end})
    
    Player : AddToggle({
	Title = "Change Jump",
	Description = "Changes The Jump To The Selected Value",
	Default = S["Change Jump"],
	Callback = function(Value)
	_G.ChangeJump = Value
	S["Change Jump"] = Value
	SS()
	end})
	
	Player : AddSlider({
    Title = "Select Dash Distance",
    Description = "Select The Distance Your Dash Will Travel",
    Min = 1,
    Max = 200,
    Increase = 10,
    Default = S["Select Dash Distance"],
    Callback = function(Value)
    _G.SelectDashDistance = Value
    S["Select Dash Distance"] = Value
    SS()
    end})
    
    Player : AddToggle({
	Title = "Change Dash Distance",
	Description = "Changes Your Dash Distance To The Selected Distance",
	Default = S["Change Dash Distance"],
	Callback = function(Value)
	_G.ChangeDashDistance = Value
	S["Change Dash Distance"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "No Collision",
	Description = "Allows The Player To Pass Through Barriers",
	Default = S["No Collision"],
	Callback = function(Value)
	_G.NoClip = Value
	S["No Collision"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Infinite Jump",
	Description = "Allows The Player To Jump Infinitely",
	Default = S["Infinite Jump"],
	Callback = function(Value)
	_G.InfiniteJump = Value
	S["Infinite Jump"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Walk On Water",
	Description = "Allows The Player To Walk On Water",
	Default = S["Walk On Water"],
	Callback = function(Value)
	if Value then
		Map:WaitForChild("WaterBase-Plane", 9e9).Size = Vector3.new(1000, 113, 1000)
	else
		Map:WaitForChild("WaterBase-Plane", 9e9).Size = Vector3.new(1000, 80, 1000)
	end
	S["Walk On Water"] = Value
	SS()
	end})
	
	Player : AddSection("Aimbot")
	
	Player : AddToggle({
	Title = "Aimbot Nearest",
	Description = "Target The Nearest Player/Enemie",
	Default = S["Aimbot Nearest"],
	Callback = function(Value)
	_G.AimbotNearest = Value
	S["Aimbot Nearest"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Ignore Enemies",
	Description = "Don't Aim At Enemies",
	Default = S["Ignore Enemies"],
	Callback = function(Value)
	_G.IgnoreEnemies = Value
	S["Ignore Enemies"] = Value
	SS()
	end})
	
	----------------------------------------[[ Race ]]----------------------------------------
	
	----------------------------------------[[ Shop ]]----------------------------------------
	
	Shop : AddSection("Christmas")
		
	Shop : AddButton({
	Title = "Buy 2x EXP (15 Mins.)",
	Description = "Buy 2x EXP (15 Mins.)",
	Callback = function()
	InvokeServer("Candies", "Check")
	InvokeServer("Candies", "Buy", 1, 1)
	end})
	
	Shop : AddButton({
	Title = "Buy Stats Refund",
	Description = "Buy Stats Refund",
	Callback = function()
	InvokeServer("Candies", "Check")
	InvokeServer("Candies", "Buy", 1, 2)
	end})
	
	Shop : AddButton({
	Title = "Buy Race Reroll",
	Description = "Buy Race Reroll",
	Callback = function()
	InvokeServer("Candies", "Check")
	InvokeServer("Candies", "Buy", 1, 3)
	end})
	
	Shop : AddButton({
	Title = "Buy 200 Frags",
	Description = "Buy 200 Frags",
	Callback = function()
	InvokeServer("Candies", "Check")
	InvokeServer("Candies", "Buy", 2, 2)
	end})
	
	Shop : AddButton({
	Title = "Buy 500 Frags",
	Description = "Buy 500 Frags",
	Callback = function()
	InvokeServer("Candies", "Check")
	InvokeServer("Candies", "Buy", 2, 2)
	end})
	
	Shop : AddSection("Ectoplasm")
	
	Shop : AddButton({
	Title = "Buy Bizarre Rifle",
	Description = "Buy Bizarre Rifle",
	Callback = function()
	end})
	
	Shop : AddButton({
	Title = "Buy Ghoul Mask",
	Description = "Buy Ghoul Mask",
	Callback = function()
	end})
	
	Shop : AddButton({
	Title = "Buy Midnight Blade",
	Description = "Buy Midnight Blade",
	Callback = function()
	end})
	
	Shop : AddSection("Ability Teacher")
	
	Shop : AddButton({
	Title = "Buy Geppo",
	Description = "Buy Geppo",
	Callback = function()
	InvokeServer("BuyHaki", "Geppo")
	end})
	
	Shop : AddButton({
	Title = "Buy Buso",
	Description = "Buy Buso",
	Callback = function()
	InvokeServer("BuyHaki", "Buso")
	end})
	
	Shop : AddButton({
	Title = "Buy Soru",
	Description = "Buy Soru",
	Callback = function()
	InvokeServer("BuyHaki", "Soru")
	end})
	
	Shop : AddButton({
	Title = "Buy Ken Haki",
	Description = "Buy Ken Haki",
	Callback = function()
	InvokeServer("KenTalk", "Buy")
	end})
	
	Shop : AddSection("Miscellaneous")
	
	Shop : AddButton({
	Title = "Buy Random Race",
	Description = "Buy Random Race",
	Callback = function()
	InvokeServer("BlackbeardReward", "Reroll", "1")
	InvokeServer("BlackbeardReward", "Reroll", "2")
	end})
	
	Shop : AddButton({
	Title = "Buy Reset Stats",
	Description = "Buy Reset Stats",
	Callback = function()
	InvokeServer("BlackbeardReward", "Refund", "1")
	InvokeServer("BlackbeardReward", "Refund", "2")
	end})
	
	Shop : AddSection("Fighting Styles")
	
	Shop : AddButton({
	Title = "Buy Black Leg",
	Description = "Buy Black Leg",
	Callback = function()
	InvokeServer("BuyBlackLeg")
	end})
	
	Shop : AddButton({
	Title = "Buy Electro",
	Description = "Buy Electro",
	Callback = function()
	InvokeServer("BuyElectro")
	end})
	
	Shop : AddButton({
	Title = "Buy Fishman Karate",
	Description = "Buy Fishman Karate",
	Callback = function()
	InvokeServer("BuyFishmanKarate")
	end})
	
	Shop : AddButton({
	Title = "Buy Dragon Claw",
	Description = "Buy Dragon Claw",
	Callback = function()
	InvokeServer("BlackbeardReward", "DragonClaw", "1")
	InvokeServer("BlackbeardReward", "DragonClaw", "2")
	end})
	
	Shop : AddButton({
	Title = "Buy Superhuman",
	Description = "Buy Superhuman",
	Callback = function()
	InvokeServer("BuySuperhuman")
	end})
	
	Shop : AddButton({
	Title = "Buy Death Step",
	Description = "Buy Death Step",
	Callback = function()
	InvokeServer("BuyDeathStep")
	end})
	
	Shop : AddButton({
	Title = "Buy Sharkman Karate",
	Description = "Buy Sharkman Karate",
	Callback = function()
	InvokeServer("BuySharkmanKarate")
	end})
	
	Shop : AddButton({
	Title = "Buy Electric Claw",
	Description = "Buy Electric Claw",
	Callback = function()
	InvokeServer("BuyElectricClaw")
	end})
	
	Shop : AddButton({
	Title = "Buy Dragon Talon",
	Description = "Buy Dragon Talon",
	Callback = function()
	InvokeServer("BuyDragonTalon")
	end})
	
	Shop : AddButton({
	Title = "Buy GodHuman",
	Description = "Buy GodHuman",
	Callback = function()
	InvokeServer("BuyGodhuman")
	end})
	
	Shop : AddButton({
	Title = "Buy Sanguine Art",
	Description = "Buy Sanguine Art",
	Callback = function()
	InvokeServer("BuySanguineArt")
	end})
	
	Shop : AddSection("Swords")
	
	Shop : AddButton({
	Title = "Buy Katana",
	Description = "Buy Katana",
	Callback = function()
	InvokeServer("BuyItem", "Katana")
	end})
	
	Shop : AddButton({
	Title = "Buy Cutlass",
	Description = "Buy Cutlass",
	Callback = function()
	InvokeServer("BuyItem", "Cutlass")
	end})
	
	Shop : AddButton({
	Title = "Buy Dual Katana",
	Description = "Buy Dual Katana",
	Callback = function()
	InvokeServer("BuyItem", "Dual Katana")
	end})
	
	Shop : AddButton({
	Title = "Buy Iron Mace",
	Description = "Buy Iron Mace",
	Callback = function()
	InvokeServer("BuyItem", "Iron Mace")
	end})
	
	Shop : AddButton({
	Title = "Buy Triple Katana",
	Description = "Buy Triple Katana",
	Callback = function()
	InvokeServer("BuyItem", "Triple Katana")
	end})
	
	Shop : AddButton({
	Title = "Buy Pipe",
	Description = "Buy Pipe",
	Callback = function()
	InvokeServer("BuyItem", "Pipe")
	end})
	
	Shop : AddButton({
	Title = "Buy Dual-Headed Blade",
	Description = "Buy Dual-Headed Blade",
	Callback = function()
	InvokeServer("BuyItem", "Dual-Headed Blade")
	end})
	
	Shop : AddButton({
	Title = "Buy Soul Cane",
	Description = "Buy Soul Cane",
	Callback = function()
	InvokeServer("BuyItem", "Soul Cane")
	end})
	
	Shop : AddButton({
	Title = "Buy Bisento",
	Description = "Buy Bisento",
	Callback = function()
	InvokeServer("BuyItem", "Bisento")
	end})
	
	Shop : AddSection("Guns")
	
	Shop : AddButton({
	Title = "Buy Musket",
	Description = "Buy Musket",
	Callback = function()
	InvokeServer("BuyItem", "Musket")
	end})
	
	Shop : AddButton({
	Title = "Buy Slingshot",
	Description = "Buy Slingshot",
	Callback = function()
	InvokeServer("BuyItem", "Slingshot")
	end})
	
	Shop : AddButton({
	Title = "Buy Flintlock",
	Description = "Buy Flintlock",
	Callback = function()
	InvokeServer("BuyItem", "Flintlock")
	end})
	
	Shop : AddButton({
	Title = "Buy Refined Slingshot",
	Description = "Buy Refined Slingshot",
	Callback = function()
	InvokeServer("BuyItem", "Refined Slingshot")
	end})
	
	Shop : AddButton({
	Title = "Buy Dual Flintlock",
	Description = "Buy Dual Flintlock",
	Callback = function()
	InvokeServer("BuyItem", "Dual Flintlock")
	end})
	
	Shop : AddButton({
	Title = "Buy Cannon",
	Description = "Buy Cannon",
	Callback = function()
	InvokeServer("BuyItem", "Cannon")
	end})
	
	Shop : AddButton({
	Title = "Buy Kabucha",
	Description = "Buy Kabucha",
	Callback = function()
	InvokeServer("BlackbeardReward", "Slingshot", "1")
	InvokeServer("BlackbeardReward", "Slingshot", "2")
	end})
	
	Shop : AddSection("Accessories")
	
	Shop : AddButton({
	Title = "Buy Black Cape",
	Description = "Buy Black Cape",
	Callback = function()
	InvokeServer("BuyItem", "Black Cape")
	end})
	
	Shop : AddButton({
	Title = "Buy Swordsman Hat",
	Description = "Buy Swordsman Hat",
	Callback = function()
	InvokeServer("BuyItem", "Swordsman Hat")
	end})
	
	Shop : AddButton({
	Title = "Buy Tomoe Ring",
	Description = "Buy Tomoe Ring",
	Callback = function()
	InvokeServer("BuyItem", "Tomoe Ring")
	end})
	
	Shop : AddSection("Races")
	
	Shop : AddButton({
	Title = "Buy Ghoul Race",
	Description = "Buy Ghoul Race",
	Callback = function()
	InvokeServer("Ectoplasm", "Change", 4)
	end})
	
	Shop : AddButton({
	Title = "Buy Cyborg Race",
	Description = "Buy Cyborg Race",
	Callback = function()
	InvokeServer("CyborgTrainer", "Buy")
	end})
	
	Shop : AddSection("Draco Crafts")
	
	Shop : AddButton({
	Title = "Craft Volcanic Magnet",
	Description = "Craft Volcanic Magnet",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
	end})
	
	Shop : AddButton({
	Title = "Craft Dragonstorm",
	Description = "Craft Dragonstorm",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "Dragonstorm")
	end})
	
	Shop : AddButton({
	Title = "Craft Dragonheart",
	Description = "Craft Dragonheart",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "Dragonheart")
	end})
	
	Shop : AddButton({
	Title = "Craft T-Rex Skull",
	Description = "Craft T-Rex Skull",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "TRexSkull")
	end})
	
	Shop : AddButton({
	Title = "Craft Dino Hood",
	Description = "Craft Dino Hood",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "DinoHood")
	end})
	
	Shop : AddSection("Beast Hunter")
	
	Shop : AddButton({
	Title = "Craft Leviathan Crown",
	Description = "Craft Leviathan Crown",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "LeviathanCrown")
	end})
	
	Shop : AddButton({
	Title = "Craft Leviathan Shield",
	Description = "Craft Leviathan Shield",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "LeviathanShild")
	end})
	
	Shop : AddButton({
	Title = "Craft Leviathan Ship",
	Description = "Craft Leviathan Ship",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "LeviathanShip")
	end})
	
	Shop : AddSection("Shark Hunter")
	
	Shop : AddButton({
	Title = "Craft Shark Tooth Necklace",
	Description = "Craft Shark Tooth Necklace",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "Tooth Necklace")
	end})
	
	Shop : AddButton({
	Title = "Craft Terror Jaw",
	Description = "Craft Terror Jaw",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "Terror Jaw")
	end})
	
	Shop : AddButton({
	Title = "Craft Monster Magnet",
	Description = "Craft Monster Magnet",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "Shark Anchor")
	end})
	
	Shop : AddSection("Dragon Talon Sage")
	
	Shop : AddButton({
	Title = "Craft Common Scroll",
	Description = "Craft Common Scroll",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "CommonScroll")
	end})
	
	Shop : AddButton({
	Title = "Craft Rare Scroll",
	Description = "Craft Rare Scroll",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "RareScroll")
	end})
	
	Shop : AddButton({
	Title = "Craft Legendary Scroll",
	Description = "Craft Legendary Scroll",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "LegendaryScroll")
	end})
	
	Shop : AddButton({
	Title = "Craft Mythical Scroll",
	Description = "Craft Mythical Scroll",
	Callback = function()
	InvokeServer("CraftItem", "Craft", "MythicalScroll")
	end})
	
	----------------------------------------[[ Visual ]]----------------------------------------
	
	Visual : AddSection("Extra Sensory Perception")
	
	Visual : AddSlider({
    Title = "Font Size",
    Description = "Font Size To Be Used",
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
	Description = "Choose The Font That Will Be Used In The ESPs",
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
    Description = "See Name, Distance And Health",
    Default = S["ESP Players"],
    Callback = function(Value)
    _G.ESPPlayers = Value
    S["ESP Players"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Fruits",
    Description = "See Name And Distance",
    Default = S["ESP Fruits"],
    Callback = function(Value)
    _G.ESPFruits = Value
    S["ESP Fruits"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Berries",
    Description = "See Name And Distance",
    Default = S["ESP Berries"],
    Callback = function(Value)
    _G.ESPBerries = Value
    S["ESP Berries"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Chests",
    Description = "See Name And Distance",
    Default = S["ESP Chests"],
    Callback = function(Value)
    _G.ESPChests = Value
    S["ESP Chests"] = Value
	SS()
    end})
    
    Visual : AddToggle({
    Title = "ESP Islands",
    Description = "See Name And Distance",
    Default = S["ESP Islands"],
    Callback = function(Value)
    _G.ESPIslands = Value
    S["ESP Islands"] = Value
	SS()
    end})
    
    if Sea2 then
    Visual : AddToggle({
    Title = "ESP Flowers",
    Description = "See Name And Distance",
    Default = S["ESP Flowers"],
    Callback = function(Value)
    _G.ESPFlowers = Value
    S["ESP Flowers"] = Value
	SS()
    end})
    end
    
    Visual : AddSection("Fake Effects")
    
    Visual : AddToggle({
	Title = "Ice Walk",
	Description = "Allows You To Use The Ice Walk Effect",
	Default = S["Ice Walk"],
	Callback = function(Value)
	_G.IceWalk = Value
	local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	if Char then
	--	Char:SetAttribute("WaterWalking", Value)
	end
	S["Ice Walk"] = Value
	SS()
	end})
	
	if not _G.AutoExecuted then
		_G.AutoExecuted = true
		queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/agenext/Games/refs/heads/main/Blox%20Fruits/BF.lua"))()]])
	end