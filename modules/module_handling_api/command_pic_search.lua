 local function gen_random ()
 	math.randomseed(os.time())
	return math.random(0,10)
 end

 function command_pic_search ( user_token, message )
	local pic_match = message:match "[Пп]икча%s(.*)"
	if pic_match then
		local pic = request("https://api.vk.com/method/photos.search?", { q = pic_match, access_token = account.user_token, v = "5.52" })
		local rand = gen_random()
		if pic["response"]["items"][rand] then
			send_media( "photo", account, pic["response"]["items"][rand]["owner_id"], pic["response"]["items"][rand]["id"])
		end
	end
end