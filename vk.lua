local vk = require "curl"

local access_token = "" --group
local userId = ""
local groupId = ""
local account = vk.make_account("mail@gmail.com", "password")

account.access_token = access_token
vk.auth(account)

while(true) do

--получаем данные необходимые для запроса к Long Poll серверу
	local long_poll_server = vk.call(account, "groups.getLongPollServer", { group_id = groupId})
--делаем запрос к Long Poll серверу
	local answer = 	request(long_poll_server["response"]["server"],
					{act = "a_check", key = long_poll_server["response"]["key"],
					ts = long_poll_server["response"]["ts"], wait = "3"})


	if(answer["updates"][1] ~= nil) then

		local to_banned = nil

		reciewed_message = answer["updates"][1]["object"]["message"]["text"]

		if(reciewed_message == "пидор") then
			vk.call(account, "messages.send", { chat_id = "3", v = "5.28", message = "сам пидор"})
		end
		if(reciewed_message == "шлюха") then
			vk.call(account, "messages.send", { chat_id = "3", v = "5.28", message = "сама шлюха"})
		end
		if(reciewed_message == "максбот") then
			vk.call(account, "messages.send", { chat_id = "3", v = "5.28", message = "максбот сосать"})
		end
		if(reciewed_message == "сиськи") then
			vk.call(account, "messages.send", { chat_id = "3", v = "5.28", message = "( . ) ( . )"})
		end
		if(reciewed_message == "xatar") then
			vk.call(account, "messages.send", { chat_id = "3", v = "5.28", attachment = "video-25173386_171216781", message = ""})
		end
		if(reciewed_message == "пермач "..to_banned) then
			vk.call(account, "messages.removeChatUser", { chat_id = "5", user_id = to_banned})
		end
	end
end
