local vk = require "lib"
local curl = require "cURL"

local access_token = "" --group
local user_token  = "" -- user
local userId = 
local groupId = ""
local account = vk.make_account("mail@gmail.com", "passwd")

account.access_token = access_token
vk.auth(account)

--получаем данные необходимые для запроса к Long Poll серверу
long_poll_server = vk.call(account, "groups.getLongPollServer", { group_id = groupId})

lp_server = long_poll_server["response"]["server"]
lp_key = long_poll_server["response"]["key"]
lp_ts = long_poll_server["response"]["ts"]


function os_exec(str)
	local res = io.popen(str)
	local ex = res:read("*a")
	return ex
end


while(true) do

--делаем запрос к Long Poll серверу
	local answer = 	request(lp_server,
					{act = "a_check", key = lp_key,
					ts = lp_ts, wait = "30"})

	if (answer ~= nil) then
		if (answer["updates"] ~= nil) then
			if (answer["updates"][1] ~= nil) then
				if (answer["updates"][1]["object"]["message"]) ~= nil then
					reciewed_message = answer["updates"][1]["object"]["message"]["text"]
					peer = answer["updates"][1]["object"]["message"]["peer_id"]
					print(reciewed_message)
				end

				lp_ts = answer["ts"] --обновляем тс во избежание бесконечного засера беседы

				if(reciewed_message == "пинг") then
					vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = "понг"})
				end
	
				if(reciewed_message) then
					local video_match = reciewed_message:match("^видео%s(.*)$")
					if (video_match ~= nil) then
						local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = user_token, v = "5.52" })
						if (video["response"]["items"][1]~= nil) then
							vk.call(account, "messages.send", { peer_id = peer, v = "5.52", attachment = "video"..video["response"]["items"][1]["owner_id"].."_"..video["response"]["items"][1]["id"]})
						end
					end
					end
					if (answer["updates"][1]["object"]["message"] ~= nil) then 
						if (answer["updates"][1]["object"]["message"]["from_id"] == userId) then
							local os_match = reciewed_message:match("os (.*)$")
							if (os_match ~= nil) then
									local exec_result = os_exec(os_match)
									vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = exec_result})
							end

							local c_match = reciewed_message:match("^c%s(.*)$")
							if (c_match ~= nil) then
								local file = io.open("CODE_TO_EXEC/main.c", "w")
								file:write(c_match)
								local exec_result = os_exec("cd CODE_TO_EXEC && gcc main.c && ./a.out")
								vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = exec_result})
							end

							local lua_match = reciewed_message:match("^lua%s(.*)$")
							if (lua_match ~= nil) then
								local file = io.open("CODE_TO_EXEC/main.lua", "w")
								file:write(lua_match)
								local exec_result = os_exec("cd CODE_TO_EXEC && lua main.lua")
								vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = exec_result})
							end

							local asm_match = reciewed_message:match("^asm%s(.*)$")
							if (asm_match ~= nil) then
								local file = io.open("CODE_TO_EXEC/main.asm", "w")
								file:write(asm_match)
								local exec_result = os_exec("cd CODE_TO_EXEC && fasm main.asm && ld main.o -o main && ./main")
								vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = exec_result})
							end
						end
						if (answer["updates"][1]["object"]["message"]["from_id"] ~= userId) then
							local os_match = reciewed_message:match("^os%s(.*)$")
							print(os_match)
							if (os_match ~= nil) then
								vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = "access denied"})
							end

							local c_match = reciewed_message:match("^c%s(.*)$")
							print(c_match)
							if (c_match ~= nil) then
								vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = "access denied"})
							end
						end
						if (answer["updates"][1]["object"]["message"]["action"] ~= nil) then
							if(answer["updates"][1]["object"]["message"]["action"]["type"] == "chat_invite_user") then
								vk.call(account, "messages.send", { peer_id = peer, v = "5.52", message = "привет @id"..answer["updates"][1]["object"]["message"]["action"]["member_id"].."(арчевод)"})
							end
						end
				end --if(reciewed_message)
			end --if (answer["updates"][1] ~= nil)
		end --if (answer["updates"] ~= nil)
	end	--if (answer ~= nil)
end	--while true
