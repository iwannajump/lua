 local function gen_random ()
 	math.randomseed(os.time())
	return math.random(0,10)
 end

 function command_video_search ( user_token, message )
	local video_match = message:match "^видео%s(.*)$" or message:match "^Видео%s(.*)$"
		if video_match then
			local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = account.user_token, v = "5.52" })
			local rand = gen_random()
			if video["response"]["items"][rand] ~= nil then
				send_video( account, video["response"]["items"][rand ]["owner_id"], video["response"]["items"][rand ]["id"])
			end
		end
end


function command_pic_search ( user_token, message )
	local pic_match = message:match "^картинка%s(.*)$" or message:match "^pic%s(.*)$"
	if pic_match then
		local pic = request("https://api.vk.com/method/photos.search?", { q = pic_match, access_token = account.user_token, v = "5.52" })
		local rand = gen_random()
		if pic["response"]["items"][rand] then
			send_pic( account, pic["response"]["items"][rand]["owner_id"], pic["response"]["items"][rand]["id"])
		end
	end
end