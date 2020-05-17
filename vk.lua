local vk = require "lib"
local curl = require "cURL"

local access_token = "" --group
-- local user_token  = "" -- user
local userId = 
local groupId = ""
local account = vk.make_account("mail@gmail.com", "password")

account.access_token = access_token
vk.auth(account)

--получаем данные необходимые для запроса к Long Poll серверу
long_poll_server = vk.call(account, "groups.getLongPollServer", { group_id = groupId})

lp_server = long_poll_server["response"]["server"]
lp_key = long_poll_server["response"]["key"]
lp_ts = long_poll_server["response"]["ts"]

-- function os_exec(str)
-- 	local t = os.execute(str)
-- 	return t
-- end

function os_exec(str)
	local res = io.popen(str)
	local ex = res:read("*a")
	return ex
end


while(true) do

--делаем запрос к Long Poll серверу
	local answer = 	request(lp_server,
					{act = "a_check", key = lp_key,
					ts = lp_ts, wait = "3"})

	if (answer ~= nil) then
		if (answer["updates"] ~= nil) then
			if (answer["updates"][1] ~= nil) then
				if (answer["updates"][1]["object"]["message"]) ~= nil then
					reciewed_message = answer["updates"][1]["object"]["message"]["text"]
					peer = answer["updates"][1]["object"]["message"]["peer_id"]
				end

				lp_ts = answer["ts"] --обновляем тс во избежание бесконечного засера беседы

				if(reciewed_message == "пидор") then
					vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "сам пидор"})
				end
				if(reciewed_message == "тест") then
					vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "ок"})
				end
				if(reciewed_message == "максбот") then
					vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "максбот сосать"})
				end
				if(reciewed_message == "кто нахуй") then
					vk.call(account, "messages.send", { peer_id = peer, v = "5.103", attachment = "photo499047616_457259084"})
				end
	
				if(reciewed_message) then
				local video_match = reciewed_message:match("видео (.*)$")
				if (video_match ~= nil) then
					local video = request("https://api.vk.com/method/video.search?", { q = video_match, access_token = user_token, v = "5.52" })
					if (video["response"]["items"][1]~= nil) then
						vk.call(account, "messages.send", { peer_id = peer, v = "5.103", attachment = "video"..video["response"]["items"][1]["owner_id"].."_"..video["response"]["items"][1]["id"]})
					end
				end
				end
				if (answer["updates"][1]["object"]["message"]["from_id"] == userId) then
					local os_match = reciewed_message:match("os (.*)$")
					if (os_match ~= nil) then
						if (os_exec(os_match) == true) then
							vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "ok"})
						else
							vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "command not found: "..os_match})
						end
					end
				end
				-- if (answer["updates"][1]["object"]["message"]["from_id"] == userId) then
				-- 	local os_match = reciewed_message:match("os (.*)$")
				-- 	if (os_match ~= nil) then
				-- 		local exec_result = os_exec(os_match)
				-- 		if (exec_result ~= nil) then
				-- 			vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = exec_result})
				-- 		else
				-- 			vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "command not found: "..os_match})
				-- 		end
				-- 	end
				-- end
				if (answer["updates"][1]["object"]["message"]["from_id"] ~= userId) then
					local os_match = reciewed_message:match("os (.*)$")
					print(os_match)
					if (os_match ~= nil) then
						vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "access denied"})
					end
				end
				if (answer["updates"][1]["object"]["message"]["action"] ~= nil) then
					if(answer["updates"][1]["object"]["message"]["action"]["type"] == "chat_invite_user") then
						vk.call(account, "messages.send", { peer_id = peer, v = "5.103", message = "привет @id"..answer["updates"][1]["object"]["message"]["action"]["member_id"].."(арчевод)"})
					end
				end
			end
		end
	end
end
