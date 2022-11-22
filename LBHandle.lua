local etNum = require(game.ReplicatedStorage.EternityNum)

local DataStorageService = game:GetService("DataStoreService")
local mps = game:GetService("MarketplaceService")



local CashLeaderboard = DataStorageService:GetOrderedDataStore("LevelLeaderboard")
local GusLeaderboard = DataStorageService:GetOrderedDataStore("GusLeaderboard")
local TimeLeaderboard = DataStorageService:GetOrderedDataStore("TimeLeaderboard")
local DonatorLeaderboard = DataStorageService:GetOrderedDataStore("DonatorLeaderboard")



--Time Played Handler
local function secConvert(num)
	local t = num

	local seconds = t % 60
	t = t-seconds

	local minutes = math.floor(t/60) % 60
	t = t-minutes*60

	local hours = math.floor(t/3600) % 24
	t = t-hours*3600

	local days = math.floor(t/(3600*24))

	if days > 0 then
		num = days.."D "..hours.."H"
	else if hours > 0 then
			num = hours.."H "..minutes.."M"
		else if minutes > 0 then
				num = minutes.."M "..math.floor(seconds).."S"

			end
		end
		return num
	end
end
---------


--LB Updater
local function updateLeaderboard()
	local success, errorMessage = pcall (function()

		local Data = CashLeaderboard:GetSortedAsync(false, 50)
		local Data2 = GusLeaderboard:GetSortedAsync(false, 50)
		local Data3 = TimeLeaderboard:GetSortedAsync(false, 50)
		local Data4 = DonatorLeaderboard:GetSortedAsync(false, 50)


		local LevelPage = Data:GetCurrentPage()
		local GusPage = Data2:GetCurrentPage()
		local TimePage = Data3:GetCurrentPage()
		local RobuxPage = Data4:GetCurrentPage()


		for Rank, data in ipairs(LevelPage) do


			local userName = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local Name = userName
			local Level = data.value

			local isOnLeaderboard = false
			for i, v in pairs(game.Workspace.LB.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end


			local number = Level
			local text = etNum.short((number))

			if Level and isOnLeaderboard == false then
				local newLbFrame = game.ReplicatedStorage.ScrollingFrame:WaitForChild("LeaderboardFrame1"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Level.Text = "Lv. "..text
				newLbFrame.Rank.Text = "#"..Rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.02 * #game.Workspace.LB.LeaderboardUI.ScrollingFrame.Holder:GetChildren()), 0)
				newLbFrame.Parent = game.Workspace.LB.LeaderboardUI.ScrollingFrame.Holder
			end
		end


		for Rank, data in ipairs(GusPage) do


			local userName = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local Name = userName
			local Gus = data.value



			local isOnLeaderboard = false
			for i, v in pairs(game.Workspace.LB2.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end

			local number1 = Gus
			local text1 = etNum.short(Gus)

			if Gus and isOnLeaderboard == false and tonumber(number1) > 0 then
				local newLbFrame = game.ReplicatedStorage.ScrollingFrame2:WaitForChild("LeaderboardFrame"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Gus.Text = text1
				newLbFrame.Rank.Text = "#"..Rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.02 * #game.Workspace.LB2.LeaderboardUI.ScrollingFrame.Holder:GetChildren()), 0)
				newLbFrame.Parent = game.Workspace.LB2.LeaderboardUI.ScrollingFrame.Holder
			end
		end


		for Rank, data in ipairs(TimePage) do


			local userName = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local Name = userName
			local Time = data.value



			local isOnLeaderboard = false
			for i, v in pairs(game.Workspace.LB3.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end


			local number2 = Time
			local text2 = secConvert(number2)

			if Time and isOnLeaderboard == false then
				local newLbFrame = game.ReplicatedStorage.ScrollingFrame3:WaitForChild("LeaderboardFrame"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Time.Text = text2
				newLbFrame.Rank.Text = "#"..Rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.02 * #game.Workspace.LB3.LeaderboardUI.ScrollingFrame.Holder:GetChildren()), 0)
				newLbFrame.Parent = game.Workspace.LB3.LeaderboardUI.ScrollingFrame.Holder
			end
		end


		for Rank, data in ipairs(RobuxPage) do

			local userName = game.Players:GetNameFromUserIdAsync(data.key)
			local Name = userName
			local Donated = data.value

			local isOnLeaderboard = false
			for i, v in pairs(game.Workspace.LB4.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end

			if Donated and isOnLeaderboard == false then
				local newLbFrame = game.ReplicatedStorage.ScrollingFrame4:WaitForChild("LeaderboardFrame"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Donated.Text = "R$"..Donated
				newLbFrame.Rank.Text = "#"..Rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.02 * #game.Workspace.LB4.LeaderboardUI.ScrollingFrame.Holder:GetChildren()), 0)
				newLbFrame.Parent = game.Workspace.LB4.LeaderboardUI.ScrollingFrame.Holder
			end
		end

	end)

	if not success then
		error(errorMessage)
	end
end


--LB Refresher
while true do


	for _, player in pairs(game.Players:GetPlayers()) do
		CashLeaderboard:SetAsync(player.UserId, player.Level.Value)
	end

	for _, player in pairs(game.Players:GetPlayers()) do
		GusLeaderboard:SetAsync(player.UserId, player.Gus2.Value)
	end

	for _, player in pairs(game.Players:GetPlayers()) do
		TimeLeaderboard:SetAsync(player.UserId, player.timePlayed.Value)
	end

	for _, player in pairs(game.Players:GetPlayers()) do
		TimeLeaderboard:SetAsync(player.UserId, player.Donated.Value)
	end


	for _, frame in pairs (game.Workspace.LB.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
		frame:Destroy()
	end

	for _, frame in pairs (game.Workspace.LB2.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
		frame:Destroy()
	end

	for _, frame in pairs (game.Workspace.LB3.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
		frame:Destroy()
	end

	for _, frame in pairs (game.Workspace.LB4.LeaderboardUI.ScrollingFrame.Holder:GetChildren()) do
		frame:Destroy()
	end

	updateLeaderboard()
	print("Updated!")

	wait(120)

end
