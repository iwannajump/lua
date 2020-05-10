local vk = require "curl"

local access_token = token
local userId = "123456789"
local groupId = "123456789"
local account = vk.make_account("user@gmail.com", "password")

account.access_token = access_token
vk.auth(account)

--получаем данные необходимые для запроса к Long Poll серверу
local long_poll_server = vk.call(account, "groups.getLongPollServer", { group_id = groupId})


while (true) do
-- 	--делаем запрос к Long Poll серверу
	local answer = 	request(long_poll_server["response"]["server"],
					{act = "a_check", key = long_poll_server["response"]["key"],
					ts = long_poll_server["response"]["ts"], wait = "20"})	
	

	if(answer["updates"][1]["object"]["message"]["text"] == "пидор") then
		vk.call(account, "messages.send", { chat_id = "5", v = "5.28", message = "сам пидор"})
		break	
	end
end
