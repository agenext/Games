
local g = game
local w: Workspace = workspace
local Players: Players = g:GetService("Players")
local LocalPlayer: Player = Players.LocalPlayer
local ReplicatedStorage: ReplicatedStorage = g:GetService("ReplicatedStorage")
local BrainrotsFolder: Folder = ReplicatedStorage.Models.Animals
local AnimationsFolder: Folder = ReplicatedStorage:WaitForChild("Animations"):WaitForChild("Animals")
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local RaritiesData = require(ReplicatedStorage.Datas.Rarities)
local AnimaisDatas = require(ReplicatedStorage.Datas.Animals)

function Convert(Number)
	if Number >= 1e12 then
		return (string.gsub(string.format("%.1fT", Number / 1e12), "%.0T", "T"))
	elseif Number >= 1e9 then
		return (string.gsub(string.format("%.1fB", Number / 1e9), "%.0B", "B"))
	elseif Number >= 1e6 then
		return (string.gsub(string.format("%.1fM", Number / 1e6), "%.0M", "M"))
	elseif Number >= 1e3 then
		return (string.gsub(string.format("%.1fK", Number / 1e3), "%.0K", "K"))
	else
		return tostring(math.floor(Number))
	end
end

function ParseMoney(Text)
	local Num = Text:match("%$([%d%.]+[KMBT]?)")
	if not Num then return 0 end
	local Value = tonumber(Num:match("[%d%.]+")) or 0
	if Num:find("K") then
		Value *= 1e3
	elseif Num:find("M") then
		Value *= 1e6
	elseif Num:find("B") then
		Value *= 1e9
	elseif Num:find("T") then
		Value *= 1e12
	end
	return Value
end

function GetLocalPlot()
	local Plots = w:FindFirstChild("Plots")
	if not Plots then return end
	for _, Plot in Plots:GetChildren() do
		local PlotSign = Plot:FindFirstChild("PlotSign")
		if PlotSign then
			local YourBase = PlotSign:FindFirstChild("YourBase")
			if YourBase and YourBase.Enabled then
				return Plot
			end
		end
	end
end

function GetFreeSpawn()
	local Plot = GetLocalPlot()
	if not Plot then return CFrame.new(), nil end
	local Spawns = Plot:FindFirstChild("AnimalPodiums")
	if not Spawns then return CFrame.new(), nil end
	for _, Base in Spawns:GetChildren() do
		local Spawn = Base:FindFirstChild("Base") and Base.Base:FindFirstChild("Spawn")
		if Spawn and not Spawn:FindFirstChild("Attachment") then
			local Marker = Instance.new("Attachment")
			Marker.Name = "Attachment"
			Marker.Parent = Spawn
			return Spawn.CFrame + Vector3.new(0, 3, 0), Spawn
		end
	end
	return CFrame.new(), nil
end

for _, Data in pairs(Brianrots) do
	local Pos, Spawn = GetFreeSpawn()
	if not Spawn then continue end

	local Info = AnimaisDatas[Data.Name]

	if not Spawn:FindFirstChild("Attachment") then
		local Marker = Instance.new("Attachment")
		Marker.Name = "Attachment"
		Marker.Parent = Spawn
	end

	for _, PP in pairs(Spawn:GetChildren()) do
		if PP:IsA("ProximityPrompt") then
			PP.Enabled = true
			if PP.KeyboardKeyCode == Enum.KeyCode.E then
				PP.ActionText = "Grab"
				PP.ObjectText = Info.DisplayName
				PP.Triggered:Connect(function(Player)
					if Player ~= LocalPlayer then return end
					local Model = BrainrotsFolder:FindFirstChild(Data.Name)
					if Model then
						local CarryClone = Model:Clone()
						local Character = LocalPlayer.Character
						if Character then
							local Head = Character:FindFirstChild("Head")
							if Head then
								CarryClone.Parent = Character
								CarryClone:SetPrimaryPartCFrame(Head.CFrame + Vector3.new(0, 2, 0))
								local CarryAnim = ReplicatedStorage.Animations.Players:FindFirstChild("Carry")
								if CarryAnim then
									local Animator = Character:FindFirstChild("Humanoid") and Character.Humanoid:FindFirstChildOfClass("Animator")
									if Animator then
										local Track = Animator:LoadAnimation(CarryAnim)
										Track:Play()
									end
								end
							end
						end
					end
				end)
			elseif PP.KeyboardKeyCode == Enum.KeyCode.F then
				PP.ActionText = "Sell: $"..Convert(Info.Price / 2)
				PP.ObjectText = ""
			end
		end
	end

	local Overhead = ReplicatedStorage.Overheads:FindFirstChild("AnimalOverhead")
	if Overhead then
		local OH = Overhead:Clone()
		OH.Mutation.Visible = false
		OH.DisplayName.Text = Info.DisplayName
		OH.Price.Text = "$"..Convert(Info.Price)
		OH.Rarity.Text = Info.Rarity
		OH.Generation.Text = "$"..Convert(Info.Generation).."/s"
		OH.StudsOffset = Vector3.new(0, 10, 0)
		OH.Parent = Spawn
		local Rarity = RaritiesData[Info.Rarity]
		OH.Rarity.TextColor3 = Rarity.Color
		if Rarity.GradientPreset then
			Gradients.apply(OH.Rarity, Rarity.GradientPreset)
		end
	end

	local Model = BrainrotsFolder:FindFirstChild(Data.Name)
	if Model then
		local Clone = Model:Clone()
		Clone.Parent = w
		local Root = Clone:FindFirstChild("RootPart")
		if Root then
			Root.Anchored = true
			Root.CFrame = Pos
		end
		local Anim = AnimationsFolder:FindFirstChild(Data.Name) and AnimationsFolder[Data.Name]:FindFirstChild("Idle")
		if Anim then
			local Animator = Clone:FindFirstChild("AnimationController") and Clone.AnimationController:FindFirstChild("Animator")
			if Animator then
				local Track = Animator:LoadAnimation(Anim)
				Track:Play()
			end
		end
	end

	task.spawn(function()
		while task.wait(1) do
			local Plot = GetLocalPlot()
			if not Plot then continue end
			local Mult = Plot:FindFirstChild("Multiplier") and Plot.Multiplier:FindFirstChild("Main") and Plot.Multiplier.Main:FindFirstChild("Amount")
			local SpawnsFolder = Plot:FindFirstChild("AnimalPodiums")
			if not SpawnsFolder then continue end
			for _, Base in SpawnsFolder:GetChildren() do
				local CollectFrame = Base:FindFirstChild("Claim") and Base.Claim:FindFirstChild("Main") and Base.Claim.Main:FindFirstChild("Collect")
				if CollectFrame then
					CollectFrame.Enabled = true
					CollectFrame.Offline = false
					CollectFrame:GetPropertyChangedSignal("Enabled"):Connect(function()
						if not CollectFrame.Enabled then
							CollectFrame.Enabled = true
						end
					end)
					local CollectText = CollectFrame:FindFirstChild("Collect")
					if Mult and CollectText then
						local MultValue = tonumber(Mult.Text:match("%d+")) or 1
						local GenValue = AnimaisDatas[Data.Name].Generation or 1
						local Current = ParseMoney(CollectText.Text)
						local New = Current + (GenValue * MultValue)
						local Display = Convert(New)
						CollectText.Text = string.format('Collect <br/><font color="#73ff00">$%s</font>', Display)
					end
				end
				for _, PP in pairs(Base:GetChildren()) do
					if PP:IsA("ProximityPrompt") then
						PP.Enabled = true
					end
				end
			end
		end
	end)
end
