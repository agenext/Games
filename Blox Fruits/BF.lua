	----------------------------------------[[ Name ]]----------------------------------------
	
	local g = game
	local w = workspace
	local Map = w:WaitForChild("Map")
	local Enemies = w:WaitForChild("Enemies")
	local Players = g:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UserName = LocalPlayer.Name
	local DisplayName = LocalPlayer.DisplayName
	local UserId = LocalPlayer.UserId
	local ReplicatedStorage = g:GetService("ReplicatedStorage")
	local DialogueController = require(game:GetService("ReplicatedStorage").DialogueController)
	local DialogueList = require(game:GetService("ReplicatedStorage").DialoguesList)
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
	local GameName = "Blox Fruits" 
	local FilePrefix = "Someone Settings"
	local FirstFolderPath = RootFolder .. "a/" .. MainFolder
	local SecondFolderPath = FirstFolderPath .. "/" .. GameName
	local SaveFile = SecondFolderPath .. "/" .. FilePrefix .. " - " .. PlayerName .. ".json"
	
	local S = {
		-- Settings --
		["Select Weapon"] = "Melee",
		["Tween Speed"] = 350,
		["Auro Buso"]= true,
		["Auto Attack"] = true,
		["Select Team"] = "Pirates",
		["Auto Choose Team"] = true,
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
		["Select Font"] = "FredokaOne",
		["Font Size"] = 12,
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
	local Sea1 = PlaceId == 2753915549
	local Sea2 = PlaceId == 4442272183
	local Sea3 = PlaceId == 7449423635
	
	function AttemptTeleport()
	    task.spawn(function()
	        while true do
	            task.wait(3)
	            local success, err = pcall(function()
	                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	            end)
	            if success then break end
	        end
	    end)
	end
	
	function CheckKick(v)
	    if v.Name == "ErrorPrompt" then
	        if v.Visible and v.TitleFrame.ErrorTitle.Text ~= "Teleport Failed" then
	            AttemptTeleport()
	        end
	        v:GetPropertyChangedSignal("Visible"):Connect(function()
	            if v.Visible and v.TitleFrame.ErrorTitle.Text ~= "Teleport Failed" then
	                AttemptTeleport()
	            end
	        end)
	    end
	end
	CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(CheckKick)
	----------------------------------------[[ Universal ]]----------------------------------------
	
	function CommF_(...)
		return Remotes.CommF_:InvokeServer(...)
	end
	
	function CommE(...)
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
	
	if S["Auto Choose Team"] and LocalPlayer.Team == nil then
		CommF_("SetTeam", S["Select Team"])
		wait(3)
	end
	
	function SendKey(Key, Time)
		local vim = g:GetService("VirtualInputManager")
		vim:SendKeyEvent(true, Key, false, game)
		task.wait(Time or 0.1)
		vim:SendKeyEvent(false, Key, false, game)
	end
	
	loadstring(game:HttpGet("https://raw.githubusercontent.com/agenext/Games/refs/heads/main/Blox%20Fruits/Utils/Module.txt"))()
	
	Teams = {
		["Pirates"] = "rgb(255, 89, 89)",
		["Marines"] = "rgb(175, 221, 255)"
	}
	
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
		for _, v in pairs(CommF_("getInventory")) do
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
	
	----------------------------------------[[ Settings ]]----------------------------------------
	
	function EquipTool(Name)
		local Backpack = LocalPlayer:WaitForChild("Backpack")
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local Tool = Backpack:FindFirstChild(Name)
		if Tool then
			Tool.Parent = Character
		end
	end
	
	task.spawn(function()
		while task.wait() do
			for _, Tool in LocalPlayer.Backpack:GetChildren() do
				if Tool.ToolTip == _G.SelectWeapon then
					SelectWeapon = Tool.Name 
				end
			end
		end
	end)
	
	local TweenQueue = {}
	local AddedPositions = {}
	local TweenProcessing = false
	
	function Tween(target, Index, FlagFunc)
		local key = tostring(target)
		if AddedPositions[key] then return end
		AddedPositions[key] = true
		if not TweenQueue[Index] then TweenQueue[Index] = {} end
		table.insert(TweenQueue[Index], {Pos = target, FlagFunc = FlagFunc})
		if not TweenProcessing then task.spawn(ProcessTweenQueue) end
		task.spawn(function()
			while FlagFunc() do task.wait() end
			for idx, list in pairs(TweenQueue) do
				for i = #list, 1, -1 do
					if list[i].FlagFunc == FlagFunc then
						AddedPositions[tostring(list[i].Pos)] = nil
						table.remove(list, i)
					end
				end
			end
		end)
	end
	
	function ProcessTweenQueue()
		TweenProcessing = true
		local char
		while not char do task.wait() char = LocalPlayer.Character end
		local root
		while not root do task.wait() root = char.PrimaryPart end
		local humanoid
		while not humanoid do
			task.wait()
			humanoid = char:FindFirstChildOfClass("Humanoid")
		end
		local function GetDistance(pos) return (pos - root.Position).Magnitude end
		while true do
			if not humanoid or humanoid.Health <= 0 then
				task.wait()
				char = LocalPlayer.Character
				root = char.PrimaryPart
				humanoid = char:FindFirstChildOfClass("Humanoid")
				task.wait()
			end
			local nextIndex
			for idx in pairs(TweenQueue) do
				if #TweenQueue[idx] > 0 then if not nextIndex or idx > nextIndex then nextIndex = idx end end
			end
			if not nextIndex then break end
			local tweenData
			tweenData = table.remove(TweenQueue[nextIndex], 1)
			if not tweenData or not tweenData.FlagFunc() then AddedPositions[tostring(tweenData and tweenData.Pos)] = nil continue end
			local target
			target = tweenData.Pos
			AddedPositions[tostring(target)] = nil
			if humanoid.Sit then humanoid.Sit = false end
			local PortalPos = {}
			if Sea1 then
				PortalPos = {
					Vector3.new(-4652, 872, -1754),
					Vector3.new(-7895, 5547, -380),
					Vector3.new(61164, 5, 1820),
					Vector3.new(3865, 5, -1926)
				}
			end
			if Sea2 then
				PortalPos = {
					Vector3.new(923, 125, 32853),
					Vector3.new(-6509, 83, -133)
				}
			end
			if Sea3 then
				PortalPos = {
					Vector3.new(3029, 2280, -7325),
					Vector3.new(28286, 14897, 103)
				}
			end
			local unlocks
			unlocks = CommF_("GetUnlockables")
			if Sea2 and unlocks.FlamingoAccess then
				table.insert(PortalPos, Vector3.new(-289, 306, 600))
				table.insert(PortalPos, Vector3.new(2284, 15, 905))
			end
			if Sea3 and unlocks.DefeatedIndraTrueForm then
				table.insert(PortalPos, Vector3.new(-12471, 374, -7551))
				table.insert(PortalPos, Vector3.new(5661, 1013, -335))
				table.insert(PortalPos, Vector3.new(-5074, 314, -3153))
			end
			
			local closestPortal
			closestPortal = nil
			local closestDistance
			closestDistance = GetDistance(target)
			for _, portal in pairs(PortalPos) do
				local portalDistance
				portalDistance = (portal - target).Magnitude
				if portalDistance < closestDistance then closestPortal = portal closestDistance = portalDistance end
			end
			if closestPortal == Vector3.new(3029, 2280, -7325) then
				CommF_("requestEntrance", Vector3.new(28286, 14897, 103))
				task.wait(0.1)
				root.CFrame = CFrame.new(28609, 14896, 105)
				task.wait(0.1)
				for _ = 1, 3 do CommF_("RaceV4Progress", "TeleportBack") end
				task.wait(0.2)
			elseif closestPortal then
				CommF_("requestEntrance", closestPortal)
				task.wait()
				CommF_("requestEntrance", closestPortal)
			end
			if GetDistance(target) < 300 then root.CFrame = CFrame.new(target) end
			if root.Position.Y ~= target.Y then root.CFrame += Vector3.new(0, target.Y - root.Position.Y, 0) end
			while tweenData.FlagFunc() and GetDistance(target) >= 2 and not _G.Cancel do
				if not humanoid or humanoid.Health <= 0 then
					task.wait()
					char = LocalPlayer.Character
					root = char.PrimaryPart
					humanoid = char:FindFirstChildOfClass("Humanoid")
					task.wait()
				end
				if humanoid.Sit then humanoid.Sit = false end
				if GetDistance(target) < 200 then root.CFrame = CFrame.new(target) break end
				local direction
				direction = (target - root.Position).Unit
				root.CFrame += direction * (_G.TweenSpeed or 350) * task.wait()
			end
		end
		TweenProcessing = false
	end
	
	LocalPlayer.CharacterAdded:Connect(function(Char)
		task.spawn(function()
			local Root
			while not Root do task.wait() Root = Char.PrimaryPart end
			for idx, list in pairs(TweenQueue) do
				for i = #list, 1, -1 do
					local TweenData = list[i]
					if TweenData.FlagFunc() then
						table.insert(TweenQueue[idx], TweenData)
					end
				end
			end
			TweenProcessing = false
			if #TweenQueue > 0 then task.spawn(ProcessTweenQueue) end
		end)
	end)
	
	function AutoBuso()
		if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("HasBuso") then
			CommF_("Buso")
		end
	end
	
	function IsAlive(Entity)
		if not Entity then return false end
		local Humanoid = Entity:FindFirstChild("Humanoid")
		return Humanoid and Humanoid.Health > 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead
	end
	
	function GetNearbyTargets()
		local Character = LocalPlayer.Character
		if not Character then return {} end
		local OriginPos = Character:GetPivot().Position
		local MaxDistance = 59
		local EnemiesInRange = {}
		local PlayersInRange = {}
		for _, Enemy in ipairs(w:FindFirstChild("Enemies") and w.Enemies:GetChildren() or {}) do
			local HRP = Enemy:FindFirstChild("HumanoidRootPart") or Enemy.PrimaryPart
			if HRP and IsAlive(Enemy) then
				local Dist = (HRP.Position - OriginPos).Magnitude
				if Dist < MaxDistance then
					table.insert(EnemiesInRange, Enemy)
				end
			end
		end
		if #EnemiesInRange > 0 then
			table.sort(EnemiesInRange, function(A, B)
				local APos = (A:FindFirstChild("HumanoidRootPart") or A.PrimaryPart or A:GetPivot()).Position
				local BPos = (B:FindFirstChild("HumanoidRootPart") or B.PrimaryPart or B:GetPivot()).Position
				return (APos - OriginPos).Magnitude < (BPos - OriginPos).Magnitude
			end)
			return EnemiesInRange
		end
		for _, Player in ipairs(Players:GetPlayers()) do
			if Player ~= LocalPlayer and Player.Character then
				local HRP = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character.PrimaryPart
				if HRP and IsAlive(Player.Character) then
					local Dist = (HRP.Position - OriginPos).Magnitude
					if Dist < MaxDistance then
						table.insert(PlayersInRange, Player.Character)
					end
				end
			end
		end
		table.sort(PlayersInRange, function(A, B)
			local APos = (A:FindFirstChild("HumanoidRootPart") or A.PrimaryPart or A:GetPivot()).Position
			local BPos = (B:FindFirstChild("HumanoidRootPart") or B.PrimaryPart or B:GetPivot()).Position
			return (APos - OriginPos).Magnitude < (BPos - OriginPos).Magnitude
		end)
		return PlayersInRange
	end
	
	function AttackNoCoolDown()
		local Character = LocalPlayer.Character
		if not Character then return end
		local Tool = nil
		for _, Obj in ipairs(Character:GetChildren()) do
			if Obj:IsA("Tool") then
				Tool = Obj
				break
			end
		end
		if not Tool then return end
		local ToolName = Tool.Name
		local Targets = GetNearbyTargets()
		if #Targets == 0 then return end
		local Target = Targets[1]
		local HRP = Target:FindFirstChild("HumanoidRootPart") or Target.PrimaryPart
		if not HRP then return end
		require(ReplicatedStorage.Mouse).Hit = HRP.CFrame
		require(ReplicatedStorage.Mouse).Target = HRP
		local HitOptions = {"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}
		local HitPart = Target:FindFirstChild(HitOptions[math.random(#HitOptions)]) or Target.PrimaryPart
		if not HitPart then return end
		if ToolName == "Skull Guitar" then
			local Args = {"TAP", HRP.Position}
			local Remote = Tool:FindFirstChild("RemoteEvent")
			if Remote then Remote:FireServer(unpack(Args)) end
			return
		end
		if Tool:FindFirstChild("LeftClickRemote") and not table.find({"Ice-Ice","Light-Light"}, ToolName) then
			local Dir = (HRP.Position - Character:GetPivot().Position).Unit
			Tool.LeftClickRemote:FireServer(Dir, 1)
			Tool.LeftClickRemote:FireServer(Dir, 2)
			return
		end
		local Modules = ReplicatedStorage:FindFirstChild("Modules")
		if not Modules then return end
		local Net = Modules:FindFirstChild("Net")
		if not Net then return end
		local RegisterAttack = Net:FindFirstChild("RE/RegisterAttack", true)
		local RegisterHit = Net:FindFirstChild("RE/RegisterHit", true)
		if not RegisterAttack or not RegisterHit then return end
		local HitParts = {{Target, HitPart}}
		RegisterAttack:FireServer(0.3)
		local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
		if not PlayerScripts then return end
		local LocalScript = PlayerScripts:FindFirstChildOfClass("LocalScript")
		while not LocalScript do
			PlayerScripts.ChildAdded:Wait()
			LocalScript = PlayerScripts:FindFirstChildOfClass("LocalScript")
		end
		local InternalHitFunc
		if getsenv then
			local Success, Env = pcall(getsenv, LocalScript)
			if Success and Env and Env._G then InternalHitFunc = Env._G.SendHitsToServer end
		end
		local SuccessFlag, CombatThreadFlag = pcall(function()
			return require(Modules:WaitForChild("Flags")).COMBAT_REMOTE_THREAD
		end)
		if SuccessFlag and InternalHitFunc and CombatThreadFlag then
			InternalHitFunc(HitPart, HitParts)
		elseif SuccessFlag and not CombatThreadFlag then
			RegisterHit:FireServer(HitPart, HitParts)
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
				CommE("ActivateAbility")
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
						CommF_("InviteAlly", player.Name)
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
					Tween(pos, 6, function() return _G.CollectChests end)
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
					Tween(model:GetPivot().Position, 7, function() return _G.CollectBerries end)
				end
				if not _G.CollectBerries then continue end
				local child = closestBush:FindFirstChildOfClass("Model")
				if child then
					Tween(child.WorldPivot.Position, 7, function() return _G.CollectBerries end)
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
	
	task.spawn(function()
	    while task.wait() do
	        if _G.CollectDragonEggs then
	            local Island = Map:FindFirstChild("PrehistoricIsland")
	            if Island then
	                local Core = Island:FindFirstChild("Core")
	                local DragonEggs = Core and Core:FindFirstChild("SpawnedDragonEggs")
	                if DragonEggs and #DragonEggs:GetChildren() > 0 then
	                    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	                    if HRP then
	                        local PlayerPos = HRP.Position
	                        local ClosestEgg
	                        local MinDistance = math.huge
	                        for _, Egg in DragonEggs:GetChildren() do
	                            if Egg:IsA("Model") and Egg.PrimaryPart then
	                                local EggPos = Egg.PrimaryPart.Position
	                                local Distance = (PlayerPos - EggPos).Magnitude
	                                if Distance < MinDistance then
	                                    MinDistance = Distance
	                                    ClosestEgg = Egg
	                                end
	                            end
	                        end
	                        if ClosestEgg then
	                            Tween(ClosestEgg.PrimaryPart.Position, 12, function() return _G.CollectDragonEggs end)
	                            if MinDistance <= 15 then
	                                for _, Desc in ClosestEgg:GetDescendants() do
	                                    if Desc:IsA("ProximityPrompt") then
	                                        fireproximityprompt(Desc)
	                                    end
	                                end
	                            end
	                        end
	                    end
	                end
	            end
	        end
	    end
	end)
	
	task.spawn(function()
	    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	    if HRP then
	        while task.wait() do
	            if _G.CollectDinoBones then
	                local ClosestBone
	                local MinDistance = math.huge
	                for _, bone in w:GetChildren() do
	                    if bone:IsA("BasePart") and bone.Name == "DinoBone" then
	                        local Distance = (HRP.Position - bone.Position).Magnitude
	                        if Distance < MinDistance then
	                            MinDistance = Distance
	                            ClosestBone = bone
	                        end
	                    end
	                end
	                if ClosestBone then
	                    Tween(ClosestBone.Position, 12, function() return _G.CollectDinoBones end)
	                end
	            end
	        end
	    end
	end)
	
	----------------------------------------[[ Fishery ]]----------------------------------------
	
	----------------------------------------[[ Fruits ]]----------------------------------------
	
	task.spawn(function()
		while task.wait() do
			if _G.CollectFruits then
				local char = LocalPlayer.Character
				if not char or not char.PrimaryPart then continue end
				for _, fruit in w:GetChildren() do
					if fruit.Name:find("Fruit") then
						if #fruit:GetChildren() > 0 then
							if fruit:FindFirstChild("Handle") then
								if fruit:IsA("Tool") then
									firetouchinterest(char.PrimaryPart, fruit.Handle, 0)
									firetouchinterest(char.PrimaryPart, fruit.Handle, 1)
								elseif fruit:IsA("Model") then
									Tween(fruit.Handle.Position, 10, function() return _G.CollectFruits end)
								end
							end
						end
					end
				end
			end
		end
	end)
	
	----------------------------------------[[ Teleport ]]----------------------------------------
	IslandList = {
		
	}
	for _, island in w["_WorldOrigin"].Locations:GetChildren() do
		table.insert(IslandList, island.Name)
	end
	
	----------------------------------------[[ Player ]]----------------------------------------
	
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
						Head["Player ESP"].Label.Font = (_G.SelectFont or S["Select Font"])
						Head["Player ESP"].Label.TextSize = (_G.FontSize or S["Font Size"])
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
		if not DevilFruitESP then
			for _, fruit in pairs(w:GetChildren()) do
				if fruit.Name:lower():find("fruit") then
					if fruit:FindFirstChild("Handle") and fruit.Handle:FindFirstChild("Fruit ESP") then
						fruit.Handle["Fruit ESP"]:Destroy() 
					end
				end
			end
		end
		if DevilFruitESP then
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
							Handle["Fruit ESP"].Label.Font = (_G.SelectFont or S["Select Font"])
							Handle["Fruit ESP"].Label.TextSize = (_G.FontSize or S["Font Size"])
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
				Esp.Label.Font = (_G.SelectFont or S["Select Font"])
				Esp.Label.TextSize = (_G.FontSize or S["Font Size"])
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
					PPart["Chest ESP"].Label.Font = (_G.SelectFont or S["Select Font"])
					PPart["Chest ESP"].Label.TextSize = (_G.FontSize or S["Font Size"])
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
						Esp.Label.Font = (_G.SelectFont or S["Select Font"])
						Esp.Label.TextSize = (_G.FontSize or S["Font Size"])
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
						Esp.Label.Font = (_G.SelectFont or S["Select Font"])
						Esp.Label.TextSize = (_G.FontSize or S["Font Size"])
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
	local Fish = Window:MakeTab({Title = "Fishery", Icon = RandomIcon("Fishery")})
	local Fruits = Window:MakeTab({Title = "Fruits/Raid", Icon = RandomIcon("Fruits/Raid")})
	local Teleport = Window:MakeTab({Title = "Teleport", Icon = RandomIcon("Teleport")})
	local Player = Window:MakeTab({Title = "Player", Icon = RandomIcon("Player")})
	local Race = Window:MakeTab({Title = "Race", Icon = RandomIcon("Race")})
	local Shop = Window:MakeTab({Title = "Shop", Icon = RandomIcon("Shop")})
	local Visual = Window:MakeTab({Title = "Visual", Icon = RandomIcon("Visual")})
	local Settings = Window:MakeTab({Title = "Settings", Icon = RandomIcon("Settings")})
	
	----------------------------------------[[ Social ]]----------------------------------------
	
	Social : AddDiscordInvite({
	Title = "Someone Hub",
	Description = "",
	Logo = "rbxassetid://80677412933527",
	Invite = "dsc.gg/discord",
	})
	
	----------------------------------------[[ Settings ]]----------------------------------------
	
	Settings : AddSection({"Main Settings", RandomIcon("Main Settings")})
	
	Settings : AddDropdown({
	Title = "Select Weapon",
	Description = "",
	Options = {"Melee", "Sword", "Gun", "Blox Fruits"},
	Default = S["Select Weapon"],
	Multi = false,
	Callback = function(Value)
	_G.SelectWeapon = Value
	S["Select Weapon"] = Value
	SS()
	end})
	
	Settings : AddSlider({
    Title = "Tween Speed",
    Description = "",
    Min = 50,
    Max = 350,
    Increase = 10,
    Default = S["Tween Speed"],
    Callback = function(Value)
    _G.TweenSpeed = Value 
    S["Tween Speed"] = Value
    SS()
    end})
	
	Settings : AddToggle({
	Title = "Auto Buso",
	Description = "",
	Default = S["Auto Buso"],
	Callback = function(Value)
	_G.AutoBuso = Value
	S["Auto Buso"] = Value
	SS()
	end})
	
	Settings : AddToggle({
	Title = "Auto Attack",
	Description = "",
	Default = S["Auto Attack"],
	Callback = function(Value)
	_G.AutoAttack = Value
	S["Auto Attack"] = Value
	SS()
	end})
	
	Settings : AddSection({"Others Settings", RandomIcon("Section")})
	
	Settings : AddToggle({
	Title = "Enable V3 Race",
	Description = "",
	Default = S["Enable V3 Race"],
	Callback = function(Value)
	_G.EnableV3 = Value
	S["Enable V3 Race"] = Value
	SS()
	end})
	
	Settings : AddToggle({
	Title = "Enabled V4 Race",
	Description = "",
	Default = S["Enabled V4 Race"],
	Callback = function(Value)
	_G.EnableV4 = Value
	S["Enabled V4 Race"] = Value
	SS()
	end})
	
	Settings : AddSection({"Codes", RandomIcon("Section")})
	
	Settings : AddButton({
    Title = "Redeem All Codes",
    Description = "",
    Callback = function()
    for _, Code in pairs(Codes) do
	    Remotes.Redeem:InvokeServer(Code)
    end
    end})
	
	Settings : AddSection({"Menu", RandomIcon("Section")})
	
	Settings : AddButton({
    Title = "Open Normal Fruit Shop",
    Description = "",
    Callback = function()
	require(LocalPlayer.PlayerGui.Main.FruitShopAndDealer.Controller):Open() 
    end})
    
    Settings : AddButton({
    Title = "Open Advanced Fruit Shop",
    Description = "",
    Callback = function()
    require(LocalPlayer.PlayerGui.Main.FruitShopAndDealer.Controller):Open("AdvancedFruitDealer") 
    end})
    
    Settings : AddButton({
    Title = "Open Titles Menu",
    Description = "",
    Callback = function()
    LocalPlayer.PlayerGui.Main.Titles.Visible = true
    end})
	
	Settings : AddSection({"Team", RandomIcon("Section")})
	
	Settings : AddButton({
    Title = "Join Pirates",
    Description = "",
    Callback = function()
    CommF_("SetTeam", "Pirates")
    end})
    
    Settings : AddButton({
    Title = "Join Marines",
    Description = "",
    Callback = function()
    CommF_("SetTeam", "Marines")
    end})
    
    Settings : AddDropdown({
	Title = "Select Team",
	Description = "",
	Options = {"Pirates", "Marines"},
	Default = S["Select Team"]req,
	Multi = false,
	Callback = function(Value)
	S["Select Team"] = Value
	SS()
	end})
	
	Settings : AddToggle({
	Title = "Auto Choose Team",
	Description = "",
	Default = S["Auto Choose Team"],
	Callback = function(Value)
	S["Auto Choose Team"] = Value
	SS()
	end})
	
	Settings : AddSection({"More FPS", RandomIcon("Section")})
	
	Settings : AddToggle({
	Title = "Disable Notifications",
	Description = "",
	Default = S["Disable Notifications"],
	Callback = function(Value)
	LocalPlayer.PlayerGui.Notifications.Enabled = not Value
	ReplicatedStorage.Assets.GUI.DamageCounter.Enabled = not Value
	S["Disable Notifications"] = Value
	SS()
	end})
	
	Settings : AddSection({"Others", RandomIcon("Section")})
	
	Settings : AddToggle({
	Title = "Send Ally",
	Description = "",
	Default = S["Send Ally"],
	Callback = function(Value)
	_G.SendAllies = Value
	S["Send Ally"] = Value
	SS()
	end})
	
	----------------------------------------[[ Farm ]]----------------------------------------
	
	Farm : AddSection({"Farm", RandomIcon("Farm")})
	
	Farm : AddToggle({
	Title = "Farm Level",
	Description = "",
	Default = S["Farm Level"],
	Callback = function(Value)
	_G.FarmLevel = Value
	S["Farm Level"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Nearest",
	Description = "",
	Default = S["Farm Nearest"],
	Callback = function(Value)
	
	S["Farm Nearest"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Sky Enemies",
	Description = "",
	Default = S["Farm Sky Enemies"],
	Callback = function(Value)
	
	S["Farm Sky Enemies"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Factory Raid",
	Description = "",
	Default = S["Farm Factory Raid"],
	Callback = function(Value)
	
	S["Farm Factory Raid"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Pirate Raid",
	Description = "",
	Default = S["Farm Pirate Raid"],
	Callback = function(Value)
	
	S["Farm Pirate Raid"] = Value
	SS()
	end})
	
	Farm : AddSection({"Chests", RandomIcon("Chests")})
	
	Farm : AddToggle({
	Title = "Collect Chests",
	Description = "",
	Default = S["Collect Chests"],
	Callback = function(Value)
	_G.CollectChests = Value
	S["Collect Chests"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Collect Chests [Bypass]",
	Description = "",
	Default = S["Collect Chests [Bypass]"],
	Callback = function(Value)
	
	S["Collect Chests [Bypass]"] = Value
	SS()
	end})
	
	Farm : AddSection({"Ectoplasm", RandomIcon("Ectoplasm")})
	
	Farm : AddToggle({
	Title = "Farm Ectoplasm",
	Description = "",
	Default = S["Farm Ectoplasm"],
	Callback = function(Value)
	
	S["Farm Ectoplasm"] = Value
	SS()
	end})
	
	Farm : AddSection({"Bones", RandomIcon("Bones")})
	
	Farm : AddToggle({
	Title = "Farm Bones",
	Description = "",
	Default = S["Farm Bones"],
	Callback = function(Value)
	
	S["Farm Bones"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Shinigami Boss",
	Description = "",
	Default = S["Farm Shinigami Boss"],
	Callback = function(Value)
	
	S["Farm Shinigami Boss"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Trade Bones",
	Description = "",
	Default = S["Trade Bones"],
	Callback = function(Value)
	
	S["Trade Bones"] = Value
	SS()
	end})
	
	Farm : AddSection({"Katakuri", RandomIcon("Katakuri")})
	
	Farm : AddToggle({
	Title = "Farm Cake Boss",
	Description = "",
	Default = S["Farm Cake Boss"],
	Callback = function(Value)
	
	S["Farm Cake Boss"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Dough King",
	Description = "",
	Default = S["Farm Dough King"],
	Callback = function(Value)
	
	S["Farm Dough King"] = Value
	SS()
	end})
	
	Farm : AddSection({"Tyrant of the Skies", RandomIcon("Section")})
	
	Farm : AddToggle({
	Title = "Farm Tyrant of the Skies",
	Description = "",
	Default = S["Farm Tyrant of the Skies"],
	Callback = function(Value)
	
	S["Farm Tyrant of the Skies"] = Value
	SS()
	end})
	
	Farm : AddSection({"rip indra", RandomIcon("Section")})
	
	Farm : AddToggle({
	Title = "Farm Rip Indra",
	Description = "",
	Default = S["Farm Rip Indra"],
	Callback = function(Value)
	
	S["Farm Rip Indra"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Enable Colors",
	Description = "",
	Default = S["Enable Colors"],
	Callback = function(Value)
	
	S["Enable Colors"] = Value
	SS()
	end})
	
	Farm : AddSection({"Elite Hunters", RandomIcon("Section")})
	
	Farm : AddToggle({
	Title = "Farm Elite Hunters",
	Description = "",
	Default = S["Farm Elite Hunters"],
	Callback = function(Value)
	
	S["Farm Elite Hunters"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Hop To Farm",
	Description = "",
	Default = S["Hop To Farm"],
	Callback = function(Value)
	
	S["Hop To Farm"] = Value
	SS()
	end})
	
	Farm : AddSection({"Bosses", RandomIcon("Bosses")})
	
	Farm : AddButton({
    Title = "Update Bosses List",
    Description = "",
    Callback = function()
    
    end})
    
    Farm : AddDropdown({
	Title = "Select Boss",
	Description = "",
	Options = {},
	Default = S["Select Boss"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Boss"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Selected Boss",
	Description = "",
	Default = S["Farm Selected Boss"],
	Callback = function(Value)
	
	S["Farm Selected Boss"] = Value
	SS()
	end})
	
	Farm : AddSection({"Material", RandomIcon("Material")})
	
	Farm : AddDropdown({
	Title = "Select Material",
	Description = "",
	Options = {},
	Default = S["Select Material"],
	Multi = false,
	Callback = function(Value)
	_G.SelectMaterial = Value
	S["Select Material"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Material",
	Description = "",
	Default = S["Farm Material"],
	Callback = function(Value)
	
	S["Farm Material"] = Value
	SS()
	end})
	
	Farm : AddSection({"Mastery", RandomIcon("Mastery")})
	
	Farm : AddSlider({
    Title = "Select Health [%]",
    Description = "",
    Min = 1,
    Max = 100,
    Increase = 1,
    Default = S["Select Health [%]"],
    Callback = function(Value)
    
    S["Select Health [%]"] = Value
    SS()
    end})
    
    Farm : AddDropdown({
	Title = "Select Weapon",
	Description = "",
	Options = {},
	Default = S["Select Weapon Mastery Farm"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Weapon Mastery Farm"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm With V4",
	Description = "",
	Default = S["Farm With V4"],
	Callback = function(Value)
	
	S["Farm With V4"] = Value
	SS()
	end})
	
	Farm : AddToggle({
	Title = "Farm Mastery",
	Description = "",
	Default = S["Farm Mastery"],
	Callback = function(Value)
	
	S["Farm Mastery"] = Value
	SS()
	end})
	
	----------------------------------------[[ Quests ]]----------------------------------------
	
	Quests : AddSection({"Second Sea", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Second Sea",
	Description = "",
	Default = S["Unlock Second Sea"],
	Callback = function(Value)
	
	S["Unlock Second Sea"] = Value
	SS()
	end})
	
	Quests : AddSection({"Third Sea", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Third Sea",
	Description = "",
	Default = S["Unlock Third Sea"],
	Callback = function(Value)
	
	S["Unlock Third Sea"] = Value
	SS()
	end})
	
	Quests : AddSection({"Don Swan", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Swan Access",
	Description = "",
	Default = S["Unlock Swan Access"],
	Callback = function(Value)
	
	S["Unlock Swan Access"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Defeat Don Swan",
	Description = "",
	Default = S["Defeat Don Swan"],
	Callback = function(Value)
	
	S["Defeat Don Swan"] = Value
	SS()
	end})
	
	Quests : AddSection({"Bartilo Quest", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Bartilo Quest",
	Description = "",
	Default = S["Bartilo Quest"],
	Callback = function(Value)
	
	S["Bartilo Quest"] = Value
	SS()
	end})
	
	Quests : AddSection({"Citizen Quest", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Musket Hat",
	Description = "",
	Default = S["Unlock Musket Hat"],
	Callback = function(Value)
	
	S["Unlock Musket Hat"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Citizen Quest",
	Description = "",
	Default = S["Citizen Quest"],
	Callback = function(Value)
	
	S["Citizen Quest"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Observation V2",
	Description = "",
	Default = S["Observation V2"],
	Callback = function(Value)
	
	S["Observation V2"] = Value
	SS()
	end})
	
	Quests : AddSection({"Barista Cousin", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Haki Colors",
	Description = "",
	Default = S["Unlock Haki Colors"],
	Callback = function(Value)
	
	S["Unlock Haki Colors"] = Value
	SS()
	end})
	
	Quests : AddSection({"Berries", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Collect Berries",
	Description = "",
	Default = S["Collect Berries"],
	Callback = function(Value)
	_G.CollectBerries = Value
	S["Collect Berries"] = Value
	SS()
	end})
	
	Quests : AddSection({"Swords", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Saber Sword",
	Description = "",
	Default = S["Unlock Saber Sword"],
	Callback = function(Value)
	
	S["Unlock Saber Sword"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Unlock Pole V1",
	Description = "",
	Default = S["Unlock Pole V1"],
	Callback = function(Value)
	
	S["Unlock Pole V1"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Unlock Shark Saw",
	Description = "",
	Default = S["Unlock Shark Saw"],
	Callback = function(Value)
	
	S["Unlock Shark Saw"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Unlock True Triple Katana",
	Description = "",
	Default = S["Unlock True Triple Katana"],
	Callback = function(Value)
	
	S["Unlock True Triple Katana"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Unlock Yama",
	Description = "",
	Default = S["Unlock Yama"],
	Callback = function(Value)
	
	S["Unlock Yama"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Unlock Tushita",
	Description = "",
	Default = S["Unlock Tushita"],
	Callback = function(Value)
	
	S["Unlock Tushita"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Unlock Cursed Dual Katana",
	Description = "",
	Default = S["Unlock Cursed Dual Katana"],
	Callback = function(Value)
	
	S["Unlock Cursed Dual Katana"] = Value
	SS()
	end})
	
	Quests : AddSection({"Guns", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Unlock Skull Guitar",
	Description = "",
	Default = S["Unlock Skull Guitar"],
	Callback = function(Value)
	
	S["Unlock Skull Guitar"] = Value
	SS()
	end})
	
	Quests : AddSection({"Accessories", RandomIcon("Section")})
	
	Quests : AddToggle({
	Title = "Get Coat",
	Description = "",
	Default = S["Get Coat"],
	Callback = function(Value)
	
	S["Get Coat"] = Value
	SS()
	end})
	
	Quests : AddToggle({
	Title = "Get Pink Coat",
	Description = "",
	Default = S["Get Pink Coat"],
	Callback = function(Value)
	
	S["Get Pink Coat"] = Value
	SS()
	end})
	
	----------------------------------------[[ SeaEvents ]]----------------------------------------
	
	SeaEvents : AddSection({"Settings", RandomIcon("Section")})
	
	SeaEvents : AddSlider({
    Title = "Boat Speed",
    Description = "",
    Min = 50,
    Max = 350,
    Increase = 10,
    Default = S["Boat Speed"],
    Callback = function(Value)
    
    S["Boat Speed"] = Value
    SS()
    end})
	
	SeaEvents : AddDropdown({
	Title = "Select Sea Level",
	Description = "",
	Options = {},
	Default = S["Select Sea Level"],
	Multi = false,
	Callback = function(Value)
	_G.SelectSeaLevel = Value
	S["Select Sea Level"] = Value
	SS()
	end})
	
	SeaEvents : AddDropdown({
	Title = "Select Boat",
	Description = "",
	Options = {},
	Default = S["Select Boat"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Boat"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Sailing With A Boat",
	Description = "",
	Default = S["Sailing With A Boat"],
	Callback = function(Value)
	
	S["Sailing With A Boat"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Dodge Sea Beast Attack",
	Description = "",
	Default = S["Dodge Sea Beast Attack"],
	Callback = function(Value)
	
	S["Dodge Sea Beast Attack"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Dodge Terror Shark Attack",
	Description = "",
	Default = S["Dodge Terror Shark Attack"],
	Callback = function(Value)
	
	S["Dodge Terror Shark Attack"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Repair Boat",
	Description = "",
	Default = S["Repair Boat"],
	Callback = function(Value)
	
	S["Repair Boat"] = Value
	SS()
	end})
	
	SeaEvents : AddSection({"Sea Events", RandomIcon("Section")})
	
	SeaEvents : AddToggle({
	Title = "Defeat Sea Beasts",
	Description = "",
	Default = S["Defeat Sea Beasts"],
	Callback = function(Value)
	
	S["Defeat Sea Beasts"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Defeat Terror Shark",
	Description = "",
	Default = S["Defeat Terror Shark"],
	Callback = function(Value)
	
	S["Defeat Terror Shark"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Defeat Shark",
	Description = "",
	Default = S["Defeat Shark"],
	Callback = function(Value)
	
	S["Defeat Shark"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Defeat Piranhas",
	Description = "",
	Default = S["Defeat Piranhas"],
	Callback = function(Value)
	
	S["Defeat Piranhas"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Defeat Ghost Ships",
	Description = "",
	Default = S["Defeat Ghost Ships"],
	Callback = function(Value)
	
	S["Defeat Ghost Ships"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Defeat Brigades",
	Description = "",
	Default = S["Defeat Brigades"],
	Callback = function(Value)
	
	S["Defeat Brigades"] = Value
	SS()
	end})
	
	SeaEvents : AddToggle({
	Title = "Treasure Island",
	Description = "",
	Default = S["Treasure Island"],
	Callback = function(Value)
	
	S["Treasure Island"] = Value
	SS()
	end})
	
	----------------------------------------[[ Islands ]]----------------------------------------
	
	Islands : AddSection({"Status", RandomIcon("Section")})
	
	local KitsuneStatus = Islands : AddParagraph({
    Title = "Kitsune Island Status: Not Spawned",
    Description = ""
	})
	
	local PrehistoricStatus = Islands : AddParagraph({
    Title = "Prehistoric Island Status: Not Spawned",
    Description = ""
	})
	
	local MirageStatus = Islands : AddParagraph({
    Title = "Mirage Island Status: Not Spawned",
    Description = ""
	})
	
	local FrozenDimensionStatus = Islands : AddParagraph({
    Title = "Frozen Dimension Status: Not Spawned",
    Description = ""
	})
	
	Islands : AddSection({"Kitsune Island", RandomIcon("Section")})
	
	Islands : AddToggle({
	Title = "Find Kitsune Island",
	Description = "",
	Default = S["Find Kitsune Island"],
	Callback = function(Value)
	
	S["Find Kitsune Island"] = Value
	SS()
	end})
	
	Islands : AddSlider({
    Title = "Select The Amount Of Blue Embers",
    Description = "",
    Min = 10,
    Max = 25,
    Increase = 5,
    Default = S["Select The Amount Of Blue Embers"],
    Callback = function(Value)
    
    S["Select The Amount Of Blue Embers"] = Value
    SS()
    end})
    
    Islands : AddToggle({
	Title = "Trade Blue Embers",
	Description = "",
	Default = S["Trade Blue Embers"],
	Callback = function(Value)
	
	S["Trade Blue Embers"] = Value
	SS()
	end})
	
	Islands : AddSection({"Prehistoric Island", RandomIcon("Section")})
	
	Islands : AddToggle({
	Title = "Find Prehistoric Island",
	Description = "",
	Default = S["Find Prehistoric Island"],
	Callback = function(Value)
	
	S["Find Prehistoric Island"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Fix Volcano",
	Description = "",
	Default = S["Fix Volcano"],
	Callback = function(Value)
	_G.FixVolcano = Value
	S["Fix Volcano"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Defeat Lava Golems",
	Description = "",
	Default = S["Defeat Lava Golems"],
	Callback = function(Value)
	_G.DefeatLavaGolems = Value
	S["Defeat Lava Golems"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Collect Dragon Eggs",
	Description = "",
	Default = S["Collect Dragon Eggs"],
	Callback = function(Value)
	_G.CollectDragonEggs = Value
	S["Collect Dragon Eggs"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Collect Dino Bones",
	Description = "",
	Default = S["Collect Dino Bones"],
	Callback = function(Value)
	_G.CollectDinoBones = Value
	S["Collect Dino Bones"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Craft Volcanic Magnet",
	Description = "",
	Default = S["Craft Volcanic Magnet"],
	Callback = function(Value)
	
	S["Craft Volcanic Magnet"] = Value
	SS()
	end})
	
	Islands : AddSection({"Mirage Island", RandomIcon("Section")})
	
	Islands : AddToggle({
	Title = "Find Mirage Island",
	Description = "",
	Default = S["Find Mirage Island"],
	Callback = function(Value)
	
	S["Find Mirage Island"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Go To Advanced Fruit Dealer",
	Description = "",
	Default = S["Go To Advanced Fruit Dealer"],
	Callback = function(Value)
	
	S["Go To Advanced Fruit Dealer"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Look At Moon",
	Description = "",
	Default = S["Look At Moon"],
	Callback = function(Value)
	
	S["Look At Moon"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Go To The Highest Point",
	Description = "",
	Default = S["Go To The Highest Point"],
	Callback = function(Value)
	
	S["Go To The Highest Point"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Go To Blue Gear",
	Description = "",
	Default = S["Go To Blue Gear"],
	Callback = function(Value)
	_G.GoToBlueGear = Value
	S["Go To Blue Gear"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Collect Mirage Chests",
	Description = "",
	Default = S["Collect Mirage Chests"],
	Callback = function(Value)
	
	S["Collect Mirage Chests"] = Value
	SS()
	end})
	
	Islands : AddSection({"Frozen Dimension", RandomIcon("Section")})
	
	Islands : AddButton({
    Title = "Open Spy Dialog",
    Description = "",
    Callback = function()
    
    end})
    
    Islands : AddToggle({
	Title = "Find Frozen Dimension",
	Description = "",
	Default = S["Find Frozen Dimension"],
	Callback = function(Value)
	
	S["Find Frozen Dimension"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Attack Leviathan",
	Description = "",
	Default = S["Attack Leviathan"],
	Callback = function(Value)
	
	S["Attack Leviathan"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Shoot Heart",
	Description = "",
	Default = S["Shoot Heart"],
	Callback = function(Value)
	
	S["Shoot Heart"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Go To Tiki Outpost",
	Description = "",
	Default = S["Go To Tiki Outpost"],
	Callback = function(Value)
	
	S["Go To Tiki Outpost"] = Value
	SS()
	end})
	
	Islands : AddToggle({
	Title = "Go To Hydra Island",
	Description = "",
	Default = S["Go To Hydra Island"],
	Callback = function(Value)
	
	S["Go To Hydra Island"] = Value
	SS()
	end})
	
	----------------------------------------[[ Fishery ]]----------------------------------------
	
	Fish : AddSection({"Settings", RandomIcon("Settings")})
	
	Fish : AddDropdown({
	Title = "Select Bait",
	Description = "",
	Options = {},
	Default = S["Select Bait"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Bait"] = Value
	SS()
	end})
	
	Fish : AddDropdown({
	Title = "Select Rod",
	Description = "",
	Options = {},
	Default = S["Select Rod"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Rod"] = Value
	SS()
	end})
	
	Fish : AddToggle({
	Title = "Craft Bait",
	Description = "",
	Default = S["Craft Bait"],
	Callback = function(Value)
	
	S["Craft Bait"] = Value
	SS()
	end})
	
	Fish : AddSection({"Fish", RandomIcon("Section")})
	
	Fish : AddToggle({
	Title = "Automatic Fishing",
	Description = "",
	Default = S["Automatic Fishing"],
	Callback = function(Value)
	
	S["Automatic Fishing"] = Value
	SS()
	end})
	
	----------------------------------------[[ Fruits ]]----------------------------------------
	
	Fruits : AddSection({"Fruits", RandomIcon("SECTION")})
	
	Fruits : AddToggle({
	Title = "Random Fruits",
	Description = "",
	Default = S["Random Fruits"],
	Callback = function(Value)
	
	S["Random Fruits"] = Value
	SS()
	end})
	
	Fruits : AddToggle({
	Title = "Collect Fruits",
	Description = "",
	Default = S["Collect Fruits"],
	Callback = function(Value)
	_G.CollectFruits = Value
	S["Collect Fruits"] = Value
	SS()
	end})
	
	Fruits : AddToggle({
	Title = "Store Fruits",
	Description = "",
	Default = S["Store Fruits"],
	Callback = function(Value)
	
	S["Store Fruits"] = Value
	SS()
	end})
	
	Fruits : AddSection({"Raid", RandomIcon("Section")})
	
	Fruits : AddDropdown({
	Title = "Select Chip",
	Description = "",
	Options = {},
	Default = S["Select Chip"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Chip"] = Value
	SS()
	end})
	
	Fruits : AddToggle({
	Title = "Buy Chip",
	Description = "",
	Default = S["Buy Chip"],
	Callback = function(Value)
	
	S["Buy Chip"] = Value
	SS()
	end})
	
	Fruits : AddToggle({
	Title = "Complete Raid",
	Description = "",
	Default = S["Complete Raid"],
	Callback = function(Value)
	
	S["Complete Raid"] = Value
	SS()
	end})
	
	----------------------------------------[[ Teleport ]]----------------------------------------
	
	Teleport : AddSection({"Seas", RandomIcon("Section")})
	
	Teleport : AddButton({
    Title = "Go To First Sea",
    Description = "",
    Callback = function()
    
    end})
    
    Teleport : AddButton({
    Title = "Go To Second Sea",
    Description = "",
    Callback = function()
    
    end})
    
    Teleport : AddButton({
    Title = "Go To Third Sea",
    Description = "",
    Callback = function()
    
    end})
	
	Teleport : AddSection({"Islands", RandomIcon("Section")})
	
	Teleport : AddDropdown({
	Title = "Select Island",
	Description = "",
	Options = IslandList,
	Default = S["Select Island"],
	Multi = false,
	Callback = function(Value)
	_G.SelectIsland =  Value
	S["Select Island"] = Value
	SS()
	end})
	
	Teleport : AddToggle({
    Title = "Go To Island",
    Description = "",
    Callback = function(Value)
    Tween(w["_WorldOrigin"].Locations[_G.SelectIsland].Position, 3, function() return Value end)
    end})
	
	----------------------------------------[[ Player ]]----------------------------------------
	
	Player : AddSection({"Player", RandomIcon("Section")})
	
	Player : AddSlider({
    Title = "Select Walk Speed",
    Description = "",
    Min = 10,
    Max = 300,
    Increase = 10,
    Default = S["Select Walk Speed"],
    Callback = function(Value)
    
    S["Select Walk Speed"] = Value
    SS()
    end})
    
    Player : AddToggle({
	Title = "Change Walk Speed",
	Description = "",
	Default = S["Change Walk Speed"],
	Callback = function(Value)
	
	S["Change Walk Speed"] = Value
	SS()
	end})
	
	Player : AddSlider({
    Title = "Select Dash Distance",
    Description = "",
    Min = 1,
    Max = 200,
    Increase = 10,
    Default = S["Select Dash Distance"],
    Callback = function(Value)
    
    S["Select Dash Distance"] = Value
    SS()
    end})
    
    Player : AddToggle({
	Title = "Change Dash Distance",
	Description = "",
	Default = S["Change Dash Distance"],
	Callback = function(Value)
	
	S["Change Dash Distance"] = Value
	SS()
	end})
	
	Player : AddSlider({
    Title = "Select Jump Power",
    Description = "",
    Min = 10,
    Max = 300,
    Increase = 10,
    Default = S["Select Jump Power"],
    Callback = function(Value)
    
    S["Select Jump Power"] = Value
    SS()
    end})
    
    Player : AddToggle({
	Title = "Change Jump Power",
	Description = "",
	Default = S["Change Jump Power"],
	Callback = function(Value)
	
	S["Change Jump Power"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Infinite Jump",
	Description = "",
	Default = S["Infinite Jump"],
	Callback = function(Value)
	
	S["Infinite Jump"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "No Collision",
	Description = "",
	Default = S["No Collision"],
	Callback = function(Value)
	
	S["No Collision"] = Value
	SS()
	end})
	
	Player : AddSection({"Aimbot", RandomIcon("Section")})
	
	Player : AddButton({
    Title = "Update Players Lost",
    Description = "",
    Callback = function()
    
    end})
	
	Player : AddDropdown({
	Title = "Select Player",
	Description = "",
	Options = {},
	Default = S["Select Player"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Player"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Aimbot Player",
	Description = "",
	Default = S["Aimbot Player"],
	Callback = function(Value)
	
	S["Aimbot Player"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Aimbot Nearest",
	Description = "",
	Default = S["Aimbot Nearest"],
	Callback = function(Value)
	
	S["Aimbot Nearest"] = Value
	SS()
	end})
	
	Player : AddToggle({
	Title = "Ignore Enemies",
	Description = "",
	Default = S["Ignore Enemies"],
	Callback = function(Value)
	
	S["Ignore Enemies"] = Value
	SS()
	end})
	
	----------------------------------------[[ Race ]]----------------------------------------
	
	Race : AddSection({"Status", RandomIcon("Section")})
	
	local RaceStatus = Race : AddParagraph({
    Title = "Race: Human V1",
    Description = ""
	})
	
	local MirageStatus = Race : AddParagraph({
    Title = "Mirage Puzzle: ❌",
    Description = ""
	})
	
	local AncientStatus = Race : AddParagraph({
    Title = "Ancient One: Need f7K",
    Description = ""
	})
	
	local MoonStatus = Race : AddParagraph({
    Title = "Moon: Full Moon In 18M:10S",
    Description = "Full Moon In 10 Hours"
	})
	
	Race : AddSection({"Evolve", RandomIcon("Section")})
	
	Race : AddToggle({
	Title = "Race V2",
	Description = "",
	Default = S["Race V2"],
	Callback = function(Value)
	
	S["Race V2"] = Value
	SS()
	end})
	
	Race : AddToggle({
	Title = "Race V3",
	Description = "",
	Default = S["Race V3"],
	Callback = function(Value)
	
	S["Race V3"] = Value
	SS()
	end})
	
	Race : AddToggle({
	Title = "Auto Race Trial",
	Description = "",
	Default = S["Auto Race Trial"],
	Callback = function(Value)
	
	S["Auto Race Trial"] = Value
	SS()
	end})
	
	Race : AddButton({
    Title = "Update Players List",
    Description = "",
    Callback = function()
    
    end})
	
	Race : AddDropdown({
	Title = "Select Allies",
	Description = "",
	Options = {},
	Default = S["Select Allies"],
	Multi = false,
	Callback = function(Value)
	
	S["Select Allies"] = Value
	SS()
	end})
	
	Race : AddToggle({
	Title = "Kill Players After Trial",
	Description = "",
	Default = S["Kill Players After Trial"],
	Callback = function(Value)
	
	S["Kill Players After Trial"] = Value
	SS()
	end})
	
	Race : AddSection({"Teleport", RandomIcon("Section")})
    
    Race : AddButton({
    Title = "Go To Race Door",
    Description = "",
    Callback = function()
    
    end})
    
    Race : AddButton({
    Title = "Go To Ancient One",
    Description = "",
    Callback = function()
    
    end})
    
    Race : AddButton({
    Title = "Go To Temple Of Time",
    Description = "",
    Callback = function()
    
    end})
    
    Race : AddButton({
    Title = "Go To Ancient Clock",
    Description = "",
    Callback = function()
    
    end})
	
	----------------------------------------[[ Shop ]]----------------------------------------
	
	Shop : AddSection("Christmas")
		
	Shop : AddButton({
	Title = "Buy 2x EXP (15 Mins.)",
	Description = "Buy 2x EXP (15 Mins.)",
	Callback = function()
	CommF_("Candies", "Check")
	CommF_("Candies", "Buy", 1, 1)
	end})
	
	Shop : AddButton({
	Title = "Buy Stats Refund",
	Description = "Buy Stats Refund",
	Callback = function()
	CommF_("Candies", "Check")
	CommF_("Candies", "Buy", 1, 2)
	end})
	
	Shop : AddButton({
	Title = "Buy Race Reroll",
	Description = "Buy Race Reroll",
	Callback = function()
	CommF_("Candies", "Check")
	CommF_("Candies", "Buy", 1, 3)
	end})
	
	Shop : AddButton({
	Title = "Buy 200 Frags",
	Description = "Buy 200 Frags",
	Callback = function()
	CommF_("Candies", "Check")
	CommF_("Candies", "Buy", 2, 2)
	end})
	
	Shop : AddButton({
	Title = "Buy 500 Frags",
	Description = "Buy 500 Frags",
	Callback = function()
	CommF_("Candies", "Check")
	CommF_("Candies", "Buy", 2, 2)
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
	CommF_("BuyHaki", "Geppo")
	end})
	
	Shop : AddButton({
	Title = "Buy Buso",
	Description = "Buy Buso",
	Callback = function()
	CommF_("BuyHaki", "Buso")
	end})
	
	Shop : AddButton({
	Title = "Buy Soru",
	Description = "Buy Soru",
	Callback = function()
	CommF_("BuyHaki", "Soru")
	end})
	
	Shop : AddButton({
	Title = "Buy Ken Haki",
	Description = "Buy Ken Haki",
	Callback = function()
	CommF_("KenTalk", "Buy")
	end})
	
	Shop : AddSection("Miscellaneous")
	
	Shop : AddButton({
	Title = "Buy Random Race",
	Description = "Buy Random Race",
	Callback = function()
	CommF_("BlackbeardReward", "Reroll", "1")
	CommF_("BlackbeardReward", "Reroll", "2")
	end})
	
	Shop : AddButton({
	Title = "Buy Reset Stats",
	Description = "Buy Reset Stats",
	Callback = function()
	CommF_("BlackbeardReward", "Refund", "1")
	CommF_("BlackbeardReward", "Refund", "2")
	end})
	
	Shop : AddSection("Fighting Styles")
	
	Shop : AddButton({
	Title = "Buy Black Leg",
	Description = "Buy Black Leg",
	Callback = function()
	CommF_("BuyBlackLeg")
	end})
	
	Shop : AddButton({
	Title = "Buy Electro",
	Description = "Buy Electro",
	Callback = function()
	CommF_("BuyElectro")
	end})
	
	Shop : AddButton({
	Title = "Buy Fishman Karate",
	Description = "Buy Fishman Karate",
	Callback = function()
	CommF_("BuyFishmanKarate")
	end})
	
	Shop : AddButton({
	Title = "Buy Dragon Claw",
	Description = "Buy Dragon Claw",
	Callback = function()
	CommF_("BlackbeardReward", "DragonClaw", "1")
	CommF_("BlackbeardReward", "DragonClaw", "2")
	end})
	
	Shop : AddButton({
	Title = "Buy Superhuman",
	Description = "Buy Superhuman",
	Callback = function()
	CommF_("BuySuperhuman")
	end})
	
	Shop : AddButton({
	Title = "Buy Death Step",
	Description = "Buy Death Step",
	Callback = function()
	CommF_("BuyDeathStep")
	end})
	
	Shop : AddButton({
	Title = "Buy Sharkman Karate",
	Description = "Buy Sharkman Karate",
	Callback = function()
	CommF_("BuySharkmanKarate")
	end})
	
	Shop : AddButton({
	Title = "Buy Electric Claw",
	Description = "Buy Electric Claw",
	Callback = function()
	CommF_("BuyElectricClaw")
	end})
	
	Shop : AddButton({
	Title = "Buy Dragon Talon",
	Description = "Buy Dragon Talon",
	Callback = function()
	CommF_("BuyDragonTalon")
	end})
	
	Shop : AddButton({
	Title = "Buy GodHuman",
	Description = "Buy GodHuman",
	Callback = function()
	CommF_("BuyGodhuman")
	end})
	
	Shop : AddButton({
	Title = "Buy Sanguine Art",
	Description = "Buy Sanguine Art",
	Callback = function()
	CommF_("BuySanguineArt")
	end})
	
	Shop : AddSection("Swords")
	
	Shop : AddButton({
	Title = "Buy Katana",
	Description = "Buy Katana",
	Callback = function()
	CommF_("BuyItem", "Katana")
	end})
	
	Shop : AddButton({
	Title = "Buy Cutlass",
	Description = "Buy Cutlass",
	Callback = function()
	CommF_("BuyItem", "Cutlass")
	end})
	
	Shop : AddButton({
	Title = "Buy Dual Katana",
	Description = "Buy Dual Katana",
	Callback = function()
	CommF_("BuyItem", "Dual Katana")
	end})
	
	Shop : AddButton({
	Title = "Buy Iron Mace",
	Description = "Buy Iron Mace",
	Callback = function()
	CommF_("BuyItem", "Iron Mace")
	end})
	
	Shop : AddButton({
	Title = "Buy Triple Katana",
	Description = "Buy Triple Katana",
	Callback = function()
	CommF_("BuyItem", "Triple Katana")
	end})
	
	Shop : AddButton({
	Title = "Buy Pipe",
	Description = "Buy Pipe",
	Callback = function()
	CommF_("BuyItem", "Pipe")
	end})
	
	Shop : AddButton({
	Title = "Buy Dual-Headed Blade",
	Description = "Buy Dual-Headed Blade",
	Callback = function()
	CommF_("BuyItem", "Dual-Headed Blade")
	end})
	
	Shop : AddButton({
	Title = "Buy Soul Cane",
	Description = "Buy Soul Cane",
	Callback = function()
	CommF_("BuyItem", "Soul Cane")
	end})
	
	Shop : AddButton({
	Title = "Buy Bisento",
	Description = "Buy Bisento",
	Callback = function()
	CommF_("BuyItem", "Bisento")
	end})
	
	Shop : AddSection("Guns")
	
	Shop : AddButton({
	Title = "Buy Musket",
	Description = "Buy Musket",
	Callback = function()
	CommF_("BuyItem", "Musket")
	end})
	
	Shop : AddButton({
	Title = "Buy Slingshot",
	Description = "Buy Slingshot",
	Callback = function()
	CommF_("BuyItem", "Slingshot")
	end})
	
	Shop : AddButton({
	Title = "Buy Flintlock",
	Description = "Buy Flintlock",
	Callback = function()
	CommF_("BuyItem", "Flintlock")
	end})
	
	Shop : AddButton({
	Title = "Buy Refined Slingshot",
	Description = "Buy Refined Slingshot",
	Callback = function()
	CommF_("BuyItem", "Refined Slingshot")
	end})
	
	Shop : AddButton({
	Title = "Buy Dual Flintlock",
	Description = "Buy Dual Flintlock",
	Callback = function()
	CommF_("BuyItem", "Dual Flintlock")
	end})
	
	Shop : AddButton({
	Title = "Buy Cannon",
	Description = "Buy Cannon",
	Callback = function()
	CommF_("BuyItem", "Cannon")
	end})
	
	Shop : AddButton({
	Title = "Buy Kabucha",
	Description = "Buy Kabucha",
	Callback = function()
	CommF_("BlackbeardReward", "Slingshot", "1")
	CommF_("BlackbeardReward", "Slingshot", "2")
	end})
	
	Shop : AddSection("Accessories")
	
	Shop : AddButton({
	Title = "Buy Black Cape",
	Description = "Buy Black Cape",
	Callback = function()
	CommF_("BuyItem", "Black Cape")
	end})
	
	Shop : AddButton({
	Title = "Buy Swordsman Hat",
	Description = "Buy Swordsman Hat",
	Callback = function()
	CommF_("BuyItem", "Swordsman Hat")
	end})
	
	Shop : AddButton({
	Title = "Buy Tomoe Ring",
	Description = "Buy Tomoe Ring",
	Callback = function()
	CommF_("BuyItem", "Tomoe Ring")
	end})
	
	Shop : AddSection("Races")
	
	Shop : AddButton({
	Title = "Buy Ghoul Race",
	Description = "Buy Ghoul Race",
	Callback = function()
	CommF_("Ectoplasm", "Change", 4)
	end})
	
	Shop : AddButton({
	Title = "Buy Cyborg Race",
	Description = "Buy Cyborg Race",
	Callback = function()
	CommF_("CyborgTrainer", "Buy")
	end})
	
	Shop : AddSection("Draco Crafts")
	
	Shop : AddButton({
	Title = "Craft Volcanic Magnet",
	Description = "Craft Volcanic Magnet",
	Callback = function()
	CommF_("CraftItem", "Craft", "Volcanic Magnet")
	end})
	
	Shop : AddButton({
	Title = "Craft Dragonstorm",
	Description = "Craft Dragonstorm",
	Callback = function()
	CommF_("CraftItem", "Craft", "Dragonstorm")
	end})
	
	Shop : AddButton({
	Title = "Craft Dragonheart",
	Description = "Craft Dragonheart",
	Callback = function()
	CommF_("CraftItem", "Craft", "Dragonheart")
	end})
	
	Shop : AddButton({
	Title = "Craft T-Rex Skull",
	Description = "Craft T-Rex Skull",
	Callback = function()
	CommF_("CraftItem", "Craft", "TRexSkull")
	end})
	
	Shop : AddButton({
	Title = "Craft Dino Hood",
	Description = "Craft Dino Hood",
	Callback = function()
	CommF_("CraftItem", "Craft", "DinoHood")
	end})
	
	Shop : AddSection("Beast Hunter")
	
	Shop : AddButton({
	Title = "Craft Leviathan Crown",
	Description = "Craft Leviathan Crown",
	Callback = function()
	CommF_("CraftItem", "Craft", "LeviathanCrown")
	end})
	
	Shop : AddButton({
	Title = "Craft Leviathan Shield",
	Description = "Craft Leviathan Shield",
	Callback = function()
	CommF_("CraftItem", "Craft", "LeviathanShild")
	end})
	
	Shop : AddButton({
	Title = "Craft Leviathan Ship",
	Description = "Craft Leviathan Ship",
	Callback = function()
	CommF_("CraftItem", "Craft", "LeviathanShip")
	end})
	
	Shop : AddSection("Shark Hunter")
	
	Shop : AddButton({
	Title = "Craft Shark Tooth Necklace",
	Description = "Craft Shark Tooth Necklace",
	Callback = function()
	CommF_("CraftItem", "Craft", "Tooth Necklace")
	end})
	
	Shop : AddButton({
	Title = "Craft Terror Jaw",
	Description = "Craft Terror Jaw",
	Callback = function()
	CommF_("CraftItem", "Craft", "Terror Jaw")
	end})
	
	Shop : AddButton({
	Title = "Craft Monster Magnet",
	Description = "Craft Monster Magnet",
	Callback = function()
	CommF_("CraftItem", "Craft", "Shark Anchor")
	end})
	
	Shop : AddSection("Dragon Talon Sage")
	
	Shop : AddButton({
	Title = "Craft Common Scroll",
	Description = "Craft Common Scroll",
	Callback = function()
	CommF_("CraftItem", "Craft", "CommonScroll")
	end})
	
	Shop : AddButton({
	Title = "Craft Rare Scroll",
	Description = "Craft Rare Scroll",
	Callback = function()
	CommF_("CraftItem", "Craft", "RareScroll")
	end})
	
	Shop : AddButton({
	Title = "Craft Legendary Scroll",
	Description = "Craft Legendary Scroll",
	Callback = function()
	CommF_("CraftItem", "Craft", "LegendaryScroll")
	end})
	
	Shop : AddButton({
	Title = "Craft Mythical Scroll",
	Description = "Craft Mythical Scroll",
	Callback = function()
	CommF_("CraftItem", "Craft", "MythicalScroll")
	end})
	
	----------------------------------------[[ Visual ]]----------------------------------------
	
	Visual : AddSection({"Extra Sensory Perception", "Extra Sensory Perception"})
	
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
    
    Visual : AddToggle({
    Title = "ESP Flowers",
    Description = "See Name And Distance",
    Default = S["ESP Flowers"],
    Callback = function(Value)
    _G.ESPFlowers = Value
    S["ESP Flowers"] = Value
	SS()
    end})