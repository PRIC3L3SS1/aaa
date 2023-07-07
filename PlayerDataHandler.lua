local PlayerDataHandler = {}

local dataTemplate = {
	Sigils = {
		SigilLuck = "1",

		T1Sigils = {
			Ordinary = "0",
			Unusual = "0",
			Infrequent = "0",
			Extravagant = "0",
			Illustrious = "0",
			Imaginary = "0",
			Delightful = "0",
			Unrevelealed = "0",
			Invisible = "0",
			Meaningless = "0",
		},
		
		T2Sigils = {
			Abnormal = "0",
			Common = "0",
			Frequent = "0",
			Thrifty = "0",
			Obscure = "0",
			Reality = "0",
			Unpleasant = "0",
			Manifested = "0",
			Conspicuous = "0",
			Unknown = "0",
		},
		
		T3Sigils = {
			
		},
	},

	PlayerStats = {
		Essence = "0",
		Cash = "0",
		Multi = "0",
		Verdant = "0",
		Kauri = "0",
		Amethyst = "0",
		Delhi = "0",
		Ilmentie = "0",
		Lodestone = "0",
		Rosetta = "0",
		Bioluminsecence = "0",
		OmoMarrow = "0",
		Corruption = "0",
	},
	
	Boosts = {
		CashBoost = "0",
		CashBoostTime = "0",
		
		MultiBoost = "0",
		MultiBoostTime = "0",
		
		VerdantBoost = "0",
		VerdantBoostTime = "0",
		
		KauriBoost = "0",
		KauriBoostTime = "0",
	},

	MiscStats = {
		TotalCash = "0",
		TotalMulti = "1",
		TotalVerdant = "0",
		TotalKauri = "0",
		TotalAmethyst = "0",
		TotalDelhi = "0",
		TotalIlmentie = "0",
		TotalLodestone = "0",
		TotalRosetta = "0",
		TotalBioluminsecence = "0",
		TotalOmoMarrow = "0",
		
		HighestSupporter = "Unkranked",
		HighestRichest = "Unranked",
		HighestCorrupted = "Unranked",
		HighestPlaytime = "Unranked",
		
		Playtime = "0",
		ServerPlaytime = "0",
		Donated = "0",
		TotalAmountOfCorruptions = "0",
		SecretOne = false,
		SecretTwo = false,
		SecretThree = false,
		JoinDate = DateTime.now():FormatLocalTime("lll", "en-us"),
		PlayerIsInGroup = false,
	},
	
	Titles = {
		Member = false,
		Vip = false,
		Lucky = false,
		LBRichest = false,
		LBCorrupted = false,
		LBContributor = false,
		LBPlaytime = false,
		AlterEnthusiast = false,
		
	},
	
	BadgesAndGamepasses = {
		VIPGamepass = false,
		SpeedyGamepass = false,
		LuckyGamepass = false,
		CorruptedGamepass = false,
		SuperLuckGamepass = false,
		AdvancedAltersGamepass = false,
		WelcomeBadge = true,
		ShiniesBadge = false,
		TravelerBadge = false,
		TokenJarBadge = false,
		HowBadge = false,
		VIPBadge = false,
		SpeedyBadge = false,
		LuckyBadge = false,
		CorruptedBadge = false,
		SuperLuckBadge = false,
		AdvancedAltersBadge = false,
		
	},
	
	Milestones = {
		CashMilestone = "0",
		MultiMilestone = "0",
		VerdantMilestone = "0",
		KauriMilestone = "0",
		AmethystMilestone = "0",
		DelhiMilestone = "0",
		IlmeniteMilestone = "0",
		LodestoneMilestone = "0",
		RosettaMilestone = "0",
		BioluminescenceMilestone = "0",
		OmoMarrowMilestone = "0",
	},
}

local ProfileService = require(game.ServerScriptService.Data.ProfileService)
local Players = game:GetService("Players")

local ProfileStore = ProfileService.GetProfileStore("PlayerProfile", dataTemplate)

local Profiles = {}

local function playerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_"..player.UserId)

	if profile then
		profile:AddUserId(player.UserId)
		profile:Reconcile()

		profile:ListenToRelease(function()
			Profiles[player] = nil
			player:Kick()
		end)

		if not player:IsDescendantOf(Players) then
			profile:Release()
		else
			Profiles[player] = profile
			
		end
	else
		player:Kick()
	end
end

function PlayerDataHandler:Init()
	for _, player in ipairs(game.Players:GetPlayers()) do
		task.spawn(playerAdded, player)
	end

	game.Players.PlayerAdded:Connect(playerAdded)

	game.Players.PlayerRemoving:Connect(function(player)
		if Profiles[player] then
			Profiles[player]:Release()
		end
	end)
end

local function getProfile(player)
	assert(Profiles[player], string.format("Profile does not exist for %s", player.UserId))

	return Profiles[player]
end

function PlayerDataHandler:Get(player, key)
	local profile = getProfile(player)
	assert(profile.Data[key], string.format("Data does not exist for key: %s", key))

	return profile.Data[key]
end

function PlayerDataHandler:Set(player, key, value)
	local profile = getProfile(player)
	assert(profile.Data[key], string.format("Data does not exist for key: %s", key))

	assert(type(profile.Data[key]) == type(value))

	profile.Data[key] = value

	-- Update the value in the player's folder
	local playerFolder = player:FindFirstChild("PlayerData")
	if playerFolder then
		local stringValue = playerFolder:FindFirstChild(key)
		if stringValue and stringValue:IsA("StringValue") then
			stringValue.Value = tostring(value)
		end
	end
end

function PlayerDataHandler:Update(player, key, callback)
	local profile = getProfile(player)

	local oldData = self:Get(player, key)
	local newData = callback(oldData)

	self:Set(player, key, newData)
end

return PlayerDataHandler
