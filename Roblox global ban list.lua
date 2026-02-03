--You can send ban requests to ATF1511.--
--Include evidence (If possible in video form)--
--Also include chat logs if you want--

--Also you can change the link if you want--

local HttpService = game:GetService("HttpService")

local BANLIST_URL = "https://pastebin.com/raw/tLymGy9S"

local function isPlayerBanned(userId)
	local success, data = pcall(function()
		return HttpService:GetAsync(BANLIST_URL)
	end)

	if not success then
		warn("Ban list failed to load:", data)
		return false
	end

	local banList = HttpService:JSONDecode(data)

	for _, entry in ipairs(banList) do
		if entry.UserId == userId then
			return true, entry.Reason
		end
	end

	return false
end

game.Players.PlayerAdded:Connect(function(player)
	local banned, reason = isPlayerBanned(player.UserId)

	if banned then
		player:Kick("You are globally banned. Appeal to ATF1511. \nReason: " .. (reason or "No reason provided"))
		
	end
end)

