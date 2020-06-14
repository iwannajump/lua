require "lib"
require "auth"  --init `account` variable
require "modules/module_admin/lib_admin"
require "modules/module_admin/commands_admin"
require "modules/module_math/lib_math"
require "modules/module_math/commands_math"
require "modules/module_handling_api/command_video_search"
require "modules/module_handling_api/command_pic_search"
require "modules/module_help/command_help"
require "modules/module_regex/command_regex"
require "modules/module_translate/command_translate"
require "modules/module_weather/command_weather"

local server 			= get_lp_server()
local lp_server 		= server["response"]["server"]
local lp_key 			= server["response"]["key"]
local lp_ts 			= server["response"]["ts"]

while true do

	answer =		request(lp_server,
				{act = "a_check", key = lp_key,
				ts = lp_ts, wait = "60"})

	if answer_not_empty(answer) then

		lp_ts = answer["ts"]

		message 		= answer["updates"][1]["object"]["message"]["text"]
		from_id 		= answer["updates"][1]["object"]["message"]["from_id"]
		account.peer		= answer["updates"][1]["object"]["message"]["peer_id"]
			
		command_help		( message )

		command_mem_usage	( message )

		if message then
				
			print(message)

			if message:match "[Пп]ереводчик%s(.*)$" then
				command_translate	( message )
			end

			if message:match "[Пп]огода%s(.*)$" then
				command_weather 		( message )
			end

			if message:match"[Вв]идео%s(.*)$" then
				command_video_search	( user_token, message )
			end

			if message:match"[Пп]икча%s(.*)$" then
				command_pic_search	( user_token, message )
			end

			if message:match"[Фф]ибоначчи%s(.*)$" then
				command_fibonacci	( message )
			end

			if message:match"[Фф]акториал%s(.*)$" then
				command_factorial	( message )
			end

			if message:match"[Ee]qu%s(.*)$" then
				command_equation	( message )
			end

			if message:match"[Cc]alc%s([^%$].*)$" then
				command_calculator	( message )
			end

			if message:match"[Rr]egex%s(.*)$" then
				command_regex		( message )
			end

			if message:match "[Tt]o rgb%s(.*)$" then
				command_hex_to_rgb	( message )
			end

			if message:match "[Tt]o hex%s(.*)" then
				command_rgb_to_hex	( message )
			end

			if from_id == account.user_id then

				if message:match "[Oo]s%s(.*)$" then
					bash			( message )
				end

				if message:match "[Ll]ua%s(.*)$" then
					lua_exec		( message )
				end

			else
				error_403			( message )
			end
		end
	end

	if answer_not_empty(answer) ~= true then
		print("\tgetting new server...")
		server 		= get_lp_server()
		lp_server 	= server["response"]["server"]
		lp_key 		= server["response"]["key"]
		lp_ts 		= server["response"]["ts"]
	end
end
