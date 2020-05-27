local vk 		= require "lib"
local curl 		= require "cURL"
local user_id 		= 
local account 		= vk.make_account("mail@gmail.com", "password")
local user_token	= "" 	-- user
account.access_token	= ""	-- group
account.api_version	= "5.52"

local long_poll_server 	= vk.call(account, "groups.getLongPollServer", { group_id = "123456789" })
local lp_server 	= long_poll_server["response"]["server"]
local lp_key 		= long_poll_server["response"]["key"]
local lp_ts 		= long_poll_server["response"]["ts"]

while true do

	local answer = 		request(lp_server,
						{act = "a_check", key = lp_key,
						ts = lp_ts, wait = "30"})

	if answer_not_empty(answer) == true then

		reciewed_message 	= answer["updates"][1]["object"]["message"]["text"]
		account.peer 		= answer["updates"][1]["object"]["message"]["peer_id"]
		from_id 			= answer["updates"][1]["object"]["message"]["from_id"]
		lp_ts 				= answer["ts"]

		if reciewed_message == "пинг" then
			send_message(account, "понг")
		end
		if reciewed_message == "info" then
			send_message(account, "ok")
		end

		if reciewed_message then

			local video_match = reciewed_message:match("^видео%s(.*)$")
			if video_match ~= nil then
				local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = user_token, v = "5.52" })
				
				if video["response"]["items"][1] ~= nil then
					video_owner_id 	= video["response"]["items"][1]["owner_id"]
					video_id 		= video["response"]["items"][1]["id"]
					send_video(account, video_owner_id, video_id)
				end
			end

			if from_id == user_id then

				--		BASH
				local os_match = reciewed_message:match("^os%s(.*)$")
				if os_match ~= nil then
					local exec_result = os_exec(os_match)
					send_message(account, exec_result)

					if exec_result == "" then
						send_message(account, "command not found: " .. os_match)
					end
				end

				--		C
				local c_match = reciewed_message:match("^c%s(.*)$")
				if c_match ~= nil then
					local file = io.open("CODE_TO_EXEC/main.c", "w")
					file:write(c_match)
					local exec_result = os_exec("cd CODE_TO_EXEC && gcc main.c && ./a.out")
					send_message(account, exec_result)
				end

				--		LUA
				local lua_match = reciewed_message:match("^lua%s(.*)$")
				if lua_match ~= nil then
					local file = io.open("CODE_TO_EXEC/main.lua", "w")
					file:write(lua_match)
					local exec_result = os_exec("cd CODE_TO_EXEC && lua main.lua")
					send_message(account, exec_result)
				end

				-- 		ASSEMBLY LANGUAGE
				local asm_match = reciewed_message:match("^asm%s(.*)$")
				if asm_match ~= nil then
					local file = io.open("CODE_TO_EXEC/main.asm", "w")
					file:write(asm_match)
					local exec_result = os_exec("cd CODE_TO_EXEC && fasm main.asm && ld main.o -o main && ./main")
					send_message(account, exec_result)
				end
			else
				local access_denied_match = reciewed_message:match("^os%s(.*)$")  	or 
											reciewed_message:match("^c%s(.*)$")  	or
											reciewed_message:match("^lua%s(.*)$") 	or 
											reciewed_message:match("^asm%s(.*)$")
				if access_denied_match ~= nil then
					send_message(account, "access denied")
				end	
			end
		end --if(reciewed_message)
	end --if answer_not_empty(answer) == true
end --while true
