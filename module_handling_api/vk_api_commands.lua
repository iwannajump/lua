function command_video_search ( account, user_token, message )
	local video_match = message:match "^видео%s(.*)$" or message:match "^Видео%s(.*)$"
		if video_match then
			local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = account.user_token, v = "5.52" })
			if video["response"]["items"][1] ~= nil then
				send_video(account, video["response"]["items"][1]["owner_id"], video["response"]["items"][1]["id"])
			end
		end
end