 local function gen_random ()
 	math.randomseed(os.time())
	return math.random(0,10)
 end

function command_video_search ( user_token, message )
	local video_match = message:match "[Вв]идео%s(.*)"
		if video_match then
			local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = account.user_token, v = "5.52" })
			local rand = gen_random()
			if video["response"]["items"][rand] then
				send_media( "video", account, video["response"]["items"][rand]["owner_id"], video["response"]["items"][rand]["id"])
			end
		end
end